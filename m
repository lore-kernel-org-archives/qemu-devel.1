Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16080C33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:15:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4A9B20730
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 15:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IYnJWxxO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4A9B20730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is6sB-00029J-0x
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 10:15:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60033)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1is6rG-00012F-Dj
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:14:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1is6rF-0002Gf-8T
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:14:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27988
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1is6rF-0002G1-4e
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 10:14:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579187691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=beXdIu21cRXbl4yPGrala8yO8Oe9tEAnP5u6uqNcFcI=;
 b=IYnJWxxOr3Gk84aSRZJDxVY8UC5QEFKK4IZQPlnrQDwTVxWgxTP/Mt/1XN3rFy5m4lYWhF
 oZfP2RcOuUHg3rLo+6bCLafnAh7lLy6SX8deHB+1buGsF0weDIauPyJZbLuOmKCxubwRcf
 fmaOQtR3LsrjcJYymN0k1dJy4fJZrAA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-4A9n3Fn7PiWLxgrfzTli2g-1; Thu, 16 Jan 2020 10:14:49 -0500
Received: by mail-wr1-f72.google.com with SMTP id w6so9307970wrm.16
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 07:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d7ecfqEHWDwfHQwxmYKbI6S9S5hVdzYYMiYdWDRpwZk=;
 b=fAdt4vL70gRjsLExlNXgA/aPL75UHuPYIDzyH5Jq5Tcsq3EMYDzyGUEPw36AgZwTLt
 oWCjYDgcp+Hd/Qr/IOW6p/JnzuUVcmUPl8h75onRZinK4Kjl/bcYKffWGw0qWL+Xuddy
 zRM5qMoYetUjd8TzIkh39REvx3NvPn15bZEKL8e9rqMKNTTSDm6qnpdrUN6WtISQteTZ
 CYtGLOvI/FZWUEoxrjywt8TsOqnWL0Lzf85wRLfCgiXtnMJH7VPjs5abi/M5/q4TIre4
 TlZspHE8vtjSLsux3R2xPwpHNpXOKT2oXlQep3cM3EnKEeytKPmUbxHua4UeorPgwFpi
 Ne7A==
X-Gm-Message-State: APjAAAWgJUJFplv1YXc8hcHadIZ91E72AbRdOrv03YYWwfntL1E/nVci
 SFgVa/de9ft3yXVMndbia5rlqC3eT2UFkpP3QmyAuZkAovUP2U2W/NxcvbAWtivaunvdBLqPxJm
 cuZMAEpqgg1ZH8nY=
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr3343302wme.59.1579187688099; 
 Thu, 16 Jan 2020 07:14:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxUJ/+/Nin7uLEYFTgLw5HaOYbANMeSbW1v+QFE/KqJmgc16QIYblM/JyE/Qb+AZjOhGV2viA==
X-Received: by 2002:a1c:9ac6:: with SMTP id c189mr3343285wme.59.1579187687903; 
 Thu, 16 Jan 2020 07:14:47 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id y139sm228119wmd.24.2020.01.16.07.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 07:14:47 -0800 (PST)
Subject: Re: [PATCH v2 41/86] hw/hppa/machine: Correctly check the firmware is
 in PDC range
To: BALATON Zoltan <balaton@eik.bme.hu>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
 <1579100861-73692-42-git-send-email-imammedo@redhat.com>
 <alpine.BSF.2.21.99999.352.2001151914440.24151@zero.eik.bme.hu>
 <caded923-2daa-9ec2-8129-fb76a744042f@redhat.com>
 <alpine.BSF.2.21.99999.352.2001152238430.24151@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0fb31eb7-9b65-4ec2-b200-b8ac9216edeb@redhat.com>
Date: Thu, 16 Jan 2020 16:14:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.99999.352.2001152238430.24151@zero.eik.bme.hu>
Content-Language: en-US
X-MC-Unique: 4A9n3Fn7PiWLxgrfzTli2g-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

On 1/15/20 10:59 PM, BALATON Zoltan wrote:
> On Wed, 15 Jan 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 1/15/20 7:15 PM, BALATON Zoltan wrote:
>>> On Wed, 15 Jan 2020, Igor Mammedov wrote:
>>>> From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>
>>>> The firmware has to reside in the PDC range. If the Elf file
>>>> expects to load it below FIRMWARE_START, it is incorrect,
>>>> regardless the RAM size.
>>>>
>>>> Acked-by: Helge Deller <deller@gmx.de>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>> hw/hppa/machine.c | 2 +-
>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>> index 5d0de26..6775d87 100644
>>>> --- a/hw/hppa/machine.c
>>>> +++ b/hw/hppa/machine.c
>>>> @@ -155,7 +155,7 @@ static void machine_hppa_init(MachineState=20
>>>> *machine)
>>>> =C2=A0=C2=A0=C2=A0 qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%=
08" PRIx64
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-0x%08" PRIx64 ", entry at 0x%08" PRIx64=
 ".\n",
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 firmware_low, firmware_high, firmware_ent=
ry);
>>>> -=C2=A0=C2=A0=C2=A0 if (firmware_low < ram_size || firmware_high >=3D =
FIRMWARE_END) {
>>>> +=C2=A0=C2=A0=C2=A0 if (firmware_low < FIRMWARE_START || firmware_high=
 >=3D=20
>>>> FIRMWARE_END) {
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("Firmware over=
laps with memory or IO space");
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 exit(1);
>>>
>>> Should this also be EXIT_FAILURE like in other places when you're=20
>>> changing the line nearby?
>>
>> I didn't changed this line, this seems unrelated to the patch purpose.
>=20
> Fair enough. Just thought because there was patch 85/86 making that=20
> change to keep consistency. Maybe you can change this in that patch but=
=20
> I don't really mind just spotted it.

Ah this is because it is a patch of mine included in Igor series, and=20
Igor uses EXIT_FAILURE in his other patches, OK now it makes sense.

Maybe the EXIT_FAILURE can be done in a new series, calling 'sed' to=20
update the full repository.


