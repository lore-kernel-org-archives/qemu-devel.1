Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ADBC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:52:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C1B520897
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTrcHAao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C1B520897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCJB-00073k-JJ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:52:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNCHG-0005VZ-PD
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:50:30 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNCHA-00081T-Jf
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:50:26 -0400
Received: by mail-wr1-x443.google.com with SMTP id j2so4618625wrx.7
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VvDwgqqBVsDX6ZSTgq2sLKindWShDx4wt2crfE89Ew0=;
 b=WTrcHAaoEjW8jkV/07q5O923AToffinx3tVwBUnTwqyjAAfhV/iTmTXAG0NC453jqo
 KaYT8uHFUBz7vHzX6z8hRbMafu3neL4yHiuH6bfKgfyo9mD+m40cMqE8WnjXHSlco7oQ
 wtHGKaGbEd4d3r1lef7z8Ku1/iqNe/2MlNaDdjde72gNeOCCOhex0PevfmTcnH04MiEX
 BjW7/muVtpHrq2DaeLkVj7nu34tbl5cYAm6GdnNcdzqU2S4OsYfa9CV1hfovndqdE8lE
 PPMq/EYx32IM5VEYsWKZF8DSZImTfRLbuk5OAIrjTLPItL5Gl5N5jgjKpue8Sv4FECkT
 GJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VvDwgqqBVsDX6ZSTgq2sLKindWShDx4wt2crfE89Ew0=;
 b=B8MD/+ZjlcS16VMdnPIgNaCyxlZa02MbGomTLnmelvRnj03KyXpzmGaYpzyS0gXSJw
 iz0yR5o6ildMrFXXRgGJoz7cp9WuDAsai1La8ZoMnpef4qm+G+iKyiWnP7Ktj5rPxWaI
 p3uC9FY80MDdPJLM4Zah/VqHMAM644EAalfUfpl4VM6q3s/SiQrLEN0/LCFpFULTR80I
 waDGTZh2ZlmU9rNtVite5n6EQhc4pWw9vGmOjDG7SiKDf2KKugnBRommDNMiKG/LKl2/
 ua5alaWChf9Nv/HNBW6bURBnvBxtH+kUi0An7GZlkIc2KDj77SB5sPUG4RG1vlY92T63
 NGSg==
X-Gm-Message-State: AOAM532dGlRjUaEo/dKPkdfB0qdAjhAJG6AwPsz/tPnv4Jb4zb4d5i9L
 2r/33OlnF1ySMUPg+Pn/wdg=
X-Google-Smtp-Source: ABdhPJyTc47UeXS3GHZolMfkVqDnXwcdDl+J6D1oLtpPnI2Q/OGZDlNoHJg+p25tioBoyuAPLVWBSw==
X-Received: by 2002:adf:f6cd:: with SMTP id y13mr3231134wrp.161.1601373021991; 
 Tue, 29 Sep 2020 02:50:21 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id j14sm5345316wrr.66.2020.09.29.02.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 02:50:21 -0700 (PDT)
Subject: Re: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-17-f4bug@amsat.org>
 <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
 <105e7a4e-adee-284e-cf20-31b1a2781720@amsat.org> <87r1qkq5wp.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <49ee3fe3-b814-6b36-a857-b42788b44db5@amsat.org>
