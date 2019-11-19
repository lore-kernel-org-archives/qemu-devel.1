Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFC5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38270222B0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 14:31:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38270222B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX4XP-00019t-9J
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 09:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iX4GY-0007KF-A6
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iX4GW-0005hL-SG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:02 -0500
Received: from 2.mo2.mail-out.ovh.net ([188.165.53.149]:36518)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iX4GW-0005gc-It
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 09:14:00 -0500
Received: from player795.ha.ovh.net (unknown [10.109.159.69])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id E4FDB1B5A72
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 15:13:58 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player795.ha.ovh.net (Postfix) with ESMTPSA id 2BB40C18ADFF;
 Tue, 19 Nov 2019 14:13:52 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 12/17] aspeed/smc: Add AST2600 timings registers
Date: Tue, 19 Nov 2019 15:12:06 +0100
Message-Id: <20191119141211.25716-13-clg@kaod.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191119141211.25716-1-clg@kaod.org>
References: <20191119141211.25716-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Ovh-Tracer-Id: 17917008169540487953
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudegkedgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepveorughrihgtucfnvgcuifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpeek
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 188.165.53.149
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

Each CS has its own Read Timing Compensation Register on newer SoCs.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ssi/aspeed_smc.h |  1 +
 hw/ssi/aspeed_smc.c         | 17 ++++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 684d16e33613..6fbbb238f158 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -40,6 +40,7 @@ typedef struct AspeedSMCController {
     uint8_t r_ce_ctrl;
     uint8_t r_ctrl0;
     uint8_t r_timings;
+    uint8_t nregs_timings;
     uint8_t conf_enable_w0;
     uint8_t max_slaves;
     const AspeedSegments *segments;
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 86cadbe4cc00..7755eca34976 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -137,7 +137,7 @@
 /* Checksum Calculation Result */
 #define R_DMA_CHECKSUM    (0x90 / 4)
=20
-/* Misc Control Register #2 */
+/* Read Timing Compensation Register */
 #define R_TIMINGS         (0x94 / 4)
=20
 /* SPI controller registers and bits (AST2400) */
@@ -256,6 +256,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 1,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 5,
         .segments          =3D aspeed_segments_legacy,
@@ -271,6 +272,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 1,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 5,
         .segments          =3D aspeed_segments_fmc,
@@ -288,6 +290,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D 0xff,
         .r_ctrl0           =3D R_SPI_CTRL0,
         .r_timings         =3D R_SPI_TIMINGS,
+        .nregs_timings     =3D 1,
         .conf_enable_w0    =3D SPI_CONF_ENABLE_W0,
         .max_slaves        =3D 1,
         .segments          =3D aspeed_segments_spi,
@@ -303,6 +306,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 1,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 3,
         .segments          =3D aspeed_segments_ast2500_fmc,
@@ -320,6 +324,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 1,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 2,
         .segments          =3D aspeed_segments_ast2500_spi1,
@@ -335,6 +340,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 1,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 2,
         .segments          =3D aspeed_segments_ast2500_spi2,
@@ -350,6 +356,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 1,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 3,
         .segments          =3D aspeed_segments_ast2600_fmc,
@@ -365,6 +372,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 2,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 2,
         .segments          =3D aspeed_segments_ast2600_spi1,
@@ -380,6 +388,7 @@ static const AspeedSMCController controllers[] =3D {
         .r_ce_ctrl         =3D R_CE_CTRL,
         .r_ctrl0           =3D R_CTRL0,
         .r_timings         =3D R_TIMINGS,
+        .nregs_timings     =3D 3,
         .conf_enable_w0    =3D CONF_ENABLE_W0,
         .max_slaves        =3D 3,
         .segments          =3D aspeed_segments_ast2600_spi2,
@@ -951,7 +960,8 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr =
addr, unsigned int size)
     addr >>=3D 2;
=20
     if (addr =3D=3D s->r_conf ||
-        addr =3D=3D s->r_timings ||
+        (addr >=3D s->r_timings &&
+         addr < s->r_timings + s->ctrl->nregs_timings) ||
         addr =3D=3D s->r_ce_ctrl ||
         addr =3D=3D R_INTR_CTRL ||
         addr =3D=3D R_DUMMY_DATA ||
@@ -1216,7 +1226,8 @@ static void aspeed_smc_write(void *opaque, hwaddr a=
ddr, uint64_t data,
     addr >>=3D 2;
=20
     if (addr =3D=3D s->r_conf ||
-        addr =3D=3D s->r_timings ||
+        (addr >=3D s->r_timings &&
+         addr < s->r_timings + s->ctrl->nregs_timings) ||
         addr =3D=3D s->r_ce_ctrl) {
         s->regs[addr] =3D value;
     } else if (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs) {
--=20
2.21.0


