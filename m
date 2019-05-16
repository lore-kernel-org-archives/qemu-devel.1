Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5303BC04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:57:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCC220815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 15:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NmO/Xl8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCC220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60250 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRIkt-00089v-OH
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 11:57:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=032022a23=alistair.francis@wdc.com>)
	id 1hRIjo-0007ik-MY
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:56:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=032022a23=alistair.francis@wdc.com>)
	id 1hRIjn-0000MD-86
	for qemu-devel@nongnu.org; Thu, 16 May 2019 11:56:08 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:24383)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=032022a23=alistair.francis@wdc.com>)
	id 1hRIjm-00007P-GY; Thu, 16 May 2019 11:56:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
	d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
	t=1558022167; x=1589558167;
	h=from:to:cc:subject:date:message-id:mime-version:
	content-transfer-encoding;
	bh=pZrU0rLEl7AtHjWF7GI8X1ehkUlz2HyiMO84c3e1OXI=;
	b=NmO/Xl8gNPRh7s3ILTtpKczp7AEecx7ZpOX3b5t/Ed6xC9mMVMMnxcbz
	NKIOlV2DdzuQL55XojirWAKX+XD+pWxuRNOlxPhJ5SHpF+G7Zy+PKni77
	dBT48sjltZmUB6O94e7qjuJRaIaqHelM6KFv0U76/aZ1TpIiwD0CKfvpc
	nUBELfXn3v/E8BEsIs47W0wJbxiODfYy4jm+Ql3nb9J3dvyaqeWUqOYKc
	qMVNvxLtGY6cTpWWyl3KuW02i7IlPGGSwwLiymkH6yhy/WL1qjaKE6bsb
	fSL+/fKexcMcYYoWFLrRIzcYrATGqqH7S7qt53m+WuGWXapeJlcw+e4+b g==;
X-IronPort-AV: E=Sophos;i="5.60,477,1549900800"; d="scan'208";a="113375280"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
	([199.255.45.14])
	by ob1.hgst.iphmx.com with ESMTP; 16 May 2019 23:56:02 +0800
IronPort-SDR: /mwFINPXrPe2YxMN4MLZB0xhiC8LagBcduJVmGGyIwGH1Ktz/mqxux9ENBYck5OUawYO30Cafy
	aeXGDN5FSZ+2DK11yUQKzUDNYuKfn1BP9pyKKQpAANZ4F/kvuIpv1LErcyXsa86ei5ScTcGvb5
	EPbLm32rMcAEAWt/JwfIZaqvIwXmGojaEqGCd978VwGUCkbgBfyX196Mv+SF+r7bkWIPwbwOGh
	R+yHwZsz5ciOUVe+bcc3afguCJ3A9QDsX8C5SWmSDGh6Up8dA6kdKZ/j3bWDcTgjXKQUPcrqCw
	W1ihK4RUYgYK11snR8Iq3BN3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
	by uls-op-cesaep01.wdc.com with ESMTP; 16 May 2019 08:31:37 -0700
IronPort-SDR: UOieCsjXzhXGKQUiSYIaqfcxYjdEnZab/0yyE/PCdqB7/fXnp9BbOx4fB7dcGnNdjxEkCs73+a
	/bWzqcYqX6cfZQ5rUyHQujhXRLlqhyx51kQD3MyduZ1hEwXrW0zq9ENXV8eQvHQflmQymYgzdq
	YMaRLbK3Jcol/je8OQ/vbUZAr4vD+eB0S3DRfeUjtIP775NlMw/xBYJvGZgv7GfSaBycINj2FQ
	ohhjApOKNT9H46UEvzcr973/G5zz2C9fIevmUA63/VuxG2nlUJhntXj1DZacXtp4vSoHMPNopr
	Rp4=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
	risc6-mainframe.int.fusionio.com) ([10.196.157.140])
	by uls-op-cesaip02.wdc.com with ESMTP; 16 May 2019 08:56:01 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Thu, 16 May 2019 08:54:10 -0700
