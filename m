Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3581CA9EA9
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:22:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF6B21897
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 17:22:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JLfRrk7W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABF6B21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43731 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLVxT-0001Hr-Rk
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 13:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVw1-0000EM-SE
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:21:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLVw0-0007Dc-F8
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:21:05 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41679)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLVw0-00078w-2R
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 13:21:04 -0400
Received: by mail-ot1-x343.google.com with SMTP id g13so5585471otp.8
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 10:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KYFHr2QH+Mh8sUuSrEf+c+4lYoqdIymj+MmvPuItesU=;
 b=JLfRrk7W9WegyYQL3RpcfDgOHDsxh50BxlSGmzyKAvn72XSwA2Hagwy1Hy9C7lYxwW
 BTY2XG2MZdRCqDjqD/AAQKftYU4bIaAO8wl2bsEkPGlpXx9kX6HgP8tb0l2HJXppqHu8
 y0lwuItzsVXpoIThs+0HGSGFfKGOTTial+TL8S178RibZe+LTSyOuCCeUaslwh2N9zIS
 dMwqBegbQbP+A2PPlwgzLw1hfCO9Rz2rf2v5Bo+e9S3dSsHtXE2xFbXp4wZrZSEVgfCB
 Hyo+6drruyGnH4PpKcDxKNsTckIEd9BNRsk6LW9iWY1r9WSSayMVs0hlbU1hdGTtFjqS
 Jo/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KYFHr2QH+Mh8sUuSrEf+c+4lYoqdIymj+MmvPuItesU=;
 b=syAL7O2O1KUiRrXGEMIDHh/95vU9jiNigqkzMtmOR3qMJ5p04JnVBE0bAf8q6sflma
 oBmyXPJTenc/+POltHq47YFoaU/wwqVmqjZll0rYrFompxIXPuf9SiqIvWJ2UPwxA9r5
 dDBpUgvzMLxrYSdOswSmTuvsHWWCPzevhh1q0YFXQCxSA7CHDWnvXc5fxByLQU2OUY8A
 HQYjBbF/UPyf9piG92uChY9sxlqa7tIpjJYKD0U5qaZUzxyl662BzGwrGUYEuXRxw5OX
 XedQV1/RH2nVtc8VOTZ+0wCxH1inDG0UXtQDTFqNv4aKQM+Q7CfDKwTEgyTPY+s1xxoM
 L+Vg==
X-Gm-Message-State: APjAAAXE47FWvNP10lohIeTB+ApZjEixzaudJ05qkJCEmXj1meAE87Vd
 l3CUzVwsIo4QyDmQgSygnyPyNIRco7IiHtO6Yj1dig==
X-Google-Smtp-Source: APXvYqxeTb2SHB9vdw+WOBt9sIrAFzETBm+EU38sKBIYhyEZC/PfXwqo62bpnq7GGBlZTijMF1xtWIt8YzFKJGRmijU=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr8582067otj.135.1571419251924; 
 Fri, 18 Oct 2019 10:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191018154212.13458-1-marcandre.lureau@redhat.com>
 <20191018154212.13458-10-marcandre.lureau@redhat.com>
In-Reply-To: <20191018154212.13458-10-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 18:20:40 +0100
Message-ID: <CAFEAcA-4A=SyrxsMwN0_HzSi89JAYZz8KzuDWh8O47X_WF0NtQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] smbus-eeprom: remove PROP_PTR
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:43, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Instead, set the initial data field directly. Since it is only 256
> bytes, let's simply copy it to avoid invalid pointers issues.

(Commit message says you copy the 256 bytes, but the code
doesn't seem to do any copying?)

> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Ah, the smbus code. Corey had a go at cleaning this up
a while back; I can't remember if we found a reason why
we had to keep the weird use of a pointer property here, or
if we just wanted to avoid dragging yet another thing into
an already large patchset.

What we're actually trying to set up here is always 256
bytes of data. What's the right way to pass a QOM device
a small chunk of data like that?

> ---
>  hw/i2c/smbus_eeprom.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/hw/i2c/smbus_eeprom.c b/hw/i2c/smbus_eeprom.c
> index 54c86a0112..533c728b3b 100644
> --- a/hw/i2c/smbus_eeprom.c
> +++ b/hw/i2c/smbus_eeprom.c
> @@ -44,7 +44,7 @@
>  typedef struct SMBusEEPROMDevice {
>      SMBusDevice smbusdev;
>      uint8_t data[SMBUS_EEPROM_SIZE];
> -    void *init_data;
> +    uint8_t *init_data;
>      uint8_t offset;
>      bool accessed;
>  } SMBusEEPROMDevice;
> @@ -129,14 +129,14 @@ static void smbus_eeprom_reset(DeviceState *dev)
>
>  static void smbus_eeprom_realize(DeviceState *dev, Error **errp)
>  {
> +    SMBusEEPROMDevice *eeprom =3D SMBUS_EEPROM(dev);
> +
>      smbus_eeprom_reset(dev);
> +    if (eeprom->init_data =3D=3D NULL) {
> +        error_setg(errp, "init_data cannot be NULL");
> +    }
>  }
>
> -static Property smbus_eeprom_properties[] =3D {
> -    DEFINE_PROP_PTR("data", SMBusEEPROMDevice, init_data),
> -    DEFINE_PROP_END_OF_LIST(),
> -};
> -
>  static void smbus_eeprom_class_initfn(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(klass);
> @@ -146,9 +146,8 @@ static void smbus_eeprom_class_initfn(ObjectClass *kl=
ass, void *data)
>      dc->reset =3D smbus_eeprom_reset;
>      sc->receive_byte =3D eeprom_receive_byte;
>      sc->write_data =3D eeprom_write_data;
> -    dc->props =3D smbus_eeprom_properties;
>      dc->vmsd =3D &vmstate_smbus_eeprom;
> -    /* Reason: pointer property "data" */
> +    /* Reason: init_data */
>      dc->user_creatable =3D false;
>  }
>
> @@ -172,7 +171,7 @@ void smbus_eeprom_init_one(I2CBus *smbus, uint8_t add=
ress, uint8_t *eeprom_buf)
>
>      dev =3D qdev_create((BusState *) smbus, TYPE_SMBUS_EEPROM);
>      qdev_prop_set_uint8(dev, "address", address);
> -    qdev_prop_set_ptr(dev, "data", eeprom_buf);
> +    SMBUS_EEPROM(dev)->init_data =3D eeprom_buf;
>      qdev_init_nofail(dev);
>  }
>
> --
> 2.23.0.606.g08da6496b6

thanks
-- PMM

