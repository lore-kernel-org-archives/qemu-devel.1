Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145DDC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 17:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C8AD2064B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 17:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pceAxWy8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8AD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42902 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTqNe-0004AD-CT
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 13:52:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40392)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqMq-0003je-5g
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 13:51:44 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42015)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTqMn-0003Kc-Hi
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 13:51:43 -0400
Received: by mail-wr1-x443.google.com with SMTP id j7so2863098wrt.9
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 10:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G4XuQcb/CQfDws+C5XF2wYMQNXWW3jnVCRDKvuS7Y20=;
 b=pceAxWy8DwfY1ulbZxslp5FSUNqAFTCcc0f0EmxgI6n/PcwTOFpgNT/rCuQVmz29/1
 i/V3tBwEDi6ZSPYiVQMzDWhCln92UKC5fXcNz0RDVuTOqHRj954TZqAy67/9bO0UWfej
 Nhxf5hMiORtUah9++pQRuBKE6yRSH9Hi2tDYGgeC9/2LVaN7CC3C+LHHBUNbFE6ETTrT
 on4Q55Okrt6NN8a7AHXF+kHmR9uVmR69RuAz3jxevH47kSENNBP9e/xxtzSYWI+rVCYO
 hZ2ewOoSy5BNkf2kkWm0/K3QZ3rirbl1/0ZdiuBtiVCpw6lxheiyAgNqenrxfELHbUO0
 UZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G4XuQcb/CQfDws+C5XF2wYMQNXWW3jnVCRDKvuS7Y20=;
 b=j5YYYfJ7fuoSWpBxKWf8LcN3MZBhR/CnAssJ3sZfaAL25+8C43SixVNH+udbeZdevg
 3y7ceYrH21tXhQVkHLPgA8orEEoCB2c3yDU6dKMEteB679SrYb24UzNeoYhCOPlVs1lR
 UENfFMYQyUJnR+Hpswq/s+Z6yF3DmnBJJKBY/rbgpTEup/miwQQQWsQHrLBuy6MEKEeV
 s8SUbFfP5y10rxKFGUpuy70xXJZv9VWPPrAv3+I2kzWWLQ++VERVyx5lc5CjzKIBWQK+
 6pClKuO8TRWMIo1ZoFXhax1h7gsxY2XtGNGMb1FsWpYVn6FkJciukoULBvjcEJLrIDY2
 CAzg==
X-Gm-Message-State: AOAM531m4wcTUobWuxVCBCG1CPGF/UO+JQBn3z9pFXv/lDEyIidWi1pN
 WvC5AuyAYYhrrnm08zrEaGg=
X-Google-Smtp-Source: ABdhPJxZJOH5kXVUCLoYa7mdg3p0bxLBCEegnY7b/g4CrqqBZBTZResVRfwELX7tAUFMb0Fr64VN3w==
X-Received: by 2002:adf:a501:: with SMTP id i1mr10751948wrb.162.1602957099704; 
 Sat, 17 Oct 2020 10:51:39 -0700 (PDT)
Received: from [192.168.1.36] (117.red-83-52-172.dynamicip.rima-tde.net.
 [83.52.172.117])
 by smtp.gmail.com with ESMTPSA id 10sm8191188wmn.9.2020.10.17.10.51.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Oct 2020 10:51:38 -0700 (PDT)
Subject: Re: [PULL 25/33] tests/acceptance: Add a test for the N800 and N810
 arm machines
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200228163840.23585-1-peter.maydell@linaro.org>
 <20200228163840.23585-26-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a049110f-b7cb-52bd-de77-6e1193b5b6de@amsat.org>
Date: Sat, 17 Oct 2020 19:51:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200228163840.23585-26-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.247,
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

Hi Peter, Igor, Thomas,

On 2/28/20 5:38 PM, Peter Maydell wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Old kernels from the Meego project can be used to check that Linux
> is at least starting on these machines.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Message-id: 20200225172501.29609-2-philmd@redhat.com
> Message-Id: <20200129131920.22302-1-thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS                          |  1 +
>   tests/acceptance/machine_arm_n8x0.py | 49 ++++++++++++++++++++++++++++
>   2 files changed, 50 insertions(+)
>   create mode 100644 tests/acceptance/machine_arm_n8x0.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b66c46dcb9f..264374adbe8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -686,6 +686,7 @@ F: hw/rtc/twl92230.c
>   F: include/hw/display/blizzard.h
>   F: include/hw/input/tsc2xxx.h
>   F: include/hw/misc/cbus.h
> +F: tests/acceptance/machine_arm_n8x0.py
>   
>   Palm
>   M: Andrzej Zaborowski <balrogg@gmail.com>
> diff --git a/tests/acceptance/machine_arm_n8x0.py b/tests/acceptance/machine_arm_n8x0.py
> new file mode 100644
> index 00000000000..e5741f2d8d1
> --- /dev/null
> +++ b/tests/acceptance/machine_arm_n8x0.py
> @@ -0,0 +1,49 @@
> +# Functional test that boots a Linux kernel and checks the console
> +#
> +# Copyright (c) 2020 Red Hat, Inc.
> +#
> +# Author:
> +#  Thomas Huth <thuth@redhat.com>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +import os
> +
> +from avocado import skipUnless
> +from avocado_qemu import Test
> +from avocado_qemu import wait_for_console_pattern
> +
> +class N8x0Machine(Test):
> +    """Boots the Linux kernel and checks that the console is operational"""
> +
> +    timeout = 90
> +
> +    def __do_test_n8x0(self):
> +        kernel_url = ('http://stskeeps.subnetmask.net/meego-n8x0/'
> +                      'meego-arm-n8x0-1.0.80.20100712.1431-'
> +                      'vmlinuz-2.6.35~rc4-129.1-n8x0')
> +        kernel_hash = 'e9d5ab8d7548923a0061b6fbf601465e479ed269'
> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
> +
> +        self.vm.set_console(console_index=1)
> +        self.vm.add_args('-kernel', kernel_path,
> +                         '-append', 'printk.time=0 console=ttyS1')
> +        self.vm.launch()
> +        wait_for_console_pattern(self, 'TSC2005 driver initializing')
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> +    def test_n800(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:n800
> +        """
> +        self.__do_test_n8x0()
> +
> +    @skipUnless(os.getenv('AVOCADO_ALLOW_UNTRUSTED_CODE'), 'untrusted code')
> +    def test_n810(self):
> +        """
> +        :avocado: tags=arch:arm
> +        :avocado: tags=machine:n810
> +        """
> +        self.__do_test_n8x0()
> 

FYI this test is failing:

qemu-system-arm: kernel 'meego-arm-n8x0-1.0.80.20100712.1431-vml
inuz-2.6.35~rc4-129.1-n8x0' is too large to fit in RAM (kernel size 
1964608, RAM size 0)

Alex, Thomas, can we enable AVOCADO_ALLOW_UNTRUSTED_CODE on GitLab
to avoid such regressions?

Regards,

Phil.

