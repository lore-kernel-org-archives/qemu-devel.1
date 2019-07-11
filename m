Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182CCC74A35
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:55:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCBF621537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 14:55:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBF621537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlaTQ-0007wH-2E
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 10:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41780)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlaSu-0007Rh-9K
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:54:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlaSs-0008No-VW
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:54:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlaSs-0008N1-Of
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 10:54:30 -0400
Received: by mail-wm1-f67.google.com with SMTP id g67so1891104wme.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 07:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/6MeRYrRwqCtEhEaB9G/1CulgLNtUGvQmksO0T+gDvU=;
 b=HYUAQId+x+fM9WcVpBsicQnqxwFnBNHVYeL/FhUtd+ZOAVETBQ8jrIyXFJ0yvV2bit
 h6bRFmki4dMS8UaxJNlT7aFZLyM5pQZ6RkM5wU91464v+35TUppqsISTH7ALPfRI2B6q
 VbLyBUkQrCIhFVsnS1BQhm16sb6d6OJR0Yk5egmrmyADs+fZNs0rO9HOMXeB03EZpeeT
 QGYPFBoO3LlTOJa8x7usm8MMhaqqDCvaRhkDhU/iFrbDu03rIfsIltJQueWcxqrMDYEs
 /biSenuw1vdUFs4XAg6/SDBx226VSP7ANRPCOBf4X0PYiqKg0upTBqy9yNmKH7ZxHQ5L
 UHEg==
X-Gm-Message-State: APjAAAVBkm/89uv06LGzyFKbPce9LVJaIJ39bToV65mdJp76Y1UgJw6B
 TK01VUBgWU14c25og9xlUePV1w==
X-Google-Smtp-Source: APXvYqx/D0Ft7Vf3CoOfC6h/1Ov2SRupSDr6w6ECrWCgEDvHQppwhE/z9gRaeQ3rGNIATH9J9ifB9w==
X-Received: by 2002:a1c:a101:: with SMTP id k1mr4796831wme.98.1562856869187;
 Thu, 11 Jul 2019 07:54:29 -0700 (PDT)
Received: from [192.168.1.103] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id j33sm10014882wre.42.2019.07.11.07.54.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 07:54:28 -0700 (PDT)
To: Alistair Francis <alistair23@gmail.com>
References: <1562781026-27570-1-git-send-email-chihmin.chao@sifive.com>
 <57c27698-c9ee-72f9-7074-0c0eee2ab275@redhat.com>
 <CAKmqyKNbPs9d3_BCkB2=E21TgWdTeTd5K=cZxQhAoCs3TZJkqA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <ebb45913-aaa5-1198-56eb-df98671b2bdb@redhat.com>
Date: Thu, 11 Jul 2019 16:54:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNbPs9d3_BCkB2=E21TgWdTeTd5K=cZxQhAoCs3TZJkqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH] tests/boot_linux_console: add a test for
 riscv64 + virt
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Chih-Min Chao <chihmin.chao@sifive.com>, Caio Carrara <ccarrara@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 4:43 PM, Alistair Francis wrote:
> On Thu, Jul 11, 2019 at 6:56 AM Philippe Mathieu-Daudé
> <philmd@redhat.com> wrote:
>>
>> Hi Chih-Min,
>>
>> On 7/10/19 7:50 PM, Chih-Min Chao wrote:
>>> Similar to the mips + malta test, it boots a Linux kernel on a virt
>>> board and verify the serial is working.  Also, it relies on the serial
>>> device set by the machine itself.
>>
>> Good idea!
>>
>>>
>>> If riscv64 is a target being built, "make check-acceptance" will
>>> automatically include this test by the use of the "arch:riscv64" tags.
>>>
>>> Alternatively, this test can be run using:
>>>
>>>   $ avocado run -t arch:riscv64 tests/acceptance
>>>
>>> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>
>>> ---
>>>  tests/acceptance/boot_linux_console.py | 40 ++++++++++++++++++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>
>>> diff --git a/tests/acceptance/boot_linux_console.py b/tests/acceptance/boot_linux_console.py
>>> index 3215950..bbc6b06 100644
>>> --- a/tests/acceptance/boot_linux_console.py
>>> +++ b/tests/acceptance/boot_linux_console.py
>>> @@ -354,3 +354,43 @@ class BootLinuxConsole(Test):
>>>          self.vm.launch()
>>>          console_pattern = 'Kernel command line: %s' % kernel_command_line
>>>          self.wait_for_console_pattern(console_pattern)
>>> +
>>> +    def test_riscv64_virt(self):
>>> +        """
>>> +        :avocado: tags=arch:riscv64
>>> +        :avocado: tags=machine:virt
>>> +        """
>>> +
>>> +        kernel_url = ('https://github.com/chihminchao/test-binary/raw/'
>>> +                      '0b7787305d9e40815c05a805266cc74ff356239e/qemu/riscv64/'
>>> +                      'bbl_w_kernel.gz')
>>
>> I recommend you to extract fw_jump.elf from [1] and
>> vmlinux-4.19.0-5-riscv64 from [2] with the extract_from_deb() helper.
>>
>> [1] https://packages.debian.org/sid/all/opensbi
>> [2] https://packages.debian.org/sid/linux-image-4.19.0-5-riscv64
> 
> This will works as well if you don't want to bother building the
> images yourself. Ideally we could use a newer kernel then 4.19 but for
> an acceptance test it probably doesn't matter much.

This one is available in 'experimental', in case you want to test it
too, but I'd rather use some stable channel for testing:

https://packages.debian.org/experimental/linux-image-5.0.0-trunk-riscv64

> This way Debain has done all the licence work for you as well :)

And all the building work ;)

> 
> Alistair
> 
>>
>>> +        kernel_hash = 'c7f6cc7967975ad42dc61ee0535db01c9cbd0968'
>>> +        kernel_path_gz = self.fetch_asset(kernel_url, asset_hash=kernel_hash)
>>> +        kernel_path = self.workdir + "bbl_w_kernel"
>>> +
>>> +        with gzip.open(kernel_path_gz, 'rb') as f_in:
>>> +            with open(kernel_path, 'wb') as f_out:
>>> +                shutil.copyfileobj(f_in, f_out)
>>> +
>>> +        initrd_url = ('https://github.com/groeck/linux-build-test/raw/'
>>> +                      '8584a59ed9e5eb5ee7ca91f6d74bbb06619205b8/rootfs/'
>>> +                      'riscv64/rootfs.cpio.gz')
>>> +        initrd_hash = 'f4867d263754961b6f626cdcdc0cb334c47e3b49'
>>> +        initrd_path = self.fetch_asset(initrd_url, asset_hash=initrd_hash)
>>> +
>>> +        self.vm.set_machine('virt')
>>> +        self.vm.set_console()
>>> +        kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE
>>> +                               + 'console=ttyS0 noreboot')
>>> +        self.vm.add_args('-kernel', kernel_path,
>>> +                         '-initrd', initrd_path,
>>> +                         '-append', kernel_command_line)
>>
>> You might want to use '-no-reboot' here too.
>>
>>> +        self.vm.launch()
>>> +        self.wait_for_console_pattern('Boot successful.')
>>> +
>>> +        self.exec_command_and_wait_for_pattern('cat /proc/cpuinfo',
>>> +                                               'isa')
>>> +        self.exec_command_and_wait_for_pattern('uname -a',
>>> +                                               'sifive')
>>> +        self.exec_command_and_wait_for_pattern('reboot',
>>> +                                               'reboot: Restarting system')
>>
>> Regards,
>>
>> Phil.
>>

