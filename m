Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A646C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 21:00:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E234A206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 21:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TQfTO9BY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E234A206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdKDN-0001KA-39
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 17:00:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33444)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdKCf-0000nL-Bv
 for qemu-devel@nongnu.org; Mon, 25 May 2020 17:00:09 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45950)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jdKCe-0003Tg-DR
 for qemu-devel@nongnu.org; Mon, 25 May 2020 17:00:08 -0400
Received: by mail-ot1-x344.google.com with SMTP id c3so14636126otr.12
 for <qemu-devel@nongnu.org>; Mon, 25 May 2020 14:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ph9LPORolCYrOZxQY9hTIW2ywccxlczXkbzUZWeTvV8=;
 b=TQfTO9BY1trsXNKR9NiFixkdzSkdInQyiyUXuGHYh4iTU1g+jmdqQmydQVWeD/N2L0
 hCvZOT5cDKz6psny2W4aNZKerglGPQkjsa72Osy6VaEqyvgdJ3Y3fQsDBJBKawBEK6oe
 cx4kBFa+ATWhRCfVr/naIynPAAC7UCxoAfRXy8bA4KYN2N9GxqFk1KTLTwpAQZGMoNI9
 wfKI4/46TB2shoMq9EFbnIzQ68n1tTy7R8dQ9xY3UD/DvJAf0z3LMigGvHuyMUMldbAd
 N75pItIO0v6wMlsIbTcpp1No0OMoNJslyrUm13A4qSF2/ZgaqLHsGTKsj8k6hcU4ILuE
 Ku1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ph9LPORolCYrOZxQY9hTIW2ywccxlczXkbzUZWeTvV8=;
 b=GCyk+w1obBib/ttCUEvG/m3zX00iGzM1yrn+02IQiIK+fM/VJ+UNDm7UHeGU64LsLu
 Lx6HPRzo/JMPdgMI4w728DCmoj1JcIgFw5JlOK2X2d1iIhHAAKPSKt1vEWKMaYHBpDa1
 7q3ItMrcQ6a4groncNiBktYSFfM6KKIReROOm6+EdLKUGJN4KZKc/qT9xU/QX4p/LoWK
 ekm8E8GkoGDWd3tCke9xH158uNJaACaM/18tQRrB2QrQg6u8WUHO4S061L/bzFKEkqpL
 vRUL6doAxCsft6zmBoDRR2dLjniJjOjGE0KD8kAzdNH2eCY/wBRxvlUzUer/OjYVqDD0
 IOxA==
X-Gm-Message-State: AOAM530KdDONhtlWlhjUyh6Uj+M2ABrWJwKo6em8KNZtenErEkd5HtGO
 IdLV4XHta0BNsHuap+Y9A6nPyhBxKfnpZmKXT/Pphw==
X-Google-Smtp-Source: ABdhPJzm3ZaYX0lqQYvddNEgmf4rsbZDr1uCQrgEJ1AEuurwof67S0rpRALrG2lp3THXA3V+bpqJUqd8uyH+t8gajWA=
X-Received: by 2002:a9d:b82:: with SMTP id 2mr21116041oth.221.1590440406740;
 Mon, 25 May 2020 14:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200525155826.11333-1-philmd@redhat.com>
In-Reply-To: <20200525155826.11333-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 May 2020 21:59:55 +0100
Message-ID: <CAFEAcA8UGjx5S+zVHX_Oon-ELaCRuLpXEDrjs0VoAwqJ7uPn3g@mail.gmail.com>
Subject: Re: [PATCH] hw/block/pflash_cfi01: Limit maximum flash size to 256 MiB
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>,
 Tanmay Jagdale <tanmay.jagdale@linaro.org>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Radoslaw Biernacki <radoslaw.biernacki@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Leif Lindholm <leif@nuviainc.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 25 May 2020 at 16:58, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> As of this commit, the biggest CFI01 NOR flash documented is
> the Micron PC28F00BP33EF. Its size is 2 GiB (256 MiB).
>
> Actually this "2Gb device employs a virtual chip enable feature,
> which combines two 1Gb die with a common chip enable".
>
> Since we do not want to model unrealistic hardware, cap the
> current model to this maximum. At least we have a datasheet
> to refer.
>
> If a bigger flash is provided, the user get this warning:
>
>   qemu-system-aarch64: Initialization of device cfi.pflash01 failed: Maxi=
mum supported CFI flash size is 16 MiB.
>
> Note, the sbsa-ref ARM machine introduced in commit 64580903c2b
> already uses a pair of 256 MiB flash devices.

What problem is this check solving? Is there some implementation
imposed limitation or a limit within the flash header format
that means larger sizes don't work? If so, what's the restriction?

thanks
-- PMM

