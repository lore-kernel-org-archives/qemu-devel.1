Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE04C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:50:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7F192080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 09:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHyfsDN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7F192080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSR6-0006bD-0E
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 05:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxSQH-00061D-6H; Mon, 20 Jul 2020 05:49:25 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:40457)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxSQF-0005l1-5n; Mon, 20 Jul 2020 05:49:24 -0400
Received: by mail-wm1-x341.google.com with SMTP id f139so24520079wmf.5;
 Mon, 20 Jul 2020 02:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:autocrypt:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fNJsqz/KLYzuhc5HeX2Wt5ZIRBJ+9XJvw/isbxqhlIs=;
 b=YHyfsDN3EUZCQAImBqz/J0qaw3VSsGGeUBzdMU7V9mJeKVZrpSrbt7MH625WvRQ52D
 v01tr5t3iUCwQblvGfEFa15PwdL+geAOFAF3xISNkhhRd5CFuqUHwTk0msd//UrOsBkN
 u5O5J9T0ZT1z9wotqQrxB31b3nUuXAcxS746gr8dj5cluW8KOsPtNMkVu82Qn5+MEt/N
 vDXAXE0udzLhRWAcBmOC2anREfSXNVjJb85I/lELbXkZcIWiWKTpOsIHdkuAPCVGkEZ9
 aEuDT6zRECS3ASVeMTugJhF+e1oivrmIyxPRWXNCnpgPlR3Oq/aP2o4m82Pjy/JtVWe2
 am+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=fNJsqz/KLYzuhc5HeX2Wt5ZIRBJ+9XJvw/isbxqhlIs=;
 b=pm9FQ9O0BuHJeIhF0k4Hrapcqo0FwF5Z1bdKuYlTvaiC8RhsD1SX/MqbxUn4009jrC
 QLHnqbjaudi+ZcVozScTtkPN6S11WlFphnKpgFL7PobTK8JTMddcpXHNwRMvmWZy3Rrc
 E1N+GzCm0z6Ds1j/pXS9GP92UG3+DtDl5OfphtWhOvspTWU1xnjWCDkhS9Dql4KI36Ez
 qcf2ayaRxBeYplT6t/jIz41JQUtCeazdCOARCyox4kT09h15I9jh0b2+/vDJIitf1X5D
 PWb1CPZg1JwGM+RQclZLfJJisdr3Y9pj5AEbn2d00Rq2+GwqaxdaCDyaCn4ZN8OG72Ul
 LGUw==
X-Gm-Message-State: AOAM533NN2gTinuLvfAb+9wvoqjYkro0SfkMzUmSCwFErxs5/aKwyd71
 LwCQxCaSBBCTTYWFuUO/zjY=
X-Google-Smtp-Source: ABdhPJygm43XTWCTa/+ptIELD4KHa1ixKGZ42Y4PAh2/pJkz0P79JBXAJ75jra2dN9+sJnXRxwhvfg==
X-Received: by 2002:a1c:4846:: with SMTP id v67mr21825402wma.175.1595238560636; 
 Mon, 20 Jul 2020 02:49:20 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d81sm33386744wmc.0.2020.07.20.02.49.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 02:49:19 -0700 (PDT)
Subject: Re: [PATCH v6 13/13] tests/acceptance: console boot tests for
 quanta-gsj
