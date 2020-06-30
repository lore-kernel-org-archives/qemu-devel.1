Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B9BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D16582074D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbVtPF5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D16582074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqK4i-0006bR-5D
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:29:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqK3q-00064S-Vs
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:28:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46198)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jqK3p-0005hj-6S
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:28:46 -0400
Received: by mail-wr1-x441.google.com with SMTP id r12so20940771wrj.13
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 10:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OFDTVqurqeWRpPa66n3t+wBAy9jxAJmER0Aw+M9687s=;
 b=QbVtPF5eK/PTURaRncqZkUUGYZwEeAnVkyKjmCn4Uadoj9qUX9dADFPiypKTmhXfqX
 F7beQDBAN7d/e3P7Uxe99VV7ixgyD3bWRytiytavMFQIZ/Un/xvB6Lobg/qr9OpDT04j
 MkWkCtjyZTWiBL63c9pvWRxWMjAKpp8TcITRKvzgt8tKYwTPhGoMiNEfBeiOMUC/Ip3+
 A6mnh55xqUnPe6SkbAO9QHn9Jil1FS+cCM8nUWs1lhNM4PZeEk48/KDxy7SaIWvnOxpY
 3QWb4DFSuhZupAf3pXjId0tGQSJNkTJjy+zLXs736TFaEMqMqP2ld06QSU0iiGQqtJce
 ND4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OFDTVqurqeWRpPa66n3t+wBAy9jxAJmER0Aw+M9687s=;
 b=t4KzNnP5DwI5fWheUuJzMcRhVw01SWjBzxAKexp8jAcQXvhaIpxRkODf4Ldf5Pq8/A
 VAIVvjHD2u+IobDy1CPFAzDDZKxlpPZ+NGI2uhvUTsA3tdfaZ/rlhFhse8kFmtI2aK4i
 k6EJpMxf43mOmzLfWdnC13b4/7ar+nXobg21EKfW1PxPhI4j4LNlUZXoCwLrHb1CfZ2c
 vgiTTjnyboGzl9FCT+vwsU8bmfXlxzjSAfcxnkhpqKvUQSMbIGfDxb15D5x8oZ8bX4Tr
 /Hmte3WUDmaWvL1WnwN6Ik5y1S+5nw1Obu05kOJe5qj5ReQadTr50IpvGp1do+EtMsAp
 e6Bg==
X-Gm-Message-State: AOAM532dhjHaMyIQ3wsrMO+6+IThlZEgtiu9gcifVhWSp71B/JXcPUDZ
 BrVqaQmFWTLc6AFx5QL1DvNy1+zZrgvxwOfexAo=
X-Google-Smtp-Source: ABdhPJyYdzgzE8Fj0sdmi38sAQFSRfDC5geWB9VhyGpcIEvh0PgekliDhRrzoe9g6//R2NNlhIN0WhL07m5gw/UihNg=
X-Received: by 2002:a5d:62d1:: with SMTP id o17mr22190829wrv.162.1593538121459; 
 Tue, 30 Jun 2020 10:28:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200630145236.27529-1-f4bug@amsat.org>
 <CAHiYmc4=pmzEyhVTHaqxBnCotE8V+vaptMFincyurvAyDHNn6g@mail.gmail.com>
 <5725b99b-b524-ab40-c74d-a615bb28d363@amsat.org>
 <CAHiYmc7AoJd7TMX_Beo3A2f3R1M=yrpe2ZydbsSysREf4Cx3Vw@mail.gmail.com>
 <a503201a-ed9f-dff6-6e3d-4729ed31ad98@amsat.org>
