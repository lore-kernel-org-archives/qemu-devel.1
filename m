Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087C1C04AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5DAC23BE3
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 15:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o809UgVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5DAC23BE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36790 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXoxV-0007Ci-Nn
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 11:33:13 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXovj-0006DY-Ij
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:31:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hXovi-0001EI-AF
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:31:23 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36672)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hXovi-0001B4-1A
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 11:31:22 -0400
Received: by mail-oi1-x244.google.com with SMTP id w7so1769978oic.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jun 2019 08:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cpIRGwwsnOFT+WXSoFLoVq+filoB25fBcTEl10ryb6k=;
	b=o809UgVcnJbDlYZDuLAR4OkiJBwkI7bmll7okCs9R95qpXtRe/JgW537UbFV0dnnxZ
	4LU4lqibTI2NBBOtYdbe0Ei+ATqCQpHXgcSPCdGjuTMjy7B4fna9GTffqVIdSIyzrju3
	Nk86kuHoC9ospwRO2Vtt0jg31kYDBVoJ98OWMp9WDgKCDSsikbNQ5HpPAV7kRigpH+rW
	rXsrrFTH0M1hLpFFNc5mlsGihti+a63oFTrzdWY1jm+MFVs9X6bQAq9k9YrwHTWNL6CF
	I9OyO+9vF0QznaWhXjOQJ0OYlpXXahJHbMpqy9id6ALV2xGc/fP4hpmAxCxgQrTDIC0H
	QEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cpIRGwwsnOFT+WXSoFLoVq+filoB25fBcTEl10ryb6k=;
	b=BRN+xPVzH48SqFm0YUgkO87Z7iRGrT9b8i7QkDhbEUAwAGJORPFy46/oF5HcW1bmjx
	PE6pD+nF1P8HGrKefKwcTp0B8qnFLO8zrfkEa+U8In3BiuUUZbiz8FdOK56xU6uptWiy
	2D9h2oFRsPWlXsLxx+MT9RD8W6i+uFqnUI0ih8Z5IybOA4rLHVol38ssiomaZCM36zCk
	2L+mOdNlDShJLk4Hu+PpIxM3Av7+gOosjMQjPbAJ73XI4OgCf2J3UP4SJRIltnrY/W4d
	zymzEbLPtje2R8ZPeLyVmKfiBMgWIsF678fCv/RGrKgz5a6KL8Yh5EUTrsKmNQMrsYdz
	wGUA==
X-Gm-Message-State: APjAAAW1k+9FvywzurqRVNjMwxq7vXk/DhTp3Az/BgRV8h9chBQFfD9A
	gt77mH6nOvGnpx55Mo3stWdOKw==
X-Google-Smtp-Source: APXvYqym9bdIOUs6qwhatREgLWgXskGayjKnLH7eFbR6ZZoaGycqrhWr1W4hhnlMbXhLj7HC5/Lxhw==
X-Received: by 2002:aca:530f:: with SMTP id h15mr1266240oib.155.1559575880041; 
	Mon, 03 Jun 2019 08:31:20 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86]) by smtp.gmail.com with ESMTPSA id
	k25sm5193170otj.47.2019.06.03.08.31.18
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Jun 2019 08:31:18 -0700 (PDT)
To: Michael Rolnik <mrolnik@gmail.com>
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-6-mrolnik@gmail.com>
	<89ce6f5b-17d6-5a11-c8c6-da23f1245162@linaro.org>
	<CAK4993hWDHMPR7Oq6ROoAU_N-=iiXqEP2BG-T-MgT1g6UdESJw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e9abf7a7-24df-d85d-1108-a635c9588553@linaro.org>
Date: Mon, 3 Jun 2019 10:31:14 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAK4993hWDHMPR7Oq6ROoAU_N-=iiXqEP2BG-T-MgT1g6UdESJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On 6/1/19 10:44 PM, Michael Rolnik wrote:
> Hi Richard.
> 
> these instructions are not branches or jumps they all do skip.

Of course they're not all branches.  I used the example of a branch to show a
situation in which your translation is wrong.

> however, if you think it's important I change it, I will, just show me an
> example or explain.

Ok, let's take HPPA as a very similar example.

Many HPPA instructions may "nullify" the next instruction.  The language is
different, but it's the same thing as the AVR "skip".

Now, I spent quite a bit of effort in target/hppa using conditional move
instructions to implement this.  But you need not go that far.

Now, AVR is differs from HPPA in that there is a nullify bit as part of the
process state.  Since AVR does not have this, we will need to keep the "skip"
state entirely internal to the qemu implementation.

I suggest:

(1) Add "bool skipping;" to CPUAVRState.

Because TranslationBlocks can be ended at any instruction boundary, we need
some way to preserve the skipping state across TB's.

(2) Include "skipping" into the flags for cpu_get_tb_cpu_state, TB_FLAGS_SKIPPING.

(3) Include "skipping" into the computation of cpu_interrupts_enabled.

Because "skipping" is not part of the architectural state of the CPU, we cannot
allow an interrupt to come between the two instructions.  Therefore, while
"skipping" is true, disable interrupts.

(4) Within the instructions that skip the next, issue the branch but record the
label as DisasContext->skip_label.  This will allow the main loop (and other
instructions) know that skipping is active.

(5a) In gen_intermediate_code, if TB_FLAGS_SKIPPING, decode but do not
translate the insn, then clear TB_FLAGS_SKIPPING and store 0 into env->skipping.

(5b) In gen_intermediate_code, if !TB_FLAGS_SKIPPING, copy
DisasContext->skip_label into a local variable, this_skip_label and zero.

We need to prepare for skip of skip, so do not allow the label of the first
skip to be clobbered by the label of the second skip.

(5c) After translate(), if this_skip_label is non-null, emit the label.

(6) Reverse the sense of your conditional branches.

Currently you generate

  brcond(xxx, yyy, zzz, true_label);
  goto npc
true_label:
  goto true_pc

which is fine until we have skip labels.  We now want to emit

  brcond(!xxx, yyy, zzz, false_label);
  goto true_pc
false_label:
skip_label:
  goto npc

which you can do by issuing only the branch, goto, label, and then setting
ctx->bstate to BS_STOP, so that the skip_label is emitted by the main loop, and
the goto npc is also issued by the main loop.

(7) At the end of the loop in gen_intermedite_code, if DisasContext->skip_label
is non-null, then we ended the TB with a skipping instruction and we need to
preserve that within env.

    TCGLabel *finish = NULL;

    if (ctx.skip_label) {
        finish = gen_new_label();
    }

    if (tb->cflags & CF_LAST_IO) {
    ...


    if (ctx.skip_label) {
        TCGv_i32 one;

        gen_set_label(ctx.skip_label);
        one = tcg_const_i32(1);
        tcg_gen_st8_i32(one, cpu_env, offsetof(CPUAVRState, skipping));
        tcg_temp_free_i32(one);
        tcg_gen_br(finish);
    }

 done_generating:
   gen_tb_end(tb, num_insns);


r~

