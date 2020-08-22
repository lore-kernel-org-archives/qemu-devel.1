Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E06CC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 22:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83E82072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 22:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DThOVu2r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83E82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9cN5-0001D7-Vn
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 18:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60624)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9cMX-0000mw-O8
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 18:51:49 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:42340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9cMV-0003aF-G0
 for qemu-devel@nongnu.org; Sat, 22 Aug 2020 18:51:49 -0400
Received: by mail-ej1-x634.google.com with SMTP id g19so7372632ejc.9
 for <qemu-devel@nongnu.org>; Sat, 22 Aug 2020 15:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ji1FmeIPkxSEKppLFyd/v1FRUYoKrj21Ikjw7HOBvic=;
 b=DThOVu2rhel6YEQ1mj0FqrcY4D91u9HVXV6pPtK3q7HeQ/WLdZ7iIrrk5pBaP5e4aJ
 USfpM7mpYJiRj6o242tfVN8iyMRux/SHfcjFnKRM7jDIoHoUDlDCjmHcjSMVGy4t9v04
 gA5porjkxn0qI4cqcdEOkpK1cH4Ki0iJGyvZiV4K+VPuwdU89O1Owz08EIpPp55PBMnz
 GOFD4bBAX+YeNEIOw9ruuYZYD4tCM286FtPdM9DiQ4ar2ui0SM3K4EeXcnD6G+RLKla6
 LV4MECZHZ6dcPw2EPjIhS5fK0h7ENhN11XQbuJof04rjImAKleSZydKLkikIpYnJmaxV
 AE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ji1FmeIPkxSEKppLFyd/v1FRUYoKrj21Ikjw7HOBvic=;
 b=jCVVB+TCCKPHBQs/6glRe8c2AxnBBRlNG2Tu6wgcWuwM0GyvkFF9gNEOl46YPO95Xe
 Zu2+2OFWMBMARx0RSoXsI2m0uMysv15GVdKXsjPWWtBZFROx+qBFG3RvvrjX7FSUBmuU
 jd5Yb838xBl2yyLzv3JIy5ImpUY84UVz0axEI8per8n291eP++7xdX74FSZvrG2mBppq
 kh0yduCGCni1h1KodF045vtvv2WA7qf77vEYi+PlvR5z5zncz+v6mEPRFOKep0HgXxy8
 0cw6UDpW73kPELeBki/BtsYHMxbdQqi2PRz9TMlFZysuf47NwJUpaE2aYVMlzW/lijvz
 C1+Q==
X-Gm-Message-State: AOAM533mAJx5JuB6b3QCASlsIblYJYbGW6nauTPfLnm2Vy5diyIaNUa1
 EwWOH+mL6edEUzKcAGy21UEM+PLqODTohQuoQuRK6g==
X-Google-Smtp-Source: ABdhPJywuN5xMrGW/rp7i5kwWb8rc3DISerYRX7DxgfrI8xhaD80SW0Y0RY8W5WLCSVCDuB7TRLnzNxzkPRAhWtjz14=
X-Received: by 2002:a17:906:7fc9:: with SMTP id
 r9mr8678377ejs.407.1598136705676; 
 Sat, 22 Aug 2020 15:51:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200821211412.17321-1-pbonzini@redhat.com>
In-Reply-To: <20200821211412.17321-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 22 Aug 2020 23:51:34 +0100
Message-ID: <CAFEAcA8V_vKrRMuQsjaV6aBBiy5N70UBr+13ktUnD7PBphPoLg@mail.gmail.com>
Subject: Re: [PULL 0/6] Meson build system fixes
To: Paolo Bonzini <pbonzini@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 at 22:18, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit d6f83a72a7db94a3ede9f5cc4fb39f9c8e89f954:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/acceptance-testing-20200812' into staging (2020-08-21 14:51:43 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 460b4664c6ad2b88ccfb2d69ab4cbb7d6c9165a0:
>
>   keymaps: update (2020-08-21 17:06:17 -0400)
>
> ----------------------------------------------------------------
> meson fixes:
>
> * --disable-tools --enable-system build
> * s390 no-TCG build
> * fdmon-io_uring
> * 'shift' error message in version_ge()
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

