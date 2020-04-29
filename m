Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7002AC83004
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A87B2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 14:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="meAKgOoX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A87B2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTo5N-0008VZ-A7
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 10:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51230)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTo20-0005Vd-9n
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:49:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jTo1y-0003uQ-SC
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:49:48 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:41870)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jTo1y-0003uC-DB
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 10:49:46 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id t3so475778oou.8
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 07:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0fQ8UfZ6XSti3VkPBlrs9GDBA7hTbayMlPd/qo+hVHQ=;
 b=meAKgOoXW2Qu4RpJOcS4QIhCuDxh4vf0owSDX4+LipFrtwfarFBpW2LFgks9Dwo400
 Sa/SepSixsGcP3A9H7PTAl2UmO6wo+Wl7WshruBBVXwpapzxUfY32bWrqucnSJFrU2Vn
 cFO+BkWSM8KEKct1EWYIlAm2463zOhRxI6mDQE/GpeiFr96R+IIXUSjJRJZBii/fsbVV
 9OIUrTuHZOhA8UHnItcaGuKwTCWk0ighwBLGH7xLf7JUbmGgSjpuE885v+jRK+t2DJZu
 D7a+G+XX+rS/Ghgr3NeD2ELmmUQ7PwButsW5VH4gu1TzUwobeDTXLvBc04iGhzTFioUq
 zbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0fQ8UfZ6XSti3VkPBlrs9GDBA7hTbayMlPd/qo+hVHQ=;
 b=IVsOFidSkDr1iPB4G2UZ70n73ySbRuGtgKhNCipVoMGKuUYkY/DPrQWrIg7ORm/sAj
 9WwsMlHUYEmnt8HMLmQjWT/sY2I1QqcQULuE//kElha//LLBlYqLFcLf2wrNQTuVvnYg
 omvykvTmaZEXt4eI7tcT6F6HNTpNJF1P/ebbVLraW2UAmsmlXnEOT8NxPdp26L4lvjQO
 SFcyDThcW5hAmgDVrHYlrSycF3oYGJcYbOwlyqn8ZI81EiZndaNDJostJvsQgQyXrKN4
 Iiu0PhvKeEXP/IYR3kKvCNKtJM87/rqPsDS4EOMna9mFmphpu/vbcwlel+iOx/42r4BD
 MjVg==
X-Gm-Message-State: AGi0PuaCNB9U+65/FFOPqCyEMF2QNTxF1QNEKhV/ELanI9M0SJ+sD2cV
 rbfsK+7rS8fkdn4FRbYPDJpoqsHv4pjMKnHPjOcwVA==
X-Google-Smtp-Source: APiQypISk+bPDQED9YhJOm5bHEXsM5ethp7Z6E7Sp3Zp/7t1B6wLL+a+ZORGyRGuWN6uzkEeyd2pexbsCy5n76KZsOE=
X-Received: by 2002:a4a:8253:: with SMTP id t19mr27464961oog.69.1588171785015; 
 Wed, 29 Apr 2020 07:49:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAE2XoE-ZSgtceSe5wYDm3cXf8+hTvJhD5PqZSrrFW5625LcSWg@mail.gmail.com>
 <87lfmhl0xa.fsf@linaro.org>
 <alpine.BSF.2.22.395.2004271212520.94232@zero.eik.bme.hu>
 <87imhlkwun.fsf@linaro.org>
 <CAE2XoE9hiw-ri66_xp3qNa5_Wx8ZfsQB9mqJdYR8VRm-KW830g@mail.gmail.com>
 <87ftcoknvu.fsf@linaro.org>
 <AM4PR07MB350653D5961DFCE441646131CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
 <871ro6ld2f.fsf@linaro.org>
 <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
In-Reply-To: <AM4PR07MB350673696C7DE2CA16C9C685CAAD0@AM4PR07MB3506.eurprd07.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Apr 2020 15:49:33 +0100
Message-ID: <CAFEAcA_c7hb-Ahi-fws9yjLiCHn5LnF6mdYaHyw8T3athzDZ8w@mail.gmail.com>
Subject: Re: R: About hardfloat in ppc
To: Dino Papararo <skizzato73@msn.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2d.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::c2d
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Programmingkid <programmingkidx@gmail.com>,
 "luoyonggang@gmail.com" <luoyonggang@gmail.com>,
 "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 Howard Spoelstra <hsp.cat7@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 at 15:33, Dino Papararo <skizzato73@msn.com> wrote:
>
> Hi Alex,
> maybe a pseudo code can show better what I mean
>
> if (ppc_fpu_instruction == USE_FPSCR) /* instruction have dot '.' so FPSCR will be updated and we need have care about it */
>         soft_decode (ppc_fpu_instruction)
> else  /* instruction have not dot '.' and FPSCR will be never updated and we don't need to have care about it -> maxspeed */
>         hard_decode (ppc_fpu_instruction)

My understanding was that the '.' indicates whether
the instruction updates CR1 (the condition register),
which is separate from whether it updates FPSCR
flags. So all insns update FPSCR flags; insns with
a '.' additionally update CR state which can be
tested by a following branch insn. (I'm not a PPC
expert but that's what my reading of the ISA spec is.)

> In ppc assembly all instructions who needs to take care of inexact flag and/or exception flags, are processed prior than test instructions, look at following exception handling example:
>
>    fadd. f0,f1,f2 # f1 + f2 = f0. CR1 contains except.summary
>    bta   4,error  # if bit 0 of CR1 is set, go to error
>                   # bit 0 is set if any exception occurs
>    .              # if clear, continue operation
>    .
>    .
> error:
>    mcrfs 2,1   # copy FPSCR bits 4-7 to CR field 2
>                # now CR1 and CR2 (bits 6 through 10)
>                # contain all exception bits from FPSCR

This may be a common pattern, but the architecture doesn't
require it. You could equally do

    fadd f0,f1,f2   # insn which sets fpscr bits
    mffs 30         # copy whole fpscr to a gp register
    # now do stuff based on that value

So unless you can tell for certain that nothing in
the future guest execution can the relevant FPSCR bits
before they're overwritten, you have to generate them
correctly; or be able to re-generate them later, if
you want to get fancy (you could imagine a scheme
similar to how we handle CPU condition flags on
some guests, where instead of calculating them every
time we make a note of what the operation that should
have set them was, so that at the point where the
guest actually does read the fpscr or do something
else that demands the real flag value we can recreate
them, in this case by repeating the fp operation via
softfloat. Getting that working would be a non-trivial
project, though.)

thanks
-- PMM

