Return-Path: <SRS0=SLMP=AQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E1FC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C69120720
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2020 18:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fSWiZTFq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C69120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1js9Cy-0003VN-J1
	for qemu-devel@archiver.kernel.org; Sun, 05 Jul 2020 14:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45908)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1js9C5-0002zI-M4; Sun, 05 Jul 2020 14:16:49 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1js9C4-0003KT-9G; Sun, 05 Jul 2020 14:16:49 -0400
Received: by mail-pj1-x1042.google.com with SMTP id b92so16025265pjc.4;
 Sun, 05 Jul 2020 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vzwXKwBxzMlfQOfpm981coONyXr9PQ6P2V2Qm8gfRoI=;
 b=fSWiZTFqoTFCNo1uejRPO6gY/DMUIc0LgWA4QJYi4qEyT4pqlgqWpa6U60DMWlbraD
 xDdJlUG+sQdIxn4tChskQGNVVqToIOJWLNdWvyxMMTq6w5H5x2g7SZA6CgsG4pq2KzLQ
 U9JT/Hze3meujLQtqA5Dm1tftVwszrRMM5y9D/DX5m9NajahWjOtTbGpIoiF2BP75Cq6
 W5CdCLzo6tlJcD7X6ld3zCXrYQTghT0ybwvO2BqqtUcZWjig0lF6wGNWQUOnADO8e70q
 UA/ILs/H8KaRH2/SkieTcH+dBGJX/WX/J/yW6hrVCy6lmanLKJzXD+C7x0gBf7osSyJc
 pRlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vzwXKwBxzMlfQOfpm981coONyXr9PQ6P2V2Qm8gfRoI=;
 b=XxwrnCz1uuZWhMXEvJ4kRDfwJGEcR+OYgf9CciYxtoKppCpMqoig/SY0Uojcy9I8oX
 CBw4Ry5+jnrhLbDBHFPPohXD36De2KJfeOPVRolokxB2dRqN4dJdBoWtaU5s857E5xH0
 3Lgv6ouJxxeBz/5DZzAtWeHDpl7RegSiC6O/x4E8P7tB+ATivxCZHfM7wvadxMypYysG
 Wb2pGhjpBn2OZ0cBOMsWz+qFUfYayiGxSD1VYBktQX76/N97R7sy4qV262omiHhqpqos
 ICiJbDHWfl7XSaw0r8xIch16OXio8KUtudSY16ej7Yya20rbLimsMHhgMDkomF37cFxZ
 fUzw==
X-Gm-Message-State: AOAM532K3HpURYYsajgcYA6d3o6z1Bq6gCw6Qv6ZcAcjKb/OQOdyGoE+
 LrLuafMGVnEN4Uwq/zYujyN4ojdEHq0STzdgh+0=
X-Google-Smtp-Source: ABdhPJwp0YshKfHrboJI+dbiYHih4Fj+ess4NkMwddohSRmrXCMLjxW4gKo9lrk+B3OdrWJNyAVpBfyqhQ1tcEq5IV0=
X-Received: by 2002:a17:902:b694:: with SMTP id
 c20mr37838996pls.123.1593973006134; 
 Sun, 05 Jul 2020 11:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200629160535.3910-1-wentong.wu@intel.com>
 <20200629160535.3910-3-wentong.wu@intel.com>
 <3260735e-05ab-2d42-f7e4-914ad804f543@linaro.org>
 <CAFEAcA_+e7hrA5GRGb=gv3GxJRL77ARP34vyudRbiqhdsNVKwg@mail.gmail.com>
In-Reply-To: <CAFEAcA_+e7hrA5GRGb=gv3GxJRL77ARP34vyudRbiqhdsNVKwg@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 5 Jul 2020 11:16:34 -0700
Message-ID: <CAMo8BfLVDEFCXWNffVJaRb31UOTPO1iXNz5StexoKvWqQYzg6g@mail.gmail.com>
Subject: Re: [PATCH 3/3] target/nios2: Use gen_io_start around wrctl
 instruction
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Marek Vasut <marex@denx.de>, Chris Wulff <crwulff@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>, Wentong Wu <wentong.wu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 10:09 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> On Thu, 2 Jul 2020 at 19:53, Richard Henderson
> <richard.henderson@linaro.org> wrote:
> > This isn't right.  Not so much the gen_io_start portion, but the entire
> > existence of helper_check_interrupt.
>
> I agree that it looks bogus (xtensa has a similar helper as well, incidentally),

I think there was a reason for it. According to Richard

> The correct way to acknowledge interrupts after changing an interrupt mask bit
> is to exit the TB back to the cpu main loop.

But if I do this change for Xtensa I get a bunch of test_interrupt failures
that indicate that the interrupt that should have been taken wasn't taken.
FTR here's the change that I tested, did I miss something?

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index fdf47642e6f1..85e8d65f169d 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -631,18 +631,10 @@ static int gen_postprocess(DisasContext *dc, int slot)
 {
     uint32_t op_flags = dc->op_flags;

-#ifndef CONFIG_USER_ONLY
-    if (op_flags & XTENSA_OP_CHECK_INTERRUPTS) {
-        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-            gen_io_start();
-        }
-        gen_helper_check_interrupts(cpu_env);
-    }
-#endif
     if (op_flags & XTENSA_OP_SYNC_REGISTER_WINDOW) {
         gen_helper_sync_windowbase(cpu_env);
     }
-    if (op_flags & XTENSA_OP_EXIT_TB_M1) {
+    if (op_flags & (XTENSA_OP_EXIT_TB_M1 | XTENSA_OP_CHECK_INTERRUPTS)) {
         slot = -1;
     }
     return slot;
@@ -1175,7 +1167,7 @@ static void disas_xtensa_insn(CPUXtensaState
*env, DisasContext *dc)
     if (dc->base.is_jmp == DISAS_NEXT) {
         gen_postprocess(dc, 0);
         dc->op_flags = 0;
-        if (op_flags & XTENSA_OP_EXIT_TB_M1) {
+        if (op_flags & (XTENSA_OP_EXIT_TB_M1 | XTENSA_OP_CHECK_INTERRUPTS)) {
             /* Change in mmu index, memory mapping or tb->flags; exit tb */
             gen_jumpi_check_loop_end(dc, -1);
         } else if (op_flags & XTENSA_OP_EXIT_TB_0) {


-- 
Thanks.
-- Max

