Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882B2C35242
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D186214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 15:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hUIYM/6d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D186214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j059Z-0002W2-71
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 10:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j04yX-0003ux-J0
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:51:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j04yU-0007zJ-5Q
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:51:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:38853
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j04yU-0007yq-0Y
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:51:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581087077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Etu+e6wnyQadgfiGxFspn3QHheGkw+su2bPnv99yeeg=;
 b=hUIYM/6dVfaZrZ709Q0enuSuClGEiWATdu9popGfn1J2LQcYu7uqpqhsfE99E/MFgd725I
 iioojskbhA2Vnh7oXo0ZHVR8IE4FdRhByw90xPkJ2bQ368B4JUEMsvx95aQLuhi90baboj
 +LsbKjL8UUKLlyO1c66skWM84qZS5Kk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-ytDSBm_iOU2Ko0vvZmxCtg-1; Fri, 07 Feb 2020 09:51:01 -0500
Received: by mail-wr1-f70.google.com with SMTP id d8so1346552wrq.12
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:51:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F0bDqJaWXN6Pb+0pVpT7tYDPcHahpbtor1ZQURosJAk=;
 b=gwdyHa0OvOSlDbJaXnvMU1Z/yZNk5cPJb3duTyafVsgSDbTL+r4+N06S4laVC7BOYT
 z588kiiCBsuy6r9jaSPr2h1AqY1cgx1PmfnDU9YWEhiDLkxOVkrjEW4pC69dNMCRRCWB
 q+vttSJch3DRB3zi7bA7RjAnMJdgra+ZuhcxmhPIqAg90NbZNxGuerGnm5ARUGKoyjMt
 fFRVZAXZcWrNXyN+6CyJfOd0Xhr0GSlGdD9KurmkhpTCS1S7f3cqcMAW2t0QFfDCdPtT
 BumVbUDonJYdzEKx3MktAL9Rd5CIECMMC6mc/nFniCuGd9Fqxtp7T7k1eT0RmFy+D7hC
 5u7g==
X-Gm-Message-State: APjAAAUqN++l+45yIR8lKpBhTsaXgAXAcfqSLtt6GtuUnbMTOBtU8TdR
 tjpY/OGycn5Hawaoid4MejeJ/dlreF0EIaH04Fnq+kc0yTSugfmM14ehzrgFatSOXNUdAiq6ett
 1n+3FRzpNgjl+KRc=
X-Received: by 2002:adf:e70d:: with SMTP id c13mr5034763wrm.248.1581087060045; 
 Fri, 07 Feb 2020 06:51:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqzhe7RSB3g7npSRMH2PEbzT9KvSwPPbfF5z70Nrmv/IgqgugxsZzVCtXCfL1k2SSADxGWpOIA==
X-Received: by 2002:adf:e70d:: with SMTP id c13mr5034751wrm.248.1581087059781; 
 Fri, 07 Feb 2020 06:50:59 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id a198sm3624735wme.12.2020.02.07.06.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Feb 2020 06:50:59 -0800 (PST)
Subject: Re: [PATCH v2 01/30] hw/arm/raspi: Use BCM2708 machine type with pre
 Device Tree kernels
To: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200206011756.2413-1-f4bug@amsat.org>
 <20200206011756.2413-2-f4bug@amsat.org>
 <alpine.BSF.2.22.395.2002061320310.71431@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <27d1f0e2-941c-11ca-d736-f25af055d9da@redhat.com>
Date: Fri, 7 Feb 2020 15:50:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.22.395.2002061320310.71431@zero.eik.bme.hu>
Content-Language: en-US
X-MC-Unique: ytDSBm_iOU2Ko0vvZmxCtg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Zoltan,

