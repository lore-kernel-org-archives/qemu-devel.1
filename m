Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB705C00454
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9004F222C4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 18:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XlCi4i/r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9004F222C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieNze-0008KC-Jj
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 13:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35059)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbE-0007x1-A0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbC-0007gr-CA
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 13:17:35 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53010)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=23948302b=alistair.francis@wdc.com>)
 id 1ieNbA-0007ed-LS; Mon, 09 Dec 2019 13:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1575915452; x=1607451452;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=zI4SBGpGMj8ok9qQKpMLTgRzPl5s4WakeWCo3XzAgaQ=;
 b=XlCi4i/rVJKCmyF0B73OBp9FBlhzHcvlIW6U7OfMi2lTm4VzFXlHl5g+
 ZCEAdL0oT8MtYORgf0eR5Xgrod2LA1rHXg98ZIJ9GRmMA/4pcaNVrtruZ
 fgSB5N2hUXypkbMcEvsRE1qq1HbsgLaqC3fhFXeDCQ0LiG5kElWVwVRG6
 Pjj1gLweKyYQKoBNgJWWWt2qsrYpm1wVKPMHtxYJsC17/9hqJmVVqNnqB
 0dR+Ay8GsiomncWX1IfrkeU9FgDyOOQ1GHXt2L0oF1opsod601lGJzsSh
 pTtlAPAXBDKard3rkLE67WzXIPvkjkEB5CayJ59ggwmTwaxOr7hUAyM/Z w==;
IronPort-SDR: SSX4LuCN6q04zjOH0ZsltV6/7LNhAdNsev8qBCsU9qnh9LzEGvh1ykS0RTcpu/6bNiJn2gutbV
 q4VNr9RyLgebH/PZx0LXv+HI9DOIPSidOqxYxisG3XXm4oVTePxWqk2yjHM4XuvuLqaWoZLqAs
 0SQTacBu8+UMF8qH7QwYY/gBNnbWDQ+whP9asOdxicxcJMw+JhRpfSFSxstyMYAx07OoH9r1JN
 jjShfphbL056EKmPSdmorcQMTv2vBLVbFv1C//OKgSsgiYoxM+GnSIxSWvwfAJwE8c3s71xcSF
 R1Q=
X-IronPort-AV: E=Sophos;i="5.69,296,1571673600"; d="scan'208";a="124925590"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2019 02:17:30 +0800
IronPort-SDR: 8iuBbxh5nVc4tYmjBYPfkQKR34tzWEeRY0uwLnC2B7gFKNs9ol94VnhwM/1kMQ8CsiuqT3eeqG
 w3xFJiPUYp7K0qaAjMrtrqHxv/xM/PLO+EpHX0UUhspIPX74w4bwxEbRd48u7CoI8b4wpxlKyK
 CxkiGlGkqu7hAZguAgQXF/F0DPwSyLnxqhryPPbmoDgZ1qXgT6p2nJ50+ctcO4Vs0hr2aGFZGR
 gzjALhY2aQgjVcv77oMarQNOCUsj/Tlx3KJ6wxNnQV6lkrarjSaV8+tVmCcJBtWmepCfkXr4c1
 rxEMN2+xOL1Eb6poVgJGx6ip
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2019 10:11:46 -0800
IronPort-SDR: bPHSErVPB9XUCjx2n3ELfRFR/M4Rc2qQknxNALRZOZDjPQ5y4t3PJ21zPmejQ5LlxtHaCP7/jN
 /P8dLMJA27416IF/QKiMK5r7F77r28WtrRwVsHzsl7f4OrfuS00cn1uv3OjV6068cWmMtdF9JX
 imXIMlZ0DAJlih7L0BbL3/5YjYg0gvmZTZSS/oyLhrMNktOeAtxlxwl9bIGLzLV3V7BgtysPRv
 wUrpzxHH8CNOLgpCFZt71yzmAYqTxAVuLkC37EHFXP2heO/p7ztSExV+njHijbO+pgtBPmmKi2
 UWY=
WDCIronportException: Internal
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.158.235])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2019 10:17:30 -0800
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [PATCH v1 26/36] target/riscv: Remove the hret instruction
Date: Mon,  9 Dec 2019 10:11:48 -0800
Message-Id: <c83aac89b3f1825c4c3ae282495a28572031f7d5.1575914822.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575914822.git.alistair.francis@wdc.com>
References: <cover.1575914822.git.alistair.francis@wdc.com>
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

The hret instruction does not exist in the new spec versions, so remove
it from QEMU.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/insn32.decode                     | 1 -
 target/riscv/insn_trans/trans_privileged.inc.c | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index cfd9ca6d2b..b883672e63 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -75,7 +75,6 @@ ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
 uret        0000000    00010 00000 000 00000 1110011
 sret        0001000    00010 00000 000 00000 1110011
-hret        0010000    00010 00000 000 00000 1110011
 mret        0011000    00010 00000 000 00000 1110011
 wfi         0001000    00101 00000 000 00000 1110011
 hfence_gvma 0110001    ..... ..... 000 00000 1110011 @hfence_gvma
diff --git a/target/riscv/insn_trans/trans_privileged.inc.c b/target/riscv/insn_trans/trans_privileged.inc.c
index b9b5a89b52..76c2fad71c 100644
--- a/target/riscv/insn_trans/trans_privileged.inc.c
+++ b/target/riscv/insn_trans/trans_privileged.inc.c
@@ -58,11 +58,6 @@ static bool trans_sret(DisasContext *ctx, arg_sret *a)
 #endif
 }
 
-static bool trans_hret(DisasContext *ctx, arg_hret *a)
-{
-    return false;
-}
-
 static bool trans_mret(DisasContext *ctx, arg_mret *a)
 {
 #ifndef CONFIG_USER_ONLY
-- 
2.24.0


