Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F32AC4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E12320663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 23:48:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hpfjG/He"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E12320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55518 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfYhb-0003VU-Na
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 19:48:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52006)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe6-0001IR-Ft
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe4-0001JQ-QC
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 19:45:10 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22357)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=07161884e=alistair.francis@wdc.com>)
 id 1hfYe2-0001Bo-Nz; Mon, 24 Jun 2019 19:45:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1561420071; x=1592956071;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1+PXwSnajGbLkrAQCAISjt8r6tt/L6oI4MTJ0K1AHBU=;
 b=hpfjG/HeOgoxfxeartF1LR35dQE9ZC5YJdrvU+OdyZ4e01tnM/iueLof
 Xz8USsW7nd3kR1xQxB/dfVIATRnr/ibxVgKrC5x5SbWz8UHeXrlN/cFD3
 9wfldm3HRp0TI7xDHwhGBfZj8dXGKXDSV7cuFnvK8wDLh5h6Sxo+RMno7
 Mk6kY1NZg94Q3dySNkPTEWhZo5zyc3HeUAewzp/whYZ5sjB3jIuWlfL4p
 KeEVE0fsMXMAwdKPm9QcWhhJV7hlFkNvyzlzGvBzaVuFrxcxIS2z2n+EU
 zvzHXzmZXTpka1R4knWv5HQJebahz7MEqnJoVTDTHb6zOohJWyGX3ffcD Q==;
X-IronPort-AV: E=Sophos;i="5.63,413,1557158400"; d="scan'208";a="211216774"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Jun 2019 07:47:48 +0800
IronPort-SDR: c2oU/GJnLLcfv2lRqTrn2Qkgk6lM5F4QbuDlY9MRQNC55Og8+NqJvFhjcoMLFB38yGxmuI7zkn
 s1LG+9VhJLCMwgQKzaMAx8smed6bk3rwwTTKxXx7bGrS0LT/gFl59PTbT55D9jmXzQPiTwFPna
 lQ8B0ADwgQBryisEONJPyGZXh/olfrNUzaDVIqbZ2WHpFstDWU1H6347MJx3A5U4vABREcCFzE
 407c4WUnl2mIn5mBU7I/GUT2O9JqTiRB1Y6/tO38hsfWdhc5lHv8qKL8lUCbXHK9eZh8yp5Js/
 0XaV5bzLx3dye0DKwrnkP1LR
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP; 24 Jun 2019 16:44:22 -0700
IronPort-SDR: ZHUzUF+NMsOPvBSI7CA7Xv32OH0/8uhx6LRmZ4NpyInTwUJkvao0JNs3jtMUZ8yqT9t+H+AtGV
 VkAo3ZZJMdbTaZXJCGWFtt7ALTTJKzB1qqYsznMeWgMDgOk2yAuw+RxDby1hyP6guNFn3km/BV
 bWqw+bjbLa5U0hzMMVndk0vPKKaNdLYzU9ryhM9XwlbnS6M1C6q231CAFeAv2LTa1GUvkmUYWU
 crUCi6ow/uulL1hSlBihqsnH/wRkhjPWTOJ4ZZwQNOXmcD++e0VwBUPEHVO4aSPSvKFe3EZebM
 Ssw=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.140])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Jun 2019 16:45:04 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Mon, 24 Jun 2019 16:42:35 -0700
Message-Id: <c8ce0392eced92ef29e64a4dafd0b8a0e00f3280.1561419713.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <cover.1561419713.git.alistair.francis@wdc.com>
References: <cover.1561419713.git.alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 68.232.143.124
Subject: [Qemu-devel] [PATCH v2 3/4] disas/riscv: Fix `rdinstreth` constraint
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Clark <mjc@sifive.com>

The constraint for `rdinstreth` was comparing the csr number to 0xc80,
which is `cycleh` instead. Fix this.

Signed-off-by: Wladimir J. van der Laan <laanwj@gmail.com>
Signed-off-by: Michael Clark <mjc@sifive.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 3ab4586f0a..bdcc70a68e 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -614,7 +614,7 @@ static const rvc_constraint rvcc_rdtime[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc01, r
 static const rvc_constraint rvcc_rdinstret[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc02, rvc_end };
 static const rvc_constraint rvcc_rdcycleh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
 static const rvc_constraint rvcc_rdtimeh[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc81, rvc_end };
-static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc80, rvc_end };
+static const rvc_constraint rvcc_rdinstreth[] = { rvc_rs1_eq_x0, rvc_csr_eq_0xc82, rvc_end };
 static const rvc_constraint rvcc_frcsr[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x003, rvc_end };
 static const rvc_constraint rvcc_frrm[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x002, rvc_end };
 static const rvc_constraint rvcc_frflags[] = { rvc_rs1_eq_x0, rvc_csr_eq_0x001, rvc_end };
@@ -1031,7 +1031,7 @@ const rv_opcode_data opcode_data[] = {
     { "c.lui", rv_codec_ci_lui, rv_fmt_rd_imm, NULL, rv_op_lui, rv_op_lui, rv_op_lui, rvcd_imm_nz },
     { "c.srli", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srli, rv_op_srli, rv_op_srli, rvcd_imm_nz },
     { "c.srai", rv_codec_cb_sh6, rv_fmt_rd_rs1_imm, NULL, rv_op_srai, rv_op_srai, rv_op_srai, rvcd_imm_nz },
-    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi, rv_op_andi, rv_op_andi, rvcd_imm_nz },
+    { "c.andi", rv_codec_cb_imm, rv_fmt_rd_rs1_imm, NULL, rv_op_andi, rv_op_andi, rv_op_andi },
     { "c.sub", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_sub, rv_op_sub, rv_op_sub },
     { "c.xor", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_xor, rv_op_xor, rv_op_xor },
     { "c.or", rv_codec_cs, rv_fmt_rd_rs1_rs2, NULL, rv_op_or, rv_op_or, rv_op_or },
-- 
2.22.0


