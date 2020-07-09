Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA20C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:28:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AE42207F9
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 16:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mWp0ONKm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AE42207F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtZP7-0006cW-Bs
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 12:28:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35414)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtZOV-000665-Hl; Thu, 09 Jul 2020 12:27:31 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:34592)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jtZOQ-0004kT-Qw; Thu, 09 Jul 2020 12:27:31 -0400
Received: by mail-il1-x141.google.com with SMTP id t4so2565839iln.1;
 Thu, 09 Jul 2020 09:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZXvggOZ6MvAQVnD8GqWLsbh+z4f+zwImENZh6Y47h+w=;
 b=mWp0ONKmfbPNwXoaThIPefruhT8pVGpSFIer4MlEc9W5cMH4dCbNPcZV13CvEvnsn1
 HNDlGFjrMD9zWnzWKd05DjLrZDun1WmWCaKTLM6YhamKiVqHVSRIvXWiIt1w3t5gxapj
 fZHWRrYwCcezhB+/AvHHpuweOtZ679ugNY9xhhm4L9mgBEYsuWmRgdtNWSJ/C8PhdUy+
 KboF0+ROzVDH3PTkh0yLRp7gGRvOJ5vhak0R3pLhfs1FzmUdaNSHRkANBIWpLxLWRBBV
 iLJ0yKFMHwLBdsV+u4e32Yj+2i26tYTC0llhCsg21ZySgpmFVlc/RiOeMInMZTULzYpV
 5RpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZXvggOZ6MvAQVnD8GqWLsbh+z4f+zwImENZh6Y47h+w=;
 b=AsufJYU+ketUOITs3XmOOev9XtEUCxWSZKPUAPFGbLmWwcHIEQ+by65CcJxP+sWBkI
 vc+/RbkKrNqIC/4z7W13sN/RDGIX7qb12OVueIHb7rbP7bmAA/jf0yw4rkEdmu6S7zwd
 7bHmen9PR3XZcM+KhWubTIm9Rj9EiuWGqJDVrmkefmEff3XyREZM91EJA57XtiC+cYlS
 yslNjyR0mF7CbjOsmZ+bwG7cRzk3SRmdS9WF8ACPapItGeqpIfZ1ROd0dzpxxovk4XAm
 Reb0+ljiOdBvAex5/gTw5F4LIYmGFqcwnAg5apyToQVMbc7mvLw5s7Dg1hbhBa/uzHaE
 K1jg==
X-Gm-Message-State: AOAM533OFEfAiSaW8EGIvsUPYvw2GoWpIxLLiG3ivHFXAISz5nRz0qpP
 ZbMJN4+MCsfzFCJdqmqX3C1QAPPFkBZ2hYN3Z/8=
X-Google-Smtp-Source: ABdhPJxgGsYi2giFwkGGqWUzi6qpkItOKydXnlLtXSwtph3Y0136pZYLjxSHPbdP8axI+r8j7XXrBsI6XRkkCXas6Z8=
X-Received: by 2002:a05:6e02:d51:: with SMTP id
 h17mr48304544ilj.131.1594312045279; 
 Thu, 09 Jul 2020 09:27:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200707132116.26207-1-f4bug@amsat.org>
 <20200707132116.26207-3-f4bug@amsat.org>
 <CAKmqyKNY+7tE9tcZm7_Th9qapo1CH0AwNwBf7vaf+7vSqBNtVA@mail.gmail.com>
 <CAFEAcA_ZXgNHMAhBVmjvstyG=PpaHOtcmo=VgvfBQ3Z9VJTk_g@mail.gmail.com>
 <3f1bf3ba-d6c3-a148-9850-076b2caa64d0@amsat.org>
 <CAPan3Wr09ZbbHWO-dhGeK3zhZQv3smrzLpUGMj71NWh0hToZDg@mail.gmail.com>
 <e87550d9-e1cc-cc15-2674-755249e9a965@amsat.org>
 <CAFEAcA8em-bgU2xd8OG+bPLDCSZCF8Y2ay9U57D8p9m1SWO=9g@mail.gmail.com>
 <f263f4aa-eb94-8760-6fc4-a1d46c15d099@amsat.org>
In-Reply-To: <f263f4aa-eb94-8760-6fc4-a1d46c15d099@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Jul 2020 09:17:33 -0700
Message-ID: <CAKmqyKM1h37fKNs-_jh+9Yr6EGvQ+hdbSQHHSnOoePHdLyf1Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/sd/sdcard: Do not allow invalid SD card sizes
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
 Qemu-block <qemu-block@nongnu.org>, Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 7:35 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> On 7/9/20 4:15 PM, Peter Maydell wrote:
> > On Thu, 9 Jul 2020 at 14:56, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> >>
> >> On 7/7/20 10:29 PM, Niek Linnenbank wrote:
> >>> So I manually copy & pasted the change into hw/sd/sd.c to test it.
> >>> It looks like the check works, but my concern is that with this chang=
e,
> >>> we will be getting this error on 'off-the-shelf' images as well.
> >>> For example, the latest Raspbian image size also isn't a power of two=
:
> >>>
> >>> $ ./arm-softmmu/qemu-system-arm -M raspi2 -sd
> >>> ~/Downloads/2020-05-27-raspios-buster-lite-armhf.img -nographic
> >>> WARNING: Image format was not specified for
> >>> '/home/me/Downloads/2020-05-27-raspios-buster-lite-armhf.img' and
> >>> probing guessed raw.
> >>>          Automatically detecting the format is dangerous for raw imag=
es,
> >>> write operations on block 0 will be restricted.
> >>>          Specify the 'raw' format explicitly to remove the restrictio=
ns.
> >>> qemu-system-arm: Invalid SD card size: 1.73 GiB (expecting at least 2=
 GiB)
> >>>
> >>> If we do decide that the change is needed, I would like to propose th=
at
> >>> we also give the user some instructions
> >>> on how to fix it, maybe some 'dd' command?
> >>
> >> On POSIX we can suggest to use 'truncate -s 2G' from coreutils.
> >> This is not in the default Darwin packages.
> >> On Windows I have no clue.
> >
> > dd/truncate etc won't work if the image file is not raw (eg if
> > it's qcow2).
>
> Good catch...
>
> > The only chance you have of something that's actually
> > generic would probably involve "qemu-img resize". But I'm a bit
> > wary of having an error message that recommends that, because
> > what if we got it wrong?
>
> I am not sure what to recommend then.
>
> Would that work as hint?
>
>   qemu-system-arm -M raspi2 -sd ./buster-lite-armhf.img
>   qemu-system-arm: Invalid SD card size: 1.73 GiB
>   SD card size has to be a power of 2, e.g. 2GiB.

That sounds good to me. That's enough for a user to figure out the next ste=
p.

If you want you could also add: "qemu-img might be able to help." or
something like that.

Alistair

