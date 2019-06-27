Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA4C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:01:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71DFE20B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AZNnRf5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71DFE20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgaaa-0000wt-86
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:01:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39310)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgaZ3-0000NT-BI
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgaYv-0005VL-2C
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:00:07 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43476)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgaYq-0005Lc-SS; Thu, 27 Jun 2019 16:00:01 -0400
Received: by mail-lf1-x141.google.com with SMTP id j29so2371255lfk.10;
 Thu, 27 Jun 2019 12:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rYjYxm+SVEDCvYa7FbIYeK0ER/2x8MIotQD4iyLmSrc=;
 b=AZNnRf5j6kBncSj/JZP59ulTbj2IuyED9Oc11eg7T8B4HBZTwLIO00479CgcynuJRe
 WcPZZS4ncOZ/8MC63UQcnLskBBE3agawkU9giTlUkmwDad2xGJ1nqwZuPThAMxLGsXav
 JiF/0RsE7L6tpQTJjy9kmU9fUYCYonaudSMQqsGohT0w5l9JVKJMbSUnlGJMlKX1GPUt
 y8Yxha6dChZpx9ibBLgc13SKnVOYeBSgEIXl6wISM/vtebmnRwGDka1RVh4dfbNs71sP
 s9kkpJsfSgRggxGi5/5eQ+feGDeMjSjW81tPSwe6a4D36/yMjN6tehGf0EI8Q3OB15JO
 ajCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rYjYxm+SVEDCvYa7FbIYeK0ER/2x8MIotQD4iyLmSrc=;
 b=GLCe70JDK8Cqsy7qM3+zsNs1YfhLFZdWrTY3uFZTybiwj33nIxYqa2z1K2/f1rC+xP
 MPTz25GlAxXBGKH0ZuV/JV1zoHu4+/TeclOQYoHMIK5QCPNzmey3ICZzVmK8iTP+Ou5H
 ShMhgtACw3IHpdXBmxKL5b0FGUWqcf69W/bix8q4k5IALhyJUhpO0u/f1M16ll8O42Hs
 lBktIeI7Q6noQjaBCAlkq2w2S+WXfkle0u/3l7nHgpTg4OO++RpShuMB+1tX6EPpbU+a
 TkzimfKRf1eoQiWhPDAWx6Bwn/pVieCsXBnXpl0GdNYVHvhWhFyBmIcVAWhA2D5fSYTE
 Igog==
X-Gm-Message-State: APjAAAULmi9OwhxNGwnQj+JLQtY7HIU1G+7WrtrVTYqJWG2X50FLYKzq
 oeFfDxkwn7300/CV/3/8fKg6u7LcZCkcuwKM+kg=
X-Google-Smtp-Source: APXvYqw34xBrTkX94WBDaG28yGsuQR3dFfFuhejcgn1ab8IUraX7s2LwNq3w/oBGRODyw1xZ7b5OhVTjmnlouWOkzR4=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr2970093lfu.141.1561665596272; 
 Thu, 27 Jun 2019 12:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmVZm-dhvT40Ck4d159SHin_D-U47+CHShjajzM1f-P9Gw@mail.gmail.com>
 <mhng-4265f77a-c58a-4851-871a-093b4212df1d@palmer-si-x1e>
In-Reply-To: <mhng-4265f77a-c58a-4851-871a-093b4212df1d@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 27 Jun 2019 12:56:57 -0700
Message-ID: <CAKmqyKMAGJFgJV1Y9W+ne_=jipqGMtZMKRHJmN5qpNVZrKUTeg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH for 4.1 v3] target/riscv: Expose time CSRs
 when allowed by [m|s]counteren
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Jonathan Behrens <fintelia@gmail.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 26, 2019 at 1:25 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Tue, 25 Jun 2019 23:58:34 PDT (-0700), bmeng.cn@gmail.com wrote:
> > On Wed, Jun 26, 2019 at 4:23 AM Jonathan Behrens <fintelia@gmail.com> wrote:
> >>
> >> I just did some testing on a HiFive Unleashed board and can confirm what
> >> you are saying. The low 5 bits of both mcounteren and scounteren are
> >> writable (if you try to write 0xFFFFFFFF to them, they'll take on the value
> >> 0x1F) but even with the TM bit set in both mcounteren and scounteren the
> >> rdtime instruction always generates an illegal instruction exception.
> >>
> >
> > Then I would think the FU540 is not spec complaint :)
>
> Ya, it's an errata.  There's a handful of them :)
>
> >> Reading through the relevant chapter of the spec, I still think that having
> >> mcounteren.TM be writable but making rdtime unconditionally trap is
> >> non-conformant. If other people feel strongly that rdtime should always
> >
> > Agree. To test hardware (FU540) compatibility in QEMU, maybe we can
> > add a cpu property to allow hard-wiring mcounteren.TM to zero?
>
> In theory we should have properties to control the behavior of all WARL fields,
> but it's a lot of work.  I'd be happy to take a patch for any of them.

Hmmm... We should avoid taking patches that don't adhere to the spec
just to match some hardware. In the case that core/popular software
doesn't work it probably makes sense, but in general it's probably not
the best move.

Alistair

>
> >> require trapping into firmware then the natural change would be to simply
> >> hardwire mcounteren.TM to zero (the value in scounteren wouldn't matter in
> >> that case so it could be left writable). My own (biased) personal feeling
> >> is that this full implementation makes sense at least for the `virt`
> >> machine type because it represents a clear case where deviating from
> >> current hardware enables a performance boost, and would not break
> >> compatibility with any current software: both OpenSBI and BBL try to enable
> >> hardware handling of rdtime when the platform claims to support it.
> >>
> >
> > Regards,
> > Bin
>

