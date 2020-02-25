Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A75CC35DF5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:21:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB47221556
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DCZpdhDw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB47221556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6YHM-0002iN-3B
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6YGZ-0001xq-0q
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6YGX-0007Ao-1j
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:20:42 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6YGW-00078T-HH
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:20:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582629639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1LlKKdL4DaKWeVsmQPadwMBS4Z8kHikh7mfaA90+CJc=;
 b=DCZpdhDwa7dTqdqBF/pJfTw+xjJBA6Du3CYTetvh3u/DLxyIKd4cFkIwbNXbZNkI0BmKNH
 U1yF3UoMGxOp5r8tn3Bo6BtHUqbswlOCYRfaxZ+IRyCm3IB6r6OmgQohMyQjsGaN261BpI
 slZB09pfkox0s+YSSHpHzpD4KAPoXPI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-NnQkYodhMdGXwGrhGPmIGg-1; Tue, 25 Feb 2020 06:20:34 -0500
X-MC-Unique: NnQkYodhMdGXwGrhGPmIGg-1
Received: by mail-wr1-f69.google.com with SMTP id n23so7139837wra.20
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:20:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vvCfD7/rNLbdZdQItEDS2uieFhqDbYFswtqRvUcezs8=;
 b=mpLbM2/B9r1MmlIQ5IspiKpVhTcpbNVy88o49C2PdjFIOk0XfEYBwlz7xag6aPCSTP
 Hl+HXPhhbaiUQ+76RSagNTeTKTOoQPFMEcHskYp+qSO3nkxvAFaIVjnYu+nnkIQxM3mY
 porH5dYHRyvPTcAODfDZNOs5Dw/QThV84XxQfe2F17DU5kZIleHAlzDDnqIieo5PNKC4
 jRZl3pi++GePTO3pxPSHP699gSiZMyVQrsmIl5davVMQx/O/qrYsA/J64B9tlM03qH2J
 k8A0Io3Z0waXOBmvXMEFPq50HJIB0ZLu/HDtMP9x3ESaRjn1mM8CU2IWzazXK64O5gZC
 B7ww==
X-Gm-Message-State: APjAAAUwuOwMV+QTwjA5piDx1dYZWGMdI1HTQZuxYvFr0zOLEu+ov06O
 wfkpL6TE/wmu851bpS3RJel+u+KhZCeP1XQyjnqRLJ1EkBRVaYnzDq9KFJE/R8fxNzfX9mJfaMP
 1nU6zPRgMViZ2p5U=
X-Received: by 2002:a5d:514b:: with SMTP id u11mr72026908wrt.322.1582629633354; 
 Tue, 25 Feb 2020 03:20:33 -0800 (PST)
X-Google-Smtp-Source: APXvYqy2W6aGoNtSV6nnZeAHGWDrDD0iU4TeJXDpKsJBuGhP39N9z3y6xfvHeIwr7Az73oRRWhLLpQ==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr72026882wrt.322.1582629633073; 
 Tue, 25 Feb 2020 03:20:33 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id y8sm3631022wma.10.2020.02.25.03.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:20:32 -0800 (PST)
Subject: Re: [PATCH 2/2] hw/arm/gumstix: Use the IEC binary prefix definitions
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200223231044.8003-1-philmd@redhat.com>
 <20200223231044.8003-3-philmd@redhat.com>
 <CAFEAcA8MSO4YMEq2FqvpJKUVYE_1CqaB2KLD1YN-YebOhJVgEg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <63b97fb9-02c9-2be4-73e7-19807a2d6aeb@redhat.com>
