Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C3C4727F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:17:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D59F206CA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="taQk7QNs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D59F206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNZAw-0007TE-3v
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 06:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZ2S-0007CX-JS
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:08:44 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39947)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNZ2Q-0005R5-Ip
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 06:08:44 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so1110182wrx.7
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2020 03:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=o1lCRLnW+MDmxPXqgzGMLBHBUYi9Y3fSC2TUXFMrOYE=;
 b=taQk7QNsTMsIrxWpIuNqYpgkNwbdMHrrQGQG/8771oMjFcLWll/pXPzh7UieV3hppd
 Em9NkcQa2fG9+w2Y35rZ2v4fmIH4EkVleu6mCrjnjbO8Gwe0S0/K7VUAHhOY0wiyev+7
 KYMnwniKML4EukjXDpwJ2mNGgppe6p6jmv7qejPRtijvp4HWOm9Bjxgp0DNLN+tA9EnB
 UQqlhZWhzO8ux1wuw9008ql+kceWWyWpckxN3FP28tG04ph0hsPW1mVuGCArPgIdliPO
 mV7iVcbc648FXi7B/PQJEGFwuKpyjsHcZp/j8y7FCztN+ikYjGo/Dvx8MK1e82T0w+pV
 tKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=o1lCRLnW+MDmxPXqgzGMLBHBUYi9Y3fSC2TUXFMrOYE=;
 b=cCGrHbcA/MGEKfyawwlhQ8B4o1JZSAe4HhofTLB7TFBPdmk9umu9d0x0x//g1g28Yp
 xCZ1x+fqcJas8kHKp+vK+lQyj32lOruPdCbJM4xT5b1j9mqgsiq1oi58vYLpPqEABejm
 EwYqe7Y0wbmND1LSw324KTs9oUU6y8H2QfGiwKCRDIn00eiquo2T48AT4o0VcBThu/oX
 0hDy/Lll6iWufwewnA1AkHLf1Tmfvqd2fQgRAceI4I1ZtR/RZH37SB5Hu3hAAxUHLM3Q
 dpPC+M1Tqy9tdrvnq5ufbPqTP218jKwqc/mvD2kZTYEbvAdQWJXs3MXrvAnASZ+D+BiW
 ui8Q==
X-Gm-Message-State: AOAM532B6foW7XFj4wPau30IR/9YMj/fWnvOnir6MbxKRw0jL2AEhoSD
 cp8AxbGRUO8A4AeZkJJB1wA=
X-Google-Smtp-Source: ABdhPJzCRaGI4MBdbV6Gisq8SdE8qHlNGZwM8zUYatnC/INQeVddgv2eK2KqvWl9Ef96PRZHJ7HTDQ==
X-Received: by 2002:a5d:6552:: with SMTP id z18mr2212508wrv.32.1601460520282; 
 Wed, 30 Sep 2020 03:08:40 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id z13sm1964402wro.97.2020.09.30.03.08.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Sep 2020 03:08:39 -0700 (PDT)
Subject: Re: [PATCH 16/16] tests/acceptance: Test the MIPSsim machine
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200928171539.788309-1-f4bug@amsat.org>
 <20200928171539.788309-17-f4bug@amsat.org>
 <CAKJDGDbowgUtu8Ap7K6vm_sksW3-maHU0bk3uib7BNY-5YxMdQ@mail.gmail.com>
 <105e7a4e-adee-284e-cf20-31b1a2781720@amsat.org> <87r1qkq5wp.fsf@linaro.org>
 <20200930084300.GA2264779@redhat.com> <877dsbppbh.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b2c71d4e-05a2-8f29-73ee-ced4d55526db@amsat.org>
Date: Wed, 30 Sep 2020 12:08:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <877dsbppbh.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
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

