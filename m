Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAB0C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:47:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B7621D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 06:47:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jF6giJc9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B7621D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3wfC-0000yM-Ox
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 01:47:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j3weX-0000PD-CE
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j3weV-0002nY-Oj
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:46:41 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58909
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j3weV-0002nG-LJ
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 01:46:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582008399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EexfLdD5JSfQpqO5jqNe6EOqoeJQYPvSvd4DEM4l58=;
 b=jF6giJc9UNcvyKKC10iZ8Zh/rtqHVKI6sOFmt/u/OF+iykiu3FYf2LZYDihXWcJOBNTndO
 gXf19ASMICCMmF0MRYnaiDOO6cYlCerxgt4HsmrvoOoEfPzWpiASej4X59/rUMtOd40mEW
 zU7mDotUBPRlu1eYSpGUbUuCJJJDkko=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-isl2Jcw0NcyosyCXteSoAg-1; Tue, 18 Feb 2020 01:46:30 -0500
Received: by mail-wm1-f71.google.com with SMTP id b8so544035wmj.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 22:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Xfzg04uB8sMZPMiaMCiM5JFy9tm9UmJ6U9SQouTgD8=;
 b=Nt+NnkjBU+vHHae/Wa8R4nR8ip6J4ZCM50WC3ylWODUYFWLCK1pR2utuLSwgjQLbcx
 QgL5vQ6fviM4BhYgx3DUn0SMgfpJ97ThCXsHYIekEvwNv8r+5YEJLJPi1r4bKgneeGoZ
 VE7ecezGpoXWgnZZ6uzNdA5VZk6ur0ODM1ljjAzu8ik3MWGljMr9xfY7IfGla/+lCN8Y
 QQnpgE5SviEHSRIsySEbLFKENfmFScIq+sg0DkAihaphHP9LUEJD8HBWzQWEdpTTWibf
 IDH8zPk2o0krYZz2nb5ILhO34IW5bU3aeEJSqqURiT59/gDxJC9LNdBclviLKqE62bVf
 IS6w==
X-Gm-Message-State: APjAAAUkpvLjHNHHKg3hkg2BQORDl+lHzEUcP9ZlO7ZubK62+HkZCmqK
 fVvv7tivP7CyiJd7+6aWgHZ+o5x5lqXFQ9AXHeRkzQhQcQFcy1l1ekH5QNyYFcdPfN9IbXZ1Aih
 mccvC+DuEc55M/5Y=
X-Received: by 2002:adf:ab14:: with SMTP id q20mr26592223wrc.274.1582008389499; 
 Mon, 17 Feb 2020 22:46:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqyFYA3A0hf0RlJDS0zXCK/njogR63AS57Bxes2MZV/HCb9scFCVmaaj0GOjR86mCkpVYx2Jmw==
X-Received: by 2002:adf:ab14:: with SMTP id q20mr26592197wrc.274.1582008389256; 
 Mon, 17 Feb 2020 22:46:29 -0800 (PST)
Received: from [192.168.1.35] (78.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.78])
 by smtp.gmail.com with ESMTPSA id m3sm4340179wrs.53.2020.02.17.22.46.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 22:46:28 -0800 (PST)
Subject: Re: [PATCH v4 00/20] Add Allwinner H3 SoC and Orange Pi PC Machine
To: Niek Linnenbank <nieklinnenbank@gmail.com>
References: <20200119005102.3847-1-nieklinnenbank@gmail.com>
 <CAPan3WpV2m9HXLXZDopKUb2EfX2KE9y530m2pJG4-D96==ggCg@mail.gmail.com>
 <ee95179f-c15f-9615-e241-80199e6948b7@redhat.com>
 <CAPan3WpG0yPu5sbS=mpHk=xNVGaqwWFrBcDBcovLLRit==5dwg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <3aa04b23-80a8-21d1-7481-d52b6d8f88c1@redhat.com>
