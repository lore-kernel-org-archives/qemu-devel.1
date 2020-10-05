Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DD4C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 22:09:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3C102068E
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 22:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1vAemth"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3C102068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPYfb-0002LF-Nh
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 18:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kPYem-0001nY-Jk; Mon, 05 Oct 2020 18:08:32 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:42563)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pauldzim@gmail.com>)
 id 1kPYek-0005GF-F8; Mon, 05 Oct 2020 18:08:32 -0400
Received: by mail-io1-xd42.google.com with SMTP id u6so10879825iow.9;
 Mon, 05 Oct 2020 15:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kElEDkSB/y1n8weFenZdcNF8XtMXgsLU4Kh6hIb6KhE=;
 b=R1vAemthUV9oDEeIt18p0l4JV6tVztg5F6sn2Ne8yfyuKkHYfSgBfUuMuaFD4oMRGT
 DEZZFM5Sy82H6KoaWbjGf2hd/iSzeXd7LkG2coMbqBfWS93cwMqyKDynyhlABZrRGy7A
 vELmLxwg4uEUnsJAbSeIfKzJUgXnTl+A20IY2+iKFSzPQfJ8kFEtBQ1gbeXIPpssZeud
 nv2T4wPMjU4l2nVZut2LeOGqJg8p9GYU3oboy/oY6JIvrB25sJLrlyQIrexrDWEf43Rc
 hb1p4JDzSDcnQHVrQXcg/xhD9V6PUeLZlf+8ZQgLmYSTPdnfDGIWlJyDr89uN0vxEMte
 KWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kElEDkSB/y1n8weFenZdcNF8XtMXgsLU4Kh6hIb6KhE=;
 b=CXThaKGLwIc+L/LgSxWBaisYwlj4jAxMGFlItXlcG2SjiMup/2Bv/JynrDjDmy/4lx
 Vp/PcEGgeNOWkM5VRO8HCvBFg7ejmeWc0UNL9z+pbDkXy4NrA2NJroE8hEtYWf4eJOFl
 YaiQZC/7A15G4k+yTPefFzaK4iD0SbjMw3elHvxHc5cK9kfKFU0MKbET3CH1uvI7ROLu
 w4y++zE2OS9DXNtcP4Lzu2adZxOGYD2WySGfcZvnKKjuIrBS/L3D0Oltzu++up7aZPNS
 DaH4L+FB++y8Lk3hQpzWcI0PmjbN09B7WB1DsOCleFyTaxQRTBlq9iXutpmdWAT/epop
 lq0w==
X-Gm-Message-State: AOAM531W2V2xrR4Nip5ruV2AHJou4jwTHdmBIFFILgwrE8syIDqn7/NV
 jpl12r5vxZY4ZoFJHXxsfi45Dk5/jaBGkd9Ks5c=
X-Google-Smtp-Source: ABdhPJyAcK5k/Z3L/MsVmIqHhVLm/oDJ7g3NCoMd4/FuMTqRrpHuw2hfc7SWaKiSei3jIR7gFYqUYMGf3PUu1Xeb1RA=
X-Received: by 2002:a02:a50c:: with SMTP id e12mr1953982jam.26.1601935708217; 
 Mon, 05 Oct 2020 15:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
 <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
 <875z7p3t9e.fsf@linaro.org> <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
In-Reply-To: <e43be86d-1847-199f-4cbd-2e3bd124d70a@gmail.com>
From: Paul Zimmerman <pauldzim@gmail.com>
Date: Mon, 5 Oct 2020 15:08:01 -0700
Message-ID: <CADBGO794+ZPD=B=dFuA7SC96g3GDJXF1A8j=VP6MeiSw1Sf4oQ@mail.gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
To: Thomas Schneider <74cmonty@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=pauldzim@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If you can upgrade to Qemu 5.1 or newer, you should be able to use the
builtin raspi2 or raspi3 emulation directly. Version 5.1 adds support for t=
he
USB controller on the Pi.

There is no limitation on the amount of memory you can use with this
method, and the networking should work.

Here is the command line I use to run the Raspbian image
2019-09-26-raspbian-buster. I extracted bcm2709-rpi-2-b and
kernel7.img from the FAT partition inside the image file.

qemu-system-arm -M raspi2 -drive
file=3Dbootpi/2019-09-26-raspbian-buster.img,format=3Draw,if=3Dsd -dtb
bcm2709-rpi-2-b.dtb -kernel kernel7.img -append 'rw
earlycon=3Dpl011,0x3f201000 console=3DttyAMA0 loglevel=3D8
root=3D/dev/mmcblk0p2 fsck.repair=3Dyes net.ifnames=3D0 rootwait memtest=3D=
1
dwc_otg.fiq_fsm_enable=3D0' -serial stdio -no-reboot -netdev
user,id=3Dnet0 -usb -device usb-kbd -device usb-tablet -device
usb-net,netdev=3Dnet0

Hope this helps.

