Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275C1C28CC2
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:46:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7F3E27825
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="trp1qe0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7F3E27825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44442 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXHS4-0006tb-W8
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 23:46:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXHR3-0006LB-Be
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:45:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mrolnik@gmail.com>) id 1hXHR0-0001gm-O4
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:45:28 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:33890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1hXHQz-0001dn-FW
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:45:25 -0400
Received: by mail-qk1-x744.google.com with SMTP id t64so9005313qkh.1
	for <qemu-devel@nongnu.org>; Sat, 01 Jun 2019 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=ld9NRj4uViTH/oPpnizR7Qfm4ygLHTspAugUnT4/xOI=;
	b=trp1qe0ebwhf3VAywuPisiTr5C0GCb3SncsxUf8/21b5BMGZY54q+I9Y5eoKTibSd9
	hjgC1caUTaRdxvo7KTq6ZKNIeY0+3v1ORKoZlUQ/mRVJI4xX+GnVMCCxi8orBG+zjbCO
	TpfKCakr0YuBRqjG36VmNrAr8xOcfjTyBHb993pFeijIi5oyxIi4yV17u1Cz1Mjvz2AO
	KycKPx40/BItpqrNioQ+1uLEFjvMe1VMfkGIKj1jbsEU80CoTR3r8u0Fb0hDOibkZrqH
	kC1T64P2y9pTemFNRWTbHPgp430Mh0ncgyb3EJu8VXUo3rAG0FRc/XKm/iZey2MpJ7i+
	7WPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=ld9NRj4uViTH/oPpnizR7Qfm4ygLHTspAugUnT4/xOI=;
	b=OYokIym5nv7ZxajdWIc7+FgB3JKhH/AZJxi3sGTnpvRBwP+amDn60LgsaMLH8MIrMP
	eL116DgTigYsHW41ctHsHewxLUHsjaEp+bRCLTS0aLjKvtBCE44LS2ZF2+uyVO9qWEJR
	C1hDV9/OHzlUqzoXC0cIYS48VFgryWbGM8g2ss+3yVMBpiDTfbIQ4yZ2GC9NbFI9kQUu
	OtT1S61eCOCmy1Ed1jEzDUJkwrRp8uxNarCGMwRyjbnEJzSaGxol1kAVoXz1jOvBfL+I
	fPblfIPv/UvovjyCidM79mZZ6tExNA8vm2yTZC3nqAUJO49LdvJbJhTSccODZsO1erZQ
	0bHg==
X-Gm-Message-State: APjAAAUR5Sntqhgo5ravxGuvg6tBwy/rDphLqzEtvYjkJlod7xVycGGP
	G5Uyl/3hdYvYfyjWkLJTkK+Zd2whHtNbobq2KkQ=
X-Google-Smtp-Source: APXvYqyncQlp776cT7bOCj1AubZ7mDQx/41YJ2o9OKNT7ab0EguAEx1QxtQV7ExD8leJ9asecB4rEjMn5Zub2kX2ZPw=
X-Received: by 2002:a05:620a:5b1:: with SMTP id
	q17mr15756272qkq.174.1559447122480; 
	Sat, 01 Jun 2019 20:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190530190738.22713-1-mrolnik@gmail.com>
	<20190530190738.22713-6-mrolnik@gmail.com>
	<89ce6f5b-17d6-5a11-c8c6-da23f1245162@linaro.org>
In-Reply-To: <89ce6f5b-17d6-5a11-c8c6-da23f1245162@linaro.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Sun, 2 Jun 2019 06:44:46 +0300
Message-ID: <CAK4993hWDHMPR7Oq6ROoAU_N-=iiXqEP2BG-T-MgT1g6UdESJw@mail.gmail.com>
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

Hi Richard.

these instructions are not branches or jumps they all do skip.
however, if you think it's important I change it, I will, just show me an
example or explain.

On Fri, May 31, 2019 at 6:31 PM Richard Henderson <
richard.henderson@linaro.org> wrote:

> On 5/30/19 2:07 PM, Michael Rolnik wrote:
> > +    /* decode first instruction */
> > +    ctx.inst[0].cpc = pc_start;
> > +    decode_opc(&ctx, &ctx.inst[0]);
> > +    do {
> > +        /* set curr/next PCs */
> > +        cpc = ctx.inst[0].cpc;
> > +        npc = ctx.inst[0].npc;
> > +
> > +        /* decode next instruction */
> > +        ctx.inst[1].cpc = ctx.inst[0].npc;
> > +        decode_opc(&ctx, &ctx.inst[1]);
> > +
> > +        /* translate current instruction */
> > +        tcg_gen_insn_start(cpc);
> > +        num_insns++;
>
> I don't believe that this simultaneous decode of two instructions is
> correct.
>
> Consider if ctx.inst[0] is a branch instruction that is placed as the very
> last
> word of memory.  Ordinarily, the branch would be executed and the
> TranslationBlock ended.
>
> However, the advance read of ctx.inst[1] will cause a read from unmapped
> address space (causing an exception), or read from a device (causing "Bad
> ram
> pointer" and an abort from qemu_ram_addr_from_host_nofail).
>
> I believe that the feature that you're attempting to support with this,
> skip
> the next instruction, should be handled via an internal flag bit.  This
> would
> end up looking a lot like the HPPA nullify bit, or somewhat like the ARM
> thumb
> condexec_mask.  I can go into specifics if needed.
>
> Such a change would also allow you to structure this code to use
> "exec/translator.h", which in the future will likely be mandatory.
>
>
> r~
>


-- 
Best Regards,
Michael Rolnik
