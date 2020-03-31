Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B24C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 20:08:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F7F20658
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 20:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWxNXJHl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F7F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJNBm-0001eF-6b
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 16:08:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jJNAn-0001E3-0e
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 16:07:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jJNAk-0003oE-5J
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 16:07:44 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:59297)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jJNAj-0003lf-S2
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 16:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585685260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T6wna8JGCrQl5yddINWYdosTxQ/MqNTUcqko/Is1kIk=;
 b=BWxNXJHlBvG890kN4tRQwNx+Q749YvIlxoqoDbpPmnY16jGVS1Exq14U2y9CNn3Qx+YROx
 Hxe0GA+V9wVvSNcIpTShvtS5FD5Q0RP8r/Z+R6fm6Z324+5RaPfhi6g8qRs6iqj2DnFvhl
 32BLL+3u5EGnIjd8maNhtFOYRwvQHLE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-orjXwjDxOh6Dwpc2L2ljUA-1; Tue, 31 Mar 2020 16:07:35 -0400
X-MC-Unique: orjXwjDxOh6Dwpc2L2ljUA-1
Received: by mail-ed1-f72.google.com with SMTP id c2so19359781edx.16
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 13:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9FCIhMCa4sllKyY+Z5ntxcWfOWuY/+p0ZXtEmjVXl9k=;
 b=fiGeVe8NpFzGxkVh+ZyvyT0LqSgpnxT47UFIB3EiaI0s2hIVPELFSaUd4DWQSuZ3wv
 EiAAWIymJLZUXLI8yLnbl9on5e9wAwySCrtX9lai4VAAXfxaiOEjXuwDLgAV6eERSXwO
 bDg6g3t9/JaNOSoMCW1e9uY0bYd+8jKdWq4MOQCTIRMq7DNVSTwu/NKXxw95wuVHfHon
 pgk773N+rxHesKojc/WuBc5fLa+9jBIdw2E2Ph8hc1MfCaIZHrhJ+8NJISO5MeQ63YvL
 4nck6yU7nmHfOyUmZMBHKAsH9Gl/eDOdWjsEiqIPAvFLWDXg2trNYLjYIwUBNp9wd268
 QlAA==
X-Gm-Message-State: ANhLgQ1PNR9rrWIfK9Iu97dvuexEdsawpgauKyby37+wkwr5BBTdEezJ
 FgqQ7FMBbbNn4REpQuj+aSKokSxM6ixif3jAk+ippPjK6vMjRuU5ilCvVvH2EUrtfZaCkBPY+Zw
 +aHh9kvxxDbvZ4A4=
X-Received: by 2002:a17:906:319a:: with SMTP id
 26mr16420756ejy.199.1585685254491; 
 Tue, 31 Mar 2020 13:07:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtqKdhDDNqxlr+rHRhNMjBEUSRPTcOIqNIUpig3HNIHMAepQPgfPY4EFTuP9G8gLUsYrqcX4w==
X-Received: by 2002:a17:906:319a:: with SMTP id
 26mr16420738ejy.199.1585685254200; 
 Tue, 31 Mar 2020 13:07:34 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id aq2sm2225189ejc.9.2020.03.31.13.07.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2020 13:07:33 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/7] tests/acceptance/machine_sparc_leon3: Disable
 HelenOS test
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200331105048.27989-1-f4bug@amsat.org>
 <20200331105048.27989-2-f4bug@amsat.org>
 <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e5384733-7812-1e05-fdf1-92c08c457c4f@redhat.com>
Date: Tue, 31 Mar 2020 22:07:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <3dd36ad8-53c1-7dd0-3934-88a2c14afd28@linaro.org>
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Willian Rampazzo <wrampazz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Jiri Gaisler <jiri@gaisler.se>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing Avocado team