On Mon, Oct 5, 2020 at 3:51 AM Thomas Schneider <74cmonty@gmail.com> wrote:
>
> Hello,
>
> thanks for your replies.
>
> I must admit that I don't fully understand your analysis.
> However you made some conclusions that are correct.
>
> In fact I have found a Github repo
> <https://github.com/dhruvvyas90/qemu-rpi-kernel> where a specific kernel
> and versatile-pb are provided + instructions for lauching the emulation
> with the original RPi image file:
> $ qemu-system-arm \
>    -M versatilepb \
>    -cpu arm1176 \
>    -m 256 \
>    -drive
> "file=3D/.../2020-05-27-raspios-buster-lite-armhf.img,if=3Dnone,index=3D0=
,media=3Ddisk,format=3Draw,id=3Ddisk0"
> \
>    -device
> "virtio-blk-pci,drive=3Ddisk0,disable-modern=3Don,disable-legacy=3Doff" \
>    -net "user,hostfwd=3Dtcp::5022-:22" \
>    -dtb /.../versatile-pb-buster-5.4.51.dtb \
>    -kernel /.../kernel-qemu-5.4.51-buster \
>    -append 'root=3D/dev/vda2 panic=3D1' \
>    -no-reboot
>
> This means it is more recent than the Raspberry Pi Geek article, and the
> emulation works.
> But I'm not sure if this usable considering the added models -M raspi2
> and -M raspi3.
>
> Can you please advise how to proceed?
>
> In addition I would like to know if there's a memory limitation using
> models -M raspi2 and -M raspi3?
> To my understanding there's a limitation to 256MB using -M versatilepb.
> If yes, I consider to another raw image located on host's temporary
> filesystem and use this a swap in the client.
>
> And how can I make use of a client network device that is based on
> host's tap device connected to a network bridge?
>
> THX
>
>
> Am 05.10.2020 um 11:40 schrieb Alex Benn=C3=A9e:
> > Peter Maydell <peter.maydell@linaro.org> writes:
> >
> >> On Sun, 4 Oct 2020 at 18:44, Alex Benn=C3=A9e <alex.bennee@linaro.org>=
 wrote:
> >>> Thomas <74cmonty@gmail.com> writes:
> >>>> I'm trying to emulate Rpi with QEMU.
> >>>> I found
> >>>> [url=3D1]this[/url]
> >>>> arcticle in Raspberry Pi Geek documenting the steps including persis=
tent
> >>>> storage on host.
> >>>>
> >>>> However when starting the emulation with command
> >>>> qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -serial stdio -hd=
a
> >>>> 2020-08-20-raspios-buster-armhf-lite.img -net
> >>>> "user,hostfwd=3Dtcp::5022-:22" -dtb versatile-pb-buster.dtb -kernel
> >>>> kernel-qemu-5.4.51-buster -append "root=3D/dev/sda2 rootfstype=3Dext=
4 rw
> >>>> panic=3D1" -no-reboot
> >>> Let's start with the fact you are using a versatilepb machine type wi=
th
> >>> a versatilepb dtb and not the rasppi model.
> >> Given the name of the kernel image, this probably actually *is*
> >> built for versatilepb, or it wouldn't have got as far as failing
> >> to mount the root partition. There seems to be a lot of confusion
> >> in the raspberry pi community about the difference between
> >> running the raspi userspace plus a for-versatilepb kernel
> >> versus running a full raspi setup.
> > Ahh your German is considerably better than mine ;-) Looking more
> > closely at the blog it seems to be predicated on extracting a Raspbian
> > kernel which at least stands a fighting chance of being a multi_config
> > kernel - like the buster above.
> >
> > I can see why these sorts of shenanigans used to be pulled when there
> > where no RaspPi models although if all you want to do is run an ARM use=
r
> > space what's wrong with using linux-user for this sort of thing?
> >
> >> Anyway, failing to mount the rootfs and not listing any
> >> sda devices is not a problem with the fstab, because the system
> >> hasn't got as far as being able to mount the filesystem with a
> >> fstab on it yet. One possibility is that the kernel is
> >> missing the device drivers for either PCI or for the SCSI
> >> controller that gets plugged in to versatilepb by default.
> >>
> >> My guess at the cause is that you're trying to boot a Linux 5.somethin=
g
> >> kernel and you've run into the issue described in this thread:
> >> https://lists.gnu.org/archive/html/qemu-discuss/2020-09/msg00023.html
> >> where the Linux 5.x sym53c8xx scsi driver is not compatible with QEMU'=
s
> >> emulation of that device. If that's the case then you should see
> >> earlier in the kernel boot log error messages similar to the ones
> >> that Roger reported. The fix would be either to use an older
> >> kernel, or to change the QEMU commandline to use a different
> >> SCSI controller (or to use a virtio block device).
> > Do we have any documentation for the RaspPi models? The acceptance test=
s
> > look like they support the inbuilt MMC/SD controller device:
> >
> >          kernel_command_line =3D (self.KERNEL_COMMON_COMMAND_LINE +
> >                                 serial_kernel_cmdline[uart_id] +
> >                                 ' root=3D/dev/mmcblk0p2 rootwait ' +
> >                                 'dwc_otg.fiq_fsm_enable=3D0')
> >
> > It would be useful to fill the hole in the documentation so gently stee=
r
> > people away from these hybrid franken-machine approaches.
> >
> >> thanks
> >> -- PMM
> >
>
>