In-Reply-To: <a503201a-ed9f-dff6-6e3d-4729ed31ad98@amsat.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Tue, 30 Jun 2020 19:28:29 +0200
Message-ID: <CAHiYmc6tp9k9eSOKiSWaQjmaTyvJXi3k+RmLWqLmhTHY9_KDnQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] hw/mips/malta: Add the 'malta-strict' machine,
 matching Malta hardware
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yunqiang Su <ysu@wavecomp.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Igor Mammedov <imammedo@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 19:16 Philippe Math=
ieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 6/30/20 6:55 PM, Aleksandar Markovic wrote:
> > =D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 18:46 Philippe =
Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> > =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>
> >> On 6/30/20 5:38 PM, Aleksandar Markovic wrote:
> >>> =D1=83=D1=82=D0=BE, 30. =D1=98=D1=83=D0=BD 2020. =D1=83 16:52 Philipp=
e Mathieu-Daud=C3=A9 <f4bug@amsat.org> =D1=98=D0=B5
> >>> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >>>>
> >>>> Hi,
> >>>>
> >>>> This series add a new 'malta-strict' machine, that aims to properly
> >>>> model the real hardware (which is not what the current 'malta'
> >>>> machine models).
> >>>>
> >>>> As a bonus for Debian builders, a 'malta-unleashed' machine RFC
> >>>> patch is included. This might start another endless discussion
> >>>> upstream, but this is not the point of, so I still include it
> >>>> for people to test. The rest of the series is candidate for merging
> >>>> in mainstream QEMU.
> >>>>
> >>>> Philippe Mathieu-Daud=C3=A9 (6):
> >>>>   hw/mips/malta: Trivial code movement
> >>>>   hw/mips/malta: Register the machine as a TypeInfo
> >>>>   hw/mips/malta: Introduce MaltaMachineClass::max_ramsize
> >>>>   hw/mips/malta: Introduce the 'malta-strict' machine
> >>>>   hw/mips/malta: Verify malta-strict machine uses correct DIMM sizes
> >>>>   hw/mips/malta: Introduce the 'malta-unleashed' 64-bit machine
> >>>>
> >>>>  hw/mips/malta.c | 125 ++++++++++++++++++++++++++++++++++++++++++---=
---
> >>>>  1 file changed, 111 insertions(+), 14 deletions(-)
> >>>>
> >>>> --
> >>>
> >>> This whole series is based on idea of emulating physically
> >>> non-existing feature, and as such violates the fundamental principles
> >>> of QEMU.
> >>>
> >>> As such, not acceptable for upstreaming.
> >>>
> >>> I don't see the point of sending again the same series, in just
> >>> cosmetically different form, if it was said to you that the concept i=
s
> >>> wrong.
> >>
> >> Have you looked at the patches? What "violates the fundamental
> >> principles of QEMU" is the code currently in mainstream. Should
> >> we remove it? I can send a patch for it if it pleases you, but
> >> you will make QEMU unuseful for many distribution users.
> >>
> >
> > Past mistakes are past mistakes. We have to live with them. And not
> > make them in the future.
> >
> > I see the whole series as a precursor for your change that repeats
> > past mistakes, a "wolf in sheep clothing".
> >
> > That's why I reject the series as a whole.
>
> As a co-maintainer I don't accept that.
>

I offered you the full maintainership for Malta.

You said you can proveide only "Odd fiexes".

I had to jump in to provide "Maintained" status.

Therefore, I provide the higher level of maintainership, and you have
to respect that. But you don't.

Regards,
Aleksandar

> The 'malta' machine is not changed, the series adds the 'malta-strict'
> machine which check the RAM restriction:
>
> $ qemu-system-mips -M malta-strict -bios /dev/null -m 512
> qemu-system-mips: Too much memory for this machine: 512 MiB, maximum 256 =
MiB
>
> $ qemu-system-mips -M malta-strict -bios /dev/null -m 252
> qemu-system-mips: RAM size must be the combination of 4 powers of 2
>
> $ qemu-system-mips -M malta-strict -monitor stdio -S -bios /dev/null -m 1=
00
> QEMU 5.0.50 monitor - type 'help' for more information
> (qemu) info mtree
> address-space: memory
>   0000000000000000-ffffffffffffffff (prio 0, i/o): system
>     0000000000000000-00000000063fffff (prio 0, ram): alias
> mips_malta_low_preio.ram @mips_malta.ram 0000000000000000-00000000063ffff=
f
>
> 100 =3D 64 + 32 + 2 + 2
>
> >
> > Yours,
> > Aleksandar
> >
> >> What this series does is emulate the physically existing feature
> >> that are not yet emulated in QEMU.
> >>
> >> Please refer to the datasheet 'MIPS Document Number: MD00051
> >> Revision 01.07' before rejecting this series, and find the
> >> correct arguments.
> >>
> >> Thanks.
> >>
> >>>
> >>> Regards,
> >>> Aleksandar
> >>>
> >>>
> >>>> 2.21.3
> >>>>
> >>>
> >

