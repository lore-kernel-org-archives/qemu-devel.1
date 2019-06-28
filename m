Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A7C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A23620828
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 18:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kX25EMlD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A23620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgvcq-0007RA-I1
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgvZv-0005oq-Ix
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:26:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgvZt-0007i8-IZ
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 14:26:31 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:44368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgvZm-0007ct-S8; Fri, 28 Jun 2019 14:26:23 -0400
Received: by mail-lj1-x242.google.com with SMTP id k18so6883306ljc.11;
 Fri, 28 Jun 2019 11:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uD2MQOPp4yIo0Q7aUKtJd7ZiJNAt2RAb/dO8AfPehd8=;
 b=kX25EMlDg3vy/Uyfxu0LzEh0MjWxTP1UGNPe54vZmf2aElYQoiNAUFf+AHKqCac23E
 OYhtDu063jI2ug2+k0xH7wRjulPrIFe0Xo9DZZhryLG5ceby4I27GNk23O9sY9tGDF6H
 NrvEZQ493jaltuj2uFRdmtaTnXKjZZrMSR4KKwM7cY0XCuEzkpOZpMh7aD/jS9xLwpTL
 Q8YH+tz3WpsAHJhBn7Ozun7w3AuQ7CFojvO4pWPeY8hDVHasxVEOJpES27JyzktbipOJ
 nNPXbNANfTA4pBW3lKIiyCQkwtIaA2QlTf4KnPuxp+lAFbnfx0M7nW92f2nSZFmg+7VR
 4Gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uD2MQOPp4yIo0Q7aUKtJd7ZiJNAt2RAb/dO8AfPehd8=;
 b=Fqiuw7TOEmGIjxHWXe9BAeaT+0mPtXMaRlFZqKtV2/MhIVeYMq3ZxFUR4qRm7cgsp+
 cD4D0DCR4pW489YW6e5fFMY2fRFtHu7Ynxo/+Rnq8+u+FFrRKgthj79V3MJj9OGlMBqh
 AmBI+UP5rUVyz1NGbpR3UB5YOcBBaiPZVTxK9Vb/Es2spHV2xprnsaMHi2QItXfFJ7H9
 ZRbsZgJIL8u+GYD6eji+fpYAkrFaHYRixQ73nBxYmPqSxTSdrmdOBGpv5Nh9K5/hob5T
 lDAHYe9r1ow71HNpHSa9ltje0RDcWS8nrLwxXWP+967wuiNI1YHOzQqCCs/wGkbkostx
 SgNw==
X-Gm-Message-State: APjAAAVg0/hOBHqjDr0H5L2jrwYAL9WAyxRkQ60+rB5wDhxY3QaxjuuB
 ETMA1dPs5IUIMS3nLeusMWqq8ZFr7J8vJnb4SfE=
X-Google-Smtp-Source: APXvYqxC7nzFm3U8Ay70Vc0zdy1Z4rUqweoClfCAFF/7ciKmtzTWsE76RsjiKUrgyuhK6UWubZmhW+EJJ8d7dZwhaPQ=
X-Received: by 2002:a2e:86cc:: with SMTP id n12mr6947159ljj.146.1561746380790; 
 Fri, 28 Jun 2019 11:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAKmqyKMAGJFgJV1Y9W+ne_=jipqGMtZMKRHJmN5qpNVZrKUTeg@mail.gmail.com>
 <mhng-89e59e27-71b5-4452-93af-a889983f711c@palmer-si-x1e>
In-Reply-To: <mhng-89e59e27-71b5-4452-93af-a889983f711c@palmer-si-x1e>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 11:23:20 -0700
Message-ID: <CAKmqyKNiZheaqC5UHkOMY+s54vgR8ho1gequAM4Sts3=25DzkA@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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

On Thu, Jun 27, 2019 at 11:12 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Thu, 27 Jun 2019 12:56:57 PDT (-0700), alistair23@gmail.com wrote:
> > On Wed, Jun 26, 2019 at 1:25 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >> On Tue, 25 Jun 2019 23:58:34 PDT (-0700), bmeng.cn@gmail.com wrote:
> >> > On Wed, Jun 26, 2019 at 4:23 AM Jonathan Behrens <fintelia@gmail.com> wrote:
> >> >>
> >> >> I just did some testing on a HiFive Unleashed board and can confirm what
> >> >> you are saying. The low 5 bits of both mcounteren and scounteren are
> >> >> writable (if you try to write 0xFFFFFFFF to them, they'll take on the value
> >> >> 0x1F) but even with the TM bit set in both mcounteren and scounteren the
> >> >> rdtime instruction always generates an illegal instruction exception.
> >> >>
> >> >
> >> > Then I would think the FU540 is not spec complaint :)
> >>
> >> Ya, it's an errata.  There's a handful of them :)
> >>
> >> >> Reading through the relevant chapter of the spec, I still think that having
> >> >> mcounteren.TM be writable but making rdtime unconditionally trap is
> >> >> non-conformant. If other people feel strongly that rdtime should always
> >> >
> >> > Agree. To test hardware (FU540) compatibility in QEMU, maybe we can
> >> > add a cpu property to allow hard-wiring mcounteren.TM to zero?
> >>
> >> In theory we should have properties to control the behavior of all WARL fields,
> >> but it's a lot of work.  I'd be happy to take a patch for any of them.
> >
> > Hmmm... We should avoid taking patches that don't adhere to the spec
> > just to match some hardware. In the case that core/popular software
> > doesn't work it probably makes sense, but in general it's probably not
> > the best move.
>
> WARL is Write Any Read Legal.  Essentially it means that the hardware gets to
> decide what sort of behavior that field has, and is the mechanism for optional
> features in the ISA.  In this case it'd be entirely within spec, specifically:
>
>     Registers mcounteren and scounteren are WARL registers that must be
>     implemented if U-mode and S-mode are implemented. Any of the bits may
>     contain a hardwired value of zero, indicating reads to the corresponding
>     counter will cause an illegal instruction exception when executing in a
>     less-privileged mode.
>
> Taking a patch that matches the out-of-spec FU540 behavior doesn't make any
> sense, I don't want to implement errata in QEMU :)

Ah, I misread your email. That is fine then :)

Alistair

>
> >
> > Alistair
> >
> >>
> >> >> require trapping into firmware then the natural change would be to simply
> >> >> hardwire mcounteren.TM to zero (the value in scounteren wouldn't matter in
> >> >> that case so it could be left writable). My own (biased) personal feeling
> >> >> is that this full implementation makes sense at least for the `virt`
> >> >> machine type because it represents a clear case where deviating from
> >> >> current hardware enables a performance boost, and would not break
> >> >> compatibility with any current software: both OpenSBI and BBL try to enable
> >> >> hardware handling of rdtime when the platform claims to support it.
> >> >>
> >> >
> >> > Regards,
> >> > Bin
> >>

