Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD2BC606BD
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544DC20844
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 14:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544DC20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkUXb-000628-D5
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 10:22:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39831)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hkUTY-0001fH-QP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:18:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hkUTX-0008LS-Rt
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 10:18:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hkUTV-0008E4-O0; Mon, 08 Jul 2019 10:18:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F2D75A3B76;
 Mon,  8 Jul 2019 14:18:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-204.ams2.redhat.com
 [10.36.116.204])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBB4A2B1D1;
 Mon,  8 Jul 2019 14:18:34 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Mon,  8 Jul 2019 16:18:11 +0200
Message-Id: <20190708141812.3974-6-kwolf@redhat.com>
In-Reply-To: <20190708141812.3974-1-kwolf@redhat.com>
References: <20190708141812.3974-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 08 Jul 2019 14:18:37 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 5/6] MAINTAINERS: update RBD block maintainer
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Dillaman <dillaman@redhat.com>

Remove Josh as per his request since he is no longer the upstream RBD
tech lead. Add myself as the maintainer since I am the current RBD tech
lead.

Signed-off-by: Jason Dillaman <dillaman@redhat.com>
Reviewed-by: Josh Durgin <jdurgin@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cce50287a..cc9636b43a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2385,7 +2385,7 @@ S: Supported
 F: block/vmdk.c
=20
 RBD
-M: Josh Durgin <jdurgin@redhat.com>
+M: Jason Dillaman <dillaman@redhat.com>
 L: qemu-block@nongnu.org
 S: Supported
 F: block/rbd.c
--=20
2.20.1