Message-Id: <ad91b397f360b2fc7f4087e476f7df5b04d42ddb.1558021877.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 216.71.153.141
Subject: [Qemu-devel] [PATCH v3 1/1] target/arm: Fix vector operation
 segfault
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
Cc: philmd@redhat.com, richard.henderson@linaro.org, qemu-arm@nongnu.org,
	alistair.francis@wdc.com, alistair23@gmail.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 89e68b575 "target/arm: Use vector operations for saturation"
causes this abort() when booting QEMU ARM with a Cortex-A15:

0  0x00007ffff4c2382f in raise () at /usr/lib/libc.so.6
1  0x00007ffff4c0e672 in abort () at /usr/lib/libc.so.6
2  0x00005555559c1839 in disas_neon_data_insn (insn=<optimized out>, s=<optimized out>) at ./target/arm/translate.c:6673
3  0x00005555559c1839 in disas_neon_data_insn (s=<optimized out>, insn=<optimized out>) at ./target/arm/translate.c:6386
4  0x00005555559cd8a4 in disas_arm_insn (insn=4081107068, s=0x7fffe59a9510) at ./target/arm/translate.c:9289
5  0x00005555559cd8a4 in arm_tr_translate_insn (dcbase=0x7fffe59a9510, cpu=<optimized out>) at ./target/arm/translate.c:13612
6  0x00005555558d1d39 in translator_loop (ops=0x5555561cc580 <arm_translator_ops>, db=0x7fffe59a9510, cpu=0x55555686a2f0, tb=<optimized out>, max_insns=<optimized out>) at ./accel/tcg/translator.c:96
7  0x00005555559d10d4 in gen_intermediate_code (cpu=cpu@entry=0x55555686a2f0, tb=tb@entry=0x7fffd7840080 <code_gen_buffer+126091347>, max_insns=max_insns@entry=512) at ./target/arm/translate.c:13901
8  0x00005555558d06b9 in tb_gen_code (cpu=cpu@entry=0x55555686a2f0, pc=3067096216, cs_base=0, flags=192, cflags=-16252928, cflags@entry=524288) at ./accel/tcg/translate-all.c:1736
9  0x00005555558ce467 in tb_find (cf_mask=524288, tb_exit=1, last_tb=0x7fffd783e640 <code_gen_buffer+126084627>, cpu=0x1) at ./accel/tcg/cpu-exec.c:407
10 0x00005555558ce467 in cpu_exec (cpu=cpu@entry=0x55555686a2f0) at ./accel/tcg/cpu-exec.c:728
11 0x000055555588b0cf in tcg_cpu_exec (cpu=0x55555686a2f0) at ./cpus.c:1431
12 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=0x55555686a2f0) at ./cpus.c:1735
13 0x000055555588d223 in qemu_tcg_cpu_thread_fn (arg=arg@entry=0x55555686a2f0) at ./cpus.c:1709
14 0x0000555555d2629a in qemu_thread_start (args=<optimized out>) at ./util/qemu-thread-posix.c:502
15 0x00007ffff4db8a92 in start_thread () at /usr/lib/libpthread.

This patch ensures that we don't hit the abort() in the second switch
case in disas_neon_data_insn() as we will return from the first case.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
---
v3:
 - Resend with hopefully 8bit encoding instead of base64

 target/arm/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index dd053c80d6..298c262825 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -6598,13 +6598,13 @@ static int disas_neon_data_insn(DisasContext *s, uint32_t insn)
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
                            (u ? uqadd_op : sqadd_op) + size);
-            break;
+            return 0;
 
         case NEON_3R_VQSUB:
             tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                            rn_ofs, rm_ofs, vec_size, vec_size,
                            (u ? uqsub_op : sqsub_op) + size);
-            break;
+            return 0;
 
         case NEON_3R_VMUL: /* VMUL */
             if (u) {
-- 
2.21.0


