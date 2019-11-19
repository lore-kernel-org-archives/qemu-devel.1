Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D92CC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70F1222A5
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:17:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70F1222A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4K0-0002FH-5j
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:17:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42112)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4GJ-0006wu-JC
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4GI-0005bZ-AW
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:47 -0500
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:54973)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4GI-0005b8-4I
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:46 -0500
Received: from player795.ha.ovh.net (unknown [10.109.159.7])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 5A42F823E3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:13:44 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 45A4EC18ACC4;
 Tue, 19 Nov 2019 14:13:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 10/17] aspeed/smc: Restore default AHB window mapping at reset
Date: Tue, 19 Nov 2019 15:12:04 +0100
Message-Id: <20191119141211.25716-11-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17913067520693668625
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeeh
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.75.45
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
Cc: Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The current model only restores the Segment Register values but leaves
the previous CS mapping behind. Introduce a helper setting the
register value and mapping the region at the requested address. Use
this helper when a Segment register is set and at reset.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index f0c7bbbad302..955ec21852ac 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -475,10 +475,26 @@ static bool aspeed_smc_flash_overlap(const AspeedSM=
CState *s,
     return false;
 }
=20
+static void aspeed_smc_flash_set_segment_region(AspeedSMCState *s, int c=
s,
+                                                uint64_t regval)
+{
+    AspeedSMCFlash *fl =3D &s->flashes[cs];
+    AspeedSegments seg;
+
+    s->ctrl->reg_to_segment(s, regval, &seg);
+
+    memory_region_transaction_begin();
+    memory_region_set_size(&fl->mmio, seg.size);
+    memory_region_set_address(&fl->mmio, seg.addr - s->ctrl->flash_windo=
w_base);
+    memory_region_set_enabled(&fl->mmio, true);
+    memory_region_transaction_commit();
+
+    s->regs[R_SEG_ADDR0 + cs] =3D regval;
+}
+
 static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
                                          uint64_t new)
 {
-    AspeedSMCFlash *fl =3D &s->flashes[cs];
     AspeedSegments seg;
=20
     s->ctrl->reg_to_segment(s, new, &seg);
@@ -529,13 +545,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCSt=
ate *s, int cs,
     aspeed_smc_flash_overlap(s, &seg, cs);
=20
     /* All should be fine now to move the region */
-    memory_region_transaction_begin();
-    memory_region_set_size(&fl->mmio, seg.size);
-    memory_region_set_address(&fl->mmio, seg.addr - s->ctrl->flash_windo=
w_base);
-    memory_region_set_enabled(&fl->mmio, true);
-    memory_region_transaction_commit();
-
-    s->regs[R_SEG_ADDR0 + cs] =3D new;
+    aspeed_smc_flash_set_segment_region(s, cs, new);
 }
=20
 static uint64_t aspeed_smc_flash_default_read(void *opaque, hwaddr addr,
@@ -897,10 +907,10 @@ static void aspeed_smc_reset(DeviceState *d)
         qemu_set_irq(s->cs_lines[i], true);
     }
=20
-    /* setup default segment register values for all */
+    /* setup the default segment register values and regions for all */
     for (i =3D 0; i < s->ctrl->max_slaves; ++i) {
-        s->regs[R_SEG_ADDR0 + i] =3D
-            s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]);
+        aspeed_smc_flash_set_segment_region(s, i,
+                    s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]));
     }
=20
     /* HW strapping flash type for the AST2600 controllers  */
--=20
2.21.0


