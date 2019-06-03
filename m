Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B9EC04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:36:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71BB22726D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBGynjHn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71BB22726D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36865 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXp0l-0000n2-Lj
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:36:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXoz1-0008Mx-EW
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXoyz-0006o2-Sk
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:34:47 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:42222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXoyz-0006mp-Nv
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:34:45 -0400
Received: by mail-qk1-x744.google.com with SMTP id b18so669545qkc.9
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 08:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=zfyNrFdHvdP05ue5xadDHk3G4KHLQ+0LPtsCLVQgp3k=;
	b=NBGynjHn1NU+LE/ni0ngxVrmqZQko/sFG9/1BATCNWcAp6zofFKiIxaUdhYdPIjl8f
	p+c7lxdHULMa7Yu5Nh7w3Ka0jikaQgzTHqKgMMqnTevByPMwPMuwTankGil2Vopexxis
	+lDS74PI/uOlskOuiHIiXLZ2cZ7dC84CWq1xJ3Lk7aLydepowNbaf4ZEQ42rxMR4rfY3
	6VhNNB+bQqpd2bzMH6lO7B4zUGt28zrZGBSo97TIVLHLJ/hyrQlTgwB/KOg3gZnjAYlV
	o4BGnxfkueJWtCkEHeHsLqaEg08jPWq40nTyiuWcQCevfyUB8C7T/VIlgWjtPgcBGRnH
	5xpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=zfyNrFdHvdP05ue5xadDHk3G4KHLQ+0LPtsCLVQgp3k=;
	b=gSMpgwvJpc3FL4+h1WC36iCQDrQhd7aNsA6PXxCvYVZp1vlPXcefTTf/Dr8r/rArUe
	stTAEZV9lAS+AygIVvzz7KZEtFO9iPA1/++i1332vDOOUxiMZIpQmsAqK75jAJp64Dvs
	39TojUH56310QH+qgRCM9T0OeNHA3CUnu6YgbbgoGCevdEMznD2KdkDSwoT4gYstPd/i
	wZnzcebD8yyaEDMKPyO3sd15X2BnwJ6JYXnrNnumGypTjMvvXKqTwBl2yeCGaWXYuiYm
	G/IUAkm/pZx9BwYVa8NEjEO92tpxqvV0SZG1IY2Nprs725KB+y79NDW3IWMoJbNhvbDo
	VEag==
X-Gm-Message-State: APjAAAVLN+9AnBq+y9Ve01HSWSKwEKD0P90w7CaFifzuUhv8n+V6cZTD
	KcPrKh7fURI8qCiKI/7QIzxkY04hPDFSlqCo3l4=
X-Google-Smtp-Source: APXvYqwLpDcMiRae6zEr5ir5eZ/KPbsJWojFxn0+RKl6NXip/CPt+JyvBnEA+j0/Ag+2LhZ6zi1Kj/ndDuoQFywZEik=
X-Received: by 2002:a37:454d:: with SMTP id s74mr15924004qka.115.1559576084511;
	Mon, 03 Jun 2019 08:34:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-6-mrolnik@gmail.com>
	<89ce6f5b-17d6-5a11-c8c6-da23f1245162@linaro.org>
	<CAK4993hWDHMPR7Oq6ROoAU_N-=iiXqEP2BG-T-MgT1g6UdESJw@mail.gmail.com>
	<e9abf7a7-24df-d85d-1108-a635c9588553@linaro.org>
In-Reply-To: <e9abf7a7-24df-d85d-1108-a635c9588553@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Mon, 3 Jun 2019 18:34:30 +0300
Message-ID: <CAK4993g8cUbkSVKZy+3bOpuMR_+8uOdp101KxQgcJ0pGt5eTXQ@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::744
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH RFC v20 5/8] target/avr: Add instruction
 translation
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Got it.
Thanks for the explanation

Sent from my cell phone, please ignore typos

On Mon, Jun 3, 2019, 6:31 PM Richard Henderson <richard.henderson@linaro.org>
wrote:

> On 6/1/19 10:44 PM, Michael Rolnik wrote:
> > Hi Richard.
> >
> > these instructions are not branches or jumps they all do skip.
>
> Of course they're not all branches.  I used the example of a branch to
> show a
> situation in which your translation is wrong.
>
> > however, if you think it's important I change it, I will, just show me an
> > example or explain.
>
> Ok, let's take HPPA as a very similar example.
>
> Many HPPA instructions may "nullify" the next instruction.  The language is
> different, but it's the same thing as the AVR "skip".
>
> Now, I spent quite a bit of effort in target/hppa using conditional move
> instructions to implement this.  But you need not go that far.
>
> Now, AVR is differs from HPPA in that there is a nullify bit as part of the
> process state.  Since AVR does not have this, we will need to keep the
> "skip"
> state entirely internal to the qemu implementation.
>
> I suggest:
>
> (1) Add "bool skipping;" to CPUAVRState.
>
> Because TranslationBlocks can be ended at any instruction boundary, we need
> some way to preserve the skipping state across TB's.
>
> (2) Include "skipping" into the flags for cpu_get_tb_cpu_state,
> TB_FLAGS_SKIPPING.
>
> (3) Include "skipping" into the computation of cpu_interrupts_enabled.
>
> Because "skipping" is not part of the architectural state of the CPU, we
> cannot
> allow an interrupt to come between the two instructions.  Therefore, while
> "skipping" is true, disable interrupts.
>
> (4) Within the instructions that skip the next, issue the branch but
> record the
> label as DisasContext->skip_label.  This will allow the main loop (and
> other
> instructions) know that skipping is active.
>
> (5a) In gen_intermediate_code, if TB_FLAGS_SKIPPING, decode but do not
> translate the insn, then clear TB_FLAGS_SKIPPING and store 0 into
> env->skipping.
>
> (5b) In gen_intermediate_code, if !TB_FLAGS_SKIPPING, copy
> DisasContext->skip_label into a local variable, this_skip_label and zero.
>
> We need to prepare for skip of skip, so do not allow the label of the first
> skip to be clobbered by the label of the second skip.
>
> (5c) After translate(), if this_skip_label is non-null, emit the label.
>
> (6) Reverse the sense of your conditional branches.
>
> Currently you generate
>
>   brcond(xxx, yyy, zzz, true_label);
>   goto npc
> true_label:
>   goto true_pc
>
> which is fine until we have skip labels.  We now want to emit
>
>   brcond(!xxx, yyy, zzz, false_label);
>   goto true_pc
> false_label:
> skip_label:
>   goto npc
>
> which you can do by issuing only the branch, goto, label, and then setting
> ctx->bstate to BS_STOP, so that the skip_label is emitted by the main
> loop, and
> the goto npc is also issued by the main loop.
>
> (7) At the end of the loop in gen_intermedite_code, if
> DisasContext->skip_label
> is non-null, then we ended the TB with a skipping instruction and we need
> to
> preserve that within env.
>
>     TCGLabel *finish = NULL;
>
>     if (ctx.skip_label) {
>         finish = gen_new_label();
>     }
>
>     if (tb->cflags & CF_LAST_IO) {
>     ...
>
>
>     if (ctx.skip_label) {
>         TCGv_i32 one;
>
>         gen_set_label(ctx.skip_label);
>         one = tcg_const_i32(1);
>         tcg_gen_st8_i32(one, cpu_env, offsetof(CPUAVRState, skipping));
>         tcg_temp_free_i32(one);
>         tcg_gen_br(finish);
>     }
>
>  done_generating:
>    gen_tb_end(tb, num_insns);
>
>
> r~
>
