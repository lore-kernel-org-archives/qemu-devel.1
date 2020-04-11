Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56374C2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E002083E
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 13:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMp+YOud"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E002083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNGfE-0005MM-50
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 09:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npiggin@gmail.com>) id 1jNGdl-0004l2-6R
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npiggin@gmail.com>) id 1jNGdi-0007X0-Nz
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 09:57:45 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:50499)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npiggin@gmail.com>)
 id 1jNGdg-0007Sq-40; Sat, 11 Apr 2020 09:57:40 -0400
Received: by mail-pj1-x1042.google.com with SMTP id b7so1861285pju.0;
 Sat, 11 Apr 2020 06:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :user-agent:message-id:content-transfer-encoding;
 bh=CA2EXUjq+Smems++Ma6jf28vZQyf783AuJ5tepKvzfA=;
 b=DMp+YOudHyMCAXvEqVuaa7+96e2O9c2iSlraMUG5+nS0bzsiqt1LHYUO008HNzla+0
 aeYOaDj25zqXFdSnSa4F4BkJnuMbRC+SwNhRwjkCjIgAbLL8Zxl1ozzB9/sQd/JbliHF
 RK0FFcoBrnHA/dwgb2Nl95LobnwMnsnZJpu3+XD4l4N5PUL7p6mBnlG4T/z4BiQb+crv
 nWgzTlGEWo9shdYkxql16SVt208OFvM5O4Q4LVL+1H5PIDxoENgev8tFyY7Xu+DurRd4
 CjgOUyG0q+bum4jmYFS+jutZoukYDzQ8XUkBaLPIsdwN3tR4UI6d2pD4P4qYikuyJxo5
 h5vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:user-agent:message-id:content-transfer-encoding;
 bh=CA2EXUjq+Smems++Ma6jf28vZQyf783AuJ5tepKvzfA=;
 b=I2tZ4tGDdvR7W9O/UjkLqUFx3iBGeLLt6G2Oqskgh8i6xX7V9z/efseAvYMQysu/v7
 c33yMI73mf2Ng0O5KOMgLe3XYuYo6CXb//BRieY6Zlibr8QFaesyr7HfqFJ0+Zn8p4OD
 LzT+pJDi5fRmClIZuasn5pXwcDSvciLiW9SW0kFTn/j2M1oa90Dph8MTi74dH0b0zR2t
 AVpFDJZzYeUZWYg4z9FXpDpBrBtMtcjSbTmdCM9oQ8xPDoiP/PilISOpLmrYZL5goWJY
 Y6eHaWfLCweOTn99ITCoVC+SWNNPXh9hWvgacpawM5heOJWr1L1Zs6vqkAfdqZI5nWmJ
 F2gg==
X-Gm-Message-State: AGi0PuZHtVi3IehMs/AQN+gcbX4mCy6fhR/L5Sl3SaX0CaWUWegBV4Oz
 lfhUb6hQoJetkw6jhCqni3M=
X-Google-Smtp-Source: APiQypKJZjPQepDzedFgjgZHVNHo13y3VmhECU+Qh9O1RVtKp3jSMqIMYo0qxruFCc1cg2vyLVnXxg==
X-Received: by 2002:a17:90b:1985:: with SMTP id
 mv5mr11349089pjb.69.1586613458322; 
 Sat, 11 Apr 2020 06:57:38 -0700 (PDT)
Received: from localhost (60-241-117-97.tpgi.com.au. [60.241.117.97])
 by smtp.gmail.com with ESMTPSA id u18sm4380454pfl.40.2020.04.11.06.57.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 06:57:37 -0700 (PDT)
Date: Sat, 11 Apr 2020 23:57:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Boot flakiness with QEMU 3.1.0 and Clang built kernels
To: Nathan Chancellor <natechancellor@gmail.com>
References: <20200410205932.GA880@ubuntu-s3-xlarge-x86>
 <1586564375.zt8lm9finh.astroid@bobo.none>
 <20200411005354.GA24145@ubuntu-s3-xlarge-x86>
 <1586597161.xyshvdbjo6.astroid@bobo.none>
In-Reply-To: <1586597161.xyshvdbjo6.astroid@bobo.none>
MIME-Version: 1.0
User-Agent: astroid/0.15.0 (https://github.com/astroidmail/astroid)
Message-Id: <1586612535.6kk4az03np.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1042
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
Cc: qemu-devel@nongnu.org, clang-built-linux@googlegroups.com,
 =?iso-8859-1?q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Nicholas Piggin's on April 11, 2020 7:32 pm:
> Nathan Chancellor's on April 11, 2020 10:53 am:
>> The tt.config values are needed to reproduce but I did not verify that
>> ONLY tt.config was needed. Other than that, no, we are just building
>> either pseries_defconfig or powernv_defconfig with those configs and
>> letting it boot up with a simple initramfs, which prints the version
>> string then shuts the machine down.
>>=20
>> Let me know if you need any more information, cheers!
>=20
> Okay I can reproduce it. Sometimes it eventually recovers after a long
> pause, and some keyboard input often helps it along. So that seems like=20
> it might be a lost interrupt.
>=20
> POWER8 vs POWER9 might just be a timing thing if P9 is still hanging
> sometimes. I wasn't able to reproduce it with defconfig+tt.config, I
> needed your other config with various other debug options.
>=20
> Thanks for the very good report. I'll let you know what I find.

It looks like a qemu bug. Booting with '-d int' shows the decrementer=20
simply stops firing at the point of the hang, even though MSR[EE]=3D1 and=20
the DEC register is wrapping. Linux appears to be doing the right thing=20
as far as I can tell (not losing interrupts).

This qemu patch fixes the boot hang for me. I don't know that qemu=20
really has the right idea of "context synchronizing" as defined in the
powerpc architecture -- mtmsrd L=3D1 is not context synchronizing but that
does not mean it can avoid looking at exceptions until the next such
event. It looks like the decrementer exception goes high but the
execution of mtmsrd L=3D1 is ignoring it.

Prior to the Linux patch 3282a3da25b you bisected to, interrupt replay
code would return with an 'rfi' instruction as part of interrupt return,
which probably helped to get things moving along a bit. However it would
not be foolproof, and Cedric did say he encountered some mysterious
lockups under load with qemu powernv before that patch was merged, so
maybe it's the same issue?

Thanks,
Nick

The patch is a bit of a hack, but if you can run it and verify it fixes
your boot hang would be good.
---

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index b207fb5386..1d997f5c32 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -4364,12 +4364,21 @@ static void gen_mtmsrd(DisasContext *ctx)
     if (ctx->opcode & 0x00010000) {
         /* Special form that does not need any synchronisation */
         TCGv t0 =3D tcg_temp_new();
+        TCGv t1 =3D tcg_temp_new();
         tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
                         (1 << MSR_RI) | (1 << MSR_EE));
-        tcg_gen_andi_tl(cpu_msr, cpu_msr,
+        tcg_gen_andi_tl(t1, cpu_msr,
                         ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
-        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
+        tcg_gen_or_tl(t1, t1, t0);
+
+        gen_update_nip(ctx, ctx->base.pc_next);
+        gen_helper_store_msr(cpu_env, t1);
         tcg_temp_free(t0);
+        tcg_temp_free(t1);
+        /* Must stop the translation as machine state (may have) changed *=
/
+        /* Note that mtmsr is not always defined as context-synchronizing =
*/
+        gen_stop_exception(ctx);
+
     } else {
         /*
          * XXX: we need to update nip before the store if we enter
=

