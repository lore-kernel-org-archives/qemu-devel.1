Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE2B6C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936A22465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 22:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936A22465A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irqi9-0006I9-Di
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 17:00:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59676)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1irqhJ-0005EU-8U
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:59:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1irqhH-0000TB-JV
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:59:32 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:51512)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1irqhH-0000R7-Dv
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 16:59:31 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4785D7475F9;
 Wed, 15 Jan 2020 22:59:28 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 237DB74594E; Wed, 15 Jan 2020 22:59:28 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 223447456F8;
 Wed, 15 Jan 2020 22:59:28 +0100 (CET)
Date: Wed, 15 Jan 2020 22:59:28 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2 41/86] hw/hppa/machine: Correctly check the firmware
 is in PDC range
In-Reply-To: <caded923-2daa-9ec2-8129-fb76a744042f@redhat.com>
Message-ID: <alpine.BSF.2.21.99999.352.2001152238430.24151@zero.eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-42-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001151914440.24151@zero.eik.bme.hu>
 <caded923-2daa-9ec2-8129-fb76a744042f@redhat.com>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-823118792-1579125568=:24151"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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
Cc: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-823118792-1579125568=:24151
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Jan 2020, Philippe Mathieu-Daud=C3=A9 wrote:
> On 1/15/20 7:15 PM, BALATON Zoltan wrote:
>> On Wed, 15 Jan 2020, Igor Mammedov wrote:
>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>=20
>>> The firmware has to reside in the PDC range. If the Elf file
>>> expects to load it below FIRMWARE_START, it is incorrect,
>>> regardless the RAM size.
>>>=20
>>> Acked-by: Helge Deller <deller@gmx.de>
>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>> ---
>>> hw/hppa/machine.c | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>=20
>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>> index 5d0de26..6775d87 100644
>>> --- a/hw/hppa/machine.c
>>> +++ b/hw/hppa/machine.c
>>> @@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState *machi=
ne)
>>> =C2=A0=C2=A0=C2=A0 qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x=
%08" PRIx64
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-0x%08" PRIx64 ", entry at 0x%08" PRIx=
64 ".\n",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware_low, firmware_high, firmware_e=
ntry);
>>> -=C2=A0=C2=A0=C2=A0 if (firmware_low < ram_size || firmware_high >=3D=
 FIRMWARE_END) {
>>> +=C2=A0=C2=A0=C2=A0 if (firmware_low < FIRMWARE_START || firmware_hig=
h >=3D FIRMWARE_END) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Firmware ove=
rlaps with memory or IO space");
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>=20
>> Should this also be EXIT_FAILURE like in other places when you're chan=
ging=20
>> the line nearby?
>
> I didn't changed this line, this seems unrelated to the patch purpose.

Fair enough. Just thought because there was patch 85/86 making that chang=
e=20
to keep consistency. Maybe you can change this in that patch but I don't=20
really mind just spotted it.

Regards,
BALATON Zoltan
--3866299591-823118792-1579125568=:24151--