Date: Tue, 18 Feb 2020 07:46:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAPan3WpG0yPu5sbS=mpHk=xNVGaqwWFrBcDBcovLLRit==5dwg@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: isl2Jcw0NcyosyCXteSoAg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Peter Maydell <peter.maydell@linaro.org>, jasowang@redhat.com,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:27 PM, Niek Linnenbank wrote:
> Hi Philippe,
>=20
> On Wed, Feb 12, 2020 at 11:12 PM Philippe Mathieu-Daud=C3=A9=20
> <philmd@redhat.com <mailto:philmd@redhat.com>> wrote:
>=20
>     On 2/12/20 10:47 PM, Niek Linnenbank wrote:
>      > Hi all,
>      >
>      > Short status update regarding this series.
>      >
>      > Currently I am debugging booting NetBSD 9.0-RC2, which is recently
>      > released [1]
>      > The problem is that, apparently, RC2 can't mount the rootfs proper=
ly:
>      >
>      > [ =C2=A0 3.1871510] vfs_mountroot: can't open root device
>      > [ =C2=A0 3.2141370] cannot mount root, error =3D 6
>      >
>      > This only happens using the RC2 filesystem image. However, the RC2
>      > kernel can
>      > properly load & boot the RC1 filesystem image, and the RC1 kernel
>     gives
>      > the same error
>      > on the RC2 filesystem.=C2=A0 But I dont think its a NetBSD-RC2 iss=
ue,
>     because
>      > on a real
>      > Orange Pi PC hardware board, this problem does not show.
>=20
>     Linux shows:
>      =C2=A0 =C2=A0console: mmc0: Problem switching card into high-speed m=
ode!
>=20
>     QEMU MMC support is not in good shape, and high-speed SD card
>     support is
>     limited. I keep procrastinating at reviewing your SDHCI patch hmmmmm.
>=20
>     So you added:
>=20
>      =C2=A0 * DMA transfers
>      =C2=A0 * Direct FIFO I/O
>      =C2=A0 * Short/Long format command responses
>=20
>     I'd start diffing the trace output of the following events:
>=20
>     allwinner_sdhost*
>     sdcard*
>=20
>     with both kernels.
>=20
> Thanks for the kind suggestions Philippe.
> Indeed, comparing the trace files of both the RC1 and RC2 kernels is one=
=20
> of the things I did, and many more.
>=20
> After extensive low-level debugging, I discovered that the issue is much=
=20
> more simple than I thought.
> In particular, when using -sd <file>, the emulated device gets the same=
=20
> physical size as the file.
> Normally this is not a problem, but for the NetBSD RC2 image, the kernel=
=20
> reads the MBR partition table,
> compares it with the device size and concludes that the NetBSD partition=
=20
> in the image is larger than the actual device.
>=20
> Unfortunately, this root cause is not printed on the NetBSD console,=20
> only the final=C2=A0 'can't open root device' message.
> Also, when running on hardware, obviously the SD card will be larger,=20
> e.g. 4GB or more, so that is why this issue does not show.
>=20
> So the fix is to extend the input image by a few megabytes before=20
> booting it.
> And on the positive side, with this search we now have more confidence=20
> that the
> emulated SD/MMC device in Qemu works as expected.

Good news!

IIRC from the specs, cards are block devices and the only alignment=20
required is the size of a block (512KiB for your 4GiB card).

That said I never saw a card not pow2 aligned, but the card firmware=20
should be able to discard blocks and announce fewer. Maybe FreeBSD is=20
incorrect assuming a pow2 alignment?

>=20
> Kind regards,
> Niek
>=20
>      >
>      > I'm comparing traces and adding more low-level debug output to
>     NetBSD
>      > and QEMU to find the issue.
>      >
>      > Also I processed the review remarks which were send so far.
>      >
>      > Kind regards,
>      > Niek
>      >
>      > [1] https://www.netbsd.org/releases/formal-9/NetBSD-9.0.html
>=20
>=20
>=20
> --=20
> Niek Linnenbank
>=20


