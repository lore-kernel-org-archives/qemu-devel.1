Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA531C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:45:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16A032224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 09:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0gy9wJW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16A032224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kURjK-0004Lr-T8
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 05:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kURhG-0003ML-M4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:43:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kURhE-0001eh-Ic
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 05:43:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id t9so10576751wrq.11
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 02:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qLpY989jTtGRcPJHerXfOmmOwYFAtbrmJOvHUqO1euA=;
 b=h0gy9wJW6TO48/LbMXlhAT5HaH8XKnJp+wWXoEZVdbuv/XugJG9g5OywbNnvR8YKVX
 4pR54248Ic3zXguES4ngrawng8cMA9GLPmE8qq3GwqcPGtdltDu0KbRmiez+++02jHG0
 oPjTthNMFtCzRlfJTGzi/5fy+0UUeYrpAg3CwLK7KD/ifh9rR0LFDxgSt3OuekVOMYIB
 ypgQmql+v5DafOm5Ps99UW+nFKkhHhBTGESgv1HKjO17QZHPCQnIftvdGGHsYWP1LCEB
 5Fe42pM7Aezap4AQ/Q//D4oNuPb60AgSA8hJzCX1UrMHzAXBN5DbhlfunOEpA7SZjHu7
 r56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qLpY989jTtGRcPJHerXfOmmOwYFAtbrmJOvHUqO1euA=;
 b=D9QHxkz7ZyJ4e3UaaPE1C/3yedwbFBf7+eIQ4DpuucXw2YiYAZuxa01HsBU7ZiYkYB
 Uw/70gjEJJL231dPg483I6WZR9HC4ZCNqM29QkKTX4Dja6k3A7c8pcx43fDx9X8NQK/v
 FF5+lpopE729ryxMEs7ln5FxO3Ys5/PzdZ66PRH58b8X0BAYiVm7DvQjAC4+j4z5I3eJ
 rBBdhCreTJLVF5SVSQbfeISUocd/3xEVjNRoVTYsEIMFcX02Wky87UsoDRKT9cLvYXa9
 Q5A5idI3nk4TpmaWwSKjKHqyLV7K16WXxarrLq2voWmC+e+jZzxiplA/VqSWrl3S28IV
 W1SA==
X-Gm-Message-State: AOAM533h2CJGwzxmN6w2vAKbWsTTNfe3fgNC0pYAP3wQ7Ej8kcOrpMl1
 ANCP+14yyXcLamjDA6B1JBU=
X-Google-Smtp-Source: ABdhPJxPY2qXZos2Z7ks1Z77/Wus/09HQOd7vVTV3J6lgkDnmbCRo1bjj7KDH6iBO/2VwE+Uektyzw==
X-Received: by 2002:adf:cd87:: with SMTP id q7mr18476586wrj.169.1603100594862; 
 Mon, 19 Oct 2020 02:43:14 -0700 (PDT)
Received: from [192.168.1.36] (36.red-83-57-175.dynamicip.rima-tde.net.
 [83.57.175.36])
 by smtp.gmail.com with ESMTPSA id a3sm17578061wrh.94.2020.10.19.02.43.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 02:43:14 -0700 (PDT)
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-devel@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
 <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
 <6ce6a790-c68e-e3ed-962e-ba6f49244315@redhat.com>
 <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