On 3/31/20 6:18 PM, Richard Henderson wrote:
> On 3/31/20 3:50 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> This test was written/tested around beginning of 2019, but was
>> extracted from a bigger series and posted end of June 2019 [*].
>> Unfortunately I did not notice commit 162abf1a8 was merged by
>> then, which implements the AHB and APB plug and play devices.
>>
>> HelenOS 0.6 is expecting the PnP registers to be not implemented
>> by QEMU, then forces the discovered AMBA devices (see [2]).
>>
>> Before 162abf1a8, the console was displaying:
>>
>>    HelenOS bootloader, release 0.6.0 (Elastic Horse)
>>    Built on 2014-12-21 20:17:42 for sparc32
>>    Copyright (c) 2001-2014 HelenOS project
>>     0x4000bf20|0x4000bf20: kernel image (496640/128466 bytes)
>>     0x4002b4f2|0x4002b4f2: ns image (154195/66444 bytes)
>>     0x4003b87e|0x4003b87e: loader image (153182/66437 bytes)
>>     0x4004bc03|0x4004bc03: init image (155339/66834 bytes)
>>     0x4005c115|0x4005c115: locsrv image (162063/70267 bytes)
>>     0x4006d390|0x4006d390: rd image (152678/65889 bytes)
>>     0x4007d4f1|0x4007d4f1: vfs image (168480/73394 bytes)
>>     0x4008f3a3|0x4008f3a3: logger image (158034/68368 bytes)
>>     0x4009feb3|0x4009feb3: ext4fs image (234510/100301 bytes)
>>     0x400b8680|0x400b8680: initrd image (8388608/1668901 bytes)
>>    ABMA devices:
>>    <1:00c> at 0x80000100 irq 3
>>    <1:00d> at 0x80000200
>>    <1:011> at 0x80000300 irq 8
>>    Memory size: 64 MB
>>
>> As of this commit, it is now confused:
>>
>>    ABMA devices:
>>    <1:3000> at 0x00000000 irq 0
>>    <1:3000> at 0x00000000 irq 0
>>    <1:3000> at 0x00000000 irq 0
>>    <1:3000> at 0x00000000 irq 0
>>    <1:3000> at 0x00000000 irq 0
>>    <1:3000> at 0x00000000 irq 0
>>    <1:3000> at 0x00000000 irq 0
>>    ...
>>
>> As this test is not working as expected, simply disable it (by
>> skipping it) for now.
>>
>> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg627094.html
>> [2] https://github.com/HelenOS/helenos/blob/0.6.0/boot/arch/sparc32/src/=
ambapp.c#L75
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   tests/acceptance/machine_sparc_leon3.py | 4 ++++
>>   1 file changed, 4 insertions(+)
>=20
> Thanks!
>=20
> Reviewed-by: Richard Henderson <richard.hendersion@linaro.org>
> Tested-by: Richard Henderson <richard.hendersion@linaro.org>

Thanks!

First job failed by timeout, 2nd succeeded:
https://travis-ci.org/github/philmd/qemu/jobs/669265466

However "Ran for 46 min 48 sec"

 From the log:

Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_malta=
_5KEc_cpio
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_malta=
_5KEc_cpio
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_i=
nitrd
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_i=
nitrd
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_s=
d
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_s=
d
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_b=
ionic
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_u=
boot_netbsd9
Fetching asset from=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_u=
boot_netbsd9
Fetching asset from=20
tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_netbsd
...
  (13/82)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_mips64el_malta=
_5KEc_cpio:=20
  SKIP: untrusted code
  (24/82)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_b=
ionic:=20
  SKIP: storage limited
...
  (25/82)=20
tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_arm_orangepi_u=
boot_netbsd9:=20
  SKIP: storage limited
...
  (63/82)=20
tests/acceptance/ppc_prep_40p.py:IbmPrep40pMachine.test_openbios_and_netbsd=
:=20
  SKIP: Running on Travis-CI

Is it possible that we are now fetching assets for tests we are not=20
running? In particular the one marked @skip because the downloading time=20
was too long on Travis?

RESULTS    : PASS 65 | ERROR 0 | FAIL 0 | SKIP 14 | WARN 0 | INTERRUPT 0=20
| CANCEL 3
JOB TIME   : 1480.72 s

Does this "JOB TIME" sums the 'Fetching asset' part?

Thanks,

Phil.


