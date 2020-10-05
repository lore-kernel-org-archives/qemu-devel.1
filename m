Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FB3C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:52:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A552075A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLI0v3WD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A552075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPO6I-0000lt-Ry
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kPO5Z-0000EG-Pj; Mon, 05 Oct 2020 06:51:29 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <74cmonty@gmail.com>)
 id 1kPO5X-0001XG-50; Mon, 05 Oct 2020 06:51:29 -0400
Received: by mail-ej1-x641.google.com with SMTP id qp15so11225519ejb.3;
 Mon, 05 Oct 2020 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=zlomqrOhtPoc70L+vuBIPNvjCF/pYjLzg+HplJ0eKC0=;
 b=BLI0v3WDQskJrV4IrM0ybWiJfV3gQtMGNnVV1D9T2Bz6nSKIRXriLr9WF7J/DS6ViG
 zkYqkNc78eD8OYKMU5zfk1nQX0JLjBw4thPvkN2KgYtUQMCDZ2k6PlozPYz8Ebu7UR/1
 yVMihR0RvFfr21kocl7zoS4jkGS50fPAoV/Fs2HSsV6QkNKBxMMKtwticWCNY2miResK
 MX7h12VkUQ2DWRPwUMCCoFXnVjoOhTRba76kPiE5KX7sWwtLCifCb6lKIs8O5G0hFzL3
 XgdyvwKZ0hX0IPI3BN0kh+6WAcUMyfxerqcjB3EHeCnn2vQOSgmr1Wi7msC6Q0J/11II
 f4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=zlomqrOhtPoc70L+vuBIPNvjCF/pYjLzg+HplJ0eKC0=;
 b=VyfRP6NAhWqIRoD9SY26NZjGMSJQPK+Hfd2XPynyj4Wa9MRKF3JnXy2+L5ZfnUfBvE
 6e6+OWBJSvy8qqk1LuJEX0j3UgwmsUO9SN9SduQVDlUaiwWb4dZbSAO+EIbIe9JuonvL
 Qpa5+eqMezddqD6ctjMmPtQZIZVwIRJM9WRXX2aRrAdSxTEgqnPgjQX8zgiVBRV8T28k
 5vrvfWU393b5BQ1Vcv4ucBS4VoRf36oAkWZpKGhipwNUz37g+fcnG8N/I9qVZSjmQ1og
 KpDxJk/H4WF4hskdsPW9ITzeqvqdNP1JBdjWWepb7HvRADcUuedYAci35YEhBoUyxX4H
 KixA==
X-Gm-Message-State: AOAM532flAkpIL7rQvcYPHK9Wp/p/6ZUQsy/da6zwt5VJSeX0HlGID/S
 4xLr0Qchv3IU1q9vwp+l/uA=
X-Google-Smtp-Source: ABdhPJwj9d/4ggZf13j2Iv+gSgLTGnY5Gjk5oF2jPz6ugiIQNa1CFlBC83g/Ubap//vkQc5eFxhAlg==
X-Received: by 2002:a17:906:f14b:: with SMTP id
 gw11mr14663475ejb.41.1601895083880; 
 Mon, 05 Oct 2020 03:51:23 -0700 (PDT)
Received: from [10.16.55.97] ([193.16.224.1])
 by smtp.gmail.com with ESMTPSA id d25sm8344254edq.52.2020.10.05.03.51.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 03:51:23 -0700 (PDT)
Subject: Re: Emulate Rpi with QEMU fails
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org>
From: Thomas Schneider <74cmonty@gmail.com>
Message-ID: <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
Date: Mon, 5 Oct 2020 12:51:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <875z7p3t9e.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=74cmonty@gmail.com; helo=mail-ej1-x641.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

thanks for your replies.

I must admit that I don't fully understand your analysis.
However you made some conclusions that are correct.

In fact I have found a Github repo 
<https://github.com/dhruvvyas90/qemu-rpi-kernel> where a specific kernel 
and versatile-pb are provided + instructions for lauching the emulation 
with the original RPi image file:
$ qemu-system-arm \
   -M versatilepb \
   -cpu arm1176 \
   -m 256 \
   -drive 
