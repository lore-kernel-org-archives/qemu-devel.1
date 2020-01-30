Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AA0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:44:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2086620707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 13:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qXMfA3Wp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2086620707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixA7h-0000e5-Bn
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 08:44:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49960)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ixA6n-0008OM-3c
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ixA6l-0007oH-TU
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:43:49 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32946)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ixA6l-0007mT-NP
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 08:43:47 -0500
Received: by mail-oi1-x242.google.com with SMTP id q81so3563185oig.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 05:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=OkXZ5mBnjCBuyBuOnpbdspAfHsDoISRmIcMli/2QOx0=;
 b=qXMfA3Wp7sjcxcCi/q3pxYPbEG6nqjEuIuFBNPIKKMSBCPfK6U4kwgf82JxhUdtGpS
 52jjpgyY2Jomh2jxk570ldcJohdIpcaarEhFdrScM4OztonoQ4IVOVFAZS9xNAwZ9bz+
 WRBftE22ncG0DVCci71T1+RFlfXY0J2jPV2SXrg4+MXy0TVu2gdOiHVlluE/UqKiNPB6
 k/sqLxn0zEEB+fhZCPmrsP5StuHAqYb+9oXCVQokU7bxfD3vea5hFVzYc+RMi90AtaM1
 ixWJWCIjBzfIZb9Iz3geSLO5hjpjWj5rkcpzzDI6TF1aPvtc9fegnjf01EBcQvvrtpOb
 ESUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=OkXZ5mBnjCBuyBuOnpbdspAfHsDoISRmIcMli/2QOx0=;
 b=VKF5P3WDKMhYIrd5Icv49B/uuS9nRx8y733YjMN0hcYP7iaeVd4JUxg/o1l75CzN6p
 FqXBsLMr5k2RO8yURvG/7Q8lQF50mKzeV4hDJW3/+1wub30hgnVH2lSQ20TPlisRWNDI
 aaCJNw/jEqJkMYVfbsgD8ajKwkU8jTy57EkhB+18lbENhKWvsd5Fi0k6Y4J+WbLa4DQF
 A/HAVlNzFouMPqOMP3y9zi8nyJpa7ueGVzbsk/+DmynoQaXDcSA9FepT9Jq/m/ilATik
 tOhQ7F7Ybbn2IDrUWvSX5bOMYAZX6xaXTqVS/ftyXhDUOIzGZw9v/pWztwYiiqba+gT8
 8dWA==
X-Gm-Message-State: APjAAAXQgePIlKkI0ZZ+CNA0tTjAAYfDcZmNwjjziULHgAhNuuRNc8Hg
 4DuRcvXw1FYD9cVRCbDXJivNm8Fm5nmeCqHWxxkxUQ==
X-Google-Smtp-Source: APXvYqwbjHFgg6QHD7tv2supcMcuGDng2PEI8s6G0yXayDNk4hv1SpxuCy022Qw2UulmiRNH2TCDR/LiZS4KkoW92H4=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2881404oif.163.1580391826827; 
 Thu, 30 Jan 2020 05:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20200120235159.18510-1-f4bug@amsat.org>
 <773d1201-17fc-40b1-fa9a-06ed03732e89@redhat.com>
In-Reply-To: <773d1201-17fc-40b1-fa9a-06ed03732e89@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jan 2020 13:43:35 +0000
Message-ID: <CAFEAcA9+_Ok=CbvfBK5oOSPK04FJQi=ZCX7sjFeDwJ0erH1+Cg@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] hw/arm/raspi: Run U-Boot on the raspi machines
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Laurent Bonnans <laurent.bonnans@here.com>,
 Cheng Xiang <ext-cheng.xiang@here.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 at 06:53, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Hi Peter,
>
> (Cc'ed Wainer from the Python part).
>
> On 1/21/20 12:51 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Following Laurent report:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg639950.html
> >
> > The SYS_timer is already merged, see:
> > https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dd05be883fc
> > "hw/timer/bcm2835: Add the BCM2835 SYS_timer"
> >
> > The first patch should fix Laurent other issue.
> > Then few python patches are require to break into U-Boot console,
> > and the last patches add U-Boot tests for Raspi2 and Raspi3.
> >
> > Laurent, if you successfully test U-Boot with this patchset again,
> > do you mind replying with a "Tested-by:" tag?
> >
> > Regards,
> >
> > Phil.
> >
> > Since v3:
> > - rewrote '-smp' fix.
> > - tests use Debian 'trustable' u-boot.elf
> >
> > previous feedbacks from Peter on v3:
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg655415.html
> >
> > v3: https://www.mail-archive.com/qemu-devel@nongnu.org/msg653807.html
> > Supersedes: <20191019234715.25750-1-f4bug@amsat.org>
> >
> > Philippe Mathieu-Daud=C3=A9 (7):
> >    hw/arm/raspi: Remove obsolete use of -smp to set the soc 'enabled-cp=
us'
>
> While the first patch is reviewed by Alistair, the rest (acceptance
> tests) still requires an eye from Cleber/Eduardo.
>
> Can you queue the first patch via your qemu-arm tree?

OK, I've queued patch 1 (and dropped the rest from my
to-review queue on the assumption that somebody else will
pick them up and/or you'll send a respin at some point).

-- PMM

