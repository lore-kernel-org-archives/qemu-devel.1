Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B9AC2BA2B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:06:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E72120692
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 15:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZRz1q3WU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E72120692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLpnb-0002UA-8T
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 11:05:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35190)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLpmh-00017z-3v
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:05:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLpmf-0006rl-Nt
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:05:02 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:35624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLpmf-0006qS-II
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 11:05:01 -0400
Received: by mail-ot1-x32b.google.com with SMTP id v2so3452810oto.2
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 08:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=wk6nLUiREfqskty51a+9CGWC5RZhegtf1MFVXc+//ns=;
 b=ZRz1q3WUl7nHJol48t38pkDJamlOBl3uuVoFubKwoW/6PWFCbQ/gx2QQYU07evaxCm
 sixFNrXxEiITfb/4oRTvsWxtVgt4P1lWcGRUKlYs+gi3jwh6BmvafVLA3XZaljXt6zy4
 L8AepDNGV8rH7w7b5gDsOO+rZgbqcWHRe845o6KUobihxAMWvKbKHA1uQdOiB0DVW1+5
 p8GyA+QXuCpxheHOuoWvlVf03JIcflxSdRXR4ixIipX4V0lAoylKF5/t0LL3PmgjqyTX
 iXVj6NYGxP9eay8kGX0YomPuG0U/Hk151Z2po2Dm6ibT5v9mtTk3KTVd6Z/mbIqgQ1WZ
 bykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=wk6nLUiREfqskty51a+9CGWC5RZhegtf1MFVXc+//ns=;
 b=FRMp4FmEYEk/uymgY5ylEcCAKMB5DvxusAYMDX5uhDhCyWRmFc5Hm3CA03hFFAOwcz
 e1122cnFumYfqW/z+DCDbWNrbRCBo23jqWmVsdltd+jY1yGhYJSR1Eli0h26+5j3WRaq
 DKVKWzDzQdn1W414fv6DdxtWVA6CR67E24Km8l31ieAagSiEkSOsGHmxUEJwl9/2hl3y
 4HWAQ/Xc1mBx5px2qD8dJn8hJ00gL1J14OuXG8vmHitobzhU1PYDQ06knBkb8k7CC5gE
 bZdHeyJNz0AFeCuhWLBMPZnVhSdFZtaZgmkgpBVKs21kKSPOhY+h486+dur7O6rf7rPg
 f8HA==
X-Gm-Message-State: AGi0Pub3T07B+uaqCI2yAIbSauZ9kZILF1LkDU96LA9ZTm85llOBhmEV
 6T8U6awfFY5YvMY6YUjvJrtiCxMi51xCarKec5qb1Q==
X-Google-Smtp-Source: APiQypJb9DReDw2fba5fXAXkB0oHF8879kWNO1spBkt9vRJO3lT+TknHJPu6EA//mPLpUYl7Fpr3F9MPz/L+miCraz0=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr1852153ota.221.1586271900016; 
 Tue, 07 Apr 2020 08:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200407103920.32558-1-philmd@redhat.com>
In-Reply-To: <20200407103920.32558-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 16:04:48 +0100
Message-ID: <CAFEAcA-hKMYZm=MHfPKQs76=2aGZn51isz8Y=-Qg5d9cR9DKwg@mail.gmail.com>
Subject: Re: [PULL 0/5] Acceptance tests fixes for 5.0-rc2
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
Cc: Fam Zheng <fam@euphon.net>, KONRAD Frederic <frederic.konrad@adacore.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Apr 2020 at 11:40, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Another pull request on behalf of Eduardo and Cleber.
>
> The following changes since commit 53ef8a92eb04ee19640f5aad3bff36cd4a36c2=
50:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
0040=3D
> 6' into staging (2020-04-06 12:36:45 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/philmd/qemu.git tags/acceptance-fixes-20200407
>
> for you to fetch changes up to a41f167547ec4e4752795572193d1cbb889c4885:
>
>   .travis.yml: Cache acceptance-test assets (2020-04-06 20:03:14 +0200)
>
> ----------------------------------------------------------------
> Acceptance tests patches
>
> - Fixed EXEC migration
> - Reduce PReP/40p artifacts download failures,
> - Disable Leon3 HelenOS
> - Speed up Travis-CI job by using a specific cache bucket
>
> CI jobs results:
>   https://gitlab.com/philmd/qemu/pipelines/133379305
>   https://travis-ci.org/github/philmd/qemu/builds/671762970
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

