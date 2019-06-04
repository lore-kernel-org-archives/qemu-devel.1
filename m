Return-Path: <SRS0=GUf1=UD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B5C282CE
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:14:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B700B2075B
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2019 15:14:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B700B2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53857 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYB8z-0000R8-SJ
	for qemu-devel@archiver.kernel.org; Tue, 04 Jun 2019 11:14:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYB7V-00082L-IM
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:13:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hYB7U-0007AX-NK
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:13:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hYB7U-00079e-Fw
	for qemu-devel@nongnu.org; Tue, 04 Jun 2019 11:13:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 915A383F3F
	for <qemu-devel@nongnu.org>; Tue,  4 Jun 2019 15:12:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
	[10.36.116.148])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 5F65260BCC;
	Tue,  4 Jun 2019 15:12:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id D262411386A6; Tue,  4 Jun 2019 17:12:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  4 Jun 2019 17:12:51 +0200
Message-Id: <20190604151251.9903-3-armbru@redhat.com>
In-Reply-To: <20190604151251.9903-1-armbru@redhat.com>
References: <20190604151251.9903-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 04 Jun 2019 15:12:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] vl: Document why objects are delayed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, mprivozn@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Objects should not be "delayed" without a reason, as the previous
commit demonstrates.  The remaining ones have reasons.  State them.
and demand future ones come with such a statement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 vl.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/vl.c b/vl.c
index cc6246d2af..cd1fbc4cdc 100644
--- a/vl.c
+++ b/vl.c
@@ -2751,19 +2751,25 @@ static bool object_create_initial(const char *typ=
e, QemuOpts *opts)
         exit(0);
     }
=20
+    /*
+     * Objects should not be made "delayed" without a reason.  If you
+     * add one, state the reason in a comment!
+     */
+
+    /* Reason: rng-egd property "chardev" */
     if (g_str_equal(type, "rng-egd")) {
         return false;
     }
=20
 #if defined(CONFIG_VHOST_USER) && defined(CONFIG_LINUX)
+    /* Reason: cryptodev-vhost-user property "chardev" */
     if (g_str_equal(type, "cryptodev-vhost-user")) {
         return false;
     }
 #endif
=20
     /*
-     * return false for concrete netfilters since
-     * they depend on netdevs already existing
+     * Reason: filter-* property "netdev" etc.
      */
     if (g_str_equal(type, "filter-buffer") ||
         g_str_equal(type, "filter-dump") ||
--=20
2.21.0