To: Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <20200717060258.1602319-14-hskinnemoen@google.com>
 <f098aa02-28cd-f86b-1641-5e164ba5ca7f@kaod.org>
 <CACPK8Xe_COP0sLCZnjnRYgA13W73BPnw9g0B5u6DK4++MDy5-A@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Autocrypt: addr=philmd@redhat.com; keydata=
 mQINBDXML8YBEADXCtUkDBKQvNsQA7sDpw6YLE/1tKHwm24A1au9Hfy/OFmkpzo+MD+dYc+7
 bvnqWAeGweq2SDq8zbzFZ1gJBd6+e5v1a/UrTxvwBk51yEkadrpRbi+r2bDpTJwXc/uEtYAB
 GvsTZMtiQVA4kRID1KCdgLa3zztPLCj5H1VZhqZsiGvXa/nMIlhvacRXdbgllPPJ72cLUkXf
 z1Zu4AkEKpccZaJspmLWGSzGu6UTZ7UfVeR2Hcc2KI9oZB1qthmZ1+PZyGZ/Dy+z+zklC0xl
 XIpQPmnfy9+/1hj1LzJ+pe3HzEodtlVA+rdttSvA6nmHKIt8Ul6b/h1DFTmUT1lN1WbAGxmg
 CH1O26cz5nTrzdjoqC/b8PpZiT0kO5MKKgiu5S4PRIxW2+RA4H9nq7nztNZ1Y39bDpzwE5Sp
 bDHzd5owmLxMLZAINtCtQuRbSOcMjZlg4zohA9TQP9krGIk+qTR+H4CV22sWldSkVtsoTaA2
 qNeSJhfHQY0TyQvFbqRsSNIe2gTDzzEQ8itsmdHHE/yzhcCVvlUzXhAT6pIN0OT+cdsTTfif
 MIcDboys92auTuJ7U+4jWF1+WUaJ8gDL69ThAsu7mGDBbm80P3vvUZ4fQM14NkxOnuGRrJxO
 qjWNJ2ZUxgyHAh5TCxMLKWZoL5hpnvx3dF3Ti9HW2dsUUWICSQARAQABtDJQaGlsaXBwZSBN
 YXRoaWV1LURhdWTDqSAoUGhpbCkgPHBoaWxtZEByZWRoYXQuY29tPokCVQQTAQgAPwIbDwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4AWIQSJweePYB7obIZ0lcuio/1u3q3A3gUCXsfWwAUJ
 KtymWgAKCRCio/1u3q3A3ircD/9Vjh3aFNJ3uF3hddeoFg1H038wZr/xi8/rX27M1Vj2j9VH
 0B8Olp4KUQw/hyO6kUxqkoojmzRpmzvlpZ0cUiZJo2bQIWnvScyHxFCv33kHe+YEIqoJlaQc
 JfKYlbCoubz+02E2A6bFD9+BvCY0LBbEj5POwyKGiDMjHKCGuzSuDRbCn0Mz4kCa7nFMF5Jv
 piC+JemRdiBd6102ThqgIsyGEBXuf1sy0QIVyXgaqr9O2b/0VoXpQId7yY7OJuYYxs7kQoXI
 6WzSMpmuXGkmfxOgbc/L6YbzB0JOriX0iRClxu4dEUg8Bs2pNnr6huY2Ft+qb41RzCJvvMyu
 gS32LfN0bTZ6Qm2A8ayMtUQgnwZDSO23OKgQWZVglGliY3ezHZ6lVwC24Vjkmq/2yBSLakZE
 6DZUjZzCW1nvtRK05ebyK6tofRsx8xB8pL/kcBb9nCuh70aLR+5cmE41X4O+MVJbwfP5s/RW
 9BFSL3qgXuXso/3XuWTQjJJGgKhB6xXjMmb1J4q/h5IuVV4juv1Fem9sfmyrh+Wi5V1IzKI7
 RPJ3KVb937eBgSENk53P0gUorwzUcO+ASEo3Z1cBKkJSPigDbeEjVfXQMzNt0oDRzpQqH2vp
 apo2jHnidWt8BsckuWZpxcZ9+/9obQ55DyVQHGiTN39hkETy3Emdnz1JVHTU0Q==
Message-ID: <14f844ce-b09a-6d87-5003-155f745c79a3@amsat.org>
Date: Mon, 20 Jul 2020 11:49:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xe_COP0sLCZnjnRYgA13W73BPnw9g0B5u6DK4++MDy5-A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 QEMU Developers <qemu-devel@nongnu.org>, CS20 KFTing <kfting@nuvoton.com>,
 qemu-arm <qemu-arm@nongnu.org>, Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/20/20 10:22 AM, Joel Stanley wrote:
> On Fri, 17 Jul 2020 at 12:33, Cédric Le Goater <clg@kaod.org> wrote:
>>
>> On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
>>> This adds two acceptance tests for the quanta-gsj machine.
>>>
>>> One test downloads a lightly patched openbmc flash image from github and
>>> verifies that it boots all the way to the login prompt.
>>>
>>> The other test downloads a kernel, initrd and dtb built from the same
>>> openbmc source and verifies that the kernel detects all CPUs and boots
>>> to the point where it can't find the root filesystem (because we have no
>>> flash image in this case).
>>>
>>> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
>>
>> It looks good but I am not sure it's a good idea to have tests
>> point to URLs like :
>>
>> https://github.com/hskinnemoen/openbmc/releases/download/20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz
>>
>> Philippe, Peter, is that OK ?

FWIW I'm happier having something to test than anything.
If Havard destroys his repo, we can remove/move the test.
However ...

>>
>>
>> If so, Joel, Andrew, could we host FW images on the OpenBMC github ?
>> and do the same for Aspeed.
> 
> Yeah, we can do that if it would be preferred.

... this is certainly better.