On 9/30/20 11:49 AM, Alex Bennée wrote:
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
>> On Tue, Sep 29, 2020 at 10:38:30AM +0100, Alex Bennée wrote:
>>>
>>> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
>>>
>>>> +Alex/Daniel
>>>>
>>>> On 9/28/20 10:33 PM, Willian Rampazzo wrote:
>>>>> On Mon, Sep 28, 2020 at 2:31 PM Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>>>>
>>>>>> Add a test for the mipssim machine, based on the recommended
>>>>>> test setup from Thomas Huth:
>>>>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg606846.html
>>>>>>
>>>>>> The test is quick and can be run as:
>>>>>>
>>>>>>   $ avocado --show=console run -t machine:mipssim tests/acceptance/
>>>>>>    (1/1) tests/acceptance/machine_mips_mipssim.py:MipsSimMachine.test_mipssim_linux_console:
>>>>>>   console: Linux version 3.6.11 (root@711bb8ba16a7) (gcc version 4.8.3 (Buildroot 2014.11) ) #2 Sun Sep 27 13:39:35 UTC 2020
>>>>>>   console: Setting default memory size 0x02000000
>>>>>>   console: bootconsole [early0] enabled
>>>>>>   console: CPU revision is: 00019300 (MIPS 24Kc)
>>>>>>   console: FPU revision is: 00739300
>>>>>>   ...
>>>>>>   console: CPU frequency 12.00 MHz
>>>>>>   console: Calibrating delay loop... 950.27 BogoMIPS (lpj=4751360)
>>>>>>   ...
>>>>>>   console: MIPSNet Ethernet driver. Version: 2007-11-17. (c)2005 MIPS Technologies, Inc.
>>>>>>   ...
>>>>>>   console: Welcome to Buildroot
>>>>>>   console: buildroot login: root
>>>>>>   console: # root
>>>>>>   console: -sh: root: not found
>>>>>>   console: # ping -c 3 10.0.2.2
>>>>>>   console: PING 10.0.2.2 (10.0.2.2): 56 data bytes
>>>>>>   console: 64 bytes from 10.0.2.2: seq=0 ttl=255 time=48.231 ms
>>>>>>   console: 64 bytes from 10.0.2.2: seq=1 ttl=255 time=9.407 ms
>>>>>>   console: 64 bytes from 10.0.2.2: seq=2 ttl=255 time=2.298 ms
>>>>>>   console: --- 10.0.2.2 ping statistics ---
>>>>>>   console: 3 packets transmitted, 3 packets received, 0% packet loss
>>>>>>   PASS (7.99 s)
>>>>>>
>>>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>> ---
>>>>>> Cc: Thomas Huth <huth@tuxfamily.org>
>>>>>> ---
>>>>>>  MAINTAINERS                              |  1 +
>>>>>>  tests/acceptance/machine_mips_mipssim.py | 56 ++++++++++++++++++++++++
>>>>>>  2 files changed, 57 insertions(+)
>>>>>>  create mode 100644 tests/acceptance/machine_mips_mipssim.py
>>>>>>
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>>>> index 5eed1e692b4..17d8a012b0e 100644
>>>>>> --- a/MAINTAINERS
>>>>>> +++ b/MAINTAINERS
>>>>>> @@ -240,6 +240,7 @@ F: include/hw/misc/mips_*
>>>>>>  F: include/hw/timer/mips_gictimer.h
>>>>>>  F: tests/acceptance/linux_ssh_mips_malta.py
>>>>>>  F: tests/acceptance/machine_mips_malta.py
>>>>>> +F: tests/acceptance/machine_mips_mipssim.py
>>>>>>  F: tests/tcg/mips/
>>>>>>  K: ^Subject:.*(?i)mips
>>>>>>
>>>>>> diff --git a/tests/acceptance/machine_mips_mipssim.py b/tests/acceptance/machine_mips_mipssim.py
>>>>>> new file mode 100644
>>>>>> index 00000000000..b2749917b08
>>>>>> --- /dev/null
>>>>>> +++ b/tests/acceptance/machine_mips_mipssim.py
>>>>>> @@ -0,0 +1,56 @@
>>>>>> +# Functional tests for the MIPS simulator (MIPSsim machine)
>>>>>> +#
>>>>>> +# Copyright (c) 2020 Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>>>> +#
>>>>>> +# This work is licensed under the terms of the GNU GPL, version 2 or later.
>>>>>> +# See the COPYING file in the top-level directory.
>>>>>> +#
>>>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>>>> +
>>>>>> +import os
>>>>>> +import logging
>>>>>> +import time
>>>>>> +
>>>>>> +from avocado import skipUnless
>>>>>> +from avocado_qemu import Test
>>>>>> +from avocado_qemu import exec_command_and_wait_for_pattern
>>>>>> +from avocado_qemu import interrupt_interactive_console_until_pattern
>>>>>> +from avocado_qemu import wait_for_console_pattern
>>>>>> +
>>>>>> +class MipsSimMachine(Test):
>>>>>> +
>>>>>> +    timeout = 30
>>>>>> +    KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>>>>>> +
>>>>>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
>>>>>> +    def test_mipssim_linux_console(self):
>>>>>> +        """
>>>>>> +        Boots the Linux kernel and checks that the console is operational
>>>>>> +        :avocado: tags=arch:mipsel
>>>>>> +        :avocado: tags=machine:mipssim
>>>>>> +        :avocado: tags=device:mipsnet
>>>>>> +        """
>>>>>> +        kernel_url = ('https://github.com/philmd/qemu-testing-blob/raw/'
>>>>>> +                      '32ea5764e1de8fffa0d59366c44822cd06d7c8e0/'
>>>>>> +                      'mips/mipssim/mipsel/vmlinux')
>>>>>
>>>>> So, are you willing to maintain some images on your GitHub to avoid
>>>>> the image changes when they are not found?
>>>>
>>>> No, I am not willing to do that.
>>>>
>>>> But I see it pointless to have everyone (including CI) to spend 1h
>>>> building this image, when the sources and build recipe is available,
>>>> making the built image reproducible.
>>>
>>> I agree we don't want to build from scratch each time. However as we
>>> move from relying on third parties (which outside of the major distros
>>> has proved very flaky) we are getting to the point of managing our GPL
>>> liabilities.
>>
>> I'm wondering what the 1 hour time to build the images is
>> spent on, and what does the image need to actually do ?
> 
> Buildroot will also build the toolchain and libc of chouce before
> building it's rootfs. To be honest the rootfs part of the build is
> fairly minimal if it's mostly busybox.

