Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FFCC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:02:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D701207DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q/i9TN9B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D701207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtnz6-0001q9-B4
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:02:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtnyA-0001NN-VS
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:01:19 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:36988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtny6-0001dw-Tv
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 04:01:18 -0400
Received: by mail-oo1-xc42.google.com with SMTP id t6so837831ooh.4
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 01:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=NzI5G6Hr2anh71ZlGxqw+NTS6MRYKSJREeFl7VWQ0tU=;
 b=Q/i9TN9Bv4F9fUFkiOcRp+SibneK4gsSVzjMrdHYXAHFDaCgjZAeQRvVRCqb73RA4i
 6d+wocHNDidfoJlC4XBlpL8Nj3hw1SRFCfqZR0uh6avyQBSU1XatARC96GbxfEAIZYwx
 gpqZVWvESdnTQXNHvVDE0Ufz/Nvo7EVKD5ixWd5aaNeat3HJAujK5zcigvvHLKVTFvlx
 StxQgsjtSZKJ57Rb2RTvAIeKxix6ROXEbwMEw90hZJh2COCdoUcbzGNDbWbMY7e0mUVG
 +Iy0ka2DzFQmmG7TYO1336S9O3G20d2r5GMFc0THjYTuztWekW3aYjAoHae7RLFi5Xl9
 PPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=NzI5G6Hr2anh71ZlGxqw+NTS6MRYKSJREeFl7VWQ0tU=;
 b=gfWuKvI10dH/R7z4ezQb/VU/EX0ovjmL1XdtjJSNjiKSfpiRSzI8bt4cOSGpXkJAPi
 Mel50XaV4X1o+s0vjWtHqt2RtEltfiwXRPIp9jsdeiRbNc00vaoXiHLPtQDfd48pgCn1
 71jTbkI/VGUsCOByBBg7mFaI8glsT7b3s6ueZpYLM3QOJNHrnGVC8m8T3o6zmxIURO+Z
 boepOdt5VlV38BbtpCduBcdYk+LwgZFPJOYC7CLMbvImn+IrxJfieYZSPhyNAsK524lE
 isqD+RXZon1/vhfFVyv3yH4sNQrwb03VWAHxER7s31pvqLndRL332ItmrAqMoGK4NSw9
 ZVkw==
X-Gm-Message-State: AOAM5331KgUBbZbdWyxAnyne34Jc4vGxcYxQlop7LUhYFouHAMeo0+1Y
 mfpZNfkN5x8Nd+w1igy9+X5NdGpuPA1+Dpo6m4+6XA==
X-Google-Smtp-Source: ABdhPJzz1EZDGDTzRt5fLbccqgNu0ZoeqlBnR7CZSd9jzLjzSM1vMc0wpzl7NPd2eckn9pehqGn7+LYWG9h6gM1tmMk=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr58041743oop.20.1594368073151; 
 Fri, 10 Jul 2020 01:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200704163927.28188-1-philmd@redhat.com>
In-Reply-To: <20200704163927.28188-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2020 09:01:01 +0100
Message-ID: <CAFEAcA_mH2ZU0wLs9QwUDY4aYjmRhSfOf6x5iXT=vdkCoof7GQ@mail.gmail.com>
Subject: Re: [PULL 0/5] fw_cfg/crypto patches for 5.1 soft freeze
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 4 Jul 2020 at 17:41, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> The following changes since commit 4abf70a661a5df3886ac9d7c19c3617fa92b92=
2a:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2020-06-=
24' =3D
> into staging (2020-07-03 15:34:45 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/fw_cfg-20200704
>
> for you to fetch changes up to 69699f3055a59e24f1153c329ae6eff4b9a343e0:
>
>   crypto/tls-cipher-suites: Produce fw_cfg consumable blob (2020-07-03 18=
:16:=3D
> 01 +0200)
>
> ----------------------------------------------------------------
> firmware (and crypto) patches
>
> - add the tls-cipher-suites object,
> - add the ability to QOM objects to produce data consumable
>   by the fw_cfg device,
> - let the tls-cipher-suites object implement the
>   FW_CFG_DATA_GENERATOR interface.
>
> This is required by EDK2 'HTTPS Boot' feature of OVMF to tell
> the guest which TLS ciphers it can use.
>
> CI jobs results:
>   https://travis-ci.org/github/philmd/qemu/builds/704724619
>   https://gitlab.com/philmd/qemu/-/pipelines/162938106
>   https://cirrus-ci.com/build/4682977303068672
>
> ----------------------------------------------------------------
>
> Philippe Mathieu-Daud=3DC3=3DA9 (5):
>   crypto: Add tls-cipher-suites object
>   hw/nvram/fw_cfg: Add the FW_CFG_DATA_GENERATOR interface
>   softmmu/vl: Let -fw_cfg option take a 'gen_id' argument
>   softmmu/vl: Allow -fw_cfg 'gen_id' option to use the 'etc/' namespace
>   crypto/tls-cipher-suites: Produce fw_cfg consumable blob


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

