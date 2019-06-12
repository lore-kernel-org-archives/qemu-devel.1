Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE50CC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A69CB20B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 23:29:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A69CB20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbCgj-0004qF-Te
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 19:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35495)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbCfH-00032N-G8
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbCQA-0007Cp-Jy
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:12:48 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33376)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbCQ9-0007Bb-ST
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 19:12:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so18692664wru.0
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 16:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yDCf1hSVOF9p2tJXezR4cDgv4ZT+yucbJDDuthzBX7s=;
 b=DAO7GtSaSLUJEgPkvTwpmTnLC7HROpUoNnoTtsAULQKawzINhkbs9m3M5Yuvocoiwu
 uzXA/bfKruAiR5bcnqn3kniCVuIsTSg+x/1xPbm81SkxIk81eHMbjmnPMikurAlbKFuE
 3kGjJttwLtNDUIyiW0p7Eq/9x7Fp/Y5JKCbOO+TbGO76BcSb7B65qxR1xM3x055BEFDf
 MwpzVrNDl5Ok8NTFuebeZOMxy70/ox48FkHFxwnOmLY/aD6iqW4ggCBFa/eut+WYkHBs
 p2oCmNmrU2dBkmuVA97F/f647OtpHF2bszAZtXCv1bBEg1V2hEkpFTI+FjjosysJdaOb
 SwSA==
X-Gm-Message-State: APjAAAV4oFIY3X34xmzZIGkSwunPx9HZmE3Z36vd5WZhM1URJhSiqucv
 gw9EMPkjDRqP27GGX9Rh74ETnQ==
X-Google-Smtp-Source: APXvYqzqewZojKt4lSIUsXKhnRyKFNLDM0ojiF6kV1k8JCRZ//P4DERRAM1l7NdizGps10dAjfGNLQ==
X-Received: by 2002:adf:e446:: with SMTP id t6mr43880055wrm.115.1560381164162; 
 Wed, 12 Jun 2019 16:12:44 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id j16sm1887267wre.94.2019.06.12.16.12.43
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 16:12:43 -0700 (PDT)
To: Cleber Rosa <crosa@redhat.com>
References: <20190611171456.23444-1-ehabkost@redhat.com>
 <20190611171456.23444-7-ehabkost@redhat.com>
 <d107483c-eba8-f6fc-8e3a-ad0a86472d07@redhat.com>
 <20190612224736.GA9536@localhost.localdomain>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f9bf67d5-4b77-d952-148e-74066b49088a@redhat.com>
Date: Thu, 13 Jun 2019 01:12:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190612224736.GA9536@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PULL 6/6] travis: Make check-acceptance job more
 verbose
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/19 12:47 AM, Cleber Rosa wrote:
> On Wed, Jun 12, 2019 at 10:49:18PM +0200, Philippe Mathieu-Daudé wrote:
>> On 6/11/19 7:14 PM, Eduardo Habkost wrote:
>>> It will help us debug issues when tests fail.
>>>
>>> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
>>> ---
>>>  .travis.yml | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/.travis.yml b/.travis.yml
>>> index b053a836a3..a08a7b7278 100644
>>> --- a/.travis.yml
>>> +++ b/.travis.yml
>>> @@ -225,7 +225,7 @@ matrix:
>>>      # Acceptance (Functional) tests
>>>      - env:
>>>          - CONFIG="--python=/usr/bin/python3 --target-list=x86_64-softmmu,mips-softmmu,mips64el-softmmu,aarch64-softmmu,arm-softmmu,s390x-softmmu,alpha-softmmu"
>>> -        - TEST_CMD="make check-acceptance"
>>> +        - TEST_CMD="make AVOCADO_SHOW=test check-acceptance"
>>>        addons:
>>>          apt:
>>>            packages:
>>>
>>
>> Cleber, can you help figuring what's wrong here?
>>
>> https://travis-ci.org/qemu/qemu/jobs/544805900
>>
>> The tests seems successfull, is it possible the verbose logging returns
>> error to the shell even if the test succeed?
>>
> 
> There's some confusion here... To the best of my knowledge this failure is
> not associated with Eduardo's change of the of the AVOCADO_SHOW variable.
> This seems to be we hitting this:
> 
>   https://bugs.launchpad.net/qemu/+bug/1829779
> 
> Which was also discussed in other threads, such as:
> 
>   https://lists.gnu.org/archive/html/qemu-devel/2019-06/msg01254.html

Oh you are right, thanks for clearing this (and working on a fix!).

Regards,

Phil.

