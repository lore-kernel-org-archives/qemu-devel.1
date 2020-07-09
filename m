Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DF3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6825E2078B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D4l4qXaA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6825E2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbFG-0006ma-NP
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbEN-0006AI-My
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:25:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbEM-0004gQ-54
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:25:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id e90so2390734ote.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TwE4/5g6BhhiF9NwVqNiFgWkPQe6TS0JnKm85vwKVak=;
 b=D4l4qXaAJN40wcqAAHhh5cXKLsfvdu3nikJQK8qVTGoi7/C1bnZaK9LXx+8CJ+H7K4
 VSEaDty94eOw1Cp0YBt3RhxwiGt9ZkV9a9nwYw+9bQmcbylitT9zcL2tZCbJxqpiZ2yF
 SchdkyiZXTUfm+pkStViHgd7Bs2BWhdzPwL5RNmIiMyHyGfHkmtVAb4L5SIOgrPogHcx
 8PbzrId68eFBALXEhOgv3rGVBYmaZbdArY3SxrNFAXxz33/znJFHtijaUxh3Q7j70/oZ
 xCdETCvFcysuli3pjmsIWK6LiAsesOI5VphJCWWoFzhcoTmO8Vz+tv8Rzqd64tcc1ItH
 IDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TwE4/5g6BhhiF9NwVqNiFgWkPQe6TS0JnKm85vwKVak=;
 b=j7GLKHGe9/I01LiQUABdv+D8CqcM70GQ9X4DEiVHdcMpFJOaHVmOZC19LU1WF1+L3s
 nXdGd/fayrOjVMvjklpfxNyHLe9llYeD37yXAHM3zr3wgU0b2cX0wAyYKpsCNqXKhL1M
 mXxT0+Oy8yNLLwrUSuDHNs73qwzNp8FjrmOKPYB4wnrOmknRj++eDszo5KmVzHfIR8Jx
 QDkse/MJts/vISl9UNHwarIc0aaaxE84VSnPnuib6HyfGZRLlyAp4A6Il5afO7sxZcbt
 /AQ/rTx/VckNUSMehPMJwq+wrqGghdYwxP+5IkLh5F3YL/QKvhyYTtHJeQ4UydQooqYv
 rS1Q==
X-Gm-Message-State: AOAM532fy0UTY6rlb1jvyYFxbd+MdnE5A4QSfM7wfgBjBC+QaJzMxtXq
 8Vop2KTRmKHlLmNSZu4i5D5zHDPEca/NMGqm73pdZA==
X-Google-Smtp-Source: ABdhPJxH2dekHZ/JY8R6+C8C6Vzg/ufrNAlVlobmF/EbHcIwKhRPTJMCRVPTbHUY4z0sgesfsMY9pD9J0uh8K89/SFM=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr47423557otk.221.1594319108787; 
 Thu, 09 Jul 2020 11:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200705204630.4133-1-f4bug@amsat.org>
In-Reply-To: <20200705204630.4133-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 19:24:57 +0100
Message-ID: <CAFEAcA8nxstjcY+fGnLXdBFSeDRBjL2mDv66bBDUrudc9hJLSQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/10] hw/sd: convert legacy SDHCI devices to the SDBus
 API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020 at 21:46, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> Hi,
>
> Since v3:
> - rebased (was from Feb 2018)
> - use named GPIOs
> - addressed Peter review comment (adding TYPE_PL181_BUS object)
> - convert DPRINF to trace events
>
> Since v2:
> - pl181: remove legacy sd_set_cb() (Peter)
>
> Since v1:
> - rebased on /master (Peter sdcard reset() patches)
> - fix milkymist-mmc from previous seris using instance_init (Michael Wall=
e)
>
> This series convert 3 devices using the legacy SDCard API to the SDBus AP=
I:
> - milkymist-mmc
> - pl181
> - ssi-sd
>
> Then move the legacy API to a separate header "sdcard_legacy.h".

Hi; I had a couple of minor comments on a few patches. Alistair
has reviewed the rest. This is all for-5.2 material now, but did
you want to take it via your sd queue or should I take it via
target-arm.next ? I don't mind either way.

If you prefer the former you can have an
Acked-by: Peter Maydell <peter.maydell@linaro.org>
for the series.

thanks
-- PMM

