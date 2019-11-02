Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A998CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 20:29:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B0D520862
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 20:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0D520862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iR01s-0003Pn-L2
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 16:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42174)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iR01C-0002yT-0p
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 16:29:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iR019-0002JE-4m
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 16:29:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iR018-0002E5-SJ
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 16:29:03 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 34CA1C04B940
 for <qemu-devel@nongnu.org>; Sat,  2 Nov 2019 20:29:01 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id u2so1659461wrm.7
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 13:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ItK3NlHdDOhpQQoTTtmXss3y8n28Xy31XU2k9uhJK3Q=;
 b=OWJ4P5h4NGEFsjB7LJPR/tKGbKwdYTpFsn80imPa1pRLCeH/oPEitcwdFP/Ss2vtbl
 ooUbMHuz4mQySiUQ5dFbsHYypiettyzb+nxFcghSaFIXExinjbJJiUspdsXLcwAV1LB0
 1AQOSr1S2VpsCZsuweMDXcKzPhqxoFUCjD1E0SIJxktAjxLbpMMC0MbxzMeH2zSgTD2L
 l4+wSK98JJE498D3qTj3wvbc7bqLvhyq7tINBKCfGqB7pHMjd4L+2sHpvfLWSMpHF+gq
 RvNTvrN4N1zGD0w8wrRfd39uzSeagW/1lcghKIZP7VQLFXEs49ATUJktdFu7QGB+nsLo
 CGdA==
X-Gm-Message-State: APjAAAX6FXtaIgOzsGyive7U129kV7TtEI0X9ex7Vq4UDot+G4ZR8+12
 kV66mHIGX0TCVCSOUOc09iIPGwQIw4Qgf6g1csHlHRslRv5rqg/hd1pxZty9wEmJRL6thCGABsi
 ZPdMND+OPcN9dt9U=
X-Received: by 2002:adf:eec9:: with SMTP id a9mr15833784wrp.8.1572726539926;
 Sat, 02 Nov 2019 13:28:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxyk/j35m9fGizIDuOIU/oUEdaw7vghEwWpnjvtRXxq8fIRuDKevjaIvCzEfP79/ujN3kVkEQ==
X-Received: by 2002:adf:eec9:: with SMTP id a9mr15833769wrp.8.1572726539657;
 Sat, 02 Nov 2019 13:28:59 -0700 (PDT)
Received: from [10.34.4.205] ([109.190.253.11])
 by smtp.gmail.com with ESMTPSA id r5sm10952863wrl.86.2019.11.02.13.28.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Nov 2019 13:28:58 -0700 (PDT)
