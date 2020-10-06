Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7085DC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 06:59:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A11B120796
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 06:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d4/YkQ6f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A11B120796
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPgwN-00052C-CF
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 02:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33018)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kPgvf-0004Z7-Em; Tue, 06 Oct 2020 02:58:31 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:39348)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kPgvd-0005yL-7f; Tue, 06 Oct 2020 02:58:31 -0400
Received: by mail-ej1-x636.google.com with SMTP id lw21so12029209ejb.6;
 Mon, 05 Oct 2020 23:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=gSNo/iVKw0b/U1AJxJHVjcbsRGqawrAy4cj6DiNCzWA=;
 b=d4/YkQ6fvVjozjZQxqSgHoH47+UOZ+6MIIl3i0jqccl+gWYT2JcY5M7HW/bZVdH5rr
 yMhfbD7iMOxptWK6yjeT/1PYXc/kDBVnp3axbrs6CxrgNX7TGVGd51R1t6F4OIhJQLD3
 HJU3xjUad1IPFsw+evZv/jz5Ck6Vg+pHJhAln4YCg5n2JWlHi3OrUe1nLVGHR0fvEgYt
 8HyuGWj6FTYbpmbE755APl5gt1VQK99XQdq6knQukor6L6CetVVmfBwkMiVwdFBUGmhf
 5wPKbhROIzVoArtcXCf2enZ+b6Lf3OOa2n8qZ+CEjsSWIndNja2CV5MuqDBlHnxeFWr4
 rS4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=gSNo/iVKw0b/U1AJxJHVjcbsRGqawrAy4cj6DiNCzWA=;
 b=KZao+lp2KuFhNgCJiKBVTN5WCaKrvVTzJqoZn2Xxp3lIUO1g0fLIAANw/z4czYBYVI
 ttJDYsL5HdmL4z+OCAuNHfCXzvtv+/RkeVL/OqkgfkFFThQ4NsDARSO2ytYLmDJ3gKLS
 ke/nDGvHLczal8Ua7yszSrg/Z9FtJwcINIudPdfR+7FACNvcn+8mx/dAnCsWbsBnbAsr
 IEmjHvRBl3Fsf9nRQuaQPKmgJfdJ81vhCJtoUPKMIgTcWcseka8m5KBfLfbtkNO+/XCK
 6IlMN7j0X8xc31G+tNfmktQxx29vqIwHa9PpcMDW732yS9tNqRbO8mupaJNFluayzYFp
 0gWA==
X-Gm-Message-State: AOAM530uWdC60n9oQZPcOV3rw6gnkWPn5l+2Gwwu8UrBhBSMQ3KMu/nr
 SgUzH02SsAazu49jqpolL5Y=
X-Google-Smtp-Source: ABdhPJyvd7jgQ1rTfMhMkRTAlUXQmGwps9faPyffEBXg55eqVOLLLvCpq7ed0Eiuhqk3W1jMziSFaA==
X-Received: by 2002:a17:906:515:: with SMTP id
 j21mr3571564eja.105.1601967504903; 
 Mon, 05 Oct 2020 23:58:24 -0700 (PDT)
Received: from [10.16.23.138] ([193.16.224.10])
 by smtp.gmail.com with ESMTPSA id e4sm1647990edk.38.2020.10.05.23.58.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 23:58:23 -0700 (PDT)
Subject: Re: Emulate Rpi with QEMU fails
To: Paul Zimmerman <pauldzim@gmail.com>
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org> <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
 <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
From: Thomas Schneider <74cmonty@gmail.com>
Message-ID: <d8d79b4c-aeb4-4f07-7110-91d8d1afd701@gmail.com>
Date: Tue, 6 Oct 2020 08:58:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=74cmonty@gmail.com; helo=mail-ej1-x636.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Paul,

many thanks for sharing this info.

Can you confirm that the emulated RPi with your command will use 
"internal QEMU" network, means the client cannot be accessed from any 
other device in LAN?
If yes, what is required to setup a TAP connected to host's network bridge?

Regards
Thomas

