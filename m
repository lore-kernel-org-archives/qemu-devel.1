Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01562C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:36:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D7F20709
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 23:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auj0hqYc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D7F20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNPg5-0005Q7-U5
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 19:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34690)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <natechancellor@gmail.com>) id 1jNPfK-0004uH-3p
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 19:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <natechancellor@gmail.com>) id 1jNPfI-0007Pq-Ul
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 19:35:58 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35759)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <natechancellor@gmail.com>)
 id 1jNPfG-0007PB-DD; Sat, 11 Apr 2020 19:35:54 -0400
Received: by mail-oi1-x243.google.com with SMTP id b7so2014383oic.2;
 Sat, 11 Apr 2020 16:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=FOIrhfa5I+n7DVdFa8ydZMzj2s25vzXCYLjLMUsM8Y4=;
 b=auj0hqYczFVPzuyzWNDkZFK7lITUYTbX8Wn9sipVdURP2z3YEAX91KmHvPL07FXSWQ
 xik0o8D5cHLTcFfGB4j7xHMSNOXgi0Zp/pr9d6MPC+qYQvgpn4TCq7LV4hLhLr0qBI1v
 wqdyYV1DqS052H6WpIB1x+wqnuDITgkb8XcgaxuSGsVmbykYJk8Owk6jarkpFEL6bPNq
 mboa0aKpvLlgi52Hgo3uZgqvCB3Zbie5nBjUqrib+vNmUtzpQUcBuLSf5nbXcggX+SHW
 0XYoxifAHAaBJH3AbI7rmFTvdcPqVAYqvBbRIcwqcoZ63/m5ISMJsONzGyRMMhjgAUgH
 gx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=FOIrhfa5I+n7DVdFa8ydZMzj2s25vzXCYLjLMUsM8Y4=;
 b=oHW7xK5IwHfEPDtYZKDtHG6GwbJXaLPuczYjJOIY8E9cAQJ2ft9C9rSGMC0sT9aC4V
 HwIUA/g1C3ry8ytkDHcDTMmA5Lt8BP9viIpDDS6riUae6n+2YyIxuPckV5LGCkGdhvXW
 V6B5SRIhLa7lu9dFrG7dz/EBvIBvs3+61TZFBKYMaMNqQyHOFgYJkXJaTHTdM2SwGyrk
 YkyOBrifyOe0RnC3eotT4KsjmpfEIjM8Pb7afSyILAHk2OV9ZSD4xK+qx7kdNMb9pwpJ
 THePqYcNtoB0B1z9bJzamEv/9Qn0Br8O/UEubHNStRmnDP+PvwXOs1EHuhkdWeTJbFVd
 fu4g==
X-Gm-Message-State: AGi0PubEYe+iFX8ROiWaSRjaufHAjta+TVBYdbJdaWJRiaa/7DGcL1Qq
 cQrt2Wzi//S+8nqhIMm1XxM=
X-Google-Smtp-Source: APiQypKkfyJ5NFiSf6+E4JFzIzGRYPoWc6gdg8pREBBsEFuDxCZRnacAfldjAvLBtCRUEikv/MWAHQ==
X-Received: by 2002:aca:2806:: with SMTP id 6mr7800691oix.135.1586648153184;
 Sat, 11 Apr 2020 16:35:53 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::3])
 by smtp.gmail.com with ESMTPSA id n38sm3487564otn.26.2020.04.11.16.35.52
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sat, 11 Apr 2020 16:35:52 -0700 (PDT)
Date: Sat, 11 Apr 2020 16:35:51 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Boot flakiness with QEMU 3.1.0 and Clang built kernels
Message-ID: <20200411233551.GA34862@ubuntu-s3-xlarge-x86>
References: <20200410205932.GA880@ubuntu-s3-xlarge-x86>
 <1586564375.zt8lm9finh.astroid@bobo.none>
 <20200411005354.GA24145@ubuntu-s3-xlarge-x86>
 <1586597161.xyshvdbjo6.astroid@bobo.none>
 <1586612535.6kk4az03np.astroid@bobo.none>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586612535.6kk4az03np.astroid@bobo.none>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@fr.ibm.com>, qemu-ppc@nongnu.org,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Apr 11, 2020 at 11:57:23PM +1000, Nicholas Piggin wrote:
