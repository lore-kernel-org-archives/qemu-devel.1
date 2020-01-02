Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED89C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:47:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5F8215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 14:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="btEH6FDa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5F8215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in1ka-00022O-C4
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 09:47:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41781)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1in1jd-0001SE-UA
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:46:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1in1jc-0003sO-MW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:46:01 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26062
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1in1jc-0003rs-J5
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 09:46:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577976359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yls47jQK8SpQOvybOv9drIVcdElwSa1+Bi5RpxnZXAs=;
 b=btEH6FDaLFwBi1dZOGnOh5jOXNSvgraocK/LvvLf6Z/kF8rpBGczsKK+FFBaHqStDkYSWa
 nCFmoEkH99wRDWkYyo3f50j0PA0CbHLFD9ZzJf4k/jx3FQ8QVeo+VWUid6OxNHZ6P7O973
 lxubrFjBoIy2uLnu7T34F+umKYWgMSw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-351-I60EGi04Oe2JiIcJp9eXfw-1; Thu, 02 Jan 2020 09:45:58 -0500
Received: by mail-wm1-f72.google.com with SMTP id h130so820544wme.7
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 06:45:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mA7dgI6yltfpBR/sYgtBdnSobk2/vz2JLBcyQqsoHVQ=;
 b=GSnmF3pfjpVeeIih1q13XdyQq4RfvQ6HwnDjg+zYEPCg/K1FaNI3igYnI+gi9/QJQA
 3/Hnr05PYmgrRo6m4ZaTGJofLuOdGZ8+tzClDvuvx8o1hnIstcI5K/jPVV5Ec7uPP5Nr
 luwnqa7ATTyTyaiR8CsVlhOBkansavKte8ZiTo2GrLxm6BqIPIvLNSVDUjCDRIwG+UFk
 OeXFXawdVdiK7pUBX0Z8CfUXRdTx8iz6lp+EujVQeFQJ8+5ua2BiEHrA0doEcg9nUvpz
 qlJTOW+lM5gtMekFyLgSAJOqOSUSZeJzVbNzgDPGWLNz6fBTEEI96Spc2Q0zmqZyGM97
 a+EA==
X-Gm-Message-State: APjAAAWM6ilzHeJiCvOMQOyfWqDyi3oziOB5WoHaycmP5dEzL/tJCCif
 Im07Jrs8UCJ0l47QS7yl4SjC09OrMxa5EhjnXxrL6DXx26G9QAQ9v3VayvAeBc/GeUUBoNPQwGk
 Jd5FWUT3FA7+/PM0=
X-Received: by 2002:adf:fd87:: with SMTP id d7mr82779090wrr.226.1577976357035; 
 Thu, 02 Jan 2020 06:45:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqydjN9uFWjDzY/dmO7+ji9YB8BWY8sTT0c/9P6bIlOD0xLW+PVho5gtcH8vFywrmsEMJnkQaw==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr82779080wrr.226.1577976356795; 
 Thu, 02 Jan 2020 06:45:56 -0800 (PST)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id g23sm8688291wmk.14.2020.01.02.06.45.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2020 06:45:56 -0800 (PST)
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
To: Igor Mammedov <imammedo@redhat.com>, Helge Deller <deller@gmx.de>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <20200102154158.460b2da6@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2953de56-4544-1727-3454-18dc1c19821b@redhat.com>
Date: Thu, 2 Jan 2020 15:45:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200102154158.460b2da6@redhat.com>
Content-Language: en-US
X-MC-Unique: I60EGi04Oe2JiIcJp9eXfw-1
X-Mimecast-Spam-Score: 0
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/2/20 3:41 PM, Igor Mammedov wrote:
> On Thu, 2 Jan 2020 12:31:58 +0100
> Helge Deller <deller@gmx.de> wrote:
>=20
>> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote:
>>> On 12/31/19 2:03 PM, Igor Mammedov wrote:
>>>> If user provided non-sense RAM size, board will complain and
>>>> continue running with max RAM size supported.
>>>> Also RAM is going to be allocated by generic code, so it won't be
>>>> possible for board to fix things up for user.
>>>>
>>>> Make it error message and exit to force user fix CLI,
>>>> instead of accepting non-sense CLI values.
>>>>
>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>>>> ---
>>>>  =C2=A0 hw/hppa/machine.c | 3 ++-
>>>>  =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
>>>> index 5d0de26..25f5afc 100644
>>>> --- a/hw/hppa/machine.c
>>>> +++ b/hw/hppa/machine.c
>>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *machine)
>>>>  =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory. */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_START) {
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =3D ram_=
size =3D FIRMWARE_START;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM size mor=
e than %d is not supported", FIRMWARE_START);
>>>> +        exit(EXIT_FAILURE);
>>>
>>> $ qemu-system-hppa -m 3841m
>>> qemu-system-hppa: invalid accelerator kvm
>>> qemu-system-hppa: falling back to tcg
>>> qemu-system-hppa: RAM size more than -268435456 is not supported
>>>
>>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned format,=
 we can simply use "RAM size more than 3840m is not supported". Is that OK =
with you?
>>
>> I don't really like that change.
>>
>> We currently only emulate a 32-bit system, and for those 4GB is the maxi=
mum.
>> So, if I start my machine with "qemu-system-hppa -m 4G", the current cod=
e
>> then automatically uses the maximum possible of 3841MB (which is limited=
 by
>> firmware start address).
>> I don't expect users to know the excact 3841MB number.
> It's annoying to see a error where it used to work before
> with no matter what -m value user have used.
>=20
> But error message tells exact max size one could use,
> so user doesn't have to know max, just fix CLI with provided value.
>=20
>> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3GB or 4=
GB,
>> but not "3841MB".
>>
>> So, I think that patch is - although it's more correct - not a
>> benefit for the end user.
> Sure thing that users dislike when we do breaking changes (removing legac=
y CLI
> options, fixups or adding error checks that weren't there before).
> But I'd choose correctness (and consistent codebase) vs convenience.
> (it's no like we are hiding max from user)

Going from 3841MB to 4GB is not a breaking change, and 4GB is correct I=20
think. The Raspberry Pi machines do the same (allocate more RAM than the=20
CPU is able to access, and DMA is able to use this extra RAM).