"file=/.../2020-05-27-raspios-buster-lite-armhf.img,if=none,index=0,media=disk,format=raw,id=disk0" 
\
   -device 
"virtio-blk-pci,drive=disk0,disable-modern=on,disable-legacy=off" \
   -net "user,hostfwd=tcp::5022-:22" \
   -dtb /.../versatile-pb-buster-5.4.51.dtb \
   -kernel /.../kernel-qemu-5.4.51-buster \
   -append 'root=/dev/vda2 panic=1' \
   -no-reboot

This means it is more recent than the Raspberry Pi Geek article, and the 
emulation works.
But I'm not sure if this usable considering the added models -M raspi2 
and -M raspi3.

Can you please advise how to proceed?

In addition I would like to know if there's a memory limitation using 
models -M raspi2 and -M raspi3?
To my understanding there's a limitation to 256MB using -M versatilepb.
If yes, I consider to another raw image located on host's temporary 
filesystem and use this a swap in the client.

And how can I make use of a client network device that is based on 
host's tap device connected to a network bridge?

THX


Am 05.10.2020 um 11:40 schrieb Alex Bennée:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> On Sun, 4 Oct 2020 at 18:44, Alex Bennée <alex.bennee@linaro.org> wrote:
>>> Thomas <74cmonty@gmail.com> writes:
>>>> I'm trying to emulate Rpi with QEMU.
>>>> I found
>>>> [url=1]this[/url]
>>>> arcticle in Raspberry Pi Geek documenting the steps including persistent
>>>> storage on host.
>>>>
>>>> However when starting the emulation with command
>>>> qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -serial stdio -hda
>>>> 2020-08-20-raspios-buster-armhf-lite.img -net
>>>> "user,hostfwd=tcp::5022-:22" -dtb versatile-pb-buster.dtb -kernel
>>>> kernel-qemu-5.4.51-buster -append "root=/dev/sda2 rootfstype=ext4 rw
>>>> panic=1" -no-reboot
>>> Let's start with the fact you are using a versatilepb machine type with
>>> a versatilepb dtb and not the rasppi model.
>> Given the name of the kernel image, this probably actually *is*
>> built for versatilepb, or it wouldn't have got as far as failing
>> to mount the root partition. There seems to be a lot of confusion
>> in the raspberry pi community about the difference between
>> running the raspi userspace plus a for-versatilepb kernel
>> versus running a full raspi setup.
> Ahh your German is considerably better than mine ;-) Looking more
> closely at the blog it seems to be predicated on extracting a Raspbian
> kernel which at least stands a fighting chance of being a multi_config
> kernel - like the buster above.
>
> I can see why these sorts of shenanigans used to be pulled when there
> where no RaspPi models although if all you want to do is run an ARM user
> space what's wrong with using linux-user for this sort of thing?
>
>> Anyway, failing to mount the rootfs and not listing any
>> sda devices is not a problem with the fstab, because the system
>> hasn't got as far as being able to mount the filesystem with a
>> fstab on it yet. One possibility is that the kernel is
>> missing the device drivers for either PCI or for the SCSI
>> controller that gets plugged in to versatilepb by default.
>>
>> My guess at the cause is that you're trying to boot a Linux 5.something
>> kernel and you've run into the issue described in this thread:
>> https://lists.gnu.org/archive/html/qemu-discuss/2020-09/msg00023.html
>> where the Linux 5.x sym53c8xx scsi driver is not compatible with QEMU's
>> emulation of that device. If that's the case then you should see
>> earlier in the kernel boot log error messages similar to the ones
>> that Roger reported. The fix would be either to use an older
>> kernel, or to change the QEMU commandline to use a different
>> SCSI controller (or to use a virtio block device).
> Do we have any documentation for the RaspPi models? The acceptance tests
> look like they support the inbuilt MMC/SD controller device:
>
>          kernel_command_line = (self.KERNEL_COMMON_COMMAND_LINE +
>                                 serial_kernel_cmdline[uart_id] +
>                                 ' root=/dev/mmcblk0p2 rootwait ' +
>                                 'dwc_otg.fiq_fsm_enable=0')
>
> It would be useful to fill the hole in the documentation so gently steer
> people away from these hybrid franken-machine approaches.
>
>> thanks
>> -- PMM
>


