Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7B1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:22:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B7320888
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 15:22:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tc6QmSVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B7320888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeKMX-0004OU-U6
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 11:22:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeKIC-0008R5-S1
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:18:01 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29]:43737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeKIB-00012C-9X
 for qemu-devel@nongnu.org; Thu, 28 May 2020 11:18:00 -0400
Received: by mail-oo1-xc29.google.com with SMTP id u190so5786719ooa.10
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 08:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xqL5+lFiOehshGmdO3WlGflxD2371215xA9kGAmA0no=;
 b=Tc6QmSVefxCYzguKHCjCbLC1T4eHPHSsVpacDK68oQ+QcpJdeyUanXYwuBMD6piAo0
 6Z50jzCIVi0GqgZHt8fBDkoxCIbq4XZlmi5hBSvkFhjmS/nvZLeGANGiGok+luiR57G9
 C17tQ7IYxw/d/SXPVNmr131qdK4Hkjc3XOMOiHhlXW/NuScb0sr1G9D0yqhALInKrRLn
 VAznBT6Dtfi1WcCIdVutSZ0i1cj4PbASuLMEOJAOI6dy0Ruczee6cOkNL3HfYXh1VaKS
 dEXlrsEi1ZnvCBjQzLfucVwzEVojObwBU7BBOyO/BQZovM6jiaPvrcT0XBdSAbPMpGKF
 b3wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xqL5+lFiOehshGmdO3WlGflxD2371215xA9kGAmA0no=;
 b=MSbYsDF3ghyF9c3mBI28lRTFvcP4tznHwmixdTMh4KWlrlnXK62izJsJ6sJq1x50Vc
 2LyMXUIgcDqAjswFFTcx/QzodGbxDKRBH271N+MD6kKnDFiYMIEhevCq/71xzeoNQ2fT
 5FuSQIPY+jaDkp/0c8n+qq0mEIU35ApZ13C51xHFTo97xjfZ34x+HWEiV/fvQzPh2hPb
 ylbDqAIYRPq9Gd3aCqSObuxlbMj7/FN1r5gzA4lQyADV8yyBumzwZ7TcYA3WQPzD8YhG
 iiPYWHqk4XUnWsUBGKeWVCC8zUs1dE0ouvak5No3ylozUZowD4GMlI1mAZSJ1zE5I9lB
 Dnig==
X-Gm-Message-State: AOAM533ItFgWpNzQ8LYYPU4fUUM/jLnUpYDdA1rljPbnpFutrYAypfeG
 VK8slnA3FAcP6zF17pa5eAOR0TEnBIFf+nN5qeKO3Q==
X-Google-Smtp-Source: ABdhPJwcnAvwYEwyz6cY7jyAgMe1QXv3FLuAoIbqVPv1oGgZZ5+c+9Auy9PhbYKa9J9vGS0oUhS41pAEQgQPkychqs0=
X-Received: by 2002:a4a:381:: with SMTP id 123mr960031ooi.85.1590679077643;
 Thu, 28 May 2020 08:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200527182617.1979018-1-alistair.francis@wdc.com>
In-Reply-To: <20200527182617.1979018-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 16:17:46 +0100
Message-ID: <CAFEAcA9faRTHp5+jhEi=m=p-+kstCUZif-k2xN9b8K=hFukVBg@mail.gmail.com>
Subject: Re: [PULL 0/1] register-api queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc29.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 at 19:35, Alistair Francis <alistair.francis@wdc.com> w=
rote:
>
> The following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84=
f3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-2=
0200526' into staging (2020-05-26 20:25:06 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-register-api-20200527
>
> for you to fetch changes up to 5932a46c8a419db4a6402ac8ae42953b4d4fef1e:
>
>   hw/registerfields: Prefix local variables with underscore in macros (20=
20-05-27 11:23:07 -0700)
>
> ----------------------------------------------------------------
> A single patch to avoid clashes with the regiser field macros.
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (1):
>       hw/registerfields: Prefix local variables with underscore in macros


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