Exactly, half of the time is spent building binutils and gcc.

> 
>> Is it anything more than boot the kernel successfully ?
>>
>> I've not tried a timed build, but surely a minimal / tiny
>> Linx kernel build is much less than an hour ? Combine with
>> a tiny C program that simply prints "OK" as /bin/init and
>> powers off the VM. Or we need more advanced then a minimal
>> busybox build.
> 
> Starting from a buildroot is useful for development certainly because
> it's a lot easier to add stuff to it if you need to.
> 
>> I think it'd be great if we could self-build a minimal
>> kernel+init for all platforms we target, using distro
>> provided cross-compilers.

We can't because MIPSsim has been dropped from the Linux kernel v3.18,
and trying to build a such old kernel produce a *lot* of errors with
a current (cross) compiler. See:
https://lists.nongnu.org/archive/html/qemu-devel/2018-04/msg04071.html

What provides buildroot is old enough toolchain to be able to build
old code.

> 
> We've been down this round before haven't we? Wasn't that what the JeOS
> builds where all about?
> 
> Anyway things have moved on from the bad old days of crosstool and the
> distros are better at packaging sane cross compilers that can build
> kernels and basic user space. However leaving everyone to use their own
> distro compiler is going to lead to repeatability problems - or maybe we
> just treat it like we do with the existing TCG tests?
> 
>>
>>
>> Regards,
>> Daniel
> 
> 

