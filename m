Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D61C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:55:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEE7621019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 11:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEE7621019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho50n-0007X4-9u
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 07:55:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1ho4zq-00043l-Bn
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:54:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ho4zp-0001Xt-Bm
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:54:50 -0400
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:58714)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ho4zp-0001No-4p
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 07:54:49 -0400
Received: from player778.ha.ovh.net (unknown [10.109.146.50])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 3162F1D8405
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2019 13:54:40 +0200 (CEST)
Received: from kaod.org (lfbn-1-2240-157.w90-76.abo.wanadoo.fr [90.76.60.157])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id BC8B5801F20C;
 Thu, 18 Jul 2019 11:54:33 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 13:54:04 +0200
Message-Id: <20190718115420.19919-2-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190718115420.19919-1-clg@kaod.org>
References: <20190718115420.19919-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 6773132366158007270
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrieehgdegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.32.124.17
Subject: [Qemu-devel] [PATCH v2 01/17] ppc/xive: use an abstract type for
 XiveNotifier
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xive.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
index 55c53c741776..085e468ea69a 100644
--- a/include/hw/ppc/xive.h
+++ b/include/hw/ppc/xive.h
@@ -149,13 +149,11 @@
  * XIVE Notifier (Interface between Source and Router)
  */
=20
-typedef struct XiveNotifier {
-    Object parent;
-} XiveNotifier;
+typedef struct XiveNotifier XiveNotifier;
=20
 #define TYPE_XIVE_NOTIFIER "xive-notifier"
 #define XIVE_NOTIFIER(obj)                                     \
-    OBJECT_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
+    INTERFACE_CHECK(XiveNotifier, (obj), TYPE_XIVE_NOTIFIER)
 #define XIVE_NOTIFIER_CLASS(klass)                                     \
     OBJECT_CLASS_CHECK(XiveNotifierClass, (klass), TYPE_XIVE_NOTIFIER)
 #define XIVE_NOTIFIER_GET_CLASS(obj)                                   \
--=20
2.21.0