On 2/6/20 1:21 PM, BALATON Zoltan wrote:
> On Thu, 6 Feb 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>> When booting without device tree, the Linux kernels uses the $R1
>> register to determine the machine type. The list of values is
>> registered at [1].
>>
>> There are two entries for the Raspberry Pi:
>>
>> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D3138
>> =C2=A0name: MACH_TYPE_BCM2708
>> =C2=A0value: 0xc42 (3138)
>> =C2=A0status: Active, not mainlined
>> =C2=A0date: 15 Oct 2010
>>
>> - https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D4828
>> =C2=A0name: MACH_TYPE_BCM2835
>> =C2=A0value: 4828
>> =C2=A0status: Active, mainlined
>> =C2=A0date: 6 Dec 2013
>>
>> QEMU always used the non-mainlined type MACH_TYPE_BCM2708.
>> The value 0xc43 is registered to 'MX51_GGC' (processor i.MX51), and
>> 0xc44 to 'Western Digital Sharespace NAS' (processor Marvell 88F5182).
>>
>> The Raspberry Pi foundation bootloader only sets the BCM2708 machine
>> type, see [2] or [3]:
>>
>> 133 9:
>> 134=C2=A0=C2=A0=C2=A0=C2=A0 mov r0, #0
>> 135=C2=A0=C2=A0=C2=A0=C2=A0 ldr r1, =3D3138=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 @ BCM2708 machine id
>> 136=C2=A0=C2=A0=C2=A0=C2=A0 ldr r2, atags=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 @ ATAGS
>> 137=C2=A0=C2=A0=C2=A0=C2=A0 bx=C2=A0 r4
>>
>> U-Boot only uses MACH_TYPE_BCM2708 (see [4]):
>>
>> 25 /*
>> 26=C2=A0 * 2835 is a SKU in a series for which the 2708 is the first or=
=20
>> primary SoC,
>> 27=C2=A0 * so 2708 has historically been used rather than a dedicated 28=
35 ID.
>> 28=C2=A0 *
>> 29=C2=A0 * We don't define a machine type for bcm2709/bcm2836 since the =
RPi=20
>> Foundation
>> 30=C2=A0 * chose to use someone else's previously registered machine ID=
=20
>> (3139, MX51_GGC)
>> 31=C2=A0 * rather than obtaining a valid ID:-/
>> 32=C2=A0 *
>> 33=C2=A0 * For the bcm2837, hopefully a machine type is not needed, sinc=
e=20
>> everything
>> 34=C2=A0 * is DT.
>> 35=C2=A0 */
>>
>> While the definition MACH_BCM2709 with value 0xc43 was introduced in
>> a commit described "Add 2709 platform for Raspberry Pi 2" out of the
>> mainline Linux kernel, it does not seem used, and the platform is
>> introduced with Device Tree support anyway (see [5] and [6]).
>>
>> Remove the unused values (0xc43 introduced in commit 1df7d1f9303aef
>> "raspi: add raspberry pi 2 machine" and 0xc44 in commit bade58166f4
>> "raspi: Raspberry Pi 3 support"), keeping only MACH_TYPE_BCM2708.
>>
>> [1] https://www.arm.linux.org.uk/developer/machines/
>> [2]=20
>> https://github.com/raspberrypi/tools/blob/920c7ed2e/armstubs/armstub7.S#=
L135=20
>>
>> [3]=20
>> https://github.com/raspberrypi/tools/blob/49719d554/armstubs/armstub7.S#=
L64=20
>>
>> [4]=20
>> https://gitlab.denx.de/u-boot/u-boot/blob/v2015.04/include/configs/rpi-c=
ommon.h#L18=20
>>
>> [5]=20
>> https://github.com/raspberrypi/linux/commit/d9fac63adac#diff-6722037d795=
70df5b392a49e0e006573R526=20
>>
>> [6]=20
>> http://lists.infradead.org/pipermail/linux-rpi-kernel/2015-February/0012=
68.html=20
>>
>>
>> Cc: Zolt=C3=A1n Baldaszti <bztemail@gmail.com>
>> Cc: Pekka Enberg <penberg@iki.fi>
>> Cc: Stephen Warren <swarren@nvidia.com>
>> Cc: Kshitij Soni <kshitij.soni@broadcom.com>
>> Cc: Michael Chan <michael.chan@broadcom.com>
>> Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> hw/arm/raspi.c | 5 ++---
>> 1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
>> index 3996f6c63a..ef76a27f33 100644
>> --- a/hw/arm/raspi.c
>> +++ b/hw/arm/raspi.c
>> @@ -29,8 +29,7 @@
>> #define FIRMWARE_ADDR_3 0x80000 /* Pi 3 loads kernel.img here by=20
>> default */
>> #define SPINTABLE_ADDR=C2=A0 0xd8 /* Pi 3 bootloader spintable */
>>
>> -/* Table of Linux board IDs for different Pi versions */
>> -static const int raspi_boardid[] =3D {[1] =3D 0xc42, [2] =3D 0xc43, [3]=
 =3D=20
>> 0xc44};
>=20
> Maybe worth a comment about why using this number (short, one line=20
> version of commit message).

You mean something like:

/* Registered machine type:
  * https://www.arm.linux.org.uk/developer/machines/list.php?mid=3D3138
  */

>=20
> Regards,
> BALATON Zoltan
>=20
>> +#define MACH_TYPE_BCM2708=C2=A0=C2=A0 3138 /* Linux board IDs */
>>
>> typedef struct RasPiState {
>> =C2=A0=C2=A0=C2=A0 BCM283XState soc;
>> @@ -116,7 +115,7 @@ static void setup_boot(MachineState *machine, int=20
>> version, size_t ram_size)
>> =C2=A0=C2=A0=C2=A0 static struct arm_boot_info binfo;
>> =C2=A0=C2=A0=C2=A0 int r;
>>
>> -=C2=A0=C2=A0=C2=A0 binfo.board_id =3D raspi_boardid[version];
>> +=C2=A0=C2=A0=C2=A0 binfo.board_id =3D MACH_TYPE_BCM2708;
>> =C2=A0=C2=A0=C2=A0 binfo.ram_size =3D ram_size;
>> =C2=A0=C2=A0=C2=A0 binfo.nb_cpus =3D machine->smp.cpus;
>>
>>


