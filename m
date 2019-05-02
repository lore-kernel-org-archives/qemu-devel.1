Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C781FC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D4BD2081C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 07:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKpY2YTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4BD2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46454 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hM64V-0002C9-5f
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 03:23:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58301)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1hM63h-0001oT-Ei
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:23:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1hM63d-0005jS-GM
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:23:07 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:53280)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1hM63V-0005cQ-4U
	for qemu-devel@nongnu.org; Thu, 02 May 2019 03:22:59 -0400
Received: by mail-it1-x143.google.com with SMTP id l10so1612312iti.3
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 00:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=N7NSxJr5uDvgcq3djMQ2v1/6rgL3Lq/qkCZV7efUj7I=;
	b=IKpY2YTcOTrzlxBQJKUNt7GCQ2Ep3NOb9rGyBUpgtqR8YnnPbUg2SBep4dYSPGHW5T
	UiQyQWnZMifOGsmXt+sgepQ3dfjWnHvV3nqDLETHBnNSe0KFLTET6ujEuqA2TCOWc6wY
	ZNFfYGeUZdN/wJjZ2uIOaUT1G4DWL6ZHyucxuIuL9qrCh1crc27P2n5y9+dGPchbkjdF
	iqm8eLH9oPdC3jHHnXp2xL55DYqwARjHwMW5ZbmV1jweUjuA7ruR++4VWhBsddIMXX6r
	3tbrWfH09OzuVSvSpCAH3MFXLtVJlIU5Y/lM9DHbQZZGpWkFeY78Y02XIWIYe46YAVvY
	7Mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=N7NSxJr5uDvgcq3djMQ2v1/6rgL3Lq/qkCZV7efUj7I=;
	b=Um28/1fsn01WQo2+wBADV82s4xabLVnfwETXRkVVC98P7ERbhvhkSiezSuXd9vqPM5
	9g8starhYW8k0JfqL+tTNGDdpjim/QgMoGWRqaDVwhMZJ+HAnzLRQ8U/7ygFN5SCVHIv
	QGrG1V9wH0200ierMpU3q9hKg2QWoERlihMXRWeO1wgU7WwSNtCKUbdvXccSNefdY8zF
	0ZhGwsVpZRPj3p4+EPJdzrbTvMcpGA8guixRtQOxkv3VJnPWPsoNnFoUAhmzxNY9B3+U
	UoMXcUOR58qt45d1UjsKpKflz0+R+IlSya3bKfbzb31UxaCD8oQkMo2ZfvQKoSdfgR9Z
	M6dg==
X-Gm-Message-State: APjAAAXO0Fed2xffeuBJhg8IG4zxmEUitmR/aLDxkcZMyMSMYqRU1F3x
	YIycVmDWHzcnTCvEi1b3I9zEwzcVUU5FttV7eHrT4Q==
X-Google-Smtp-Source: APXvYqxJdfKwsgErl8UCA3YEUtZCFHshyLAoq47+Qm2/mb3LPPVK1R9ykzAA7F3/5e3o7i3HCFWKSHvhbiTaATsVPQI=
X-Received: by 2002:a24:b342:: with SMTP id z2mr1138315iti.121.1556781768611; 
	Thu, 02 May 2019 00:22:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190409102935.28292-1-shameerali.kolothum.thodi@huawei.com>
	<20190409102935.28292-4-shameerali.kolothum.thodi@huawei.com>
	<CAKv+Gu_guvAydmCZDeVnj0NR_WyTHeCmwh4tK9WKUBY6cy-4Pg@mail.gmail.com>
	<5FC3163CFD30C246ABAA99954A238FA83F137685@lhreml524-mbs.china.huawei.com>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA83F137685@lhreml524-mbs.china.huawei.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Thu, 2 May 2019 09:22:35 +0200
