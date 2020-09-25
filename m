Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A5CC4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:11:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B80EB23718
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s3Xv3eFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80EB23718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqJe-0000n5-G2
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLq3a-0008Nu-3J
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:54:46 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:41269)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLq3W-0001ZQ-9G
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 11:54:45 -0400
Received: by mail-ed1-x52a.google.com with SMTP id ay8so2971635edb.8
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 08:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=qBdnhASA3CmGwJ2xz4tCDQllu/o2ASkjwGqbZtwFZ2w=;
 b=s3Xv3eFRLW2DfehCne8Xah3L/sttBtR/4FfSnQ4QHS3sIGBGkuhiNEya+c739HeGdH
 uRszAZMuLE1Kgux5Bsn08Wr9nKsg5H777v+1LXWkqvNjWI10/ADpSdBWBtKhNNIcwIZk
 l1JiIveW4gJiWadAw2Te8HIj4J5bKT01G/OxAg1oPgWVqYKX/77p2E9NQVVFFUnup2t/
 D0Jovx7b9vvlO6QCc679wWXfyzFCF4ZhHlsBOe6EZ8BkdUSkj0fFTeyjy3iCxfk/WIxa
 RqvSNRrljdMAq+ZQxdFVpmHxDx0/J3Ug8cEadQGvuoBBGeXyDxHGJCUCJr6zDvbHVVv3
 Yasg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=qBdnhASA3CmGwJ2xz4tCDQllu/o2ASkjwGqbZtwFZ2w=;
 b=P5sMc2ixJ5UMlpedA7T9Wlc25KEh+hcd8D13CYElAg1aS/LPA3qYd6bBEBgPJFmrzZ
 rS5O7V7hH7xDYVFFliOQTiJgwoFIILi4GTYptwuMrmr6hjxZIPBH4vn+WNSY5WHeLGJW
 QIcDtLiqScSmA9JxrPjfc7zyF3KXzI8pnx5RgvAeaI0bfNZDpzdrv0cYeiCS5zZaJo8E
 sNE//InG6yw8FTyzq5Be74Fp3+sx3TWr6qVYWjO/Ua19SGNRRbbCKpJHLbeaiImfNMaJ
 SMUoaBhqJ60rhnV7IesofUOCdw3WRXrKFWDMbMH7KUggwWLVWgj5g1Z3G5b0s09adsfT
 PFXQ==
X-Gm-Message-State: AOAM5322Uv8NFbt1PW9TcLuIpqWWgQlqpqiTDvQYOyOSHQuwQz/rY04x
 rIJhixx/cqvLXDRflezUWWR0pLuMd/aBgWuxEHS03w==
X-Google-Smtp-Source: ABdhPJy4wwY/+ai1lvN0UqfKEHg/asCi3V/GzSVPpwrKwor/2WEURf9IP2we3ek1s9b0kMFmToPe/Zw2bcyW4cFsZnc=
X-Received: by 2002:a50:f28b:: with SMTP id f11mr2015908edm.44.1601049280207; 
 Fri, 25 Sep 2020 08:54:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200916122648.17468-1-alex.bennee@linaro.org>
 <20200916122648.17468-8-alex.bennee@linaro.org>
 <CAFEAcA_UEoe2H5zc=L1T3p31FoxKSfG0mRznN-68FQmGTp3+pg@mail.gmail.com>
 <87imcdzwh7.fsf@linaro.org> <d04bee00-624f-c48c-89a1-d5e6cbbddb76@amsat.org>
In-Reply-To: <d04bee00-624f-c48c-89a1-d5e6cbbddb76@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Sep 2020 16:54:28 +0100
Message-ID: <CAFEAcA8PioiyU2t9bqJW5_HiQQKrhOScTQFBd+a7BY-fH802sQ@mail.gmail.com>
Subject: Re: [PULL 7/8] gitlab: create a build-deprecated target
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 14:52, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Should we stop building the ppc64abi32 target instead?
>
> From c609274b853 ("docs/system/deprecated: mark
> ppc64abi32-linux-user for deprecation"):
>
>  The ppc64abi32 architecture has a number of issues which regularly
>  trip up our CI testing and is suspected to be quite broken. For that
>  reason the maintainers strongly suspect no one actually uses it.

It still builds fine and it also runs the 'ls' binary in
the linux-user-test collection (ie the 32-bit PPC binary).

thanks
-- PMM

