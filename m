Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285D1C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E837B2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="da93uEfS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E837B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxWJD-0000M8-7Q
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxWIc-0008GL-D5
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:57:46 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:41301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxWIa-0000Gy-2u
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 09:57:46 -0400
Received: by mail-oi1-x235.google.com with SMTP id y22so14414202oie.8
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 06:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=n0ZdW6pc3BkljCTplKZqk4BC3KsHPCJqc3SArZ1eZw0=;
 b=da93uEfSvRqWIEvw0UpS707gOLFjM2UjzKBPFUj83OPrERHhH7TkJTHUlnLpFTnWBH
 QguNKUy+j/pwz/u0cGuhcYabf89CC2dW6ZsOwJEbB7oVIwPNEnd3FpU7QOcYiooqy0wF
 veFamY8X8vyTwzyu6Pu3ZbeRb6QuDhsc1Pu3xnunzbtO87v4r5xLlgbxvU4rMOdHx20u
 WRF+7fdBeLDFBRDdls1Nfl7ZvADrthdK0aNcDfHLVBNe8qbpJRzkGGm1mpBBOXcFb/YF
 SKDvEWzn9pBfdFu9KTqiNUKsdBDOQLHbx2YIxBhYhQSV0X92mznYFf1NrQL7nKk746m3
 RjcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=n0ZdW6pc3BkljCTplKZqk4BC3KsHPCJqc3SArZ1eZw0=;
 b=L8JSRbLbm6PqywijZPfJMnFV+1XE/apgFYNGSSFobGNsD0oRlg0KI6E4iG9MJlc8QN
 cIlgFgM4eNZ9G8MBIBVNmirIdvivUO5qNFBGK+yogYSL0gRgDvCMvL/vDEkPSBiyY28e
 yWNVq6Aq+q3CS8F3XkRI258+77JFkNas/bLd628WUxxl0O2Az1tt47OkNkSwa2lEOWG5
 w1YUKrTo8vkg9fd2Fv5h/IWWtBXxmthdpX9gbwzHuABLVEaZHYnfTwHPIifNSkyoLic0
 LKxwDHEsg5Dl/HxyK97jDZ85Nx0FrhR27MRHR2evIsxwXQupXvHi2d1+loQQmxW9FvCY
 IdIQ==
X-Gm-Message-State: AOAM533C6K1A8ObLRNc/PaZaUuCF0JUY1fAkBpivfERpPL0ruXGFOwCa
 kMXxPvxP6DFVb3cSaziXjcZacm68UOV72JUGP7xQcg==
X-Google-Smtp-Source: ABdhPJw1hvbVzvVXSEsRWuvpV99fvaWZ7OdVtamyfYIWr17PCs0QQF0h5nj8eZcliCKsJg0mNtHnsCJbNwmaLWu1cGA=
X-Received: by 2002:aca:2819:: with SMTP id 25mr16370292oix.48.1595253462636; 
 Mon, 20 Jul 2020 06:57:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200720054126.258032-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200720054126.258032-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 14:57:31 +0100
Message-ID: <CAFEAcA8ZE-eJZZ93ndjoTSt2feHqWrqULRqgzDrrqiApuYAwTw@mail.gmail.com>
Subject: Re: [PULL 0/4] ppc-for-5.1 queue 20200720
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x235.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jul 2020 at 06:41, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 9fc87111005e8903785db40819af66b8f85b8b96:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20200717' into staging (2020-07-19 10:29:05 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.1-20200720
>
> for you to fetch changes up to b25fbd6a1302c0eac5b326be3e1f828e905c0c9a:
>
>   pseries: Update SLOF firmware image (2020-07-20 09:21:39 +1000)
>
> ----------------------------------------------------------------
> ppc patch queue 20200720
>
> Here are some assorted fixes for qemu-5.1:
>  * SLOF update with improved TPM handling, and fix for possible stack
>    overflows on many-vcpu machines
>  * Fix for NUMA distances on NVLink2 attached GPU memory nodes
>  * Fixes to fail more gracefully on attempting to plug unsupported PCI bridge types
>  * Don't allow pnv-psi device to be user created
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

