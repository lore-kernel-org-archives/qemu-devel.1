Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B579ECA9EB7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:01:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DBB021783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 17:01:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DBB021783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMxWu-0001Vf-1K
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 13:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iMxC0-0001a7-B3
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iMxBy-0006rn-BG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:32 -0400
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:35486)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iMxBw-0006qb-Ce
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 12:39:30 -0400
Received: from player688.ha.ovh.net (unknown [10.109.146.166])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id F2A6210C72C
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 18:39:23 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 25092B32C3C5;
 Tue, 22 Oct 2019 16:39:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v5 4/7] ppc/pnv: Add a PnvChip pointer to PnvCore
Date: Tue, 22 Oct 2019 18:38:09 +0200
Message-Id: <20191022163812.330-5-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191022163812.330-1-clg@kaod.org>
References: <20191022163812.330-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 3511400336961342438
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrkeejgddutdefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.109.80
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will use it to reset the interrupt presenter from the CPU reset
handler.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 include/hw/ppc/pnv_core.h | 3 +++
 hw/ppc/pnv_core.c         | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index bfbd2ec42aa6..55eee95104da 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -31,6 +31,8 @@
 #define PNV_CORE_GET_CLASS(obj) \
      OBJECT_GET_CLASS(PnvCoreClass, (obj), TYPE_PNV_CORE)
=20
+typedef struct PnvChip PnvChip;
+
 typedef struct PnvCore {
     /*< private >*/
     CPUCore parent_obj;
@@ -38,6 +40,7 @@ typedef struct PnvCore {
     /*< public >*/
     PowerPCCPU **threads;
     uint32_t pir;
+    PnvChip *chip;
=20
     MemoryRegion xscom_regs;
 } PnvCore;
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 9f981a4940e6..cc17bbfed829 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -222,6 +222,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
                                 "required link 'chip' not found: ");
         return;
     }
+    pc->chip =3D PNV_CHIP(chip);
=20
     pc->threads =3D g_new(PowerPCCPU *, cc->nr_threads);
     for (i =3D 0; i < cc->nr_threads; i++) {
@@ -243,7 +244,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     }
=20
     for (j =3D 0; j < cc->nr_threads; j++) {
-        pnv_realize_vcpu(pc->threads[j], PNV_CHIP(chip), &local_err);
+        pnv_realize_vcpu(pc->threads[j], pc->chip, &local_err);
         if (local_err) {
             goto err;
         }
--=20
2.21.0