Am 06.10.2020 um 00:08 schrieb Paul Zimmerman:
> If you can upgrade to Qemu 5.1 or newer, you should be able to use the
> builtin raspi2 or raspi3 emulation directly. Version 5.1 adds support for the
> USB controller on the Pi.
>
> There is no limitation on the amount of memory you can use with this
> method, and the networking should work.
>
> Here is the command line I use to run the Raspbian image
> 2019-09-26-raspbian-buster. I extracted bcm2709-rpi-2-b and
> kernel7.img from the FAT partition inside the image file.
>
> qemu-system-arm -M raspi2 -drive
> file=bootpi/2019-09-26-raspbian-buster.img,format=raw,if=sd -dtb
> bcm2709-rpi-2-b.dtb -kernel kernel7.img -append 'rw
> earlycon=pl011,0x3f201000 console=ttyAMA0 loglevel=8
> root=/dev/mmcblk0p2 fsck.repair=yes net.ifnames=0 rootwait memtest=1
> dwc_otg.fiq_fsm_enable=0' -serial stdio -no-reboot -netdev
> user,id=net0 -usb -device usb-kbd -device usb-tablet -device
> usb-net,netdev=net0
>
> Hope this helps.
>
> On Mon, Oct 5, 2020 at 3:51 AM Thomas Schneider <74cmonty@gmail.com> wrote:
>> Hello,
>>
>> thanks for your replies.
>>
>> I must admit that I don't fully understand your analysis.
>> However you made some conclusions that are correct.
>>
>> In fact I have found a Github repo
>> <https://github.com/dhruvvyas90/qemu-rpi-kernel> where a specific kernel
>> and versatile-pb are provided + instructions for lauching the emulation
>> with the original RPi image file:
>> $ qemu-system-arm \
>>     -M versatilepb \
>>     -cpu arm1176 \
>>     -m 256 \
>>     -drive
>> "file=/.../2020-05-27-raspios-buster-lite-armhf.img,if=none,index=0,media=disk,format=raw,id=disk0"
>> \
>>     -device
>> "virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off" \
>>     -net "user,hostfwd=tcp::5022-:22" \
>>     -dtb /.../versatile-pb-buster-5.4.51.dtb \
>>     -kernel /.../kernel-qemu-5.4.51-buster \
>>     -append 'root=/dev/vda2 panic=1' \
>>     -no-reboot
>>
>> This means it is more recent than the Raspberry Pi Geek article, and the
>> emulation works.
>> But I'm not sure if this usable considering the added models -M raspi2
>> and -M raspi3.
>>
>> Can you please advise how to proceed?
>>
>> In addition I would like to know if there's a memory limitation using
>> models -M raspi2 and -M raspi3?
>> To my understanding there's a limitation to 256MB using -M versatilepb.
>> If yes, I consider to another raw image located on host's temporary
>> filesystem and use this a swap in the client.
>>
>> And how can I make use of a client network device that is based on
>> host's tap device connected to a network bridge?
>>
>> THX
>>
>>
>> Am 05.10.2020 um 11:40 schrieb Alex Bennée:
>>> Peter Maydell <peter.maydell@linaro.org> writes:
>>>
>>>> On Sun, 4 Oct 2020 at 18:44, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>> Thomas <74cmonty@gmail.com> writes:
>>>>>> I'm trying to emulate Rpi with QEMU.
>>>>>> I found
>>>>>> [url=1]this[/url]
>>>>>> arcticle in Raspberry Pi Geek documenting the steps including persistent
>>>>>> storage on host.
>>>>>>
>>>>>> However when starting the emulation with command
>>>>>> qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -serial stdio -hda
>>>>>> 2020-08-20-raspios-buster-armhf-lite.img -net
>>>>>> "user,hostfwd=tcp::5022-:22" -dtb versatile-pb-buster.dtb -kernel
>>>>>> kernel-qemu-5.4.51-buster -append "root=/dev/sda2 rootfstype=ext4 rw
>>>>>> panic=1" -no-reboot
>>>>> Let's start with the fact you are using a versatilepb machine type with
>>>>> a versatilepb dtb and not the rasppi model.
>>>> Given the name of the kernel image, this probably actually *is*
>>>> built for versatilepb, or it wouldn't have got as far as failing
>>>> to mount the root partition. There seems to be a lot of confusion
>>>> in the raspberry pi community about the difference between
>>>> running the raspi userspace plus a for-versatilepb kernel
>>>> versus running a full raspi setup.
>>> Ahh your German is considerably better than mine ;-) Looking more
>>> closely at the blog it seems to be predicated on extracting a Raspbian
>>> kernel which at least stands a fighting chance of being a multi_config
>>> kernel - like the buster above.
>>>
>>> I can see why these sorts of shenanigans used to be pulled when there
>>> where no RaspPi models although if all you want to do is run an ARM user
>>> space what's wrong with using linux-user for this sort of thing?
>>>
>>>> Anyway, failing to mount the rootfs and not listing any
>>>> sda devices is not a problem with the fstab, because the system
>>>> hasn't got as far as being able to mount the filesystem with a
>>>> fstab on it yet. One possibility is that the kernel is
>>>> missing the device drivers for either PCI or for the SCSI
>>>> controller that gets plugged in to versatilepb by default.
>>>>
>>>> My guess at the cause is that you're trying to boot a Linux 5.something
>>>> kernel and you've run into the issue described in this thread:
>>>> https://lists.gnu.org/archive/html/qemu-discuss/2020-09/msg00023.html
>>>> where the Linux 5.x sym53c8xx scsi driver is not compatible with QEMU's
>>>> emulation of that device. If that's the case then you should see
>>>> earlier in the kernel boot log error messages similar to the ones
>>>> that Roger reported. The fix would be either to use an older
>>>> kernel, or to change the QEMU commandline to use a different
>>>> SCSI controller (or to use a virtio block device).
>>> Do we have any documentation for the RaspPi models? The acceptance tests
>>> look like they support the inbuilt MMC/SD controller device:
>>>
>>>           kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>>>                                  serial_kernel_cmdline[uart_id] +
>>>                                  ' root=/dev/mmcblk0p2 rootwait ' +
>>>                                  'dwc_otg.fiq_fsm_enable=0')
>>>
>>> It would be useful to fill the hole in the documentation so gently steer
>>> people away from these hybrid franken-machine approaches.
>>>
>>>> thanks
>>>> -- PMM
>>


