Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E69DC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:25:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F03B72081C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 14:25:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqZ+Y5xJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F03B72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37453 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTofN-0003uY-6f
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 10:25:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodZ-0002a8-Un
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTodY-0006sO-Ob
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:05 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTodY-0006rg-EL
	for qemu-devel@nongnu.org; Thu, 23 May 2019 10:24:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id e15so6529966wrs.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 07:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding;
	bh=8woPEtG8YS4MOTdISE4mp0N5yE3FIOBq9YtwFKXxb9k=;
	b=sqZ+Y5xJby1OAUrlrXJ1PDT+sgzej2FcbkZwKb9lp0s1hakGDxO2oUavGRni2aaFTj
	pXmQcKsxAVw+V7eAOGKazo9RFRwM5nVIlfTR/+ZDbZCYxUNAv4A6WTMRKTK/WGUjTAkU
	dLFxQRrk0kJvjB0JpDOKq1pEkOm8bAJWorEe7qTeqJ84tz8RY6uz+ByFBZ3DC1qp9NhS
	B9HryrIDRH41WM9ivsyBxGZmELC1u+lyOimjRYs9Q1dWdg86z0v2Cy7A/PopWXhXLIuI
	fO0FYibA4c5vDUWvx8r/xsaZpo0KSVhNzpLnAsthKqR9qNe5c4w5tvscQn6vPFw0FjVD
	3Dsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=8woPEtG8YS4MOTdISE4mp0N5yE3FIOBq9YtwFKXxb9k=;
	b=dBtNOc1+itQ54LhQrBJyNuYJ5q0S99itzqmio4K5ev0nkyACfscYeWlkvth8zlJiLD
	FUJDkXogdWH99mu04qIVzaVlortiLtINMa658+a/goJVnnj7aOmAV8JaqG59r4U/Lw/w
	qSj44IQaH40kvmV4k/ZSRC3f027fq9rtr3q3mmAz977wztIMc12pQP9TmvPVvFUriSyw
	DsZleHoMhfgULFpILXu02cGeK7cd07Yd4hFBWnrKDqBcDSLlqrrt9+FxuMK5vsZC4Yuc
	CWBc1CYIJmBdisOHCCn0cCDysdHZBxzE2l66HMU5W/te54kSSsrVU/bk/AVYdVZAzc8J
	KBVg==
X-Gm-Message-State: APjAAAX6c7vN6Gxqtj6eI+uMcAyVsaKr5GUF2ux87C8XimIfNiqAYB0b
	1ITtv2qHSdtbcupRrIw7akFIDbfM29IZLA==
X-Google-Smtp-Source: APXvYqyQ6iPdy52r4+evttVbovcAm0bMQt7lUXoXKJaBUecrIMPbxxlTYFUvMucRXxQkAvyfqONYPw==
X-Received: by 2002:a5d:53c6:: with SMTP id a6mr35404971wrw.232.1558621442445; 
	Thu, 23 May 2019 07:24:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id z5sm9700617wmi.34.2019.05.23.07.24.01
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 07:24:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu, 23 May 2019 15:23:48 +0100
Message-Id: <20190523142357.5175-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190523142357.5175-1-peter.maydell@linaro.org>
References: <20190523142357.5175-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PULL 03/12] target/arm: Fix vector operation segfault
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <alistair.francis@wdc.com>

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
Message-id: ad91b397f360b2fc7f4087e476f7df5b04d42ddb.1558021877.git.alistair.francis@wdc.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index dd053c80d62..298c262825d 100644
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
2.20.1


