Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6641CC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:41:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F882151B
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 15:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w0szmhyc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F882151B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlDi8-00007v-D8
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 11:41:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlDgn-0007mr-3k
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:39:53 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:41355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlDgk-0007js-5F
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 11:39:52 -0400
Received: by mail-oo1-xc42.google.com with SMTP id y45so4160241ooi.8
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 08:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HQjhk2kW5iuW9MHP9wBoBAZ1jJ2lH2MO8EKv2KNe6zo=;
 b=w0szmhycnCTpx7bWpj/ia6KqpVs5mfvgZamu0MBn6YwR+5MXnbbBCWbjFkru57++nL
 LGsGJaKJDIpryHMwD2v5DnwCPTXdqHD4ONybd64QdHlIjJzDVMxV6H/k6pv8Xl8YwQen
 Sguv5STI+I9zym0SJvTwJZA1LpNPOV0ke3KZ+W3eh97sNgv3qhEGHDDIo2Xb+zH9zwec
 228NoM1jb+3jgGhqZNyuSMaebN4Wdp9cvtBaBige8Q6pT8FnEahqNZb2S4pJw1riXWPq
 bDrZb+EXp/C9us9JdjkBgp+EMroDk+Q/ogZU8Gxnr1jrSzhCAhrvHHVlZ3BUS42ApkmE
 iiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HQjhk2kW5iuW9MHP9wBoBAZ1jJ2lH2MO8EKv2KNe6zo=;
 b=HYNYaHbtYLjDcG/wh+9Pppxok3yzAiMu/21fj0yVlj+8oryKd/LJC8yLgnahF785zx
 MzjTs+8dpgQd+Uior4OgToBoNJEzDxJa1IUxDuAQbhCmX04cfOkddWyUkaY/wIqCCpAz
 8Rb9g3HDQuMENLKGe2Dp+QklY7uJ7kL1MNIXFIxFUaZHrCtho8JwaCpRpwDcyfQXGHtl
 QvVjyMmvNuR5G67rWvMwVXZueXiMl1Tlgd0zTyaLhARQnaEWXRAbubRBjL48sY9btERD
 QZrlT8D8Ve3GkIWlycTOcr9uCFI9suLCgsXMR5RkMiLW422nHIYQ6pmcVionHT3exH+g
 Vr8A==
X-Gm-Message-State: AOAM533KygOGZR/DE5WUdR97Os8srI4uGCWv9HHKKfw7wM4xkj8hdcLQ
 E+e6JcBQrfm6afU68EGj11N7kDGYGn5zZW5kDd8Igw==
X-Google-Smtp-Source: ABdhPJzsZimVol6g4a0CgVucJ3ETZVhGAa8y+gifdoWy0VsgFXdxXY02Yeub5i/+Cz/Up4d/rZJCGMb5kSuN8Kf1mEk=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr2840833ooi.85.1592321988743; 
 Tue, 16 Jun 2020 08:39:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200611081319.1864-1-wentong.wu@intel.com>
In-Reply-To: <20200611081319.1864-1-wentong.wu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 16:39:37 +0100
Message-ID: <CAFEAcA_oQ7X9COCPnoarrKfGtXD4CVKs7MAjWq-i_8yc5jTtDA@mail.gmail.com>
Subject: Re: [PATCH] hw/nios2: Update interrupt request when CR_STATUS_PIE
 disabled
To: wentongw <wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Marek Vasut <marex@denx.de>,
 Thomas Huth <thuth@redhat.com>, Chris Wulff <crwulff@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jun 2020 at 01:23, wentongw <wentong.wu@intel.com> wrote:
>
> Update interrupt request when external interupt pends for STATUS_PIE
> disabled. Otherwise on icount enabled nios2 target there will be cpu
> abort when guest code changes state register with wrctl instruction.
>
> Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> ---
>  hw/nios2/cpu_pic.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/nios2/cpu_pic.c b/hw/nios2/cpu_pic.c
> index 1c1989d5..2abc8fa8 100644
> --- a/hw/nios2/cpu_pic.c
> +++ b/hw/nios2/cpu_pic.c
> @@ -42,6 +42,8 @@ static void nios2_pic_cpu_handler(void *opaque, int irq=
, int level)
>          } else if (!level) {
>              env->irq_pending =3D 0;
>              cpu_reset_interrupt(cs, type);
> +        } else {
> +            cs->interrupt_request |=3D type;
>          }

Thanks for the clarification in your other email about the
issue you're trying to address:

> I=E2=80=99m running icount mode on qemu_nios2 with customized platform
> but cpu abort happened(qemu: fatal: Raised interrupt while not
> in I/O function) when guest code changes state register with wrctl
> instruction add some debug code finding that it=E2=80=99s caused by the
> interrupt_request mismatch.

I don't think the change you've made is the correct fix.
Setting cs->interrupt_request like this is pretty much
the same thing that calling cpu_interrupt() does, so
what your patch is doing is essentially "ignore the
status.PIE bit and always deliver interrupts", which isn't
how the hardware behaves.

The assertion you've run into is saying "some instruction caused us
to take an interrupt, but it wasn't marked up to indicate that it
might cause a side effect". (This only matters in icount mode, where
we insist that we never get unexpected sideeffects like this.) If
the guest writes to status.PIE to unmask interrupts that's the kind
of thing that will cause an interrupt to be taken, so the problem
really here is that the nios2 translate.c code hasn't indicated
that this insn can do this.

The right fix here will be that target/nios2/translate.c
needs to do this:
    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
        gen_io_start();
    }
before generating code for an insn like this one, and then
    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
        gen_io_end();
    }
after it. (Compare the xtensa target which does a similar
kind of thing for its interrupt handling.)
For wrctl to STATUS it should I think also end the TB,
because we want to actually take any pending interrupt
now, not in a few instructions time when the next branch
comes along.

The fact that the current nios2 code has no calls to
gen_io_start() in it at all (apart from one in boilerplate
code) suggests to me that this target is simply broken
for use with -icount at the moment. There may well be
other bugs of a similar kind where particular insns that
cause interrupts or touch devices (any equivalent to the
x86 in/out insns, for instance) also need to be marked up
as IO.

(Beyond that, the way that nios2_check_interrupts() works
looks weird; in an ideal world it would be rewritten to
work in a way that's more in line with how we'd write that
kind of code today. It should be possible to get it to work with
icount without getting into that kind of refactoring/rework,
though.)

thanks
-- PMM

