Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63955C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 20:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F8F920709
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 20:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmyjy7A9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F8F920709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZhA0-0003C0-BJ
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 16:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amanieu@gmail.com>)
 id 1jZh9L-0002an-CT; Fri, 15 May 2020 16:41:43 -0400
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:35570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <amanieu@gmail.com>)
 id 1jZh9K-0003W4-GV; Fri, 15 May 2020 16:41:43 -0400
Received: by mail-qk1-x741.google.com with SMTP id f13so4068628qkh.2;
 Fri, 15 May 2020 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=sGI3cjgD81o12Yb6qGdPXmUNebFu5+QVlbT6fJWHnzs=;
 b=tmyjy7A9kIv+puWrfW3m9wDPnko0MHq+eiqzepgT5MCyZjH73mmllhE30/HcltIrzp
 jyErc3t60N1HJJzQzT2tpmdctAN9eajFriolGxqchqU6dRoMGseo9crxsylP9A/3Sr/X
 IoTORgcol/mkUml8k0zRBLAdy4ddTAH/Xumw49Q98ZBI4Y6sqg+2ZEwJCTsuDTEyBzgR
 aCKLWaw5g1pTcbS9UmyumRcfXhTtUp5LQu6etLyGYotIbNRIMnUcSjIEPTZMFWiMMqxV
 w8bteZotaCyfZ8R0ElcgxXjolhHbTgGDyUHHU4ZJhjcV3Pb4U9a3ZWkIZ7FzXXqg3bt7
 AN0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sGI3cjgD81o12Yb6qGdPXmUNebFu5+QVlbT6fJWHnzs=;
 b=eiP0Cs3rZggAgAOBUXofK/ekdcrPdtvGoJxqlSLZV/kfD+JvUUI7mW1yyCfvvaUpuC
 hVGLzEkhhrL2Ln8UKbU0p7SYWjXWgPrxqSq+zNwZ0U1PPCQHAKep53v2bo0YoKbi521K
 97bMjageRbrxclOGYuPD7GaM5xH9APZnUxfJQCrmcJ24niA8pZX37ecoQGyJ8LbFaAYO
 oTQOgO3CEIodAiMqmefrVDZyizpi6b1VHiAGNAhoBr80nTtVz0p/Xk4E16muGBa8+lvM
 vZxaUmV+a8GhGY3vm4FiGFbain8dhK5zQ47zBVYUwddaFCuFBntk7sjopa3WxtkmX0ru
 wk5w==
X-Gm-Message-State: AOAM53234cvL3Ao9T7drfHJvsfzpNHsY8DSthVbfxxrFicpevf5ywkcw
 7NTBMMEkWF/uzZXKPSV+vJrt4MBGFi4311yxOOc=
X-Google-Smtp-Source: ABdhPJzVgLwlLu2FKvJjJN9aVk5AIROTxzc5KRh0d6TEfGpHmUyps0TR+HNVQaq7PYY0j8gVnnuRxNCX+kQiMqwig0I=
X-Received: by 2002:ae9:dcc2:: with SMTP id q185mr5249613qkf.239.1589575300456; 
 Fri, 15 May 2020 13:41:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200507202429.1643202-1-amanieu@gmail.com>
 <CAFEAcA-n8-pOcwovsS1Z3T4AMa1Nueo2yik9zX5H16QAHeE05A@mail.gmail.com>
In-Reply-To: <CAFEAcA-n8-pOcwovsS1Z3T4AMa1Nueo2yik9zX5H16QAHeE05A@mail.gmail.com>
From: "Amanieu d'Antras" <amanieu@gmail.com>
Date: Fri, 15 May 2020 21:41:29 +0100
Message-ID: <CA+y5pbSueV8HQKQEZnBS4DvOvMDXUY7HMaODNhY7v-fKkJJPYw@mail.gmail.com>
Subject: Re: [PATCH] linux-user/arm: Reset CPSR_E when entering a signal
 handler
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::741;
 envelope-from=amanieu@gmail.com; helo=mail-qk1-x741.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 15, 2020 at 7:34 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 7 May 2020 at 21:25, Amanieu d'Antras <amanieu@gmail.com> wrote:
> >
> > This fixes signal handlers running with the wrong endianness if the
> > interrupted code used SETEND to dynamically switch endianness.
> >
> > Signed-off-by: Amanieu d'Antras <amanieu@gmail.com>
> > ---
> >  linux-user/arm/signal.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
> > index d96fc27ce1..8aca5f61b7 100644
> > --- a/linux-user/arm/signal.c
> > +++ b/linux-user/arm/signal.c
> > @@ -244,6 +244,12 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
> >      } else {
> >          cpsr &= ~CPSR_T;
> >      }
> > +    cpsr &= ~CPSR_E;
> > +#ifdef TARGET_WORDS_BIGENDIAN
> > +    if (env->cp15.sctlr_el[1] & SCTLR_E0E) {
> > +        cpsr |= CPSR_E;
> > +    }
> > +#endif
> >
> >      if (ka->sa_flags & TARGET_SA_RESTORER) {
> >          if (is_fdpic) {
> > @@ -287,7 +293,8 @@ setup_return(CPUARMState *env, struct target_sigaction *ka,
> >      env->regs[13] = frame_addr;
> >      env->regs[14] = retcode;
> >      env->regs[15] = handler & (thumb ? ~1 : ~3);
> > -    cpsr_write(env, cpsr, CPSR_IT | CPSR_T, CPSRWriteByInstr);
> > +    cpsr_write(env, cpsr, CPSR_IT | CPSR_T | CPSR_E, CPSRWriteByInstr);
> > +    arm_rebuild_hflags(env);
>
> I was just looking at the signal code's handling of CPSR for a different
> reason, and I noticed that at the moment we don't allow CPSR.E to be
> updated from the signal frame when the signal handler returns
> (because CPSR_USER doesn't contain CPSR_E and that's what we
> use in restore_sigcontext() to define what bits from the frame we
> allow updating). Don't you find that when the interrupted code
> returns from the signal handler that it ends up running with the
> wrong endianness (ie the endianness the handler used) ?

I actually found this while trying to test the SETEND instruction
under risu. The signal handler was crashing because it loaded a
pointer with the wrong endianness, which was pretty obvious. However I
missed the fact that code was now running with the wrong endianness
after returning from the signal handler since I had both the master
and the apprentice running under qemu-arm.

> I'm going to fix this by putting CPSR_E in CPSR_USER, anyway.

You also need to call arm_rebuild_hflags() after modifying CPSR_E
otherwise the change doesn't take effect.

-- Amanieu

