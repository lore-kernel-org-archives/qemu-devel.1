Return-Path: <SRS0=QItv=AX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6CFC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 14:32:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15008206B6
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2020 14:32:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CE1hv7cO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15008206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jud27-0007Gk-5d
	for qemu-devel@archiver.kernel.org; Sun, 12 Jul 2020 10:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jud1U-0006nH-0D
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 10:32:08 -0400
Received: from mail-oo1-xc33.google.com ([2607:f8b0:4864:20::c33]:39090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jud1S-0000MW-5m
 for qemu-devel@nongnu.org; Sun, 12 Jul 2020 10:32:07 -0400
Received: by mail-oo1-xc33.google.com with SMTP id c4so1881136oou.6
 for <qemu-devel@nongnu.org>; Sun, 12 Jul 2020 07:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=lx9bTUr//Nmft0TGkJFu8a4mjaNcgCoDS0A/OBm8Lc4=;
 b=CE1hv7cOryAfP2h5CheJtB6Ic7+SHqN+hBrK6tFuIZMSZmTolKxIPHBMeh1B4QjBiN
 P11pK8E+0Jc6iwi2UIqfxec/3HfwM8L2fRcmCY2+LdfSCDEN50yvAgLLkzQZ/Iv4imPJ
 c2R10r/s3EJdRkpyPvWMIR8DzoV0cuP5QtEK38qaGWpW3zUqc27fwJWNdhxmUi3fahaQ
 HQALV0pvRYi4IWaU1Endqtk89LD0WtdaHkmixrQSBDi8wZIf7lGrZCkZBlcOppqz3+2A
 wgP9ZJWAL817MvdjSku6xzs3up3RhWwSEK3h93XQ7z5YZsnaWsRhlzy4WUoSQiRCX4A5
 F/ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=lx9bTUr//Nmft0TGkJFu8a4mjaNcgCoDS0A/OBm8Lc4=;
 b=ZkBhu6E1K1fG5YqTuWEmzwZJmV1swJWBhZ+fHofmts3AK3hYumyq8H/4YnEZkCphW1
 34Bq+XLaJu9bTC5LZprhxlt1ymsRbKPuvaxKUYC41kSiiuU1L1YvusgShalXOm8U6iLQ
 BTuYcWVugCJ94zh8UA2oMaGVg+uTOn7N9jfvcKWvRZL3D/a6B3U/B4DfpY0lPAQIZwH7
 t0ha8lBuIZOEHi/etpHNdPrxe3uZcYAiSyj/qrnzrkNAzyWExYt/EjQattvJDzTdA68L
 bYVoBPuBcFgM7eOtjxT7vvx2+1o1otKz0dvM808dE3phe2APAQNxGvKyBiPJ4xKfZ7bU
 pGRA==
X-Gm-Message-State: AOAM531TvSAVqFH/n9lzbLmmq+mmhyP6bb+XoaWcaAShueHTD/qVjWN0
 WepYzK4cfskoMF0SGErdEUOz9yV5HxM1TGtRNr2tNA==
X-Google-Smtp-Source: ABdhPJz/7S9Im9CUW4q2GFFdT3pvuMP8rYzFkcyykezK6k9v12+pkdpEvrPfp2+Oq5mHnqxe3qdKb+rvp6b1fvuH0t4=
X-Received: by 2002:a05:6820:172:: with SMTP id
 k18mr59541925ood.69.1594564323992; 
 Sun, 12 Jul 2020 07:32:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200711090544.29302-1-f4bug@amsat.org>
In-Reply-To: <20200711090544.29302-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 12 Jul 2020 15:31:53 +0100
Message-ID: <CAFEAcA-5iHCUPDPU+eA-ZV6_At2uHffLzDZqaFS--AoYZXOmfw@mail.gmail.com>
Subject: Re: [PULL v3 00/32] AVR port
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c33;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc33.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Thomas Huth <huth@tuxfamily.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 10:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Since v2:
>
>   Removed incorrect cpu_to_le32() call.
>
> Since v1:
>
>   Fixed issue on big-endian host reported by Peter Maydell.
>
> Possible false-positives from checkpatch:
>
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updatin=
g?
>
> The following changes since commit f2a1cf9180f63e88bb38ff21c169da97c3f2ba=
d5:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-07=
-v2'=3D
>  into staging (2020-07-10 14:41:23 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/avr-port-20200711
>
> for you to fetch changes up to 19b293472f1514b5424ef4d9b092e02bd9b106c2:
>
>   target/avr/disas: Fix store instructions display order (2020-07-11 11:0=
2:05=3D
>  +0200)
>
> ----------------------------------------------------------------
> 8bit AVR port from Michael Rolnik.
>
> Michael started to work on the AVR port few years ago [*] and kept
> improving the code over various series.
>
> List of people who help him (in chronological order):
> - Richard Henderson
> - Sarah Harris and Edward Robbins
> - Philippe Mathieu-Daud=3DC3=3DA9 and Aleksandar Markovic
> - Pavel Dovgalyuk
> - Thomas Huth
>
> [*] The oldest contribution I could find on the list is from 2016:
> https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg02985.html


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

