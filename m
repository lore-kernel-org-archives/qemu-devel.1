Return-Path: <SRS0=E5X6=CV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C862BC433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 20:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22B992074B
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2020 20:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wgaPhZR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22B992074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHBxj-00031f-UH
	for qemu-devel@archiver.kernel.org; Sat, 12 Sep 2020 16:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHBww-0002ax-6L
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 16:16:42 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c]:37413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kHBwu-0005H2-Jz
 for qemu-devel@nongnu.org; Sat, 12 Sep 2020 16:16:41 -0400
Received: by mail-ej1-x62c.google.com with SMTP id nw23so17944895ejb.4
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2020 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2Nv+nnFHayGUqocJ17Nj1h3AM02fuHY983oGcb2kjXo=;
 b=wgaPhZR3mHfE+BsYHrc3+6YC62fGqjOVO7ye0DazbFRLRPu73Mgq16LoAwPHNNbeCS
 /5AexJ1GXhRBh2GR1JxG/p6GNwxuaCj2dEdYjXmNIsIPsMq3UUd2phkLYbR194DfhVkB
 fULE0PKEm4c3zgsQMSp47jBF9maLYXh2aU2zTXEGYW3tXHdIWql75fHoLbyabxt1Qd+M
 xrG3G2vQ99acDM92CGRJvUXpgPaLfYk0ayr9ReOYY8ncsLj23vRsXpgJQEfWNMpQdNNt
 2sh6xANubTlDsTmkorkyyjNV6KN5P9XMnOent7UN5Hrmlism7+0iqsniVsKOJTpJ75Cc
 pEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2Nv+nnFHayGUqocJ17Nj1h3AM02fuHY983oGcb2kjXo=;
 b=pAZgGqYAniz5aLAGVKayrwUxB8ZBKEuQHRWHh1jUSNO8LkkC6hQqA+/5x5qmtbwHtQ
 3wEXgO/9GfFVt9aq/uBL+QI70k5A0MFa6GgDEldn8CYKt3JF9TtH5xU88yC+HNtZ2sA1
 lpoeu/VSyNLxoWvjZgHOu1hus0xkULFtq6o+llnt2YBaZ7LlAdCEmJ0fffmQM5BkXBzb
 9mxUDxdWOWkAHiMT8Q+xc+TNhkaJ81r18LBfYGD+FE1rr2Th5as4AWt7uCnk2P07Tn+b
 GJwsEmmRf3hzuwOSjMwfHx/U9Q6babe6jdAJShyrUD34qtAj2TsL5O0Gkl1h1xwJ0xGL
 UevQ==
X-Gm-Message-State: AOAM532O3ZQuLg/Khwp5Mhiohq+fJWwfiFj05zY2x+19NzgoJgwRLDi+
 uQYX/jc0hNm0KPYnfICHLcr3w2DnI8NAszCJSauNiw==
X-Google-Smtp-Source: ABdhPJyd6yQZ97x8GmDCVr97wyPCCOx/fwhW88a0hjUkCdFK5lI5Rw0E4tuLC1f72dAY8psmVdhu+nMsqarfXIsXKq0=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr7172890ejk.407.1599941799044; 
 Sat, 12 Sep 2020 13:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200911193330.1148942-1-laurent@vivier.eu>
In-Reply-To: <20200911193330.1148942-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 12 Sep 2020 21:16:28 +0100
Message-ID: <CAFEAcA_-jdWSB+uFa6BmO9Fn5Ksnbp8hqw0VqS9iHGBSFS-hAg@mail.gmail.com>
Subject: Re: [PULL 00/18] Trivial branch for 5.2 patches
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62c.google.com
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 at 20:35, Laurent Vivier <laurent@vivier.eu> wrote:
>
> The following changes since commit 9435a8b3dd35f1f926f1b9127e8a906217a5518a:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/sirius/ipxe-20200908-pull=
> -request' into staging (2020-09-08 21:21:13 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/trivial-branch-for-5.2-pull-request
>
> for you to fetch changes up to 8821e21414468b1810f0ccf38bcbfa5c0bd1d56b:
>
>   target/i386/kvm: Add missing fallthrough comment (2020-09-11 21:25:59 +0200)
>
> ----------------------------------------------------------------
> trivial patches pull request 20200911
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

