Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DABAC47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E227206BB
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:44:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E227206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48252 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHX3B-00078y-Dz
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42961)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHX2E-0006bu-HZ
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:43:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <k.kozlowski.k@gmail.com>) id 1iHX2D-0004an-AM
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:43:02 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <k.kozlowski.k@gmail.com>)
 id 1iHX2D-0004aP-40; Mon, 07 Oct 2019 13:43:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id f22so377196wmc.2;
 Mon, 07 Oct 2019 10:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=UPcpTQSi7VXhqtxvLfOXbN2IwD881LYjHFdrb1IRVbE=;
 b=ugys95Gk6K4EH1TBsVyPoLodHNCN6GQuiFQVcR0Ar2l6PDCN+WlP1Bp1fMC8sIezQS
 129D+UP6smYuyOVa3IPjVMBqPODG7le+ys3NgL7GqlLbzIBq+bUh+LZZtRpVQBexQVMN
 TGr38e2658cMG478mhAnncNS0MfTGKKPQ2cALPE6OsmOdUMg7sNqxVuBM8eMNBzvtrPq
 lxbmwftXSaACq8m5QcOX0dpY1oxSIfvkFNL3F2WlacQXsv7MsBDvGfJ09qrg3MchXX7H
 7ydKRKy32e5g9EeedNsY1QPH6nEhgLsqytyj6LJMPM4ae1uvXFQtEHFAs1dRfxYRRrII
 PtPw==
X-Gm-Message-State: APjAAAXqpu1CT7UuyLgK8J/gSB/V18q0+msecz868d5JGPRzStILS5ow
 A8WD72arYr6c19+p1BRYcD4=
X-Google-Smtp-Source: APXvYqxN+oDJWC33Bnqipdlj0RVLZRRbxvQfl5t3tWU1042c+oyk+U9bH88UnmSjFpj/Me2oq+QXQw==
X-Received: by 2002:a1c:3182:: with SMTP id x124mr377956wmx.168.1570470179609; 
 Mon, 07 Oct 2019 10:42:59 -0700 (PDT)
Received: from kozik-lap ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id s10sm164130wmf.48.2019.10.07.10.42.57
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 07 Oct 2019 10:42:58 -0700 (PDT)
Date: Mon, 7 Oct 2019 19:42:56 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH 0/5] hw/arm/exynos4210: Add acceptance tests to the
 SMDKC210 board
Message-ID: <20191007174256.GA9803@kozik-lap>
References: <20191005154748.21718-1-f4bug@amsat.org> <20191007091024.GC541@pi3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191007091024.GC541@pi3>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
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
Cc: =?utf-8?B?RnLDqWTDqXJpYw==?= Basse <contact@fredericb.info>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Evgeny Voevodin <e.voevodin@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-devel@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Dmitry Solodkiy <d.solodkiy@samsung.com>, Cleber Rosa <crosa@redhat.com>,
 Maksim Kozlov <m.kozlov@samsung.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 07, 2019 at 11:10:24AM +0200, Krzysztof Kozlowski wrote:
> On Sat, Oct 05, 2019 at 05:47:43PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi all,
> >=20
> > Yesterday Peter Maydell asked on IRC if I had any working Exynos4
> > image. I looked at some old backuped notes and could boot Guenter
> > initrd with BusyBox.
> > I'll use this cover letter to share my notes, they might help to
> > have this board fully usable again.
> >=20
> > This board is listed as "Odd Fixes". Since we have it covered, I
> > thought it was worthwhile to have it covered by tests to avoid
> > more regressions.
> >=20
> > Fr=C3=A9d=C3=A9ric Basse used this board last year:
> > https://fredericb.info/2018/03/emulating-exynos-4210-bootrom-in-qemu.ht=
ml
> >=20
> > I'll have a look a these particular commits he added:
> >=20
> > - https://github.com/frederic/qemu-exynos-bootrom/commit/9be5c9f2253dbc=
04ee
> >=20
> >    sd: add sd clock support to SDHC_CLKCON
> >=20
> > - https://github.com/frederic/qemu-exynos-bootrom/commit/6f045949ee2fde=
c624
> >=20
> >    sd: always reply to ACMD41 (SD_APP_OP_COND)
> >=20
> > Guenter also carries on this patch:
> >=20
> > - https://github.com/groeck/qemu/commit/0a80543cc910d
> >=20
> >   hw/timer/exynos4210_mct: Initialize timer before starting it
> >=20
> >   When booting a recent Linux kernel, the qemu message "Timer with peri=
od
> >   zero, disabling" is seen, apparently because a timer is started before
> >   being initialized.  Fix the problem by initializing the offending tim=
er
> >   before starting it.
> >=20
> > It might also be interesting to use Krzysztof's initramfs image:
> > https://github.com/krzk/tools/blob/master/run-qemu.sh#L29
>=20
> I haven't been working on QEMU since 2 years but I can try to find that
> initramfs image.
>=20
> The recent initramfs I create, is for testing kernel under my Buildbot.
> I take standard initramfs from Arch ARM and then I add some more stuff:
> Source/instruction is here:
> https://github.com/krzk/tools/tree/master/buildbot/initramfs
> and the script making it for each boot is here:
> https://github.com/krzk/tools/blob/master/buildbot/build-slave-deploy.sh#=
L50
> https://github.com/krzk/tools/blob/master/pi/make-initramfs.sh
>

I checked my initramfs. I created it simply from a running Arch ARM
    instance with `fakeroot mkinitcpio -g file.cpio.gz`

You could automatize the process by:
1. Downloading and extracting
   http://os.archlinuxarm.org/os/ArchLinuxARM-odroid-latest.tar.gz,
2. Running mkinitcpio or creating initramfs manually (e.g. my script
   above).

Best regards,
Krzysztof