> 
> Nice work on adding a test Havard. I have been meaning to do the same
> for the aspeed machines for a while.
> 
>>
>> Thanks,
>>
>> C.
>>
>>> ---
>>>  tests/acceptance/boot_linux_console.py | 65 ++++++++++++++++++++++++++
>>>  1 file changed, 65 insertions(+)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>>> index 73cc69c499..1d82fc7ff8 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -569,6 +569,71 @@ class BootLinuxConsole(LinuxKernelTest):
>>>                                                  'sda')
>>>          # cubieboard's reboot is not functioning; omit reboot test.
>>>
>>> +    def test_arm_quanta_gsj(self):
>>> +        """
>>> +        :avocado: tags=arch:arm
>>> +        :avocado: tags=machine:quanta-gsj
>>> +        """
>>> +        # 25 MiB compressed, 32 MiB uncompressed.
>>> +        image_url = (
>>> +                'https://github.com/hskinnemoen/openbmc/releases/download/'
>>> +                '20200711-gsj-qemu-0/obmc-phosphor-image-gsj.static.mtd.gz')
>>> +        image_hash = '14895e634923345cb5c8776037ff7876df96f6b1'
>>> +        image_path_gz = self.fetch_asset(image_url, asset_hash=image_hash)

This path is in the Avocado assets cache.

>>> +        image_name = os.path.splitext(os.path.basename(image_path_gz))[0]

You take the basename, so it is not in the Avocado assets cache
but in the local workdir, good. As this is a temporary file name,
we don't care much if the name matches. This works too (and the
reviewer doesn't have to wonder what is the path name):

             image_name = "obmc.mtd"

I'm fine either ways, thanks for adding a pair of tests!

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>> +        image_path = os.path.join(self.workdir, image_name)
>>> +        archive.gzip_uncompress(image_path_gz, image_path)
>>> +
>>> +        self.vm.set_console()
>>> +        drive_args = 'file=' + image_path + ',if=mtd,bus=0,unit=0'
>>> +        self.vm.add_args('-drive', drive_args)
>>> +        self.vm.launch()
>>> +
>>> +        self.wait_for_console_pattern('> BootBlock by Nuvoton')
>>> +        self.wait_for_console_pattern('>Device: Poleg BMC NPCM730')
>>> +        self.wait_for_console_pattern('>Skip DDR init.')
>>> +        self.wait_for_console_pattern('U-Boot ')
>>> +        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
>>> +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
>>> +        self.wait_for_console_pattern('OpenBMC Project Reference Distro')
>>> +        self.wait_for_console_pattern('gsj login:')
>>> +
>>> +    def test_arm_quanta_gsj_initrd(self):
>>> +        """
>>> +        :avocado: tags=arch:arm
>>> +        :avocado: tags=machine:quanta-gsj
>>> +        """
>>> +        initrd_url = (
>>> +                'https://github.com/hskinnemoen/openbmc/releases/download/'
>>> +                '20200711-gsj-qemu-0/obmc-phosphor-initramfs-gsj.cpio.xz')
>>> +        initrd_hash = '98fefe5d7e56727b1eb17d5c00311b1b5c945300'
>>> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>>> +        kernel_url = (
>>> +                'https://github.com/hskinnemoen/openbmc/releases/download/'
>>> +                '20200711-gsj-qemu-0/uImage-gsj.bin')
>>> +        kernel_hash = 'fa67b2f141d56d39b3c54305c0e8a899c99eb2c7'
>>> +        kernel_path = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>>> +        dtb_url = (
>>> +                'https://github.com/hskinnemoen/openbmc/releases/download/'
>>> +                '20200711-gsj-qemu-0/nuvoton-npcm730-gsj.dtb')
>>> +        dtb_hash = '18315f7006d7b688d8312d5c727eecd819aa36a4'
>>> +        dtb_path = self.fetch_asset(dtb_url, asset_hash=dtb_hash)
>>> +
>>> +        self.vm.set_console()
>>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>>> +                               'console=ttyS0,115200n8 '
>>> +                               'earlycon=uart8250,mmio32,0xf0001000')
>>> +        self.vm.add_args('-kernel', kernel_path,
>>> +                         '-initrd', initrd_path,
>>> +                         '-dtb', dtb_path,
>>> +                         '-append', kernel_command_line)
>>> +        self.vm.launch()
>>> +
>>> +        self.wait_for_console_pattern('Booting Linux on physical CPU 0x0')
>>> +        self.wait_for_console_pattern('CPU1: thread -1, cpu 1, socket 0')
>>> +        self.wait_for_console_pattern(
>>> +                'Give root password for system maintenance')
>>> +
>>>      def test_arm_orangepi(self):
>>>          """
>>>          :avocado: tags=arch:arm
>>>
>>
> 


