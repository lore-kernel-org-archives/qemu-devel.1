Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F08502063A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ma+1AfQ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F08502063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k998i-0002rw-8S
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47004)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k997s-00025Y-VM
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:38:45 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:35934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k997q-0007FK-BI
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:38:44 -0400
Received: by mail-ej1-x62c.google.com with SMTP id kq25so2815625ejb.3
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=RXeeXGGmG+/dZWk/SefzpclsyOKIefCTMUadtAQhlMQ=;
 b=ma+1AfQ3C+VLP3AcqhLVUzhhL+BWpHEoz4/w/fid3mFrbUaHbIq7E8CjGyL9a/yqoQ
 gKpSO/skcqNlpvATdDWTJXckUr8G1lCSoqjnNsqC7aSrU3rlhsbE1M1SNnO37je9P9H0
 igxnfBrJ2K3PxMBNtwbmKlzNgHA7ET8iuFACnsT4ziY57PL1hUVMRPsGqTGAle70+mFk
 gPI7m1/CLmCAu3yrqmVJy/917A0j350hZKgMFJy4ZvQuwaplhMzVBTZ5+V6rtnsmwmYQ
 +u9jGBKTEfaUUZuipM/u7JpYv+Y8BgH/9U9zdVa0CdvOFOzKvek9rqcG6Sw1SBHjuuDY
 z5Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=RXeeXGGmG+/dZWk/SefzpclsyOKIefCTMUadtAQhlMQ=;
 b=XZFJ4nokaqy+jJry4QY+2Q4n2Ugyeg9cOA8qKzwDYs6U5A23HrSKh79qUlFnYeeYCy
 lRa4NGNlsbXcjaNfIJdAYRtBxCH++4iSRV1zJ53C+8/xfJy7/sr71KupJmf/1vVupZRl
 emG0HdRLGJ547o2PboxNxeQ32DCYyHu8TGysvl6voIn9xbRTW3LFujfc35OheTb2QSaM
 YdHyqnCW8Wq26QEl96Q/lPy7I9rwfYsKx+QDs1PucKTrpbEvY00qofZNP4pJCuwZbFhl
 /3MKnoNNoi1RxbBEWEgtqw7Hge7VDRtpGKYe3c+6L6Ejn799K4Ih5B8g4vGKIyrl/hf9
 vQ5A==
X-Gm-Message-State: AOAM533luS7nFI6MCVPHpJvWWIrhYKde7oyqm+PCmQ35r/3NN9lucG77
 Xhj4AvIHpJv2fc8zjMpy2LVkV7Ty6nT1TQCnHYQ0zg==
X-Google-Smtp-Source: ABdhPJxSLnKuRTXpesvip6hiijrmfnyQBYQ/QoqkqBD2MjBKKmc11AwNUk3hoNRMZTjVt7p576XkQw2kofokiiK4UwE=
X-Received: by 2002:a17:906:7fc9:: with SMTP id
 r9mr3245530ejs.407.1598024320615; 
 Fri, 21 Aug 2020 08:38:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200812131822.28162-1-philmd@redhat.com>
In-Reply-To: <20200812131822.28162-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 16:38:29 +0100
Message-ID: <CAFEAcA93sg3oXfL8BsbhWGfRswD9F+065itvqHQo+MFjm6_5nA@mail.gmail.com>
Subject: Re: [PULL 0/2] Acceptance testing patches for 2020-08-12
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 12 Aug 2020 at 14:19, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91=
cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/acceptance-testing-20200812
>
> for you to fetch changes up to 0eca1f4b5c1a6cf8f05ff7da72a4e97b41894e84:
>
>   acceptance: use stable URLs for the Debian and Ubuntu installer (2020-0=
8-12=3D
>  14:14:28 +0200)
>
> ----------------------------------------------------------------
> Acceptance tests patches
>
> - Use stable URLs for the Debian and Ubuntu installer
>   (Ubuntu has been updated last Wednesday, August 5, 2020).
>
> CI jobs results:
> . https://cirrus-ci.com/build/6385815351721984
> . https://gitlab.com/philmd/qemu/-/pipelines/177054604


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

