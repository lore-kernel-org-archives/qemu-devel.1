Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7A3C352BE
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:03:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E7B20776
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 18:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSgOVNvz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E7B20776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60475 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPro8-00009i-Ft
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 14:03:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1jPrmm-0007gR-Gz
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 14:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <josemartins90@gmail.com>) id 1jPrml-0006NS-B5
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 14:01:48 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:39648)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <josemartins90@gmail.com>)
 id 1jPrmi-0006MG-Md; Sat, 18 Apr 2020 14:01:44 -0400
Received: by mail-io1-xd43.google.com with SMTP id e127so6133803iof.6;
 Sat, 18 Apr 2020 11:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to:cc;
 bh=WohNrsQPuTHTAitkS+Hsv10fCQyuOe669Z2kncG5j4w=;
 b=kSgOVNvzJa7QXhH3jSVmmDt1R6Q6gEzRiUA5JS0iqhS3xt0nftZE1S2uapMM0AKwwS
 Zw9Q7atE+G+Edz9DTi1rD8dG755FRm8s2ze4tQNpZtsa8dZV9H6KMmqd19+fbSUSMsjk
 bvHkGMx3pNosnQK0Qi7i7497Y6zhxsp2qifm58dIbRJ8FFbauYHA/7+GXVTBurqjrqem
 uUNFSrP/hRgnfmAIkfeFMVmKNQS+unVAqJTEefEl2jW3kxS+rc7cfWvq/lU91W1W3Bmw
 GjLsj62iFI7A37L9Y1iip4cxZd5s8nkVEcDxSwRHPHFZp/34m4Y/te2pgvPrtc2f5T4h
 LM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
 bh=WohNrsQPuTHTAitkS+Hsv10fCQyuOe669Z2kncG5j4w=;
 b=GsrAjAuKdaLSL3cbLeSS1a/tyouC4x0mGnmu9QXAnuZOx2SoVXygpFC+Fh2L5O/Tfa
 S57ok7u1nrfwQ9apN3psGKV6GFmfRQZrQ8yh6BLKO841HQCGPCx+cLLQEs47ATJozKaS
 vItfPdLvY2nOgYNVZzp7zKy+g28t9WvwMYeOKCVWlr90/1CtCMT44T5cSrDYRLnv27jY
 CZdXCvOawY0l2VFSIR6kiKAPU3DP5iCyXAsRKLQvCwDr+xTH75p0CpL0e+T47uLjXTNP
 HPbkekOh0azTcVo+oslXVQZqyfuVvPZq8FgcplALOtHijutE0CalOB1H0WH9wIfAMtCt
 OqEA==
X-Gm-Message-State: AGi0PuZ8FqKrreUKiwENLTCiEPMZmaj96ZhfrWBLsyF6nofAQxN0vwlT
 AA9giZqe93fPzZup8FFJ60JJ110trorCEHTvzP6go394UUE=
X-Google-Smtp-Source: APiQypIABaBDgfJtQPhqVvjW8r/IrIvpJTEI+W6uqggnU4+TZqecXHnpiQGyHas8d8NtmG5FWZY4m92kti0V3aep/Aw=
X-Received: by 2002:a05:6638:11a:: with SMTP id
 x26mr2059966jao.89.1587232902698; 
 Sat, 18 Apr 2020 11:01:42 -0700 (PDT)
MIME-Version: 1.0
From: Jose Martins <josemartins90@gmail.com>
Date: Sat, 18 Apr 2020 19:01:31 +0100
Message-ID: <CAC41xo2O1k+cn7EO3Zu3U70qefFwGa5B1iNRNgRwLk7SGX=-Aw@mail.gmail.com>
Subject: [PATCH 1/1] target/riscv: fix VS interrupts forwarding to HS
To: qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: alistair.francis@wdc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When vs interrupts (2, 6, 10) are enabled, pending and not delegated
in hideleg, they are not always forwarded to hs mode after a return to
vs mode. This happens independently of the state of spie and sie on
the hs-level sstatus before the return. Instead, the vs-level status
sie state seems to be controlling if the interrupt is forward to hs or
not. This is both because, in riscv_cpu_local_irq_pending, vs
interrupts are ignored when checking for hs pending interrupts and
also because hs interrupts might not be considered enabled after
jumping to vs mode if the spie (which implicitly is copied to sie) is
not set when sret is executed. From what I could gather, the spec does
not preclude hs mode from receiving vs interrupts if they are not
delegated in hideleg (although this is true for m mode, but guaranteed
by hardwiring the corresponding bits in mideleg). Also, it clearly
states that: "Interrupts for higher-privilege modes, y>x, are always
globally enabled regardless of the setting of the global yIE bit for
the higher-privilege mode.", so hs_mstatus_sie must be set whenever
virt is enabled. After solving the previous issue, the problem remains
that when such interrupts are delegated in hideleg, there is still the
need to check it when calculating pending_hs_irq, otherwise, we're
still "forcing an hs except" when the interrupt should be forwarded to
vs. I believe the following patch will fix this issue:

Signed-off-by: Jose Martins <josemartins90@gmail.com>
---
 target/riscv/cpu_helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
index d3ba9efb02..9962ee4690 100644
--- a/target/riscv/cpu_helper.c
+++ b/target/riscv/cpu_helper.c
@@ -43,8 +43,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
     target_ulong mstatus_sie = get_field(env->mstatus, MSTATUS_SIE);
     target_ulong hs_mstatus_sie = get_field(env->mstatus_hs, MSTATUS_SIE);

-    target_ulong pending = env->mip & env->mie &
-                               ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
+    target_ulong pending = env->mip & env->mie;
     target_ulong vspending = (env->mip & env->mie &
                               (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));

@@ -52,11 +51,11 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
                           (env->priv == PRV_M && mstatus_mie);
     target_ulong sie    = env->priv < PRV_S ||
                           (env->priv == PRV_S && mstatus_sie);
-    target_ulong hs_sie = env->priv < PRV_S ||
+    target_ulong hs_sie = riscv_cpu_virt_enabled(env) || env->priv < PRV_S ||
                           (env->priv == PRV_S && hs_mstatus_sie);

     if (riscv_cpu_virt_enabled(env)) {
-        target_ulong pending_hs_irq = pending & -hs_sie;
+        target_ulong pending_hs_irq = pending & ~env->hideleg & -hs_sie;

         if (pending_hs_irq) {
             riscv_cpu_set_force_hs_excep(env, FORCE_HS_EXCEP);
-- 
2.17.1

