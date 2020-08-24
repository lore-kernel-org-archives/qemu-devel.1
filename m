Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702F8C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:13:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ECD9206BE
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 11:13:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poeefoj+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ECD9206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAAPf-0008SK-Gi
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 07:13:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAAP3-0007vm-Ez
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:12:41 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:46353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAAP1-0007TX-LL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 07:12:41 -0400
Received: by mail-ej1-x634.google.com with SMTP id d11so11150950ejt.13
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 04:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H9QY3U3xXyxQPsx//FMpmi8CiLgyO6VGbBhJCFVX+Hw=;
 b=poeefoj+/h16BjXYv8uaVCSqkzA+ZJpUZd0EsNUCWKTxu1PJwiCH4WdqF0nHWTNBap
 joN2ULDlYjHkDZ5SJgOXALQgSIrx5PVx2TF/6EKZe/bzfHjmoTCmr+e1YbVBkOhsMyO0
 vkaEm304kB84XlpzVk45IVwTBUBGCIxfcNHX1hK3Q8Lg6pm7LWUF8JvCMju691iGoltM
 c0As1UuKPBBycMlUG9FSFt02fzI7KEXvhENtTKcA3QrAwGANhCkvSycWIW9/RtfXGBqH
 aFuU0IhjBoAHD42KIMp+WLOzplhQ89iDov1w8yRC1DnLJ8oCkeeCeMSxx603WJ4Q3Tgd
 AlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H9QY3U3xXyxQPsx//FMpmi8CiLgyO6VGbBhJCFVX+Hw=;
 b=RxbobJua33Fvf9yYPz/yH6/PwGlk30KzVLbaT8BFOBsx0K4cEWEXofe9V55TwJsdXG
 /Kjy9R16ucbtMATrC5o9y5NH0XuoHuFFhL5kmVR5b3EtsNvdYS1L+GbvUs4ICV/PbXeY
 FtujLZ9a53xpiVP3RgBPuQohs4S3qQc4rXZJsbN8wBPWuJrBDBTDu+d9ONuPyB7TYs/U
 sVAMWoibGC0NGjeWuyCTXCYTRa72Te45pJwkgT07czZwIyvxD4xZmfVYYFCuqWRKlhnW
 LiboEg7qaOJJKFjDj218LhTIAw0aES2ugecSCU8MWJG9RkMrnt10rBBGDIR7wUBcuGmc
 GUJA==
X-Gm-Message-State: AOAM531EF4EaW9N8EaBfegK90X7bzgOzLH+Fj/grCsf8HeCzz6srv4/4
 Ibq/eSpvgRgq+RkbmvEzK3OHoAg7tFxdcbhgHku1QQ==
X-Google-Smtp-Source: ABdhPJxGdLlhHKsst7x1jAOkrPnkxRi7+ahHswHGakUlwyH4WtXXmcB/ngforuBMkEYbZx5QFxR1ni9oLoO3uxJaU0w=
X-Received: by 2002:a17:906:68da:: with SMTP id
 y26mr4893207ejr.250.1598267558166; 
 Mon, 24 Aug 2020 04:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200818041922.251708-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200818041922.251708-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 12:12:27 +0100
Message-ID: <CAFEAcA9=q1mgHwCr508VSiLrh7+M53tLmF2zmxgX9iD3c6oiiQ@mail.gmail.com>
Subject: Re: [PULL 00/40] ppc-for-5.2 queue 20200818
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x634.google.com
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, Greg Kurz <groug@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Aug 2020 at 05:19, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20200818
>
> for you to fetch changes up to 3110f0ee19ccdb50adff3dfa1321039f69efddcd:
>
>   spapr/xive: Use xive_source_esb_len() (2020-08-14 13:35:45 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-08-18
>
> Here's my first pull request for qemu-5.2, which has quite a few
> accumulated things.  Highlights are:
>
>  * Preliminary support for POWER10 (Power ISA 3.1) instruction emulation
>  * Add documentation on the (very confusing) pseries NUMA configuration
>  * Fix some bugs handling edge cases with XICS, XIVE and kernel_irqchip
>  * Fix icount for a number of POWER registers
>  * Many cleanups to error handling in XIVE code
>  * Validate size of -prom-env data
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