Subject: Re: [PULL 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
 <CAFEAcA-9wQMzJN+ZeWDE8k1E9uwUw3NHNJuR2H_hHRNeX1Lf8Q@mail.gmail.com>
 <ff388170-7ee8-39f2-359b-246571e720a5@redhat.com>
Message-ID: <78fb8474-5e89-b05e-315b-32b587ca4353@redhat.com>
Date: Sat, 2 Nov 2019 21:28:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <ff388170-7ee8-39f2-359b-246571e720a5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Paolo,

On 10/30/19 10:44 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Peter, Paolo,
>=20
> On 10/30/19 7:15 AM, Peter Maydell wrote:
>> On Mon, 28 Oct 2019 at 17:48, Philippe Mathieu-Daud=C3=A9=20
>> <philmd@redhat.com> wrote:
>>>
>>> ----------------------------------------------------------------
>>> The i440FX northbridge is only used by the PC machine, while the
>>> PIIX southbridge is also used by the Malta MIPS machine.
>>>
>>> Split the PIIX3 southbridge from i440FX northbridge.
>>>
>>> ----------------------------------------------------------------
>>
>> I get a link failure on my 'do a make clean and then make' build :
>> =C2=A0=C2=A0 LINK=C2=A0=C2=A0=C2=A0 i386-softmmu/qemu-system-i386
>> hw/i386/pc_piix.o: In function `pc_init1':
>> /home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:197: undefined
>> reference to `i440fx_init'
>> /home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:206: undefined
>> reference to `piix3_create'
>> collect2: error: ld returned 1 exit status
>=20
> This is odd, default-configs/i386-softmmu.mak selects CONFIG_I440FX,=20
> I440FX selects PCI_I440FX, and the Makefile.objs has:
> common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
>=20
> The change is in patch "hw/pci-host: Rename incorrectly named 'piix' as=
=20
> 'i440fx'" which is a simple rename:
>=20
> -- >8 --
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index d420b35548..5a494342ea 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -60,7 +60,7 @@ config I440FX
>  =C2=A0=C2=A0=C2=A0=C2=A0 select PC_PCI
>  =C2=A0=C2=A0=C2=A0=C2=A0 select PC_ACPI
>  =C2=A0=C2=A0=C2=A0=C2=A0 select ACPI_SMBUS
> -=C2=A0=C2=A0=C2=A0 select PCI_PIIX
> +=C2=A0=C2=A0=C2=A0 select PCI_I440FX
>  =C2=A0=C2=A0=C2=A0=C2=A0 select PIIX3
>  =C2=A0=C2=A0=C2=A0=C2=A0 select IDE_PIIX
>  =C2=A0=C2=A0=C2=A0=C2=A0 select DIMM
> diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
> index 397043b289..b0aa8351c4 100644
> --- a/hw/pci-host/Kconfig
> +++ b/hw/pci-host/Kconfig
> @@ -28,7 +28,7 @@ config PCI_SABRE
>  =C2=A0=C2=A0=C2=A0=C2=A0 select PCI
>  =C2=A0=C2=A0=C2=A0=C2=A0 bool
>=20
> -config PCI_PIIX
> +config PCI_I440FX
>  =C2=A0=C2=A0=C2=A0=C2=A0 bool
>  =C2=A0=C2=A0=C2=A0=C2=A0 select PCI
>  =C2=A0=C2=A0=C2=A0=C2=A0 select PAM
> diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> index a9cd3e022d..efd752b766 100644
> --- a/hw/pci-host/Makefile.objs
> +++ b/hw/pci-host/Makefile.objs
> @@ -13,7 +13,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o
>=20
>  =C2=A0common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
>  =C2=A0common-obj-$(CONFIG_FULONG) +=3D bonito.o
> -common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
> +common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
>  =C2=A0common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
>  =C2=A0common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
>  =C2=A0common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
> diff --git a/hw/pci-host/piix.c b/hw/pci-host/i440fx.c
> similarity index 100%
> rename from hw/pci-host/piix.c
> rename to hw/pci-host/i440fx.c
> ---
>=20
> I could reproduce and hw/pci-host/ doesn't contains neither piix.o nor=20
> i440fx.o.
>=20
> $ fgrep -ri i440fx i386-softmmu/
> i386-softmmu/config-devices.h-timestamp:#define CONFIG_I440FX 1
> i386-softmmu/config-devices.mak.old:CONFIG_I440FX=3Dy
> Binary file i386-softmmu/hw/i386/pc_piix.o matches
> i386-softmmu/hw/i386/pc_piix.d:=20
> /home/phil/source/qemu/include/hw/pci-host/i440fx.h \
> i386-softmmu/hw/i386/pc_piix.d:/home/phil/source/qemu/include/hw/pci-ho=
st/i440fx.h:=20
>=20
> Binary file i386-softmmu/hw/i386/acpi-build.o matches
> Binary file i386-softmmu/hw/i386/pc.o matches
> i386-softmmu/config-devices.mak:CONFIG_I440FX=3Dy
> i386-softmmu/config-devices.h:#define CONFIG_I440FX 1
>=20
> So CONFIG_I440FX is here, but no CONFIG_PCI_I440FX...
>=20
> $ fgrep -r PIIX i386-softmmu/
> i386-softmmu/config-devices.h-timestamp:#define CONFIG_IDE_PIIX 1
> i386-softmmu/config-devices.h-timestamp:#define CONFIG_PCI_PIIX 1
> i386-softmmu/config-devices.mak.old:CONFIG_IDE_PIIX=3Dy
> i386-softmmu/config-devices.mak.old:CONFIG_PCI_PIIX=3Dy
> Binary file i386-softmmu/hw/i386/pc_piix.o matches
> Binary file i386-softmmu/hw/i386/acpi-build.o matches
> Binary file i386-softmmu/hw/i386/pc.o matches
> i386-softmmu/config-devices.mak:CONFIG_IDE_PIIX=3Dy
> i386-softmmu/config-devices.mak:CONFIG_PCI_PIIX=3Dy
> i386-softmmu/config-devices.h:#define CONFIG_IDE_PIIX 1
> i386-softmmu/config-devices.h:#define CONFIG_PCI_PIIX 1
>=20
> And the old CONFIG_PCI_PIIX is still there :(
>=20
> Paolo, is some kconfig dependency missing?

docs/devel/build-system.txt is misleading:

   - $TARGET-NAME/config-devices.mak

   TARGET-NAME is again the name of a system or userspace emulator. The
   config-devices.mak file is automatically generated by make using the
   scripts/make_device_config.sh program, feeding it the
   default-configs/$TARGET-NAME file as input.

But this script has been removed in e0e312f3525:

   build: switch to Kconfig

   The make_device_config.sh script is replaced by minikconf, which
   is modified to support the same command line as its predecessor.

Anyway, back to my problem. We modified hw/i386/Kconfig and=20
hw/pci-host/Kconfig. i386-softmmu/config-devices.mak hasn't been rebuilt.

Here is the make rule matching i386-softmmu/config-devices.mak:

$(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak=20
$(MINIKCONF_INPUTS) $(BUILD_DIR)/config-host.mak
	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) > $@.tmp, "GEN",=20
"$@.tmp")

With:

MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host $(SRC_PATH)/hw/Kconfig

So hw/{i386,pci-host}/Kconfig aren't matched and doesn't trigger the=20
regeneration of i386-softmmu/config-devices.mak.

I'm not sure how to properly fix this.

Also, is the backslash useful at the end of this line in Makefile?

MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py \


Regards,

Phil.

