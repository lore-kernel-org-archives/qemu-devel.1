Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E05C43215
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFDA208D4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EFDA208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46100 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4V8-00079P-DC
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42133)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4GR-00079L-5I
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4GP-0005eK-VJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:55 -0500
Received: from 1.mo68.mail-out.ovh.net ([46.105.41.146]:40437)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4GP-0005dm-Ph
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:13:53 -0500
Received: from player795.ha.ovh.net (unknown [10.109.146.143])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 1BDD314CEF6
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:13:52 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 55397C18AD62;
 Tue, 19 Nov 2019 14:13:44 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 11/17] aspeed/smc: Do not map disabled segment on the AST2600
Date: Tue, 19 Nov 2019 15:12:05 +0100
Message-Id: <20191119141211.25716-12-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17915319318968896273
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeej
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.41.146
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

The segments can be disabled on the AST2600 (zero register value).
CS0 is open by default but not the other CS. This is closing the
access to the flash device in user mode and forbids scanning.

In the model, check the segment size and disable the associated region
when the value is zero.

Fixes: bcaa8ddd081c ("aspeed/smc: Add AST2600 support")
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ssi/aspeed_smc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 955ec21852ac..86cadbe4cc00 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -444,8 +444,13 @@ static void aspeed_2600_smc_reg_to_segment(const Asp=
eedSMCState *s,
     uint32_t start_offset =3D (reg << 16) & AST2600_SEG_ADDR_MASK;
     uint32_t end_offset =3D reg & AST2600_SEG_ADDR_MASK;
=20
-    seg->addr =3D s->ctrl->flash_window_base + start_offset;
-    seg->size =3D end_offset + MiB - start_offset;
+    if (reg) {
+        seg->addr =3D s->ctrl->flash_window_base + start_offset;
+        seg->size =3D end_offset + MiB - start_offset;
+    } else {
+        seg->addr =3D s->ctrl->flash_window_base;
+        seg->size =3D 0;
+    }
 }
=20
 static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
@@ -486,7 +491,7 @@ static void aspeed_smc_flash_set_segment_region(Aspee=
dSMCState *s, int cs,
     memory_region_transaction_begin();
     memory_region_set_size(&fl->mmio, seg.size);
     memory_region_set_address(&fl->mmio, seg.addr - s->ctrl->flash_windo=
w_base);
-    memory_region_set_enabled(&fl->mmio, true);
+    memory_region_set_enabled(&fl->mmio, !!seg.size);
     memory_region_transaction_commit();
=20
     s->regs[R_SEG_ADDR0 + cs] =3D regval;
@@ -526,8 +531,9 @@ static void aspeed_smc_flash_set_segment(AspeedSMCSta=
te *s, int cs,
     }
=20
     /* Keep the segment in the overall flash window */
-    if (seg.addr + seg.size <=3D s->ctrl->flash_window_base ||
-        seg.addr > s->ctrl->flash_window_base + s->ctrl->flash_window_si=
ze) {
+    if (seg.size &&
+        (seg.addr + seg.size <=3D s->ctrl->flash_window_base ||
+         seg.addr > s->ctrl->flash_window_base + s->ctrl->flash_window_s=
ize)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: new segment for CS%d is inva=
lid : "
                       "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
                       s->ctrl->name, cs, seg.addr, seg.addr + seg.size);
--=20
2.21.0


