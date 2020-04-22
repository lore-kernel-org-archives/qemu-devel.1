Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEC6C55185
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:15:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C06A20767
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 18:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YZepO5vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C06A20767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRJuP-0002kF-IR
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 14:15:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jRJsY-0001Z4-W0
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:13:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jRJsY-0005s7-Hi
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 14:13:46 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jRJsV-0005ar-Fs; Wed, 22 Apr 2020 14:13:43 -0400
Received: by mail-io1-xd41.google.com with SMTP id b12so3430590ion.8;
 Wed, 22 Apr 2020 11:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=attfnDxbRHujPfbbN2DK1mOiaYNsAEHnOKl1Ksh1vfE=;
 b=YZepO5vvnj+VToYyKCn+fHhD7dEEDcMpraWJ4x64UB/pQvdU830s7aYcRdi3hq2Fvy
 A2dao0ly3m1W/tSC8SeFQsrGmKG0kjDZ1U+9ZkAvWcXn4VefbzQxucz1G+dQ6DjqqQDe
 7uryIkIS/Orsxpo/2LQ8uIExy2jP++zVRAQd0asLP4uQ5nDe0Z4jmVut21IKDCdG7FfW
 PFFXaSShyLNDGYw4LHtQMNxUx4BSS9vJC9xUb0kd+ALm2hiSL7b/3uctAXTc80GYimDs
 3Y9bz5ATzmx7Pq2S9UiV1ZvseaOzA8+eBF/dKPm2oJaGkjydkRK6LlY9ynmujaW/JeOf
 ciPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=attfnDxbRHujPfbbN2DK1mOiaYNsAEHnOKl1Ksh1vfE=;
 b=URvuFG6dSKFzjJ9Kcq2VtBAJbr44aB2v/iyXbU4mLp5nBunCNGAuRCaLjjtVT3qgib
 /EHLHEZQkfRzCkNJA+pzYPl/WZ//sLT/Kogo5At5W05vvCN6ymbXmP7Dy43a4FrZJMWQ
 tOI+iX7FB9b+AwkFCVXweE2edA0kKXXb30KlTlteOaWUhWpVvJjtC67dH/rGx3I5GIWm
 d+A/2ax6rsk8A2VHlzWvb31R1euTizhlClyqoVGGKMP+dPXe8BO5tKlh/gR4Mb0XsbGT
 uglOTlLMgMQiuyhe3dp9eNkQ4J/29VFllLqiWnBn+MpQ9TUT6wwGQnJZBTG+aPMqtSXT
 ps1g==
X-Gm-Message-State: AGi0PuaLpb6UlgevErD4K+rWqk8evPzO+jsIfpnOzzQtWirQT6Vx6AOn
 nl3zi02nSZSZBqZ3nqSnBCsEU4nkTHItftd8YS4=
X-Google-Smtp-Source: APiQypK0BuUi5uABE/lfret8iIDuVzgAGlzvmi4ko9MWTvGAjCajwnJVyjU2ELzWxQhzhysqFI2wBiOAjXpRx2hNbrQ=
X-Received: by 2002:a02:6243:: with SMTP id d64mr15047851jac.135.1587579215541; 
 Wed, 22 Apr 2020 11:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200412020830.607-1-zhiwei_liu@c-sky.com>
 <f6dc4fa7-fed5-28a1-5922-68e9a0510de5@c-sky.com>
 <bf6b46c3-cc39-1b4a-4ae4-9de894721f04@linaro.org>
In-Reply-To: <bf6b46c3-cc39-1b4a-4ae4-9de894721f04@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Apr 2020 11:05:05 -0700
Message-ID: <CAKmqyKMZ9x+PXOxnFqE5e-h+cCZjJThEBjJip_OCppjX71DSrg@mail.gmail.com>
Subject: Re: [PATCH] linux-user/riscv: fix up struct target_ucontext definition
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d41
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wxy194768@alibaba-inc.com, Laurent Vivier <laurent@vivier.eu>,
 wenmeng_zhang@c-sky.com, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Apr 21, 2020 at 9:10 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/21/20 7:34 PM, LIU Zhiwei wrote:
> > Ping.
> >
> > When I port RISU, I find this bug. I can't get the correct registers from the
> > struct ucontext_t parameter in the signal handler.
>
> The RISC-V Linux ABI will need to be extended to handle RVV state.
>
> There is room in your sigcontext structure:
>
> > struct __riscv_q_ext_state {
> >         __u64 f[64] __attribute__((aligned(16)));
> >         __u32 fcsr;
> >         /*
> >          * Reserved for expansion of sigcontext structure.  Currently zeroed
> >          * upon signal, and must be zero upon sigreturn.
> >          */
> >         __u32 reserved[3];
> > };
>
> in uc->uc_mcontext.sc_fpregs.q.
>
> That reserved field is going to have to be used in some way.

Just to clarify, this patch is still correct right?

It looks good to me.

Alistair

>
> My suggestion is to use some sort of extendable record list, akin to AArch64:
>
> struct _aarch64_ctx {
>         __u32 magic;
>         __u32 size;
> };
>
> One of the 3 zeros could be the total size of the extensions, so that it's easy
> to validate the size or memcpy the lot without parsing each individual record.
>  The other two zeros could be the first header of the next record.  Which in
> this case also allows the payload of that first record to be aligned mod 16,
> which could come in handy.
>
> Talk to the risc-v kernel engineers and come up with a plan that includes room
> for the next architecture extension as well.  They may have already done so,
> but I'm not monitoring the correct mailing list to know.
>
>
> r~
>

