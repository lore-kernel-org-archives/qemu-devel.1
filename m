Return-Path: <SRS0=CCzH=3V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3BBC33CB7
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:13:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E712F2063A
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Feb 2020 01:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VLSo/fu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E712F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixhLw-0000zU-4s
	for qemu-devel@archiver.kernel.org; Fri, 31 Jan 2020 20:13:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56626)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH1-0000zS-BU
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH0-0006CU-DL
 for qemu-devel@nongnu.org; Fri, 31 Jan 2020 20:08:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:17129)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=2939926b3=alistair.francis@wdc.com>)
 id 1ixhH0-00069K-3X; Fri, 31 Jan 2020 20:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1580519313; x=1612055313;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=cmLzQpUoUHVRHXGrA7b8U45rElR7fLzQ2/9P3hAehNM=;
 b=VLSo/fu9yJx7GqQUucu121MkbLw2c0diqseVYUMTGf691HCkd3BliMtz
 EbDaqeg7DWox9aqeeXT+B3IT9koLjKW3sQM1H7TOkF+KLjckgOf9Zw7bE
 deJRPyLLH2M7Tnh71vAZAsWRG89KoP52YGcJBJA2/7wweycGxljNK3sMH
 3TsqnASLwSTgPYEPZp1WtMliXIAIlIxlCot1rua1JaOr6ElwFkclULQkk
 SvozSFKGlZieTzc99IJuBtymnowLzszHQRv0in/KYh8HLTPANB6/87mMW
 kOiFjVdiDV+pTXQkQM9sV5P9zQ8pxR5dVb/CnngLWZ/Oag9QlOe4ctzAF A==;
IronPort-SDR: x3x5BpWiR1aBk9v98dn5z9kf3JnoXGY2QJsbEixXJdoFy//t8227XNUFjyhSrpridTYz8VeWCe
 vDfn7Ix1t2g29zjcxnZPRNpgnss0fZmpllMvrRMcANDa7bjuStCqol1m8tbGuNYWflki//l3cA
 FgfFqH66kei1CxLs2bTjHVv36ylOZVJeGc5ZIrEjZPFHChLMIVi3ubMDwS9rr0hHhOwj9CySMD
 KcxWG3KfIaY8lbPyZxPFqAwQrjDsprdI9voi65xCkiModh0rCF/bPAVduSArtUdVUCgO09IRjT
 VXQ=
X-IronPort-AV: E=Sophos;i="5.70,388,1574092800"; d="scan'208";a="128872422"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2020 09:08:33 +0800
IronPort-SDR: rBz1BYKFbPS1f3ILpzmrPAZvyDv4wIT7IlFC1xyMIVkzZvufxpZQQOHRVBgq3EILWJB+GCGF8o
 RXTOqVDM92OVWM//yp9+G6cXtx71Yii3aoeTNssx0LhPnuaqKDoWCOayfY7rSzAMVSyXvxWriO
 ghv9g4ewZSSbdmpLXxvjmiZBL0mTwuamcVUU74/JczRAVWdC5em/1u6wFtFdYPCO2b6wizPkuG
 DaQ993Wjkgt7v3xdLIqG69/e7yDd+Lyi/wPuhFj6TGYOwot4fNnJTGfk/x7wKFoH3MrLsXQyBK
 A3r8fHLCWUIoIh17u/uQjVkA
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2020 17:01:42 -0800
IronPort-SDR: +E+ewVnSIc0LQHYZH2IZZkWoLvi/273mf4ESsbMWXG5WMp4lENOiawL9/lZuUVdgo5q+3Gpzg7
 +yy+Nty10AUL+w4SEsgY0clcD+n3hjsNYJQP+QjbbRH4YFsCBs/tC/TwGeNbwKntTFzvqLSVp0
 VbeM8D8WBSJeTUAvunVGGGaSBVB/EBNhux2nYKxSDTgsr0f2hmBP8t9dWxatI0hLLMPOE2Tald
 okjYRAYKotc+K7Dwk0c1olDJLoOZD/AWEyhcCdgSGr2xxgGWo9p/IiSvY6KHCgDRXPRQOff83L
 9UE=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip01.wdc.com with ESMTP; 31 Jan 2020 17:08:33 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v2 08/35] target/riscv: Fix CSR perm checking for HS mode
Date: Fri, 31 Jan 2020 17:01:56 -0800
Message-Id: <a7101c563ccc9f6a0999dac69adfe09d59e1af5f.1580518859.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1580518859.git.alistair.francis@wdc.com>
References: <cover.1580518859.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.154.42
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
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the CSR permission checking to work correctly when we are in
HS-mode.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 target/riscv/csr.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/target/riscv/csr.c b/target/riscv/csr.c
index ca27359c7e..c63b2f980c 100644
--- a/target/riscv/csr.c
+++ b/target/riscv/csr.c
@@ -801,12 +801,22 @@ int riscv_csrrw(CPURISCVState *env, int csrno, target_ulong *ret_value,
 
     /* check privileges and return -1 if check fails */
 #if !defined(CONFIG_USER_ONLY)
-    int csr_priv = get_field(csrno, 0x300);
+    int effective_priv = env->priv;
     int read_only = get_field(csrno, 0xC00) == 3;
-    if ((!env->debugger) && (env->priv < csr_priv)) {
-        return -1;
+
+    if (riscv_has_ext(env, RVH) &&
+        env->priv == PRV_S &&
+        !riscv_cpu_virt_enabled(env)) {
+        /*
+         * We are in S mode without virtualisation, therefore we are in HS Mode.
+         * Add 1 to the effective privledge level to allow us to access the
+         * Hypervisor CSRs.
+         */
+        effective_priv++;
     }
-    if (write_mask && read_only) {
+
+    if ((write_mask && read_only) ||
+        (!env->debugger && (effective_priv < get_field(csrno, 0x300)))) {
         return -1;
     }
 #endif
-- 
2.25.0


