Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9416C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:13:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87FAA22317
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 20:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1zeP/n+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87FAA22317
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX9sR-0003Ac-PM
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 15:13:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iX9p3-0001Mu-OK
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iX9p2-000167-FT
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:10:01 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:36726)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1iX9p2-00015n-BQ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 15:10:00 -0500
Received: by mail-qk1-x742.google.com with SMTP id d13so19069810qko.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 12:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EkNkM6UCUGDdHcl0lMXWJpwSe5gDp+1NR8XYjIGCkXg=;
 b=F1zeP/n+eebWEyyKODW2CghmG5mBrzIXJSBK3wQ4rolfyYQFtNwwOM/ereyH6bfKh/
 bjradQTFeO1VO+FQ5kPE1Y0ALfu1bXeNKu4x17SoLwXkT+wP0aVBt58NLftue1dXpIQa
 uJqMg9VGGWJP4wB8TqvVVstpfQGllcrd1RRdBbftWRTEhGhVXtH4MzRCXD6HgxwkqdqT
 FvbdhFOKjRXqowKc+86NsjhA2Z47Cgoeyg/DAbu0ahGl2cxxXnwYoryHgcJOnPUkXbop
 EbPNM/esL4IewCDTQNWdejRbvcqcGUK0ejGLH8MlHd4ySqeV073Gfc8muVfi4WqF+7Wq
 l+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EkNkM6UCUGDdHcl0lMXWJpwSe5gDp+1NR8XYjIGCkXg=;
 b=JTAkw2ZJFJwsUVkTD+gWORi01k0PDL/nklX2MC4M/foCeXgXi2IQl96uZHQEE+ok3I
 Vd1gTw3fwzcX4Vai7xvtgPYdK3JmbK053M2MQ7Q0hnc0ohG8bnpi3st4h8/O90kHBLOU
 zvAI+mW4SqB/cXHiDk/y8n0Z7ADPorvMNy+TkmgqPo6FcI3BPqPYhN9rQjAG+w48Z2La
 LF71A4110fNwAEdQsFMEVM/EPB0A2eY3+quXrfYdjkS6YnEbCC7NOCcGEalci6GqrDe/
 gDN3SEzQOfauPs44Dv/y6YIj8qYswjZvj2o30boTdaIR/8Sqrl42qtI5NwJHQ6aLZHSz
 aPSw==
X-Gm-Message-State: APjAAAURGePqjH0Vb3tjDxAVLNaSh+ldsETZKWvQckzmrEvyMj0N6rjH
 HmVo1UIBYNDNrvT6wzXHvvy70tyCMhJhIWaLo54=
X-Google-Smtp-Source: APXvYqyPD11GpXNLIcRsFJ/FzHJsX8IyvMuUtJqyPg/uHlMSYez1jkcGaQc8zMDh8bAX/SGK2m51hCwjxuR1UEQ2Zu0=
X-Received: by 2002:a37:388:: with SMTP id 130mr31236462qkd.378.1574194198681; 
 Tue, 19 Nov 2019 12:09:58 -0800 (PST)
MIME-Version: 1.0
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-6-mrolnik@gmail.com>
 <CAL1e-=gKGJC4X9aNtj1SL7+s5UryNtEF81YcG4kvhjPNP247Kw@mail.gmail.com>
 <CAL1e-=gXr5KJ7W3_bnuBaupuz6jYr0LnAX7FXJ8+F8rJ=ARKxw@mail.gmail.com>
 <14d51697-9415-14b9-8f92-3ae3de2fca58@linaro.org>
 <CAL1e-=g6ctnzUSgq3eRn98nOMPJ88ucUNX7xc5MxCr6J=k4YMg@mail.gmail.com>
In-Reply-To: <CAL1e-=g6ctnzUSgq3eRn98nOMPJ88ucUNX7xc5MxCr6J=k4YMg@mail.gmail.com>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Tue, 19 Nov 2019 22:09:03 +0200
Message-ID: <CAK4993j1a6Eo+FjM7rrOZgL7u955-fTXboyOWR2BriCcyFmCuw@mail.gmail.com>
Subject: Re: [PATCH v35 05/13] target/avr: Add instruction translation -
 Arithmetic and Logic Instructions
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: "thuth@redhat.com" <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "dovgaluk@ispras.ru" <dovgaluk@ispras.ru>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "philmd@redhat.com" <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar et al.

