Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37533C54FCE
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 060CD20637
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 16:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5qT6cS8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 060CD20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGPXC-0005rm-1s
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 12:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60425)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jGPVE-00041e-0k
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:00:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jGPV9-0005qc-6w
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 12:00:35 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:41410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jGPV8-0005qW-Vy; Mon, 23 Mar 2020 12:00:31 -0400
Received: by mail-ua1-x943.google.com with SMTP id l7so5163559uap.8;
 Mon, 23 Mar 2020 09:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3+zyZBOZgnwvj6HjjkL9VZ1uuTPjSF+4X1NUFEoixK8=;
 b=P5qT6cS8WdtDBs/RaI8BcVZFtcAZvKg37b7J4V+WkUawV3bPJQwrFoUQrPgnDFy7bk
 /1sXtAbKdBx0CvBH4Nl1W3DJbzssBJHYK76OGovRSZRAWy5BXy+9DITHrmHkX4tynDpb
 HQXUfllfeTdbz61GlwN7GQuOgHZJaLHTftocgR7hJEnur+DuF29VaVomBuPTt/G/ya1f
 hjCDok7Ep8TSQ8SynaG5tX73xrxoeGn8xcrhdRF46Ed5PrSk8c1nOEiPLQu8V36PNbu6
 8cCz44AwQFk2XXZClq68BDVCpkQseLSrJB73m2nTy/1pzLw/fBB9LHDeP9/wpfA2joyw
 1Jdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3+zyZBOZgnwvj6HjjkL9VZ1uuTPjSF+4X1NUFEoixK8=;
 b=mub9rgF4In92f80lcvpib8AVZBZJ89dYk0b7mLVdpHfucvbEQW0m9Ux3b63+KH6too
 J5WBydEhItcbEmq2LuGfMuRwcMd9Y2JK93nZz7F+IsBfojdzmhB/Xo/XKv6SsirnP/7K
 7zB72OXpEK3fKLYk76Ah8/OqSjha3Oia+a081mxnDKXhfZYAYOBIYaB8bteWAnL999be
 9D/jeSFEoil5RLPRWS6yU7uGmhOL0neLVQ55eFQonAyCbqsHd18lNfb/dub7hB/2kg4b
 iEHVcyiARB8Sw1CeKMYApCCavCm9pLlC4/uQLktJMrfHDm7uNo9xl1GfumYJ7uVp4DD4
 Y9rw==
X-Gm-Message-State: ANhLgQ2eM/FDYiSVm4awUpVHOUgmEo2iCkSc1GUkzqqqPu4qq/cfpJ83
 7mPj1EKQFEkGJpdlvioUXdpMZPaL8PjqgrurAfI=
X-Google-Smtp-Source: ADFU+vtWBYqeznwDdZO/XqcYBYd0LVWzbRWHUvYuoVNOZG1XzUVo5qBnIxhn2lLobWfde94ajISnsNJY6t5JbbRoRJY=
X-Received: by 2002:a9f:3311:: with SMTP id o17mr15011469uab.30.1584979230391; 
 Mon, 23 Mar 2020 09:00:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200321144110.5010-1-philmd@redhat.com>
 <20200321144110.5010-9-philmd@redhat.com>
In-Reply-To: <20200321144110.5010-9-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 23 Mar 2020 08:52:30 -0700
Message-ID: <CAKmqyKMHq58PA3epAE8gjhHdyrOPz12JDPtPezVyPzeFK0xutA@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 v2 08/11] hw/timer/exynos4210_mct: Remove dead
 assignments
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::943
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "open list:New World" <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Mar 21, 2020 at 7:50 AM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Fix warnings reported by Clang static code analyzer:
>
>   hw/timer/exynos4210_mct.c:1370:9: warning: Value stored to 'index' is n=
ever read
>         index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/timer/exynos4210_mct.c:1399:9: warning: Value stored to 'index' is n=
ever read
>         index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/timer/exynos4210_mct.c:1441:9: warning: Value stored to 'index' is n=
ever read
>         index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>         ^       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/timer/exynos4210_mct.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
> index 944120aea5..c0a25e71ec 100644
> --- a/hw/timer/exynos4210_mct.c
> +++ b/hw/timer/exynos4210_mct.c
> @@ -1367,7 +1367,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
>
>      case L0_TCNTB: case L1_TCNTB:
>          lt_i =3D GET_L_TIMER_IDX(offset);
> -        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>
>          /*
>           * TCNTB is updated to internal register only after CNT expired.
> @@ -1396,7 +1395,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
>
>      case L0_ICNTB: case L1_ICNTB:
>          lt_i =3D GET_L_TIMER_IDX(offset);
> -        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>
>          s->l_timer[lt_i].reg.wstat |=3D L_WSTAT_ICNTB_WRITE;
>          s->l_timer[lt_i].reg.cnt[L_REG_CNT_ICNTB] =3D value &
> @@ -1438,7 +1436,6 @@ static void exynos4210_mct_write(void *opaque, hwad=
dr offset,
>
>      case L0_FRCNTB: case L1_FRCNTB:
>          lt_i =3D GET_L_TIMER_IDX(offset);
> -        index =3D GET_L_TIMER_CNT_REG_IDX(offset, lt_i);
>
>          DPRINTF("local timer[%d] FRCNTB write %llx\n", lt_i, value);
>
> --
> 2.21.1
>
>