> 
> We have identified two ways to work around this, and about two days
> ago Eduardo and myself settled on one of them.  I'll send a patch in
> a few.
> 
>> INIT
>> 05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_virt
>> PARAMS (key=timeout, path=*, default=90) => 90
>> Test metadata:
>>   filename:
>> /home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py
>>   teststmpdir: /tmp/avocado_6tk1s4nz
>>   workdir:
>> /tmp/avocado_ifg2df04/avocado_job_zqdrt4ht/05-_home_travis_build_qemu_qemu_tests_acceptance_boot_linux_console.py_BootLinuxConsole.test_aarch64_virt
>> START
>> 05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_virt
>> DATA (filename=output.expected) => NOT FOUND (data sources: variant,
>> test, file)
>> PARAMS (key=arch, path=*, default=aarch64) => 'aarch64'
>> PARAMS (key=qemu_bin, path=*,
>> default=aarch64-softmmu/qemu-system-aarch64) =>
>> 'aarch64-softmmu/qemu-system-aarch64'
>> Fetching
>> https://download.fedoraproject.org/pub/fedora/linux/releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz
>> ->
>> /home/travis/avocado/data/cache/by_location/e959d0e1dd72e77653e218e666198db1f3d0c213/vmlinuz.g3ehffso
>> Retrieved URL
>> "https://download.fedoraproject.org/pub/fedora/linux/releases/29/Everything/aarch64/os/images/pxeboot/vmlinuz":
>> content-length 8623423, date: "Wed, 12 Jun 2019 18:54:21 GMT",
>> last-modified: "Sun, 21 Oct 2018 00:43:09 GMT"
>> VM launch command: 'aarch64-softmmu/qemu-system-aarch64 -chardev
>> socket,id=mon,path=/var/tmp/tmptpv0noew/qemu-6334-monitor.sock -mon
>> chardev=mon,mode=control -display none -vga none -machine virt -chardev
>> socket,id=console,path=/var/tmp/tmptpv0noew/qemu-6334-console.sock,server,nowait
>> -serial chardev:console -cpu cortex-a53 -kernel
>> /home/travis/avocado/data/cache/by_location/e959d0e1dd72e77653e218e666198db1f3d0c213/vmlinuz
>> -append printk.time=0 console=ttyAMA0'
>>>>> {'execute': 'qmp_capabilities'}
>> <<< {'return': {}}
>> Booting Linux on physical CPU 0x0000000000 [0x410fd034]
>> Linux version 4.18.16-300.fc29.aarch64
>> (mockbuild@buildvm-aarch64-02.arm.fedoraproject.org) (gcc version 8.2.1
>> 20180801 (Red Hat 8.2.1-2) (GCC)) #1 SMP Sat Oct 20 23:12:22 UTC 2018
>> Machine model: linux,dummy-virt
>> efi: Getting EFI parameters from FDT:
>> efi: UEFI not found.
>> cma: Failed to reserve 64 MiB
>> NUMA: No NUMA configuration found
>> NUMA: Faking a node at [mem 0x0000000000000000-0x0000000047ffffff]
>> NUMA: NODE_DATA [mem 0x47f9c780-0x47fa9fff]
>> Zone ranges:
>> DMA32    [mem 0x0000000040000000-0x0000000047ffffff]
>> Normal   empty
>> Movable zone start for each node
>> Early memory node ranges
>> node   0: [mem 0x0000000040000000-0x0000000047ffffff]
>> Initmem setup node 0 [mem 0x0000000040000000-0x0000000047ffffff]
>> psci: probing for conduit method from DT.
>> psci: PSCIv0.2 detected in firmware.
>> psci: Using standard PSCI v0.2 function IDs
>> psci: Trusted OS migration not required
>> percpu: Embedded 23 pages/cpu @(____ptrval____) s53528 r8192 d32488 u94208
>> Detected VIPT I-cache on CPU0
>> CPU features: enabling workaround for ARM erratum 843419
>> CPU features: detected: Kernel page table isolation (KPTI)
>> Built 1 zonelists, mobility grouping on.  Total pages: 32256
>> Policy zone: DMA32
>> Kernel command line: printk.time=0 console=ttyAMA0
>>>>> {'execute': 'quit'}
> 
> Notice how QEMU gets stuck here.
> 
> - Cleber.
> 
>> qemu received signal 9: aarch64-softmmu/qemu-system-aarch64 -chardev
>> socket,id=mon,path=/var/tmp/tmptpv0noew/qemu-6334-monitor.sock -mon
>> chardev=mon,mode=control -display none -vga none -machine virt -chardev
>> socket,id=console,path=/var/tmp/tmptpv0noew/qemu-6334-console.sock,server,nowait
>> -serial chardev:console -cpu cortex-a53 -kernel
>> /home/travis/avocado/data/cache/by_location/e959d0e1dd72e77653e218e666198db1f3d0c213/vmlinuz
>> -append printk.time=0 console=ttyAMA0
>> DATA (filename=output.expected) => NOT FOUND (data sources: variant,
>> test, file)
>> DATA (filename=stdout.expected) => NOT FOUND (data sources: variant,
>> test, file)
>> DATA (filename=stderr.expected) => NOT FOUND (data sources: variant,
>> test, file)
>> Not logging /var/log/syslog (lack of permissions)
>> PASS
>> 05-/home/travis/build/qemu/qemu/tests/acceptance/boot_linux_console.py:BootLinuxConsole.test_aarch64_virt
>> Runner error occurred: Timeout reached
[...]