how is it going? should I rebase or not?

Michael

On Tue, Nov 5, 2019 at 4:38 PM Aleksandar Markovic
<aleksandar.m.mail@gmail.com> wrote:
>
> On Tue, Nov 5, 2019 at 2:23 PM Richard Henderson
> <richard.henderson@linaro.org> wrote:
> >
> > On 11/5/19 10:46 AM, Aleksandar Markovic wrote:
> > >
> > >
> > > On Tuesday, November 5, 2019, Aleksandar Markovic <aleksandar.m.mail@gmail.com
> > > <mailto:aleksandar.m.mail@gmail.com>> wrote:
> > >
> > >
> > >         +
> > >         +/*
> > >         + *  This instruction performs 8-bit x 8-bit -> 16-bit signed
> > >         multiplication
> > >         + *  and shifts the result one bit left.
> > >         + */
> > >         +static bool trans_FMULSU(DisasContext *ctx, arg_FMULSU *a)
> > >         +{
> > >         +    if (!avr_have_feature(ctx, AVR_FEATURE_MUL)) {
> > >         +        return true;
> > >         +    }
> > >         +
> > >         +    TCGv R0 = cpu_r[0];
> > >         +    TCGv R1 = cpu_r[1];
> > >         +    TCGv Rd = cpu_r[a->rd];
> > >         +    TCGv Rr = cpu_r[a->rr];
> > >         +    TCGv R = tcg_temp_new_i32();
> > >         +    TCGv t0 = tcg_temp_new_i32();
> > >         +
> > >         +    tcg_gen_ext8s_tl(t0, Rd); /* make Rd full 32 bit signed */
> > >         +    tcg_gen_mul_tl(R, t0, Rr); /* R = Rd * Rr */
> > >         +    tcg_gen_andi_tl(R, R, 0xffff); /* make it 16 bits */
> > >         +
> > >         +    tcg_gen_shri_tl(cpu_Cf, R, 15); /* Cf = R(15) */
> > >         +    tcg_gen_setcondi_tl(TCG_COND_EQ, cpu_Zf, R, 0); /* Zf = R == 0 */
> > >         +
> > >         +    tcg_gen_shli_tl(R, R, 1);
> > >         +
> > >         +    tcg_gen_andi_tl(R0, R, 0xff);
> > >         +    tcg_gen_shri_tl(R1, R, 8);
> > >         +    tcg_gen_andi_tl(R1, R1, 0xff);
> > >         +
> > >         +    tcg_temp_free_i32(t0);
> > >         +    tcg_temp_free_i32(R);
> > >         +
> > >         +    return true;
> > >         +}
> > >         +
> > >
> > >
> > >     Hi, Michael.
> > >
> > >     The way I understand the spec is that a->rd and a->rd must be between 16
> > >     and 23:
> > >
> > >     https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html
> > >     <https://www.microchip.com/webdoc/avrassembler/avrassembler.wb_FMULSU.html>
> > >
> > >     Is my interpretation right? If yes, where is the corresponding part in the
> > >     implementation?
> > >
> > >
> > > Or, perhaps,
> > >
> > > TCGv Rd = cpu_r[a->rd];
> > >
> > > should be
> > >
> > > TCGv Rd = cpu_r[a->rd + 16];
> > >
> > > (and the same for rs)
> >
> > This happens during decode:
> >
> > +%rd_b           4:3                         !function=to_B
> > +%rr_b           0:3                         !function=to_B
> > +@fmul           .... .... . ... . ...       &rd_rr      rd=%rd_b rr=%rr_b
> > +FMUL            0000 0011 0 ... 1 ...       @fmul
> > +FMULS           0000 0011 1 ... 0 ...       @fmul
> > +FMULSU          0000 0011 1 ... 1 ...       @fmul
> >
> > This means that a->rd = to_B(extract32(insn, 4, 3)), and
> >
> > > +static int to_B(DisasContext *ctx, int indx) { return 16 + (indx % 8); }
> >
> > et voila.
> >
>
> OK. Thanks for clarification.
>
> >
> > r~



-- 
Best Regards,
Michael Rolnik

