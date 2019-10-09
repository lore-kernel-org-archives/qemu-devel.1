Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65130ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:53:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E316620679
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iS0uoPqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E316620679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIH5j-0000FH-J4
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 14:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57144)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iICNV-0006Bf-Gj
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iICNU-000662-HU
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:51:45 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39086)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iICNU-00065c-BK
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 09:51:44 -0400
Received: by mail-oi1-x244.google.com with SMTP id w144so1791444oia.6
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7OvEfYO9EpQ8fnwFtnhlr1IhWEuGDHMdr6XTfc/iLm4=;
 b=iS0uoPqa0iDdcVDDcFthTa0dBcllC/xw8QVuoB40nYxZLnHLJcPgf5fwnAlW9A5pT3
 pGLTi9+GpVIR19wE3k+W9EqDcbEcnqpScruo24bEMM9ye1z6JtwlexkJjCnpU1dr0g6x
 V4KBztKpXYeD73SwuKiqoR6qsQy1ngvcehds54sZvt4M9hppCd69dlRHUb+7XQ/SwO1P
 2/elzoXowyWmzqQUiYy/sT58OtphDc9PXZXo5ZE2bqEjXe8Gd6vARyD9cPoYezd2Uxgb
 ZSq7jbmSo0eHZCxlKrdpgwBCAOZqdJq9TsgxDfOBLXNzPibu8XYglADdv64FV8TmlaXf
 nalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7OvEfYO9EpQ8fnwFtnhlr1IhWEuGDHMdr6XTfc/iLm4=;
 b=l/ExLsG8VQ5gyCOsPNnaOV6DmZfKwnWn6jXRtHnOP3la6mY6eUoN0Cv67v9ciSbpJ8
 vYvKdjMGnAdXdqx8Tc1SYOfhK6NUBcqvO9XZuYxf5koS2ir11vvC5VZzxv2/0s3zHeB/
 Zehy1CC/rYaRdzPNHIOuhzDlopTfFtE8WxdeXFIOKtY2CAG4qWjmFUnPRPjITkm3tzku
 tbWHTNosLDd7ifZMnKZHhh5Q0sHNG8cOmbS0/0NxB5yZKlBZXAaT3qpEO4RckDVtfhhc
 Sc12N9R+nj38wMeox6RtvYSb174V0WFy3ZLnhUR+povLb2pWTW4bO3A/6n5ox2fEIHYt
 18dg==
X-Gm-Message-State: APjAAAUrhsPJgmqdW8IXaiVzk/nSZylxhnMcFQeOMGl7BpsSctMDe6ZB
 4rWxax1j8rW0Pgej56bBKoKaf09p+veKTIMsAQDHZw==
X-Google-Smtp-Source: APXvYqw2thD7HgJ1D7aUU/9v6R+eBR33EALysh6Zi2oURCCoVKqOMEfv6DInCNzXroIxkuUksdCbQUfjmrjFUz4aHn0=
X-Received: by 2002:aca:2b08:: with SMTP id i8mr2204531oik.146.1570629102479; 
 Wed, 09 Oct 2019 06:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190926151733.25349-1-philmd@redhat.com>
 <20190926151733.25349-12-philmd@redhat.com>
 <f110c099-7521-95e0-74b9-9c7e53d7d5d8@redhat.com>
In-Reply-To: <f110c099-7521-95e0-74b9-9c7e53d7d5d8@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 9 Oct 2019 14:51:30 +0100
Message-ID: <CAFEAcA_urR77o5+mFy3a4wL=BDHVzEvnAeaf2ASXdpa6md16FQ@mail.gmail.com>
Subject: Re: [PATCH 11/11] hw/misc/vmcoreinfo: Convert reset handler to
 DeviceReset
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Eduardo Habkost <ehabkost@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 26 Sep 2019 at 17:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 9/26/19 5:17 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Convert the reset handler into a proper Device reset method.
>
> Marc-Andr=C3=A9 noticed this one is incorrect, because while being QDEV i=
t is
> not connected to a QBUS.
>
> Maybe we can add a Device::unconnected property, and when set, the
> parent realize() calls 'qemu_register_reset(dev->reset, dev);'?
> This might look the same, but at least Devices implementations could
> stop to use this function...

I'm not in favour of ad-hoc attempts to patch the
problem with some devices not being reset like this.
I'd rather we figured out a general solution to the design
problem (which isn't easy, but on the other hand the
set of workarounds we currently have isn't too awful
to deal with).

thanks
-- PMM