Message-ID:
 <CAKv+Gu9yw6s=N+LkKmQ+0d5ZQBJ+5tE0_cKtZAYHh_cTXnjyCQ@mail.gmail.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event
 Device Support
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
	"sameo@linux.intel.com" <sameo@linux.intel.com>,
	"shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>,
	Auger Eric <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
	"xuwei \(O\)" <xuwei5@huawei.com>, Igor Mammedov <imammedo@redhat.com>,
	"sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
	Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502072235.XqvIwct8Km7p7UNH0rKup0FFyKVRVgvSmKMUmMEqDdI@z>

On Wed, 1 May 2019 at 13:25, Shameerali Kolothum Thodi
<shameerali.kolothum.thodi@huawei.com> wrote:
>
> Hi Ard,
>
> > -----Original Message-----
> > From: Ard Biesheuvel [mailto:ard.biesheuvel@linaro.org]
> > Sent: 01 May 2019 12:10
> > To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
> > Cc: QEMU Developers <qemu-devel@nongnu.org>; qemu-arm
> > <qemu-arm@nongnu.org>; Auger Eric <eric.auger@redhat.com>; Igor
> > Mammedov <imammedo@redhat.com>; Peter Maydell
> > <peter.maydell@linaro.org>; shannon.zhaosl@gmail.com;
> > sameo@linux.intel.com; sebastien.boeuf@intel.com; xuwei (O)
> > <xuwei5@huawei.com>; Laszlo Ersek <lersek@redhat.com>; Linuxarm
> > <linuxarm@huawei.com>
> > Subject: Re: [PATCH v4 3/8] hw/acpi: Add ACPI Generic Event Device Support
> >
> > On Tue, 9 Apr 2019 at 12:31, Shameer Kolothum
> > <shameerali.kolothum.thodi@huawei.com> wrote:
> > >
> > > From: Samuel Ortiz <sameo@linux.intel.com>
> > >
> > > The ACPI Generic Event Device (GED) is a hardware-reduced specific
> > > device[ACPI v6.1 Section 5.6.9] that handles all platform events,
> > > including the hotplug ones.This patch generates the AML code that
> > > defines GEDs.
> > >
> > > Platforms need to specify their own GedEvent array to describe what
> > > kind of events they want to support through GED.  Also this uses a
> > > a single interrupt for the  GED device, relying on IO memory region
> > > to communicate the type of device affected by the interrupt. This
> > > way, we can support up to 32 events with a unique interrupt.
> > >
> > > This supports only memory hotplug for now.
> > >
> > > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > > Signed-off-by: Sebastien Boeuf <sebastien.boeuf@intel.com>
> > > Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> >
> > Apologies if this question has been raised before, but do we really
> > need a separate device for this? We already handle the power button
> > via _AEI/_Exx on the GPIO device, and I think we should be able to add
> > additional events using that interface, rather than have two event
> > signalling methods/devices on the same platform.
>
> Right. The initial RFC was based on GPIO device[1] and later Igor commented
> here[2] that,
>
> " ARM boards were first to use ACPI hw-reduced profile so they picked up
> available back then GPIO based way to deliver hotplug event, later spec
> introduced Generic Event Device for that means to use with hw-reduced
> profile, which NEMU implemented[1], so I'd use that rather than ad-hoc
> GPIO mapping. I'd guess it will more compatible with various contemporary
> guests and we could reuse the same code for both x86/arm virt boards) "
>

On mach-virt, we already use the GPIO controller for the ACPI event
involving the power button, so by aligning with virt-x86, we end up in
the opposite situation for mach-virt.

The problem with the GED device is that it only supports GSI
interrupts, while the GPIO device supports arbitrary interrupts (such
as GPIO signalled ones). This means that mach-virt will be stuck with
having two different methods of signalling ACPI events, unless we
rewire the power button not to use a GPIO interrupt but use a GSI
directly.

In general, I think the ACPI event delivery mechanism doesn't really
have to be aligned: the ACPI event is ultimately converted into a AML
notification to the right device, and how we end up there can remain
platform specific.