Date: Tue, 29 Sep 2020 11:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87r1qkq5wp.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Thomas Huth <huth@tuxfamily.org>, qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Willian Rampazzo <wrampazz@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 Huacai Chen <chenhc@lemote.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 11:38 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> +Alex/Daniel
>>
>> On 9/28/20 10:33 PM, Willian Rampazzo wrote:
>>> On Mon, Sep 28, 2020 at 2:31 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>
>>>> Add a test for the mipssim machine, based on the recommended
>>>> test setup from Thomas Huth:
>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html
>>>>
>>>> The test is quick and can be run as:
>>>>
>>>>   $ avocado --show=console run -t machine:mipssim tests/acceptance/
>>>>    (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.test_mipssim_linux_console:
>>>>   console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8.3 (Buildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
>>>>   console: Setting default memory size 0x02000000
>>>>   console: bootconsole [early0] enabled
>>>>   console: CPU revision is: 00019300 (MIPS 24Kc)
>>>>   console: FPU revision is: 00739300
>>>>   ...
>>>>   console: CPU frequency 12.00 MHz
>>>>   console: Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
>>>>   ...
>>>>   console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIPS Technologies, Inc.
>>>>   ...
>>>>   console: Welcome to Buildroot
>>>>   console: buildroot login: root
>>>>   console: # root
>>>>   console: -sh: root: not found
>>>>   console: # ping -c 3 10.0.2.2
>>>>   console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
>>>>   console: 64 bytes from 10.0.2.2: seq=0 ttl=255 time=48.231 ms
>>>>   console: 64 bytes from 10.0.2.2: seq=1 ttl=255 time=9.407 ms
>>>>   console: 64 bytes from 10.0.2.2: seq=2 ttl=255 time=2.298 ms
>>>>   console: --- 10.0.2.2 ping statistics ---
>>>>   console: 3 packets transmitted, 3 packets received, 0% packet loss
>>>>   PASS (7.99 s)
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>> Cc: Thomas Huth <huth@tuxfamily.org>
>>>> ---
>>>>  MAINTAINERS                              |  1 +
>>>>  tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
>>>>  2 files changed, 57 insertions(+)
>>>>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 5eed1e692b4..17d8a012b0e 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
>>>>  F: include/hw/timer/mips_gictimer.h
>>>>  F: tests/acceptance/linux_ssh_mips_malta.py
>>>>  F: tests/acceptance/machine_mips_malta.py
>>>> +F: tests/acceptance/machine_mips_mipssim.py
>>>>  F: tests/tcg/mips/
>>>>  K: ^Subject:.*(?i)mips
>>>>
>>>> diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/acceptance/machine_mips_mipssim.py
>>>> new file mode 100644
>>>> index 00000000000..b2749917b08
>>>> --- /dev/null
>>>> +++ b/tests/acceptance/machine_mips_mipssim.py
>>>> @@ -0,0 +1,56 @@
>>>> +# Functional tests for the MIPS simulator (MIPSsim machine)
>>>> +#
>>>> +# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> +#
>>>> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>> +# See the COPYING file in the top-level directory.
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +import os
>>>> +import logging
>>>> +import time
>>>> +
>>>> +from avocado import skipUnless
>>>> +from avocado_qemu import Test
>>>> +from avocado_qemu import exec_command_and_wait_for_pattern
>>>> +from avocado_qemu import interrupt_interactive_console_until_pattern
>>>> +from avocado_qemu import wait_for_console_pattern
>>>> +
>>>> +class MipsSimMachine(Test):
>>>> +
>>>> +    timeout = 30
>>>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>>>> +
>>>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>>>> +    def test_mipssim_linux_console(self):
>>>> +        """
>>>> +        Boots the Linux kernel and checks that the console is operational
>>>> +        :avocado: tags=arch:mipsel
>>>> +        :avocado: tags=machine:mipssim
>>>> +        :avocado: tags=device:mipsnet
>>>> +        """
>>>> +        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
>>>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>>>> +                      'mips/mipssim/mipsel/vmlinux')
>>>
>>> So, are you willing to maintain some images on your GitHub to avoid
>>> the image changes when they are not found?
>>
>> No, I am not willing to do that.
>>
>> But I see it pointless to have everyone (including CI) to spend 1h
>> building this image, when the sources and build recipe is available,
>> making the built image reproducible.
> 
> I agree we don't want to build from scratch each time. However as we
> move from relying on third parties (which outside of the major distros
> has proved very flaky) we are getting to the point of managing our GPL
> liabilities.
> 
> After a bit of digging in your branches I see this is a buildroot
> recipe running in Docker. Are they fully reproducible?

Yes, I wrote this Dockerfile to 1/ allow others to use/test but also
2/ so I don't have to manually do this again.

BTW Thomas suggested to add a 'make legal-info' final step, since
buildroot provides it (I was not aware of that):
https://buildroot.org/downloads/manual/manual.html#legal-info

> Could we have a:
> 
>   make acceptance-image-mipsel
> 
> which built the same blob that gets inserted into the avocado cache
> should your github url ever disappear?

Yes but that would mean add this Dockerfile into the QEMU repository,
right? Where to put the .config, QEMU repo too? Then keep the *built*
image + sources + legal-info out of tree. Finally the Avocado test
containing the image SHA1 in QEMU tree. Is that OK?

> 
>> I'm not sure we need to run all the tests all the time, but I'd like
>> to have the tests:
>>
>> 1/ provided with a series, so reviewer are free to rebuild the image
>>    and test this series works as expected,
>> 2/ committed in the repository, so maintainers can verify future changes
>>    doesn't introduce regression.
> 
> Yes these are great goals - my only worry is the shifting sands some of
> these images seem to exist on.
> 
>>>
>>>> +        kernel_hash = '0f9aeca3a2e25b5b0cc4999571f39a7ad58cdc43'
>>>> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>>>> +
>>>> +        initrd_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
>>>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>>>> +                      'mips/mipssim/mipsel/rootfs.cpio')
>>>> +        initrd_hash = 'b20359bdfae66387e5a17d6692686d59c189417b'
>>>> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>>>> +
>>>> +        self.vm.set_console()
>>>> +        self.vm.add_args('-kernel', kernel_path,
>>>> +                         '-initrd', initrd_path,
>>>> +                         '-append', self.KERNEL_COMMON_COMMAND_LINE)
>>>> +        self.vm.launch()
>>>> +
>>>> +        wait_for_console_pattern(self, 'Welcome to Buildroot')
>>>> +        interrupt_interactive_console_until_pattern(self,
>>>> +                                                    interrupt_string='root\r',
>>>> +                                                    success_message='#')
>>>> +        pattern = '3 packets transmitted, 3 packets received, 0% packet loss'
>>>> +        exec_command_and_wait_for_pattern(self, 'ping -c 3 10.0.2.2', pattern)
>>>> --
>>>> 2.26.2
>>>>
>>>>
>>>
>>> IMHO, although the solution of spreading images over personal
>>> repositories is not the best, I don't have a strong opinion to block
>>> this, so
>>
>> If the URL is stable (stable commit or even better, tag) it should
>> be OK.
>>
>> tag is used in the quanta-gsj tests, see commit 4fe986dd448
>> ("tests/acceptance: console boot tests for quanta-gsj"):
>>
>>   image_url = (
>>           'https://github.com/hskinnemoen/openbmc/releases/download/'
>>           '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz')
>>   image_hash = '14895e634923345cb5c8776037ff7876df96f6b1'
>>
>>>
>>> Reviewed-by: Willian Rampazzo (willianr@redhat.com)
>>>
>>
>> Thanks!
>>
>> Phil.
> 
> 

