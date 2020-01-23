Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4693C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:36:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F0D720684
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 15:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GNmNonmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F0D720684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iueWe-0005bb-66
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 10:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iucju-00042Z-8q
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iucjs-0002Q0-TE
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:41:41 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:44307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iucjs-0002Oh-Mr
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 08:41:40 -0500
Received: by mail-ot1-x335.google.com with SMTP id h9so2704458otj.11
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 05:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R+/WGG7XgKCLKBcIsPbNaOKUXX/vdCYtJxZyxlcgr6g=;
 b=GNmNonmqIAnt+fz9lt5XspqQpAzQNq3u6Pa3maUtr2/p6Y3fvTU8LWgJW09Sni/xDX
 Ltfp5EkQ9nOI0yZGpdo9DvnUC82Ruw1774zrgUuxDVPzxpJN/+i7hhNyR36+m+ribD2C
 0WG7jwn1fO4PZ/ZE1+msISxDYVCi9CpDfDFO21LEV5WwnfWu+TTCuUtgh++HV7RVdZHq
 th0eo2fPIIuVJ6hyKr4CvAKnFvo6GwBBzYyMNhGCV6XIB1dcAEh8NsWuEe4NQiV/xxv2
 ue0rDFG45K48VXfDtU/QJuLIa5CnX1nDkzy3hWzsvCzP0lV2pEVdus/WUq5P7V+lutEg
 5jkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R+/WGG7XgKCLKBcIsPbNaOKUXX/vdCYtJxZyxlcgr6g=;
 b=jAsf4xA2g2Wc6u57RcE0LKFZS9EcKGXRwLJRvLtXNtgNHEYDSbhkxl1nw3BY3U0Zud
 eLnv6OsMPolAtMsLoJAJ6VA9DFZFdyPERts4Lb8sNkaHeApYSq7s8iRZ7KaAoR9rdZCM
 RVgis3Bi1p0oDrqDGYiAV0UeOrM6c18z1hPmuNuLQyi+JjlQwbJKy+cEheU4r1Pe+qw7
 dAHxWTW1zszirzcK4MbZCPTViYSjzCBgzrhtMoidv9YIIFyJ/mgy+ECPSPxJjIzFcW48
 H1zHxpQ/1lzSW2d3o4+3Nwuu+ut5clYJOlbchPOrUVwjkHzhgiwhGcS7Zoskbu3EXMAQ
 ZgpA==
X-Gm-Message-State: APjAAAXXHdhHtCyR6n0EZaTEX9K/XYOTtC01eaGgpUdaEjtO4qxrGRtM
 9iBjalgsHZgOBMAM6vlsArnTb0qwMc7r5ZYEhgkVLA==
X-Google-Smtp-Source: APXvYqwFuKz1EYZ2m/A8Tjda8S/MPcbx9NHAtqI+gM+qlydWKnSvDMt2Hh6yEwvLOuTqHjp66aTYiwFPyi3ypFZx6uQ=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr10724082otq.97.1579786899614; 
 Thu, 23 Jan 2020 05:41:39 -0800 (PST)
MIME-Version: 1.0
References: <20200122024946.28484-1-richard.henderson@linaro.org>
In-Reply-To: <20200122024946.28484-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 13:41:28 +0000
Message-ID: <CAFEAcA8ZgxUB2GEt-G2jai5zWN=+4fWBqfs2edXO0TyX7mXEFA@mail.gmail.com>
Subject: Re: [PULL 00/16] tcg patch queue
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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

On Wed, 22 Jan 2020 at 02:49, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20200121
>
> for you to fetch changes up to 75fa376cdab5e5db2c7fdd107358e16f95503ac6:
>
>   scripts/git.orderfile: Display decodetree before C source (2020-01-21 15:26:09 -1000)
>
> ----------------------------------------------------------------
> Remove another limit to NB_MMU_MODES.
> Fix compilation using uclibc.
> Fix defaulting of -accel parameters.
> Tidy cputlb basic routines.
> Adjust git.orderfile for decodetree.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

