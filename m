Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377A8C28CC2
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:32:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0222780A
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 03:32:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QxbO5xw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0222780A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44309 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXHEB-0004c1-N3
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 23:32:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hXHDJ-0003oq-DA
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1hXGz5-0006LH-Iy
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:16:36 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:37007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1hXGz5-0006Iq-5G
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 23:16:35 -0400
Received: by mail-lj1-x243.google.com with SMTP id 131so548181ljf.4
	for <qemu-devel@nongnu.org>; Sat, 01 Jun 2019 20:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=D3JFs7E1SZmBAPQiKL3HwgWeR0oL/aOl1WIX3xka4To=;
	b=QxbO5xw80ma37MnNcZBBV85+KSPLHrezEfuBW0slPi8oZF3BGFinCjq2QMHH5/lsGS
	3Rlo3qrTYM8Wf5bP/11pjtYNC2CdvlpC7EHAdjQMktyTm7jZx+tgNFBV2tQYyrehAp5X
	FoiDxv+bRxA3sSoUqyTE+1S0fl/krs/0E0hNCOm7QIaGR9mcICqUeKLfUuS9miT7wtuu
	wtwJfMDchSDwO4eSqRH0NiB7LOs10pBjrAQt2qAW4NDZEa9PJpee0HKzOJZNdqLshBxi
	5todOSPVU/UeJuflyQYIfYKf2SMgWuvLrSUyCI2yA4vg0HLwN2XEkFdT/ApstzjHSTdR
	NFeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=D3JFs7E1SZmBAPQiKL3HwgWeR0oL/aOl1WIX3xka4To=;
	b=lbFJFgR1wdmRwb9Sd0aEalpTVc6X4PmaJHCGyOmqhZOt57ZSwGAxuRq7n9LS+PkEwp
	WNIilSev1Qr9S/HsBWT6wTqRkNsFQrgT+BaZUD0uNZsaSk312d0Cbtnrz4oQtAYCa8ox
	5sYssC61JFrLcnNhTIFjdd0QxXtp4RpQY6k6AhHIcvHSLOO+BW3RCaCg5DRjFgBrtLh4
	TgUJj1SCrf5Z9+BquaPyJ49HY+BJuZoMJcShX909uUnQzxFeOwpem1u3PPr0h3oogui5
	OaMsUPRLLnhHjKVOUR4sXQDngZMzU5GggXlJf6P4+fcHVl1XAFwnOtmVLmKGMgoJcVgK
	QPVg==
X-Gm-Message-State: APjAAAU8u1QfIPYLXWlHg6+c8OBu61JJrOItrzntgYVvQmbWORBhiM4T
	UszxtmBMEbKvqjstYSY0MUmSnDcz8mySfrTC6eVErQ==
X-Google-Smtp-Source: APXvYqwPtfCOJ3hpFBhqwTnzP3TCsNN6idSbg6Gp4yynfkQ9pvPm7dYe5MmduB5KEn3Epk0PAsX+6nSZp54ZCrpeDyc=
X-Received: by 2002:a2e:824d:: with SMTP id j13mr9919004ljh.137.1559445389243; 
	Sat, 01 Jun 2019 20:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
	<1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-poCxPqPtfhx4mUJ5pcOjn1Hz-WNxEt29f=JgpFMi4Kg@mail.gmail.com>
	<87mujxavy3.fsf@dusky.pond.sub.org>
In-Reply-To: <87mujxavy3.fsf@dusky.pond.sub.org>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Sun, 2 Jun 2019 11:16:17 +0800
Message-ID: <CAHmQWvDC5392euk2zdKhjYBuxHx7Bw7+pnDhTPfqsRnHk51qhw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference
 machine, devices part
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 May 2019 at 21:59, Markus Armbruster <armbru@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> writes:
>
> > On Thu, 18 Apr 2019 at 05:05, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> >>
> >> Following the previous patch, this patch adds peripheral devices to the
> >> newly introduced SBSA-ref machine.
> >>
> >> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> >> ---
> >>  hw/arm/sbsa-ref.c | 451 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  1 file changed, 451 insertions(+)
> >
> > Some fairly minor comments on this one.
> >
> >> +static void create_flash(const SBSAMachineState *vms,
> >> +                         MemoryRegion *sysmem,
> >> +                         MemoryRegion *secure_sysmem)
> >> +{
> >> +    /*
> >> +     * Create one secure and nonsecure flash devices to fill SBSA_FLASH
> >> +     * space in the memmap, file passed via -bios goes in the first one.
> >> +     */
> >> +    hwaddr flashsize = vms->memmap[SBSA_FLASH].size / 2;
> >> +    hwaddr flashbase = vms->memmap[SBSA_FLASH].base;
> >> +
> >> +    create_one_flash("sbsa-ref.flash0", flashbase, flashsize,
> >> +                     bios_name, secure_sysmem);
> >> +    create_one_flash("sbsa-ref.flash1", flashbase + flashsize, flashsize,
> >> +                     NULL, sysmem);
> >> +}
> >
> > I think Markus might have an opinion on the best way to create
> > flash devices on a new board model. Is "just create two flash
> > devices the way the virt board does" the right thing?
>
> Short answer: create flash devices the way the ARM virt board does now,
> after commit e0561e60f17, merged into master today.  Possibly less
> backward compatibility stuff you don't need.  As is, your patch creates
> them the way the ARM virt board did before commit e0561e60f17.  Please
> consider updating.
>
> Longer answer:
>
> The old way to configure block backends is -drive.
>
> The newer -blockdev is more flexible.  Libvirt is in the process of
> transitioning from -drive to -blockdev entirely.  Other users with
> similar needs for flexibility may do the same.  We hope to deprecate
> -drive eventually.
>
> The traditional way to configure onboard flash is -drive if=pflash.
> Works, but we need a way to configure with -blockdev for full
> flexibility, and to support libvirt ditching -drive entirely.
>
> I recently improved the i386 PC machine types (commit ebc29e1beab) and
> the ARM virt machine types (commit e0561e60f17) to support flash
> configuration with -blockdev.
>
> I recommend new boards support flash configuration with -blockdev from
> the start.
>
> Questions?

Sorry for the late response.
Thank you for the detailed explanation, and I'll follow the new
pattern in my next version of patch which will be sent out in a few
days.

