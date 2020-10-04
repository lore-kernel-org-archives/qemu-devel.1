Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4FBC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:41:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E01B92068D
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmJtpsOS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01B92068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8xG-0003fQ-U9
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:41:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kP8wR-0002un-0v
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:41:03 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:39880)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kP8wN-0003u8-S5
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:41:02 -0400
Received: by mail-ej1-x642.google.com with SMTP id lw21so4762508ejb.6
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=vPP3s4z361Q9UgQNLLTL7OkavWGws14FpHuVpd66USo=;
 b=mmJtpsOS8ugC5pZ2fC9NsasWinEZCA3IWEKnwATZFzxq3BU+O9GdQFbnCwTjlSSRpX
 tYx2zEdYaqLFmEI4/EC9KoCYqOx54nS1bY3uNzrYn6H9NyDQoBR4rnlDzJRdzUc0Nhh7
 VPP/Go8ftHassRygl1KeOHpcrjYBS4sH8CSNGQFti3j3agWu2eO62py25CsDXkb3CqBP
 59XTuBXkkFVP6E7+N93RIfGVjDE5VhkXLuRXpekl1pqnr2A9+5VSQOKPTkAavXZo8dHJ
 FF97o5v4yOti9TGihzMCEdF4CGYPcRa5qGfQ12gMdvkJnqBLxATVPLCitja1Kr0N56XR
 wh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=vPP3s4z361Q9UgQNLLTL7OkavWGws14FpHuVpd66USo=;
 b=FcwW2pJIbi4CaWBV/Gxac3buaK8cTLgGI82oeTqUlE197Ne3dJoyAtW/1Nmw/YQ25x
 nxm3F3lg9EYbiD5StnEX7vhrT1R3OhVOuoxN+8uV1c308YGUeOCXNvW8pXz+zvDIGDpk
 gvhyvQl/bvvxmEcboI+MWwsKfnBCjEftNoovi4DW023y7rEhsVdomWcBGebZEfuLjyyE
 Z1LKeUNWgb5d7yLroyAso9Ac41twFl/EM//2E0GkdlqJPJapl1TELjbscllAliKHXBCG
 1JnCUpXmdDysRX2LSCtKFI941YwoM3kSh2PAXB2nfGYnOoLXOdWNDvM27a6LZhUpjJH6
 jjSQ==
X-Gm-Message-State: AOAM531jNWJD14yk++cn7o0XEoaMjaavpXcNQX59Yt8hVCxxnddNSB3C
 96yRNQKAxSCkVFSzGkQBRbafLPU3+AAvp5JQo3yViw==
X-Google-Smtp-Source: ABdhPJwI4Kuk0DLopxQQFsVJd36uVqa4/wc42sYxtjxCOTRkDh3lTqZwxjQ6YtDzPdfGyy/EUIuBx06zXMdiTlzw3Gc=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr11713267ejk.407.1601836857425; 
 Sun, 04 Oct 2020 11:40:57 -0700 (PDT)
MIME-Version: 1.0
References: <47dbcad4-3121-b1c3-06fa-abec7c353fb6@gmail.com>
 <87sgatanti.fsf@linaro.org>
In-Reply-To: <87sgatanti.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 4 Oct 2020 19:40:46 +0100
Message-ID: <CAFEAcA_ZMLV3DZ_R_SHvPLdEf=i-xpspD5itBmfYeqyMhgtLWQ@mail.gmail.com>
Subject: Re: Emulate Rpi with QEMU fails
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 4 Oct 2020 at 18:44, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> Thomas <74cmonty@gmail.com> writes:
> > I'm trying to emulate Rpi with QEMU.
> > I found
> > [url=3D1]this[/url]
> > arcticle in Raspberry Pi Geek documenting the steps including persisten=
t
> > storage on host.
> >
> > However when starting the emulation with command
> > qemu-system-arm -M versatilepb -cpu arm1176 -m 256 -serial stdio -hda
> > 2020-08-20-raspios-buster-armhf-lite.img -net
> > "user,hostfwd=3Dtcp::5022-:22" -dtb versatile-pb-buster.dtb -kernel
> > kernel-qemu-5.4.51-buster -append "root=3D/dev/sda2 rootfstype=3Dext4 r=
w
> > panic=3D1" -no-reboot
>
> Let's start with the fact you are using a versatilepb machine type with
> a versatilepb dtb and not the rasppi model.

Given the name of the kernel image, this probably actually *is*
built for versatilepb, or it wouldn't have got as far as failing
to mount the root partition. There seems to be a lot of confusion
in the raspberry pi community about the difference between
running the raspi userspace plus a for-versatilepb kernel
versus running a full raspi setup.

Anyway, failing to mount the rootfs and not listing any
sda devices is not a problem with the fstab, because the system
hasn't got as far as being able to mount the filesystem with a
fstab on it yet. One possibility is that the kernel is
missing the device drivers for either PCI or for the SCSI
controller that gets plugged in to versatilepb by default.

My guess at the cause is that you're trying to boot a Linux 5.something
kernel and you've run into the issue described in this thread:
https://lists.gnu.org/archive/html/qemu-discuss/2020-09/msg00023.html
where the Linux 5.x sym53c8xx scsi driver is not compatible with QEMU's
emulation of that device. If that's the case then you should see
earlier in the kernel boot log error messages similar to the ones
that Roger reported. The fix would be either to use an older
kernel, or to change the QEMU commandline to use a different
SCSI controller (or to use a virtio block device).

thanks
-- PMM

