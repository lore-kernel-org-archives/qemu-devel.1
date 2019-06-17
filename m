Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F0CC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C5F22084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C5F22084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcpWi-0007Fz-HK
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48916)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hcpV9-0006hg-If
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hcpV7-0001Bp-KS
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:08:39 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hcpV6-00016E-48
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:08:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id d18so9486064wrs.5
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=8aC46cyhFQ785ox2mpl2YTsyO7Jry51sIGIX6a2zlMQ=;
 b=k6TdJOtN6GG6DFY9XctMkEB1+LTZoKDt4EIaBoluPSs9uHhiTLkCp3gLFMlitSmkNr
 x/STqd7DkKXB+B1wj19K0UiaPQdx5lF3GXEdlm9VVZiBGWy55PX2RlPBXRxbi77z1GFh
 K9RuOhu2jO3PyvhErOvaEJdYmviUu/6szJk5hacAR1qGslMfqq0+iSXtOjUi6/rIL+ga
 Gs8Wc4dzhy3V8NhZ5Kn630NQAtFOQ7VoOnNptTbwDNnGcZdHCderh1oRbpwjSCi0jUEi
 yluQDwS/b/d7xMyq5massCxR0tTwakBO8lnsRy+K2J0mDiCeLX7PqYyFD7+cy/FLVtsS
 XpmA==
X-Gm-Message-State: APjAAAVccoA2q+p71b0pJM8+h7Eiz1BW5RAGhEI4DxKL/TrBZbeyhoUI
 gobAmDZi6n8eaqLDDsVoZEy3Ww==
X-Google-Smtp-Source: APXvYqxWRPEGR2Op3sVtopH0O3javUpkjAY5XSOfN18lIJ8hBMN6RxagpVecveCvl6ms2ZZ612Pk1Q==
X-Received: by 2002:adf:dc4b:: with SMTP id m11mr13901077wrj.51.1560769713401; 
 Mon, 17 Jun 2019 04:08:33 -0700 (PDT)
Received: from [192.168.1.38] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l12sm31950320wrb.81.2019.06.17.04.08.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 04:08:32 -0700 (PDT)
To: Hongbo Zhang <hongbo.zhang@linaro.org>
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
 <1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
 <ed731639-5ed1-5473-f078-e62f8fa98678@redhat.com>
 <CAHmQWvAuQ9mwXA5uO3ShYyvP5ywOrck5kU4gPD_kGh5S39Va2w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <cb17ecf4-d321-2f71-7528-2fd5aec2cccd@redhat.com>
Date: Mon, 17 Jun 2019 13:08:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHmQWvAuQ9mwXA5uO3ShYyvP5ywOrck5kU4gPD_kGh5S39Va2w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="EDq9rOkvOFd8EAoX2g4c2SDBGNXWjgbcG"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference
 machine, devices part
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EDq9rOkvOFd8EAoX2g4c2SDBGNXWjgbcG
Content-Type: multipart/mixed; boundary="YnHE07YsvbE1QDnKfpcfe2ray0FttL2Qv";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Laszlo Ersek <lersek@redhat.com>
Message-ID: <cb17ecf4-d321-2f71-7528-2fd5aec2cccd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 2/2] hw/arm: Add arm SBSA reference
 machine, devices part
References: <1555560291-3415-1-git-send-email-hongbo.zhang@linaro.org>
 <1555560291-3415-3-git-send-email-hongbo.zhang@linaro.org>
 <ed731639-5ed1-5473-f078-e62f8fa98678@redhat.com>
 <CAHmQWvAuQ9mwXA5uO3ShYyvP5ywOrck5kU4gPD_kGh5S39Va2w@mail.gmail.com>
In-Reply-To: <CAHmQWvAuQ9mwXA5uO3ShYyvP5ywOrck5kU4gPD_kGh5S39Va2w@mail.gmail.com>

