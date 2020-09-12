Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E3FC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 21:54:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 022F7207BB
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 21:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v6+h96O7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 022F7207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHDTw-0001HF-Uo
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 17:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHDTI-0000ph-OQ
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 17:54:12 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534]:37447)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHDTH-000786-4X
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 17:54:12 -0400
Received: by mail-ed1-x534.google.com with SMTP id n22so14009655edt.4
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 14:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TDjgWtyR8kv0LpI898ysB93+8UsnNb/eW7pFzM1XCbw=;
 b=v6+h96O7QvTTM41mlClrkV+BpjCRxgvDCYvipOfLuuSdNsYJ7qKk7qLpbVxUNOnrqh
 fi8mCwUzB8SbKMjIwRRj+dMtQcyjIttc7+NgN1Z/M4ZE7nEpkzSfQ6TOLuTv1HDwN2mC
 2tJHy4RvdzcFRuQzmdzhYqta+IpMZs3AI1aXbc3q096qiUMt8ptHx9uMHs1XHm1eRNdr
 U4tCSG7Y9bdbIMVrfQOHGPtaioB6vqJttsR7AwH7hu8HDqLhCcqqUflS6fZnIHjYOnQk
 itm2IBrmIRI8JjZojChMlZPc5DH5L8mbwLUrgQ6UspeW7YWOtGpa+5nGwkRReTuzfPju
 fHng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TDjgWtyR8kv0LpI898ysB93+8UsnNb/eW7pFzM1XCbw=;
 b=EQbctIFSFPBCS+FGLwYoNQnW1ht9YCU3tqsY+SYwQOKcprgJ0lVuaKoqSoO5oIQPwD
 jkh+p5mXGgYlyzZLq9fJuzAgUp/g46A6nhqtPZvuRjMFqHKJdlacpc0HbIAOIwZUskRr
 i14YiJb2oj2z/iHlpYmhdcGoNJActknf1ymVhMitu0j4lUstGUX5145L/etQ5ushTU5C
 cvhsSRcE5nWXVuCNPoaUJz0ANmvnZ1sOYSV3Qpv0sEvGoPx8YmcFyKmEWA+lbj1qdh+s
 wZqNqM8c1Vi2kq8qe6j6XEEbCGK8MMbJBbrjoNrchA7X5zHpy1/IFZJkhH0BkBLN/VGQ
 /OZg==
X-Gm-Message-State: AOAM532FzJp53h8yk36BB5DcRs+CFdMrNy9mPIN6I/gXGJzSAwbDaVEF
 IWR3tte82gHjCwcOwQOct4xN+URY58KiIfY0+iknFA==
X-Google-Smtp-Source: ABdhPJzOJfShPJe65GziBSQ8N36+LJuEl6S6E9cmrrs+TJ4LSsH05DvfUhFDAo/QCeInN21/3ZoAss5M0gkqgJw1kkk=
X-Received: by 2002:aa7:dd4b:: with SMTP id o11mr9868933edw.251.1599947649084; 
 Sat, 12 Sep 2020 14:54:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200910100623.1088965-1-berrange@redhat.com>
In-Reply-To: <20200910100623.1088965-1-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Sep 2020 22:53:58 +0100
Message-ID: <CAFEAcA_16qNrpfUxgy4EntWi6ERCjTXJt2g4xo6FjLMGNr1rvA@mail.gmail.com>
Subject: Re: [PULL 00/17] Crypto next patches
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 10 Sep 2020 at 11:07, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a551=
8a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-=
pull=3D
> -request' into staging (2020-09-08 21:21:13 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/berrange/qemu tags/crypt-perf-pull-request
>
> for you to fetch changes up to 1b010d9339497b081c3b8ab4f98b2a21f2cae08d:
>
>   crypto/gcrypt: Split QCryptoCipherGcrypt into subclasses (2020-09-10 11=
:02:=3D
> 23 +0100)
>
> ----------------------------------------------------------------
> Improve performance of crypto cipher subsystem
>
> ----------------------------------------------------------------
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

