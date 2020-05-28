Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9937C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4EAD2071A
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 16:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hPt5FD3Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EAD2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeL6r-0008CO-Sf
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 12:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeL2l-0005fL-6L
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:06:07 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:41868)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jeL2g-0002RO-T5
 for qemu-devel@nongnu.org; Thu, 28 May 2020 12:06:06 -0400
Received: by mail-oi1-x230.google.com with SMTP id 23so466398oiq.8
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 09:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FmQPhQdx38sSy1VSGWvWI0AsSYe4MKxKZySiJlpQwj0=;
 b=hPt5FD3Z2jXehFijuQkilXjxAiwcpKGwSECqxvUqgW2EpuIrZ4iUzB2TJrqJQrYtA7
 BZxRCZDpnLZoyDiVNfjxr0MW5ZAld1CkNuF2ju7jrfa3Fh7RHG2MuZak8obNoIpMZ2AW
 jBLX/OATQPtT27V6wyOzy0lrXErWNKmGyrJk3X/q7cx71wpbqLNJh5VjyBrM22oZ5uTG
 7xYS0qrAaqby7GJGH4JsSiqhkBu1oRSd8+tTR+OqfZRwrvc4LijBLVczfrd8j3S9OCnb
 ErJiqVVFX5GR4pZ6Dlz5PkgW3kFYtkL5p3SEPORFmnrOUOjCDrwPN0wngtUmUvIurhvK
 ezgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FmQPhQdx38sSy1VSGWvWI0AsSYe4MKxKZySiJlpQwj0=;
 b=ZtSYXm7i5jovhJ3oBTKjizsgmZ+9RAOiMWjQZsh+YdcRdji9G9qfJ4bzQ23xh1wDa7
 vjCxGm2AJdNz+eHb30d53dxT9jGfSIBp1XTw1xswJwV4WfXrJA6y6lQl252Z06PP/mzW
 OXmHpfpNpIHAHVczuYRPKZq+VuVw67TuzRM6sDMJ0+AWhQLalnFwq9Hb1irN1753iMDC
 0hzIAbOGxPAQfgdCa3bDZlEgOiOeQj8vaim4AVN/Erif07RUJuWlWelEQCDOF7zOnUfX
 fdbk9lyzzN6209KMyPJ/s1XdLdl8kA7Djo3AQWoenk6/lqKF1j1fAdcVa9Wm38+A5MCN
 7IYA==
X-Gm-Message-State: AOAM531/zEFmeGPPkDF/z5hhjTinuEsUvoYD2rkxbivyGT18GLXyq4Mc
 ybaKs5yUPSz4CzQZG1M8k0s7Mxo06GsJAEyFKnI3wA==
X-Google-Smtp-Source: ABdhPJyLT8dktE4Jw/Pc23dJ3JeBtTBOpRvj//6grBrLrE9bTR1cx+ZDGwvoAlOh1QON5pzGGcWkgJXbsbzZ6PB8kaM=
X-Received: by 2002:aca:ed16:: with SMTP id l22mr2591402oih.146.1590681961062; 
 Thu, 28 May 2020 09:06:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200528101039.24600-1-thuth@redhat.com>
In-Reply-To: <20200528101039.24600-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 May 2020 17:05:50 +0100
Message-ID: <CAFEAcA9Q4rE2zDywq=4fe86hwZY82psZre7BCTUMAOHYkcEqpw@mail.gmail.com>
Subject: Re: [PULL 0/7] Gitlab CI fixes and improvements
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 28 May 2020 at 11:10, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter,
>
> the following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-20200526' into staging (2020-05-26 20:25:06 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2020-05-28
>
> for you to fetch changes up to 0016afa250d251a1b3fbc90c6d618e7f00e02f14:
>
>   gitlab-ci: Determine the number of jobs dynamically (2020-05-28 11:01:38 +0200)
>
> ----------------------------------------------------------------
> - Build with other images instead of the broken Debian containers
> - Fix building with the latest version of Clang (at least wrt. to
>   the gitlab-CI pipeline)
> - Add Philippe, Alex and Wainer to the Gitlab-CI section in MAINTAINERS
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

