Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B6CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:19:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A90E206DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 17:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWvnqJcb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A90E206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUm5-0005tF-Fh
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 13:19:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59410)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsULN-0006XW-Dz; Mon, 06 Jul 2020 12:51:49 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36346)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jsULL-0004ns-Lp; Mon, 06 Jul 2020 12:51:49 -0400
Received: by mail-io1-xd44.google.com with SMTP id y2so40081907ioy.3;
 Mon, 06 Jul 2020 09:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=I5OtyPLT7kBESQJdicuZvnddGyuuciNxesWYzy+1Mjs=;
 b=SWvnqJcbBzJhYu/bXOQ+hKMBozzb7eF3y1umz2Fokk6JFjrelpEkePXIkPUQI6mFbk
 dpNENf/rU0eX76Tb7AhqH1ePGEthpnO6IPXUbz5EB61DvQoQNAIaU6DIIcdVsHVVmws1
 OJmTSVXUAWSPLMLvjQYBAZbYqF9f4sjGiV0YeH+hV/Yh6jvcGGJoC6+D8VS+BKiWQFiC
 twpJaf07uRx63hrFyGfmKpi96tTYFsmPrbopnqHQaIlfY45bKyT0r6p7ISvmBRziwuIM
 0nR5egIBBH7M9ocIb3VqLSVkZu9wIECRqjJ+MNF8U/yM1xaPvKo/BzfuUJME/NJEBAVN
 c8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=I5OtyPLT7kBESQJdicuZvnddGyuuciNxesWYzy+1Mjs=;
 b=C1YW5f7KI1oc+KDWVTBvUmTwwoGNOJTTTorPBO0451eKmTVXEMGRB4Ng7HZdEG+a7C
 QwJYGzcxAj6kV5XMXO0Q24QiWA5Ss6Kuxfm97UAf7D4Uqo0vfc8qlbZgI19n6Tf6tnXr
 gi7LxvmJR/8mjLq0d6qL8a6ysdlcH0HhaHDc1IC6w7hABRWoML0p//Saxo/qWOLMxzzN
 1fQ7ca51E/claJv4dZY6dLozNUNeHKgyQ52OyFNHonHP0S4vevH5tyXAK/E0sNYG/quj
 +Bbt4WZCLb4NB/745eRgon9Bn6A0RAn2GluXUaoJbGQLadXnJxQMXxDuNkbeORgsbRcR
 q6Yg==
X-Gm-Message-State: AOAM532Wcb4twetuLB94ahPXVHALV2iapJ0l7KudIxLP8FMfXB7J9UTq
 uEBMH1LjPiVXq4Cu52L7E3E2FCHoXwaf6ZqdYC0=
X-Google-Smtp-Source: ABdhPJx32i6E6M9MufdeJ2NSghV6Tz6CYvlrUgC0MSQ1lEqz+1dNzvxla71CiRMtdTXGIMrAfoAe/BclQ0FduoBB8B4=
X-Received: by 2002:a02:10c1:: with SMTP id 184mr52968031jay.135.1594054306418; 
 Mon, 06 Jul 2020 09:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200705220731.28101-1-f4bug@amsat.org>
In-Reply-To: <20200705220731.28101-1-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 6 Jul 2020 09:41:58 -0700
Message-ID: <CAKmqyKOR80ORZEdzDzi5YJX7+=fsyL+9_OJwUf-_O_nP9wZ6mA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] hw/sd: Deprecate the SPI mode and the SPI to SD
 adapter
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <huth@tuxfamily.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 libvir-list@redhat.com, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 5, 2020 at 3:08 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org=
> wrote:
>
> I tried to maintain the SPI mode because it is useful in
> tiny embedded devices, and thought it would be helpful for
> the AVR MCUs.
> As AVR was blocked, I thought it was wise to deprecate the
> SPI mode as users are interested in the faster MMC mode.
> Today Thomas surprised me by posting an update of it!
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720089.html
>
> I'm still posting this as RFC to discuss, but I'm reconsiderating
> keeping this mode a bit more.

I think it's worth keeping.

I'm pretty sure the HiFive Unleashed (sifive_u in QEMU) uses SD over
SPI. There isn't an upstream model but I think there are out of tree
patches that hopefully one day will make it upstream.

Alistair

>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/sd/ssi-sd: Deprecate the SPI to SD card 'adapter'
>   hw/sd/sdcard: Deprecate the SPI mode
>
>  docs/system/deprecated.rst | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> --
> 2.21.3
>
>

