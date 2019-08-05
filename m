Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E193C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DABA2087B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 13:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g7Twu7Wq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DABA2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hudGv-0008EO-AR
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57814)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hudGF-0007iW-7z
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:42:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hudGE-0000Wk-5d
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:42:51 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:41170)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hudGD-0000VV-UL
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 09:42:50 -0400
Received: by mail-oi1-x243.google.com with SMTP id g7so62031011oia.8
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 06:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=B05wnJyj1chi2fFWX1oj/Ms4Et6tx00K/F2SQ69Q/a0=;
 b=g7Twu7Wq3JWKEudi1gjMwSQmz1i6CDmI0hqIsOWXQpyWYIE4xGtJ5CtkPWsRtaNHQy
 WnkPe4XKO/C6U6lfFM4YCbtNTJ2e3XbRf4br2USMFfPdYjE3Q23ZLivbkAhpzu/fxdUp
 vIc5CayJ3+cEnDUJeako1c+kz5FcEfhtf6t6sAfhR9PDyu3qwGtskUauHMZzJUccMjoD
 JC+ULivLU7+TG7tocw0SxJExmHMmswFur88mhMJWZO6AU0eJaFddRD0YoiNDSuBXu5st
 nIzwu0so3vNfoyEI4AfCEjqjWcZehXjIXKu2FnGAw4A4cAWjRPUQejCyZ94gk4HwmAO+
 Fcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=B05wnJyj1chi2fFWX1oj/Ms4Et6tx00K/F2SQ69Q/a0=;
 b=Hxbux8w73lkOmASay+W+WPSbY25g3973xlXgojB9D6AdyVpyeiAqwntH8LOpG+TUnb
 quk9X2dRQyYcTOtYnIHUnZrf94E3N5RFrnKFsUIaEc5DtdrZEnIzpGWy2c7KkBaR48X9
 kTn1IU+5JmPLjxvyZmN5a+8CSRgGvKNvCcrXmTWhFQ7Ohxb06VaA6bcUmoe8GlHaEyM7
 Zo78Dg6UNDJnyM9r4eWUtEI02BjcHrM+ye2fae0RpYstT7YPuZ4SWt7YL78Ck/t7mDjl
 PxVAj+dKbsKpOQGWNiDK6AHS5y9mjJ5Rhd+iuy+gblVAKa0koJx7Ps938JI874H+Ecl7
 fJQw==
X-Gm-Message-State: APjAAAUyme88dau/eols+lScVIUrgORh44qc7p6aefOEn3gNuG/zTofB
 1AgL7BX8FdjEy6nyjZ9t6AzBOg6hRTx09pzSYmF/Ig==
X-Google-Smtp-Source: APXvYqxQtsi+tMY8nMsr+w7wv2lMlpHO9OLmCxUbLUk7CwqVbcmhIO0f78UEmrrLhbejGDwbBe9di7oXrT811pJL3uY=
X-Received: by 2002:aca:4bcc:: with SMTP id
 y195mr10299171oia.146.1565012568944; 
 Mon, 05 Aug 2019 06:42:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190726104519.23812-1-shameerali.kolothum.thodi@huawei.com>
 <20190726104519.23812-4-shameerali.kolothum.thodi@huawei.com>
 <20190730172524.6cf566ed@Igors-MacBook-Pro>
 <5FC3163CFD30C246ABAA99954A238FA83F33D896@lhreml524-mbs.china.huawei.com>
 <20190805153045.60db7bf5@redhat.com>
In-Reply-To: <20190805153045.60db7bf5@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 14:42:38 +0100
Message-ID: <CAFEAcA-+z4t75VwfWG1ezJm=4zfdWH6nz1Oe75Zs953+vKMvdQ@mail.gmail.com>
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH-for-4.2 v8 3/9] hw/acpi: Add ACPI Generic
 Event Device Support
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
Cc: "sameo@linux.intel.com" <sameo@linux.intel.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Linuxarm <linuxarm@huawei.com>,
 "shannon.zhaosl@gmail.com" <shannon.zhaosl@gmail.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "xuwei \(O\)" <xuwei5@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "sebastien.boeuf@intel.com" <sebastien.boeuf@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 14:30, Igor Mammedov <imammedo@redhat.com> wrote:
>
> On Thu, 1 Aug 2019 08:36:33 +0000
> Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:
>
> > Hi Igor,
> >
> > > -----Original Message-----
> > > > +static void acpi_ged_device_realize(DeviceState *dev, Error **errp)
> > > > +{
> > > > +    AcpiGedState *s = ACPI_GED(dev);
> > > > +
> > > > +    assert(s->ged_base);
> > > > +    acpi_ged_init(get_system_memory(), dev, &s->ged_state);
> > >
> > > calling get_system_memory() from device code used to be a reason for
> > > rejecting patch,
> > > I'm not sure what suggest though.
> > >
> > > Maybe Paolo could suggest something.
> >
> > How about using object_property_set_link()? Something like below.
> I'm afraid it doesn't help much. Issue here is that we are letting
> device to manage whole address space (which should be managed by machine)
> So I'd just keep get_system_memory() as is for now if there aren't any
> objections.

What are we trying to do with this device, and what does it need
the system memory region for?

In this case, we seem to do:

+static void acpi_ged_init(MemoryRegion *as, DeviceState *dev, GEDState *ged_st)
+{
+    AcpiGedState *s = ACPI_GED(dev);
+
+    memory_region_init_io(&ged_st->io, OBJECT(dev), &ged_ops, ged_st,
+                          TYPE_ACPI_GED, ACPI_GED_EVT_SEL_LEN);
+    memory_region_add_subregion(as, s->ged_base, &ged_st->io);
+    qdev_init_gpio_out_named(DEVICE(s), &s->irq, "ged-irq", 1);
+}


This is definitely a bad idea -- devices should not add their
own memory regions to the system memory MR. They should
expose their MRs (by being a sysbus-device) and let the board
code do the wiring up of the MRs into the right memory space
at the right address.

thanks
-- PMM

