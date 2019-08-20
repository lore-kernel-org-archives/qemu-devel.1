Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A44C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EA5020578
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 15:21:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cdQSb8qe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EA5020578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i05x4-00060S-3f
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 11:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groeck7@gmail.com>) id 1i05sT-0002yq-0T
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groeck7@gmail.com>) id 1i05sR-00012V-Mk
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 11:16:52 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44381)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <groeck7@gmail.com>)
 id 1i05sO-0000z8-Nb; Tue, 20 Aug 2019 11:16:48 -0400
Received: by mail-pg1-x543.google.com with SMTP id i18so3420517pgl.11;
 Tue, 20 Aug 2019 08:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=e17mwhOW3dmnfIx7wqPpT4HE7uV21LM/thH5qMz20Uw=;
 b=cdQSb8qePu+ZBOL9YlYlG0HVsa1bi5gkrL5pFQ9eqKBQbkScdY3Xaiam6dp/nABRUB
 hZOKqRD881W51vI+Kudp9GzUlsWi+wb1v3799hYIqr+aFKHXY5NObOd7JHR98Y6jJN3B
 keiCwA35MeJfusrofRGBF6ftkj6lUb+tkIoJrLsFSJnGqF9M8G1EY/J4FXK9mKVKorEg
 V2mx/9yaGcnEtqlQF01rmhj782LQQ5nZhLAVdKY6gTnfHWoyp5QL+rpv2eQpXW8y+sxG
 9059bQdulC43fNMpHmQDjnHdwDfAOEhd3HQGbymx4/gtdJgqwXDQ2+NM/LMjY0WpYHBC
 gxWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=e17mwhOW3dmnfIx7wqPpT4HE7uV21LM/thH5qMz20Uw=;
 b=UbhRB7ctMIe9V3gLhT9xdOepGmAvsQXRYLS1IloQeho2Q61I1ZTJjNp4qoIe7Se8zm
 3Ielk5/IRLab7ieXi2/QuVOz+9SzU01f/DwMGmUbB45BQjjpVP6TcdiOM98d38N11imu
 rQMgLjBoqlyZnjt/b8ZxAPlHCLG3ZwE5MU7WlE4pEzQz1OM8OqZuuzH5RM+r78X9fomz
 21srhnUtgGknbE4tHV9hD15VGbpzPxAsDx51ElxR9hfQv/DykbxRbjejfxIBe7NS5foP
 qrPRWToNgSMm2xuubWcoDDkbGPXHgXGkTKWCnx+lqk3042h5Q6oWw2Tmg6Qj9N2xRvV5
 sX4Q==
X-Gm-Message-State: APjAAAV8QTE/0cvke4P4wjpttDvIlV3+OyKbOmNjN0dZk83kr7Iy5HgU
 0V1zvAE7Rd8svXx/9E/JlGw=
X-Google-Smtp-Source: APXvYqw3P28P+7wOQ0y6QfN21+WCw3pHzaKiZukfZQXIlhGYxP5XWuxavBBG0Gh7HFzQjjDXiA5xRw==
X-Received: by 2002:a17:90a:240e:: with SMTP id h14mr547260pje.9.1566314207499; 
 Tue, 20 Aug 2019 08:16:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 o4sm823069pje.28.2019.08.20.08.16.46
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Aug 2019 08:16:46 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190820123417.27930-1-philmd@redhat.com>
 <3e3fcb30-1e12-eaf4-07a2-47d09aea2511@roeck-us.net>
 <509576fb-6fc1-7812-f73f-bda210c5ce99@redhat.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <485d19bf-e2af-ffbf-8761-ef79700daf42@roeck-us.net>
Date: Tue, 20 Aug 2019 08:16:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <509576fb-6fc1-7812-f73f-bda210c5ce99@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 8:08 AM, Philippe Mathieu-Daudé wrote:
> On 8/20/19 4:31 PM, Guenter Roeck wrote:
>> On 8/20/19 5:34 AM, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> Since there has been some activity on the list asking about
>>> Rasberry PI USB support, I had a look a some previous unfinished
>>> work and rebased it to share, in case it helps hobbyist interested
>>> in improving these machines.
>>>
>>> This series is some proof-of-concept on improving the AUX UART
>>> support. See the commit description for various TODO/questions.
>>>
>>> This can be tested using files documented by Peter Maydell in
>>> his blog post:
>>> https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspberry-pi-3-model/
>>>
>>>
>>> And using the kernel command line arguments suggested by Guenter Roeck:
>>>
>>> qemu-system-aarch64 -M raspi3 -m 1024 \
>>>     -kernel raspi3/bootpart/vmlinuz-4.14.0-3-arm64 \
>>>     -initrd raspi3/bootpart/initrd.img-4.14.0-3-arm64 \
>>>     -dtb raspi3/bootpart/bcm2837-rpi-3-b.dtb \
>>>     -append 'earlycon=uart8250,mmio32,0x3f215040 rdinit=/sbin/init
>>> panic=-1 console=ttyS1,115200' \
>>>     -drive
>>> file=raspi3/2018-01-08-raspberry-pi-3-buster-PREVIEW.img,format=raw,if=sd
>>> \
>>>     -serial null -serial stdio \
>>>     -d unimp,guest_errors -trace bcm283\*
>>
>> [ ... ]
>>
>>> [    3.123313] Unpacking initramfs...
>>>
>>> Here it hangs, even with CPRMAN patch from Guenter:
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-07/msg03153.html
>>>
>>
>> This command line works for me:
>>
>> qemu-system-aarch64 -M raspi3 -kernel arch/arm64/boot/Image -no-reboot \
>>      -nographic -snapshot -smp 4 -m 1G \
>>      -drive file=rootfs.ext2,format=raw,if=sd \
>>      -serial null -serial stdio -monitor none -no-reboot \
>>      --append 'panic=-1 slub_debug=FZPUA root=/dev/mmcblk0 rootwait
>> earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200' \
>>      -dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
>>
>> or, with initrd:
>>
>> qemu-system-aarch64 -M raspi3 -kernel arch/arm64/boot/Image -no-reboot \
>>      -nographic \
>>      -initrd rootfs.cpio \
>>      -m 1G -serial null -serial stdio -monitor none -no-reboot \
>>      --append 'panic=-1 slub_debug=FZPUA rdinit=/sbin/init
>> earlycon=uart8250,mmio32,0x3f215040 console=ttyS1,115200' \
>>      -dtb arch/arm64/boot/dts/broadcom/bcm2837-rpi-3-b.dtb
>>
>> This is with the mainline kernel.
>>
>> I don't see a significant difference to your patch series.
> 

Sorry, I meant ".. difference to the command line you used
to test your patch series".

> Thank you for taking the time to test!
> 
> The biggest difference is the diffstat:
> 
>   hw/char/bcm2835_aux.c         | 211 +++-------------------------------
> 
> The model is now cleaner and easier to maintain.
> 
> The logical differences are noted in 2nd patch, basically:
> 1- not same FIFO length (easily fixable)
> 2- now the model implements more feature than supposed to
> 3- migration
> 
> I'll wait for the different ARM/Migration subsystem review.
> 
> [...]
>> One possibility might be that your initrd has a problem. Can you boot
>> without your patch
>> series, or is it always stuck ?
> 
> I remember it used to work for me back when I wrote it, so it is
> probably an initrd problem. I'll test later and keep you updated.
> 

You could give it a try with the images I use:

https://github.com/groeck/linux-build-test/tree/master/rootfs/arm64

Only caveat is that you'd have to specify "noreboot" as command line
option if you don't want the system to reboot immediately.

Guenter

