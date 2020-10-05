Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12110C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:42:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4742080C
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 09:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EUodaOIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4742080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPN0T-0007eX-EA
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 05:42:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPMzE-0006Zb-QF
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:40:53 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPMzB-00013n-S4
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 05:40:52 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so7879241wmj.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tfKI/HzUoxNuqEabZNuPJmFJV3WtrxIqB11F1W0JZLA=;
 b=EUodaOIifx5ENwe0Dr8itcNv/5AtH5EoUIt9GMdhhD0Q4xFRlEulVKZpghbBQfWn4F
 0FR/7bzhCzYiSX7DVl2Zha2Ghbzl6GaWGyMCu1zvPWg1LMklVtCejLcvGCqetEJj2KJ+
 vA+t0+oVGqybylzQXeuPg+rF23gNNiHZdDlzssSFntXS+a5kDdXtf0EENTfieHWfC7P/
 bG3o+8H6qitE0kjOgdkTaIgmwJxra8IOCM6D7IHUMoUfuza31nGw+NZhTnnyKOaKuiYK
 4KkAZfNm3Dn89YRk3koxoFu5E0ze0Xcmu2SwJgUHTSAVx24WClmHrj0b/0FRc28aiaUk
 9VKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tfKI/HzUoxNuqEabZNuPJmFJV3WtrxIqB11F1W0JZLA=;
 b=eXskGKbRl4uy7d+YIzsNhDUdB4kMKCnlyM4Y5TE4UTNr4wmvlMLNiYtalN8ch12rif
 1wSQnCLbCnt6CKiKOH4iLFuOuBbFsHD6/VZ5f1kqjYcVxK7EJtgQc/gmGTSLrkNmV5Fx
 0JBDWgzet657fNFEnU0BrvrqbO2UOKsI1Y8cBZeWMpHXokXj4QQ8fc2uX0nVaiD6VarI
 Ddscdt6tzYaadaoRk2yBOoL5sFfTtasHBYu6PxHzZs8uf4yEpJd9VQbARaVNLdO97Qdp
 kFUF2kKbBbQH5tCEYlKart0c/AlVL5aaGoMVi8WcZnwmKcrk2KZqyPT4i/hAZFo7jEu0
 6WqQ==
X-Gm-Message-State: AOAM531PE+Yeg/unXEvXYEK0DSWvI8ry3IoJoia+m8E/Pq7248fns7Xu
 SLkHzkpE59rnJyL5aaUmKrypIw==
X-Google-Smtp-Source: ABdhPJyJhFENFEGJI4xQto3MTIFpyhtDG9aIdYmUYHFUwgockw/7XGW7Q4E5+rRucODw5oopOXy3Gw==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr17242631wmq.168.1601890847267; 
 Mon, 05 Oct 2020 02:40:47 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t202sm12801892wmt.14.2020.10.05.02.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 02:40:46 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 69E351FF7E;
 Mon,  5 Oct 2020 10:40:45 +0100 (BST)
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Emulate Rpi with QEMU fails
In-reply-to: <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
Date: Mon, 05 Oct 2020 10:40:45 +0100
Message-ID: <875z7p3t9e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Thomas <74cmonty@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Sun, 4 Oct 2020 at 18:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> Thomas <74cmonty@gmail.com> writes:
>> > I'm trying to emulate Rpi with QEMU.
>> > I found
>> > [url=3D1]this[/url]
>> > arcticle in Raspberry Pi Geek documenting the steps including persiste=
nt
>> > storage on host.
>> >
>> > However when starting the emulation with command
>> > qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -serial stdio -hda
>> > 2020-08-20-raspios-buster-armhf-lite.img -net
>> > "user,hostfwd=3Dtcp::5022-:22" -dtb versatile-pb-buster.dtb -kernel
>> > kernel-qemu-5.4.51-buster -append "root=3D/dev/sda2 rootfstype=3Dext4 =
rw
>> > panic=3D1" -no-reboot
>>
>> Let's start with the fact you are using a versatilepb machine type with
>> a versatilepb dtb and not the rasppi model.
>
> Given the name of the kernel image, this probably actually *is*
> built for versatilepb, or it wouldn't have got as far as failing
> to mount the root partition. There seems to be a lot of confusion
> in the raspberry pi community about the difference between
> running the raspi userspace plus a for-versatilepb kernel
> versus running a full raspi setup.

Ahh your German is considerably better than mine ;-) Looking more
closely at the blog it seems to be predicated on extracting a Raspbian
kernel which at least stands a fighting chance of being a multi_config
kernel - like the buster above.

I can see why these sorts of shenanigans used to be pulled when there
where no RaspPi models although if all you want to do is run an ARM user
space what's wrong with using linux-user for this sort of thing?

> Anyway, failing to mount the rootfs and not listing any
> sda devices is not a problem with the fstab, because the system
> hasn't got as far as being able to mount the filesystem with a
> fstab on it yet. One possibility is that the kernel is
> missing the device drivers for either PCI or for the SCSI
> controller that gets plugged in to versatilepb by default.
>
> My guess at the cause is that you're trying to boot a Linux 5.something
> kernel and you've run into the issue described in this thread:
> https://lists.gnu.org/archive/html/qemu-discuss/2020-09/msg00023.html
> where the Linux 5.x sym53c8xx scsi driver is not compatible with QEMU's
> emulation of that device. If that's the case then you should see
> earlier in the kernel boot log error messages similar to the ones
> that Roger reported. The fix would be either to use an older
> kernel, or to change the QEMU commandline to use a different
> SCSI controller (or to use a virtio block device).

Do we have any documentation for the RaspPi models? The acceptance tests
look like they support the inbuilt MMC/SD controller device:

        kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
                               serial_kernel_cmdline[uart_id] +
                               ' root=3D/dev/mmcblk0p2 rootwait ' +
                               'dwc_otg.fiq_fsm_enable=3D0')

It would be useful to fill the hole in the documentation so gently steer
people away from these hybrid franken-machine approaches.

>
> thanks
> -- PMM


--=20
Alex Benn=C3=A9e

