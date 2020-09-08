Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44B09C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:05:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB41B2078B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 10:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNxTyJSW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB41B2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFaV8-0001fW-0X
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 06:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFaUW-0000wC-JS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:04:44 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFaUT-0005ht-Gt
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 06:04:44 -0400
Received: by mail-ed1-x543.google.com with SMTP id w1so15413800edr.3
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 03:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=pHwrWC7u2HrkS5TSF535ot5rdvmEgH9XL4Qkine6i2I=;
 b=PNxTyJSWy0rhDv+e+Nd+L3RHW1DJpUR1P6uUeRbTtkO1rrnhD7oHJPk5c10M/j2lyx
 MvEnaqN9eWFcIL16BEFscBDTJIo9GONmUjdAcT9Xt2/WRZrqHfRnECbYMcddK7DdTaYK
 g9KNz+hZwDlmTC30tHDqxOeJjpBUr4g3Iq3bt6qdfmjDsJ+xHS+5aMqIUZ1uYcgRiong
 QcsGnz5Ep9+imcuAxFhyWhLSvo50aQ8YwseN7m/8+fDbCooXyFzUH/fhyZqxjzdLobwn
 yQC08uihh5xGX/973jfEv+0ncNoiE4p/jG0MA/veDMO1Dr/VAu6Ro6GqiHuC4vqsglPC
 VgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=pHwrWC7u2HrkS5TSF535ot5rdvmEgH9XL4Qkine6i2I=;
 b=WDuPZkNCwn5QqA5635iEyHn2i9bSXcA2bVsHHJRI8m3N250SCDeQP7lxVh+NP6j5li
 ZV3h/QAQj/g4UhWOwsc17FahyKcZue5X3Yq5yuHNA/089tklI2fHXpP1gR/+kKGSbGmj
 KA93o+A9Xgd69dKwABdmqtji4AinjcHVB+7k5B7LxqxvFA56skS/UlSIG5GRf7JAgwaM
 qvzJD1Dbzb8gwF5d5/YSfS4bxsHxJadJPilnFBqpuyW5TJmSk2e9SvSi7KZyUaWHiIYO
 njrVANP8UldwXT9Lu14HWJFGdMiP8+cUZCF/AzrdZ2fDeaqGbsxI4H7DrHswP6/jOa3K
 e2jw==
X-Gm-Message-State: AOAM532GMEzrLMRQn0W966Eu9EtqgGPFjLE9Z8spez18sVe2r5exgKqQ
 HQK7C2tbxXeVEj9m70eUN9TfgcMPbUgpYsrURkXjFg==
X-Google-Smtp-Source: ABdhPJz38YXfst2VQwZZn1cjumwtgXIbnrPxcLS1p/LlTk+ZiCc+6rJkRDzCbqeOxmJCxKZx5rxMLKxHaYgpOfLtooY=
X-Received: by 2002:a50:8f45:: with SMTP id 63mr26907407edy.52.1599559478516; 
 Tue, 08 Sep 2020 03:04:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200907163257.46527-1-f4bug@amsat.org>
 <20200907163257.46527-9-f4bug@amsat.org>
 <87h7s8g0v2.fsf@dusky.pond.sub.org>
In-Reply-To: <87h7s8g0v2.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 11:04:26 +0100
Message-ID: <CAFEAcA_Mkh-PM7z4ESyU4AJpDj8f+RVdUSMGeEVUanmvR=6f1w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 8/8] hw/arm/tosa: Make TYPE_TOSA_MISC_GPIO a plain
 QDev
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 08:54, Markus Armbruster <armbru@redhat.com> wrote:
>
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>
> > TYPE_TOSA_MISC_GPIO doesn't need to be a SysBus device,
> > make it a plain QDev.
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> > RFC because having to pass MachineState and call
> > object_property_add_child() simply makes things more
> > complex... but it seems to cleaner QOM design.
>
> Well, what devices really *need* to be sysbus devices?
>
> The question is trivial for "real" buses, such as PCI, USB, and so
> forth: a device is a FOO device when it plugs into a FOO bus.
>
> Sysbus is quite unlike these "real" buses.  It exists because qdev
> initially *required* qdevs to plug into a qbus, so we made up a qbus for
> the devices that don't plug into any of our "real" buses[1].
>
> I figure all sysbus devices could be coded as bus-less devices today.
> So the answer to "what devices really *need* to be sysbus devices?" is
> "none".

The major thing sysbus being a bus gives you is reset: devices
on buses get reset automatically, but devices not on buses don't.
So in this particular case I'm not in favour of this change --
right now the TOSA_MISC_GPIO device doesn't happen to need a reset,
but having devices floating around in the system which can't have
a reset method is a beartrap for our future selves. It's bad enough
that we have this issue today with CPU objects: I don't want us to
extend that to anything else if we can avoid it.

> I think a more useful question is what devices *should* be coded as
> sysbus devices vs. bus-less devices.
>
> Sysbus is more than just a dummy qbus.  It's a software interface that
> provides useful stuff.  To use it, the device needs to be a
> SysBusDevice.  This leads to a partial answer: if the device profits
> from stuff we provide only to SysBusDevices, it should be one.
>
> Perhaps the useful stuff could be separated from SysBusDevice.  Then
> this partial answer evaporates.

This also is true -- some pretty generic useful stuff like "I can have
MMIO regions" and "I get automatically reset" is implemented in sysbus,
and some (like "I have gpio lines") for DeviceState. I would be happy
to see this cleaned up. For the code we have at the moment I prefer
to treat SysBusDevice as the preferred parent class for devices, ie
don't directly inherit from DeviceState unless you really know what
you're doing.

The reset stuff in particular is desperately in need of a cleanup
but it's a swamp, as usual. Currently we reset along the qbus tree
(which is why non-bus-connected devices don't get their qdev reset
method called, and must fend for themselves via qemu_register_reset()).
These days I feel like "resetting a device should reset all its QOM
children" would be a more natural way to model things (with some sort
of "this device needs to override that default behaviour" for SoCs
with more complicated reset handling) but getting there from here
feels like it would be very painful.

> There is just one instance of TYPE_SYSTEM_BUS[2].  This leads to another
> partial answer: if the device can be part of another device, it should
> not be a SysBusDevice.
>
> Sysbus also enables "dynamic" sysbus devices.  Shoehorning them into
> SysBusDevice may have been a mistake.

I was never much of a fan of dynamic sysbus devices at all :-)

thanks
-- PMM