> Nicholas Piggin's on April 11, 2020 7:32 pm:
> > Nathan Chancellor's on April 11, 2020 10:53 am:
> >> The tt.config values are needed to reproduce but I did not verify that
> >> ONLY tt.config was needed. Other than that, no, we are just building
> >> either pseries_defconfig or powernv_defconfig with those configs and
> >> letting it boot up with a simple initramfs, which prints the version
> >> string then shuts the machine down.
> >> 
> >> Let me know if you need any more information, cheers!
> > 
> > Okay I can reproduce it. Sometimes it eventually recovers after a long
> > pause, and some keyboard input often helps it along. So that seems like 
> > it might be a lost interrupt.
> > 
> > POWER8 vs POWER9 might just be a timing thing if P9 is still hanging
> > sometimes. I wasn't able to reproduce it with defconfig+tt.config, I
> > needed your other config with various other debug options.
> > 
> > Thanks for the very good report. I'll let you know what I find.
> 
> It looks like a qemu bug. Booting with '-d int' shows the decrementer 
> simply stops firing at the point of the hang, even though MSR[EE]=1 and 
> the DEC register is wrapping. Linux appears to be doing the right thing 
> as far as I can tell (not losing interrupts).
> 
> This qemu patch fixes the boot hang for me. I don't know that qemu 
> really has the right idea of "context synchronizing" as defined in the
> powerpc architecture -- mtmsrd L=1 is not context synchronizing but that
> does not mean it can avoid looking at exceptions until the next such
> event. It looks like the decrementer exception goes high but the
> execution of mtmsrd L=1 is ignoring it.
> 
> Prior to the Linux patch 3282a3da25b you bisected to, interrupt replay
> code would return with an 'rfi' instruction as part of interrupt return,
> which probably helped to get things moving along a bit. However it would
> not be foolproof, and Cedric did say he encountered some mysterious
> lockups under load with qemu powernv before that patch was merged, so
> maybe it's the same issue?
> 
> Thanks,
> Nick
> 
> The patch is a bit of a hack, but if you can run it and verify it fixes
> your boot hang would be good.

Yes, with this patch applied on top of 5.0.0-rc2 and using the
pseries-3.1 and powernv8 machines, I do not see any hangs with a clang
built kernel at b032227c62939b5481bcd45442b36dfa263f4a7c across 100
boots.

If you happen to send it upstream:

Tested-by: Nathan Chancellor <natechancellor@gmail.com>

Thanks for looking into it!

> ---
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index b207fb5386..1d997f5c32 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4364,12 +4364,21 @@ static void gen_mtmsrd(DisasContext *ctx)
>      if (ctx->opcode & 0x00010000) {
>          /* Special form that does not need any synchronisation */
>          TCGv t0 = tcg_temp_new();
> +        TCGv t1 = tcg_temp_new();
>          tcg_gen_andi_tl(t0, cpu_gpr[rS(ctx->opcode)],
>                          (1 << MSR_RI) | (1 << MSR_EE));
> -        tcg_gen_andi_tl(cpu_msr, cpu_msr,
> +        tcg_gen_andi_tl(t1, cpu_msr,
>                          ~(target_ulong)((1 << MSR_RI) | (1 << MSR_EE)));
> -        tcg_gen_or_tl(cpu_msr, cpu_msr, t0);
> +        tcg_gen_or_tl(t1, t1, t0);
> +
> +        gen_update_nip(ctx, ctx->base.pc_next);
> +        gen_helper_store_msr(cpu_env, t1);
>          tcg_temp_free(t0);
> +        tcg_temp_free(t1);
> +        /* Must stop the translation as machine state (may have) changed */
> +        /* Note that mtmsr is not always defined as context-synchronizing */
> +        gen_stop_exception(ctx);
> +
>      } else {
>          /*
>           * XXX: we need to update nip before the store if we enter

Cheers,
Nathan

