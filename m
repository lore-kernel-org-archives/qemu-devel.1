Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2E9FC35E01
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B280320658
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 14:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEHGxMJD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B280320658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6b5s-0006U8-VF
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 09:21:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j6atu-0007Di-4V
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:09:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j6ats-0006YX-Jw
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:09:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j6ats-0006Y5-FF
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 09:09:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582639767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mplXFz9XhI87VPN32Jx6WUqNvWODeZuWVw5OoOQxrjM=;
 b=ZEHGxMJDGHNJtCn1EXuyqgLLnNEn83M7OlfoVqMpkTr5XtTUPDw8uZyMxcqEWQsX0irs85
 NR8S5rI7iTtgogI0a+LGiXiqDUD/pWi27mpuGp0VGAzpx9M1NifyalAdb4cMng2jHLdkWO
 pNbpajrC2i4RcIYMHB8TS+GXBGbCS4c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-0p9DoK40MCOtL8S9DmDYtA-1; Tue, 25 Feb 2020 09:09:26 -0500
X-MC-Unique: 0p9DoK40MCOtL8S9DmDYtA-1
Received: by mail-wr1-f70.google.com with SMTP id o6so7340460wrp.8
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 06:09:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qEoTyBPH0U7wxGlqvxw7ToAiex8GCPJH26NUCkpeNTI=;
 b=XRKB4aydPgisNEYwnky/T244fVyvXOPUGi7xqphRSvGQ2JUTzsKYqNZiSJbyLqKLDw
 /FbfY2AiD/TFXDry4Rr/if/e+9x5l15wKHPF39GpwXdekSimiokSj3cCtLBi+zQVcHJm
 54DYI9yTQI4LQGzkLzgV9nRi50O2eZGtR2zosSiMzUa05F6HEva34ZZ7vwUlwDuTHRxZ
 mtHey1pLGPlFgkmJ/g9uR91AXsYPwuW49DBmNg3ARqLsepeyq7B/uFM/BgaP0QXcODOJ
 aP/zHB1f+sWSBi62JjdQd4gJAt2IN9QR9YyV5GjYeKNbGZIYSoCh8UjHn6KhRNlFrK60
 tM1g==
X-Gm-Message-State: APjAAAVadVhFLRaLBMq+p7Z5LHRnPGfT9MJl3XduSGGv3EJX0dRwHpJr
 6Tu/Yefi4HouERzVZd/KLkaRii5aF/wLAgn6g1Tnj+HOEG19yFdXLz1m2zXo1nkmDvOFT5bIwCm
 aw8EmTos39MvoOfw=
X-Received: by 2002:a1c:610a:: with SMTP id v10mr5365092wmb.44.1582639764586; 
 Tue, 25 Feb 2020 06:09:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBHkzZErZKgDXtaRKRb3JGQsfuBu03CkA/FyxPWaI0rF/tdd2ERpgquWloOH3fmK2oebJk3A==
X-Received: by 2002:a1c:610a:: with SMTP id v10mr5365071wmb.44.1582639764355; 
 Tue, 25 Feb 2020 06:09:24 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id 25sm4358911wmi.32.2020.02.25.06.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2020 06:09:23 -0800 (PST)
Subject: Re: [RFC PATCH v2 2/2] hw/arm/integratorcp: Map a CFI parallel flash
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200223233033.15371-1-f4bug@amsat.org>
 <20200223233033.15371-3-f4bug@amsat.org>
 <CAFEAcA9bZJ9X20SX-5J2M6rWEhNC=un3Re3RVhGGHD1qMEdWtw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d8c64ad4-1c72-04fd-400a-ac003b3090cb@redhat.com>
Date: Tue, 25 Feb 2020 15:09:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9bZJ9X20SX-5J2M6rWEhNC=un3Re3RVhGGHD1qMEdWtw@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/25/20 1:47 PM, Peter Maydell wrote:
> On Sun, 23 Feb 2020 at 23:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
>>
>> The Linux kernel displays errors why trying to detect the flash:
>>
>>    Linux version 4.16.0 (linus@genomnajs) (gcc version 7.2.1 20171011 (L=
inaro GCC 7.2-2017.11)) #142 PREEMPT Wed May 9 13:24:55 CEST 2018
>>    CPU: ARM926EJ-S [41069265] revision 5 (ARMv5TEJ), cr=3D00093177
>>    CPU: VIVT data cache, VIVT instruction cache
>>    OF: fdt: Machine model: ARM Integrator/CP
>>    ...
>>    of-flash 24000000.flash: Integrator/CP flash protection
>>    of-flash 24000000.flash: do_map_probe() failed for type cfi_probe
>>    of-flash 24000000.flash: do_map_probe() failed
>>
>> Since we have a CFI pflash model available, wire it.
>> The kernel properly detects it:
>>
>>    of-flash 24000000.flash: Integrator/CP flash protection
>>    24000000.flash: Found 1 x32 devices at 0x0 in 32-bit bank. Manufactur=
er ID 0x000000 Chip ID 0x000000
>>    Intel/Sharp Extended Query Table at 0x0031
>>    Using buffer write method
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>> v2: Kconfig change was not committed
>>
>> RFC because I have no idea of the flash model, its ID code, and which
>> default CFI family (1 or 2).
>=20
> ARM DUI 0102G ("ARM Firmware Suite Reference Guide") helpfully has
> a few details:
>=20
> Device                                  Size  Organization     Flash part
> Integrator/AP Boot flash               512KB  1x512K block     Atmel AT49=
LV040
> Integrator/AP Application flash         32MB  256x128K blocks  Intel 28F3=
20S3
> Integrator/CP Boot/Application flash    16MB  64x256K blocks   Intel 28F6=
40J3A
>=20
> (of which we only model the CP.) With luck that's enough to
> nail down the relevant device properties.

"Intel 28F640J3A" is everything we need, thanks!

>=20
>> @@ -646,6 +649,14 @@ static void integratorcp_init(MachineState *machine=
)
>>                             qdev_get_gpio_in_named(icp, ICP_GPIO_MMC_CAR=
DIN, 0));
>>       sysbus_create_varargs("pl041", 0x1d000000, pic[25], NULL);
>>
>> +    dinfo =3D drive_get(IF_PFLASH, 0, 0);
>> +    if (!pflash_cfi01_register(0x24000000, "pflash", 16 * MiB,
>> +                               dinfo ? blk_by_legacy_dinfo(dinfo) : NUL=
L,
>> +                               64 * KiB, 4, 0, 0, 0, 0, 0)) {
>> +        error_report("Error registering flash memory");
>> +        exit(1);
>> +    }
>=20
> Passing a 'width' argument of 0 means "weird legacy backcompat
> device that's a bad emulation of a pair of 16-bit devices";
> we should avoid that for new code, and instead set
> the width and device-width properties to whatever the
> hardware has. (This in turn means you can't use the old
> pflash_cfi01_register() function.)

OK I'll try to document that.

> Should we be using blk_by_legacy_dinfo() in new code?
> I'm not sure if there's a better way to do this if we don't
> need to maintain back-compat with old commandline specifications
> of the flash contents.
>=20
> thanks
> -- PMM
>=20