Message-ID: <f2f276a9-a6ad-a2f8-2fbc-f1aca5423f79@amsat.org>
Date: Mon, 19 Oct 2020 11:43:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f02d74fb-af6e-6e04-7ce7-48ab09a20e4f@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 11:30 AM, Philippe Mathieu-Daudé wrote:
> On 10/19/20 8:31 AM, Thomas Huth wrote:
>> On 17/10/2020 19.51, Philippe Mathieu-Daudé wrote:
>>> Hi Peter, Igor, Thomas,
>>>
>>> On 2/28/20 5:38 PM, Peter Maydell wrote:
>>>> From: Thomas Huth <thuth@redhat.com>
>>>>
>>>> Old kernels from the Meego project can be used to check that Linux
>>>> is at least starting on these machines.
>>>>
>>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>>> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
>>>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> Message-id: 20200225172501.29609-2-philmd@redhat.com
>>>> Message-Id: <20200129131920.22302-1-thuth@redhat.com>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>>> ---
>>>>    MAINTAINERS                          |  1 +
>>>>    tests/acceptance/machine_arm_n8x0.py | 49 
>>>> ++++++++++++++++++++++++++++
>>>>    2 files changed, 50 insertions(+)
>>>>    create mode 100644 tests/acceptance/machine_arm_n8x0.py
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index b66c46dcb9f..264374adbe8 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -686,6 +686,7 @@ F: hw/rtc/twl92230.c
>>>>    F: include/hw/display/blizzard.h
>>>>    F: include/hw/input/tsc2xxx.h
>>>>    F: include/hw/misc/cbus.h
>>>> +F: tests/acceptance/machine_arm_n8x0.py
>>>>      Palm
>>>>    M: Andrzej Zaborowski <balrogg@gmail.com>
>>>> diff --git a/tests/acceptance/machine_arm_n8x0.py
>>>> b/tests/acceptance/machine_arm_n8x0.py
>>>> new file mode 100644
>>>> index 00000000000..e5741f2d8d1
>>>> --- /dev/null
>>>> +++ b/tests/acceptance/machine_arm_n8x0.py
>>>> @@ -0,0 +1,49 @@
>>>> +# Functional test that boots a Linux kernel and checks the console
>>>> +#
>>>> +# Copyright (c) 2020 Red Hat, Inc.
>>>> +#
>>>> +# Author:
>>>> +#  Thomas Huth <thuth@redhat.com>
>>>> +#
>>>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>>>> +# later.  See the COPYING file in the top-level directory.
>>>> +
>>>> +import os
>>>> +
>>>> +from avocado import skipUnless
>>>> +from avocado_qemu import Test
>>>> +from avocado_qemu import wait_for_console_pattern
>>>> +
>>>> +class N8x0Machine(Test):
>>>> +    """Boots the Linux kernel and checks that the console is 
>>>> operational"""
>>>> +
>>>> +    timeout = 90
>>>> +
>>>> +    def __do_test_n8x0(self):
>>>> +        kernel_url = ('http://stskeeps.subnetmask.net/meego-n8x0/'
>>>> +                      'meego-arm-n8x0-1.0.80.20100712.1431-'
>>>> +                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
>>>> +        kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
>>>> +        kernel_path = self.fetch_asset(kernel_url, 
>>>> asset_hash=kernel_hash)
>>>> +
>>>> +        self.vm.set_console(console_index=1)
>>>> +        self.vm.add_args('-kernel', kernel_path,
>>>> +                         '-append', 'printk.time=0 console=ttyS1')
>>>> +        self.vm.launch()
>>>> +        wait_for_console_pattern(self, 'TSC2005 driver initializing')
>>>> +
>>>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 
>>>> 'untrusted code')
>>>> +    def test_n800(self):
>>>> +        """
>>>> +        :avocado: tags=arch:arm
>>>> +        :avocado: tags=machine:n800
>>>> +        """
>>>> +        self.__do_test_n8x0()
>>>> +
>>>> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 
>>>> 'untrusted code')
>>>> +    def test_n810(self):
>>>> +        """
>>>> +        :avocado: tags=arch:arm
>>>> +        :avocado: tags=machine:n810
>>>> +        """
>>>> +        self.__do_test_n8x0()
>>>>
>>>
>>> FYI this test is failing:
>>>
>>> qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vml
>>> inuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 
>>> 1964608,
>>> RAM size 0)
> 
> FWIW:
> 
> 7998beb9c2e280f0b7424223747941f106e2e854 is the first bad commit
> commit 7998beb9c2e280f0b7424223747941f106e2e854
> Author: Igor Mammedov <imammedo@redhat.com>
> Date:   Wed Feb 19 11:08:59 2020 -0500
> 
>      arm/nseries: use memdev for RAM
> 
>      memory_region_allocate_system_memory() API is going away, so
>      replace it with memdev allocated MemoryRegion. The later is
>      initialized by generic code, so board only needs to opt in
>      to memdev scheme by providing
>        MachineClass::default_ram_id
>      and using MachineState::ram instead of manually initializing
>      RAM memory region.
> 
>      PS:
>       while at it add check for user supplied RAM size and error
>       out if it mismatches board expected value.
> 
>      Signed-off-by: Igor Mammedov <imammedo@redhat.com>
>      Reviewed-by: Andrew Jones <drjones@redhat.com>
>      Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>      Message-Id: <20200219160953.13771-26-imammedo@redhat.com>

This fixes the issue:

-- >8 --
diff --git a/hw/arm/nseries.c b/hw/arm/nseries.c
index e48092ca047..76fd7fe9854 100644
--- a/hw/arm/nseries.c
+++ b/hw/arm/nseries.c
@@ -1318,6 +1318,7 @@ static void n8x0_init(MachineState *machine,
          g_free(sz);
          exit(EXIT_FAILURE);
      }
+    binfo->ram_size = machine->ram_size;

      memory_region_add_subregion(get_system_memory(), OMAP2_Q2_BASE,
                                  machine->ram);
---

> 
>>>
>>> Alex, Thomas, can we enable AVOCADO_ALLOW_UNTRUSTED_CODE on GitLab
>>> to avoid such regressions?
>>
>> Yes, please, if you've got some spare minutes to work on such a patch, 
>> that
>> would be great! ... I once already wanted to send such a patch, but IIRC
>> there were some other ALLOW_UNTRUSTED_CODE tests failing at that poing in
>> time, and I never got around to fix them...
>>
>>   Thomas
>>
>>
> 

