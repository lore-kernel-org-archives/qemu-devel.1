Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 615EDC4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:21:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2701920722
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kzpb6M8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2701920722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFd84-0003hW-BB
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 08:21:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40741)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jFd7D-00032g-Sz
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jFd7C-00049V-2G
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:20:35 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:24154)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jFd7A-00048J-73
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 08:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584793231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Jdy9cM4yEkHa5BYOrLX/ZvLh08lyhMZqVUzEW6/vdc=;
 b=Kzpb6M8MG6E8hq6qfmCK9EpKUqpfYk+D3dBH7Vv/U4nvhyAMhGMEilCdSGLyoBItfWPZ5J
 E0uYF8JME+m1Dz1/1o7NPax9iN0Dz8yAfrVXW4qTLA3cz2kdWvun0PxHS2G0iKMVdzeh5Z
 D3xzuPUbXfvCBs70LQe8po5VLNZELNI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-HYMPJwuHOsKLKTeY3Lrzdw-1; Sat, 21 Mar 2020 08:20:26 -0400
X-MC-Unique: HYMPJwuHOsKLKTeY3Lrzdw-1
Received: by mail-ed1-f69.google.com with SMTP id ce13so7430317edb.11
 for <qemu-devel@nongnu.org>; Sat, 21 Mar 2020 05:20:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d0Qv/xpPKwvzSW/cvuupg5cn1SBat6NtfdKMxcB1t74=;
 b=uVuIwR1HdWMtKOSImta8ojsYv6f3cHam06IXznt+rA7oAAjkw3eZ3IP7BPLCe1TQ8u
 MSIyXVdL+/p93aFhzZ5F0+ZR/nErMyTypvp8Bme9U51t9pwARCM00N2AS15aME6aID/v
 bHUjGeXpV5vEYqs6QW4c0TZ9oXpu6xi37cqSnoaerNuC5Mt7K4sRxjjKCDK/rhDprbdd
 0y9YmsC0OUatR+5IZo8k5cwOtWsa+9To/H1nslMiR/HH+rijoAY51CycunDaRUUWePxj
 vvzsFFb3tME7zFKnR/+6uXLsnC1YMLX2vR2BR3LwlmLEDzyxDOZiwPfR3oVxTM96A0yW
 kc7g==
X-Gm-Message-State: ANhLgQ3Bqi0c1WKExQUnu38rvyBo7J8k8Uia5sPUR1dxoh3cFclHg9A7
 gz3RcrA7fCscBKbU5meolc31pcJk+81jkwvZdLvzeq4h+XA8NmYh8bKPj16LrucjVBL/ytokzop
 xKOCrfub2EWCkx3U=
X-Received: by 2002:a50:ed06:: with SMTP id j6mr13038300eds.89.1584793224759; 
 Sat, 21 Mar 2020 05:20:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs/rvcri/kawgabzmYXNC30aSF7aXzaAQU9WhRkxRncuRvO06EdaSpW3bNFIqWA7qIey19NTw==
X-Received: by 2002:a50:ed06:: with SMTP id j6mr13038282eds.89.1584793224557; 
 Sat, 21 Mar 2020 05:20:24 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id z22sm578021edl.6.2020.03.21.05.20.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Mar 2020 05:20:23 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 00/11] misc: Trivial static code analyzer fixes
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200321114615.5360-1-philmd@redhat.com>
 <CAHiYmc7JCR-_2Vb8hm1ob56-e3Et+1mtsoftt-CzY76i_qe2QA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <21211cae-5ccb-0851-7c24-9a6b84924ad1@redhat.com>
Date: Sat, 21 Mar 2020 13:20:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7JCR-_2Vb8hm1ob56-e3Et+1mtsoftt-CzY76i_qe2QA@mail.gmail.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/21/20 1:01 PM, Aleksandar Markovic wrote:
> 12:47 PM Sub, 21.03.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
=20
> <mailto:philmd@redhat.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>  >
>  > Fix trivial warnings reported by the Clang static code analyzer.
>  >
>=20
> Philippe,
>=20
> It would be useful and customary for this type of fixes to provide here=
=20
> the environment you used for obtaining the warnings (clang version,=20
> configure parameters, and all needed elenents to repro the warnings).

https://clang-analyzer.llvm.org/

$ sudo dnf install clang-analyzer
$ ../configure
$ scan-build make

>=20
> Regards,
> Aleksandar
>=20
>  > Philippe Mathieu-Daud=C3=A9 (11):
>  > =C2=A0 block: Remove dead assignment
>  > =C2=A0 blockdev: Remove dead assignment
>  > =C2=A0 hw/i2c/pm_smbus: Remove dead assignment
>  > =C2=A0 hw/input/adb-kbd: Remove dead assignment
>  > =C2=A0 hw/ide/sii3112: Remove dead assignment
>  > =C2=A0 hw/isa/i82378: Remove dead assignment
>  > =C2=A0 hw/gpio/aspeed_gpio: Remove dead assignment
>  > =C2=A0 hw/timer/exynos4210_mct: Remove dead assignments
>  > =C2=A0 hw/timer/stm32f2xx_timer: Remove dead assignment
>  > =C2=A0 hw/timer/pxa2xx_timer: Add assertion to silent static analyzer =
warning
>  > =C2=A0 hw/scsi/esp-pci: Remove dead assignment
>  >
>  > =C2=A0block.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | 2 +-
>  > =C2=A0blockdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| 2 +-
>  > =C2=A0hw/gpio/aspeed_gpio.c=C2=A0 =C2=A0 =C2=A0 | 4 ++--
>  > =C2=A0hw/i2c/pm_smbus.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -
>  > =C2=A0hw/ide/sii3112.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 +-
>  > =C2=A0hw/input/adb-kbd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1 -
>  > =C2=A0hw/isa/i82378.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 8 +++=
+----
>  > =C2=A0hw/scsi/esp-pci.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1 -
>  > =C2=A0hw/timer/exynos4210_mct.c=C2=A0 | 3 ---
>  > =C2=A0hw/timer/pxa2xx_timer.c=C2=A0 =C2=A0 | 1 +
>  > =C2=A0hw/timer/stm32f2xx_timer.c | 1 -
>  > =C2=A011 files changed, 10 insertions(+), 16 deletions(-)
>  >
>  > --
>  > 2.21.1
>  >
>  >
>=20