Date: Tue, 25 Feb 2020 12:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8MSO4YMEq2FqvpJKUVYE_1CqaB2KLD1YN-YebOhJVgEg@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 12:16 PM, Peter Maydell wrote:
> On Sun, 23 Feb 2020 at 23:10, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>
>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>> IEC binary prefixes ease code review: the unit is explicit.
>>
>> Add a comment describing the Connex uses a Numonyx RC28F128J3F75
>> flash, and the Verdex uses a Micron RC28F256P30TFA.
>>
>> Correct the Verdex machine description (we model the 'Pro' board).
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>=20
> This patch is doing somewhat more than the commit Subject line
> suggests. I don't think it's particularly strongly in need
> of splitting into more patches, but could you make the
> subject line a bit closer to what the patch is doing?
>=20
>> ---
>>   hw/arm/gumstix.c | 23 +++++++++--------------
>>   1 file changed, 9 insertions(+), 14 deletions(-)
>>
>> diff --git a/hw/arm/gumstix.c b/hw/arm/gumstix.c
>> index 94904d717b..ca918fda0c 100644
>> --- a/hw/arm/gumstix.c
>> +++ b/hw/arm/gumstix.c
>> @@ -35,6 +35,7 @@
>>    */
>>
>>   #include "qemu/osdep.h"
>> +#include "qemu/units.h"
>>   #include "qemu/error-report.h"
>>   #include "hw/arm/pxa.h"
>>   #include "net/net.h"
>> @@ -45,18 +46,14 @@
>>   #include "sysemu/qtest.h"
>>   #include "cpu.h"
>>
>> -static const int sector_len =3D 128 * 1024;
>> +static const int sector_len =3D 128 * KiB;
>>
>>   static void connex_init(MachineState *machine)
>>   {
>>       PXA2xxState *cpu;
>>       DriveInfo *dinfo;
>> -    MemoryRegion *address_space_mem =3D get_system_memory();
>>
>> -    uint32_t connex_rom =3D 0x01000000;
>> -    uint32_t connex_ram =3D 0x04000000;
>> -
>> -    cpu =3D pxa255_init(address_space_mem, connex_ram);
>> +    cpu =3D pxa255_init(get_system_memory(), 64 * MiB);
>>
>>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>>       if (!dinfo && !qtest_enabled()) {
>> @@ -65,7 +62,8 @@ static void connex_init(MachineState *machine)
>>           exit(1);
>>       }
>>
>> -    if (!pflash_cfi01_register(0x00000000, "connext.rom", connex_rom,
>> +    /* Numonyx RC28F128J3F75 */
>> +    if (!pflash_cfi01_register(0x00000000, "connext.rom", 16 * MiB,
>>                                  dinfo ? blk_by_legacy_dinfo(dinfo) : NU=
LL,
>>                                  sector_len, 2, 0, 0, 0, 0, 0)) {
>>           error_report("Error registering flash memory");
>=20
> Previously the variable names were helpfully acting as a
> bit of documentation of what the 64MB and 16MB things were.
> Perhaps we could instead have
>=20
> #define CONNEX_ROM_SIZE (16 * MiB)
> #define CONNEX_RAM_SIZE (64 * MiB)
>=20
> and then use those?

OK.

FYI long term plan for the pflash API is to use a white-list of tested=20
flash models, and restrict models when boards have flash soldered.

>=20
>> @@ -81,12 +79,8 @@ static void verdex_init(MachineState *machine)
>>   {
>>       PXA2xxState *cpu;
>>       DriveInfo *dinfo;
>> -    MemoryRegion *address_space_mem =3D get_system_memory();
>>
>> -    uint32_t verdex_rom =3D 0x02000000;
>> -    uint32_t verdex_ram =3D 0x10000000;
>> -
>> -    cpu =3D pxa270_init(address_space_mem, verdex_ram, machine->cpu_typ=
e);
>> +    cpu =3D pxa270_init(get_system_memory(), 256 * MiB, machine->cpu_ty=
pe);
>>
>>       dinfo =3D drive_get(IF_PFLASH, 0, 0);
>>       if (!dinfo && !qtest_enabled()) {
>> @@ -95,7 +89,8 @@ static void verdex_init(MachineState *machine)
>>           exit(1);
>>       }
>>
>> -    if (!pflash_cfi01_register(0x00000000, "verdex.rom", verdex_rom,
>> +    /* Micron RC28F256P30TFA */
>> +    if (!pflash_cfi01_register(0x00000000, "verdex.rom", 32 * MiB,
>>                                  dinfo ? blk_by_legacy_dinfo(dinfo) : NU=
LL,
>>                                  sector_len, 2, 0, 0, 0, 0, 0)) {
>>           error_report("Error registering flash memory");
>=20
> Similarly here.
>=20
>> @@ -126,7 +121,7 @@ static void verdex_class_init(ObjectClass *oc, void =
*data)
>>   {
>>       MachineClass *mc =3D MACHINE_CLASS(oc);
>>
>> -    mc->desc =3D "Gumstix Verdex (PXA270)";
>> +    mc->desc =3D "Gumstix Verdex Pro XL6P COMs (PXA270)";
>>       mc->init =3D verdex_init;
>>       mc->ignore_memory_transaction_failures =3D true;
>>       mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("pxa270-c0");
>> --
>=20
> thanks
> -- PMM
>=20