--YnHE07YsvbE1QDnKfpcfe2ray0FttL2Qv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/16/19 1:41 PM, Hongbo Zhang wrote:
> On Mon, 3 Jun 2019 at 18:54, Philippe Mathieu-Daud=C3=A9 <philmd@redhat=
=2Ecom> wrote:
>>
>> Hi Hongbo, Ard.
>>
>> On 4/18/19 6:04 AM, Hongbo Zhang wrote:
>>> Following the previous patch, this patch adds peripheral devices to t=
he
>>> newly introduced SBSA-ref machine.
>>>
>>> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
>>> ---
>>>  hw/arm/sbsa-ref.c | 451 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  1 file changed, 451 insertions(+)
>>>
>>> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
[...]
>>> +static void create_one_flash(const char *name, hwaddr flashbase,
>>> +                             hwaddr flashsize, const char *file,
>>> +                             MemoryRegion *sysmem)
>>> +{
>>> +    /*
>>> +     * Create and map a single flash device. We use the same
>>> +     * parameters as the flash devices on the Versatile Express boar=
d.
>>> +     */
>>> +    DriveInfo *dinfo =3D drive_get_next(IF_PFLASH);
>>> +    DeviceState *dev =3D qdev_create(NULL, "cfi.pflash01");
>>
>> Please use TYPE_PFLASH_CFI01 instead of "cfi.pflash01".
>>
>> I wanted to ask "does it has to be CFI01?" because this device model i=
s
>> in bad shape, but I guess I answered myself looking at the EDK2 platfo=
rm
>> code:
>>
>> - P30_CFI_ADDR_VENDOR_ID is not used
>> - NorFlashDxe::NorFlashReadCfiData() is not implemented
>> - All commands in NorFlashDxe uses:
>>     SEND_NOR_COMMAND(..., P30_CMD_...)
>>   which are specific to the Intel P30 Nor flash family (CFI01).
>>
>>> +    SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>>> +    const uint64_t sectorlength =3D 256 * 1024;
>>> +
>>> +    if (dinfo) {
>>> +        qdev_prop_set_drive(dev, "drive", blk_by_legacy_dinfo(dinfo)=
,
>>> +                            &error_abort);
>>> +    }
>>> +
>>> +    qdev_prop_set_uint32(dev, "num-blocks", flashsize / sectorlength=
);
>>> +    qdev_prop_set_uint64(dev, "sector-length", sectorlength);
>>> +    qdev_prop_set_uint8(dev, "width", 4);
>>> +    qdev_prop_set_uint8(dev, "device-width", 2);
>>> +    qdev_prop_set_bit(dev, "big-endian", false);
>>> +    qdev_prop_set_uint16(dev, "id0", 0x89);
>>> +    qdev_prop_set_uint16(dev, "id1", 0x18);
>>> +    qdev_prop_set_uint16(dev, "id2", 0x00);
>>> +    qdev_prop_set_uint16(dev, "id3", 0x00);
>>> +    qdev_prop_set_string(dev, "name", name);
>>> +    qdev_init_nofail(dev);
>>> +
>>> +    memory_region_add_subregion(sysmem, flashbase,
>>> +                                sysbus_mmio_get_region(SYS_BUS_DEVIC=
E(dev), 0));
>>> +
>>> +    if (file) {
>>> +        char *fn;
>>> +        int image_size;
>>> +
>>> +        if (drive_get(IF_PFLASH, 0, 0)) {
>>> +            error_report("The contents of the first flash device may=
 be "
>>> +                         "specified with -bios or with -drive if=3Dp=
flash... "
>>> +                         "but you cannot use both options at once");=

>>> +            exit(1);
>>> +        }
>>> +        fn =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, file);
>>> +        if (!fn) {
>>> +            error_report("Could not find ROM image '%s'", file);
>>> +            exit(1);
>>> +        }
>>> +        image_size =3D load_image_mr(fn, sysbus_mmio_get_region(sbd,=
 0));
>>> +        g_free(fn);
>>> +        if (image_size < 0) {
>>> +            error_report("Could not load ROM image '%s'", file);
>>> +            exit(1);
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +static void create_flash(const SBSAMachineState *vms,
>>> +                         MemoryRegion *sysmem,
>>> +                         MemoryRegion *secure_sysmem)
>>> +{
>>> +    /*
>>> +     * Create one secure and nonsecure flash devices to fill SBSA_FL=
ASH
>>> +     * space in the memmap, file passed via -bios goes in the first =
one.
>>> +     */
>>> +    hwaddr flashsize =3D vms->memmap[SBSA_FLASH].size / 2;
>>> +    hwaddr flashbase =3D vms->memmap[SBSA_FLASH].base;
>>> +
>>> +    create_one_flash("sbsa-ref.flash0", flashbase, flashsize,
>>> +                     bios_name, secure_sysmem);
>>> +    create_one_flash("sbsa-ref.flash1", flashbase + flashsize, flash=
size,
>>> +                     NULL, sysmem);
>>
>> static const MemMapEntry base_memmap[] =3D {
>>     /* Space up to 0x8000000 is reserved for a boot ROM */
>>     [VIRT_FLASH] =3D              {          0, 0x08000000 },
>>
> Hi Philippe,
> Thank you for the long comments.
> Some parts of this machine are based on the 'virt' machine, but I use
> this flash memory map:
> [SBSA_FLASH] =3D              {          0, 0x20000000 },
> that are 256M *2 flashes.
> Franky I didn't consider the product part number etc, just use the
> original design in 'virt' and change the size large enough as I think.

I guess we are very lucky... The Micron PC28F00BP33EF is a 2Gib
symmetrical blocks NOR flash, and the only CFI01 one I could find a
datasheet :)

"The 2Gb device employs a virtual chip enable feature, which combines
two 1Gb die with a common chip enable".

> Peter, Ard, do we need more considerations here?
>=20
>> So you are creating 2 identical flashes of 128MiB/2 =3D 64 MiB each wh=
ich
>> are the biggest flash you can have:
>>
>> "The P30 family provides density upgrades from 64-Mbit through
>> 512-Mbit." On Intel, the 512-Mib case is particular in that it is buil=
t
>> of 2x 256-Mib on the same die, with a virtual chip enable. It is simpl=
er
>> to use a Micron or Numonyx model.
>>
>> I plan to use a whitelist of supported (and tested...) models, the one=

>> you use seems the Micron JS28F512P30EF ('E' for 'Symetrically Blocked'=
,
>> since the current model doesn't support bottom/top blocks layout), or =
in
>> short: 28F512P30E.
>> Ard, is that OK?
>>
>> Checking EDK2 git history, the driver is part of ArmPlatformPkg,
>> imported in commit 1d5d0ae92d9541, based on 'Versatile Express'.
>>
>> On the Versatile Express and the RealView Emulation Baseboard user
>> guides, I only find reference of "64MB of NOR flash" with no specific =
model.
>>
>> Peter, do you have physical access to tell me what flashes are used on=

>> real hardware? I googled for Linux console boot log but the kernel
>> doesn't seem to care about detecting/mapping the flash.
>>
>> QEMU added the flash to the Versatile board in commit 964c695a54ceda3a=
,
>> with the following description:
>>
>>     - add support for the 64MB NOR CFI01 flash available at
>>     0x34000000 on the versatilepb board
>>
>> http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.dui0225d=
/BBAJIHEC.html
>>
>> However on this link I only see "SSMC Chip Select 1, normally NOR flas=
h
>> (During boot remapping, this can be NOR flash, Disk-on-Chip, or static=

>> expansion memory)". Again, nothing specific (which makes sense, why
>> restrict the users to a particuliar family, as long as the pinout matc=
hes).
>>
>> The Manufacturer/Device ID used in QEMU (0x0089, 0x0018) correspond to=

>> the Micron 28F128J3D (128-Mbit, 128 symmetrical blocks of 128-KiB).
>> Neither the flash size (64 vs 16) nor the block size (256 vs 128) matc=
h.
>>
>> The safer fix here is to find a CFI01 flash of 256 sectors of 256-KiB
>> and update the Manufacturer/Device IDs in QEMU. Luckily this matches t=
he
>> 28F512P30E cited previously :)
>>
>> Regards,
>>
>> Phil.
[...]


--YnHE07YsvbE1QDnKfpcfe2ray0FttL2Qv--

--EDq9rOkvOFd8EAoX2g4c2SDBGNXWjgbcG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0HdK8ACgkQoqP9bt6t
wN6pORAAvyFYZ0T9Wa5iR7CJdabdpg3g+TVkRhX2GVnPcdn/jCUmEhK46QDG/dDj
48OIBGih/VnRtpvpWRg4UN0rsaVB9r9cOz6RacdNIRZCK5Y8I4o8Joh5qsBleAx7
K8QY+it/VX/bpTERqy9HM5h5jdL2cepxLclDjB1HESBVtm3QjksM8pNgi/1av826
L/nfBu9AFteZBWDyzqkKnPD7Li7BCjT3ItTzoXbjbfZFONxkA3H4kgl98nGKBkjo
+HX6ZDytDSG7h2J7CIZBQ91x7jo/pZP8BO3GGRswz12b5Ne91fG4chOPgH96XpjX
sMvqrZJy63qufT9QcI4dTkuTs6e5v76DkZWcKadbN2eIYyeLrAdzkWTqOIpsYFmR
vJPi1eMhUs/O6K7MASzbn0ALydXSTfwI4nY2sgMUy96PGZ842cqCaHmhQD1ZBhH/
Dfs7ojYdMC5DpNqdLJiUfFyImB4vzMjLp3NGBzQss1/I61u7dyNKdClcEbfwXvZT
ObfYroEV+DT7cpWRUrmE0W+0+sKL5gbRuKaxCZteIxFw8h209cyErYAywhX93AIq
BHq89NT42KAOkKGsbTnYUX3ggLdIHZeJ1MhCvDwkhD2DVa9rBYS429bxd+c6ocGb
554fzkzCygJl27qR/Czz/RhTmvC9OJBlLxAAWL+C/58E9Mvqtq8=
=ULjZ
-----END PGP SIGNATURE-----

--EDq9rOkvOFd8EAoX2g4c2SDBGNXWjgbcG--

