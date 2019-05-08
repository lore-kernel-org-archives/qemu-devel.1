Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E78C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:22:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88E6C20449
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88E6C20449
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40664 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQGu-0002wl-Hd
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:22:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hOQEq-0000y9-EN
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hOQEp-0003uS-5X
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:16 -0400
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:50530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hOQEo-0003ts-Vp
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:15 -0400
Received: from player711.ha.ovh.net (unknown [10.108.35.122])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 93B7050BA4
	for <qemu-devel@nongnu.org>; Wed,  8 May 2019 19:20:13 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
	(Authenticated sender: clg@kaod.org)
	by player711.ha.ovh.net (Postfix) with ESMTPSA id C28DA5769388;
	Wed,  8 May 2019 17:20:06 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 May 2019 19:19:46 +0200
Message-Id: <20190508171946.657-4-clg@kaod.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190508171946.657-1-clg@kaod.org>
References: <20190508171946.657-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 1138566282612345830
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeefgdduuddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.42.102
Subject: [Qemu-devel] [PATCH 3/3] spapr/xive: print out the EQ page address
 in the monitor
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This proved to be a useful information when debugging issues with OS
event queues allocated above 64GB.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/spapr_xive.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 810435c30cc7..7faf03b1fb7c 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -120,6 +120,7 @@ static int spapr_xive_target_to_end(uint32_t target, =
uint8_t prio,
 static void spapr_xive_end_pic_print_info(SpaprXive *xive, XiveEND *end,
                                           Monitor *mon)
 {
+    uint64_t qaddr_base =3D xive_end_qaddr(end);
     uint32_t qindex =3D xive_get_field32(END_W1_PAGE_OFF, end->w1);
     uint32_t qgen =3D xive_get_field32(END_W1_GENERATION, end->w1);
     uint32_t qsize =3D xive_get_field32(END_W0_QSIZE, end->w0);
@@ -127,9 +128,9 @@ static void spapr_xive_end_pic_print_info(SpaprXive *=
xive, XiveEND *end,
     uint32_t nvt =3D xive_get_field32(END_W6_NVT_INDEX, end->w6);
     uint8_t priority =3D xive_get_field32(END_W7_F0_PRIORITY, end->w7);
=20
-    monitor_printf(mon, "%3d/%d % 6d/%5d ^%d",
+    monitor_printf(mon, "%3d/%d % 6d/%5d @%"PRIx64" ^%d",
                    spapr_xive_nvt_to_target(0, nvt),
-                   priority, qindex, qentries, qgen);
+                   priority, qindex, qentries, qaddr_base, qgen);
=20
     xive_end_queue_pic_print_info(end, 6, mon);
     monitor_printf(mon, "]");
--=20
2.20.1


