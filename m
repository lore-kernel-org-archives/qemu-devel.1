Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56538C43461
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:18:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D239222E7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 15:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iP9LaGBk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D239222E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFfOT-0007nT-GE
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 11:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53450)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFfNh-0007JW-6H
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:18:01 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634]:37908)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kFfNf-0006cr-GH
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 11:18:00 -0400
Received: by mail-ej1-x634.google.com with SMTP id i22so23093911eja.5
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 08:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CGf6Kiueq1IBmfXQYETy59d0PALcgKLz+/OjWCJy+98=;
 b=iP9LaGBkLjgDmD9+s+SS7qcI7nxNG5kRz+XO2SAYGdU8lF6e2d5PMtwpXHaynqU/MA
 ixD6Vqsa/5sZ36QwwxwZc51tAxuEc5IqyjC3f6Yt6R7wZ199OABu1ae93eOYyUqHrmxI
 y37V8I9MzXadhp0efTT120rZui8+l056AaQq2TjQ4/CrWepqtjdA2I4nVxLnrO6NN+6C
 bI6SiMT/QGN1VQivHeECSgmANuScGQWb5FvH5ZP8KnEcq3diuP7H9KOSSRNyBeQ+DLcn
 B+rV/YSM/EEg5+zbwlTU773mceuEuHKYW43XoNHjwywv58KdFwGRM9Nd1l+ZjRhvm+zT
 OmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CGf6Kiueq1IBmfXQYETy59d0PALcgKLz+/OjWCJy+98=;
 b=djpBRM/lLeWhMd4I3o/5CEDrwDk7rBaUJDGqLsTibXjz1TPfZ//Lv1DIyQvn+9/bnD
 fh6pppW2xAK+PHLkMKayweC7O425gS4CbybSsyuFoN6EnDr20EaitYQ/kid6aXKk8KGM
 MONjTcyw0fsopvo3JN4AEW8MhfH2i2dMMk7/WsRBB1HCQGcNahJgIni8LfJMcvKSHJxh
 OLEGRVTWtEjAydZ85x4EfxTcMuLKETxPylxNveEy6yA6Ty42Q52UNX8hcWAFH+uRb/I8
 fnXVEpbEXhc0jHNZHj8ovORPe40q3fmwa3MKQI1jJIuJDf0LhRKFlhwrRDSEnio2lET8
 36tA==
X-Gm-Message-State: AOAM531ZSraE9GlRydYECGqX/8ZumlFTnamAj5R5GZIWwyZTXZ/WzJpO
 Qumo60po/tDvQGZfum/lOjTbBeWXyePkyklinm/o6Q==
X-Google-Smtp-Source: ABdhPJzw0VsaA2kfjRtAQqOSaN0ZCPhJXD0t0Qzh7t1IZAqVe1LHjdqtjhBK74vjZ1VBzQuIcELypcDkfkULRKLCvrs=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr9125314ejv.56.1599578277999; 
 Tue, 08 Sep 2020 08:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200907200421.186121-1-richard.henderson@linaro.org>
In-Reply-To: <20200907200421.186121-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2020 16:17:46 +0100
Message-ID: <CAFEAcA8z_y2uk5nObc_JDaFGza2wnB7zDW08NHyjrfiKT2BVgw@mail.gmail.com>
Subject: Re: [PULL v2 00/18] target/microblaze patch queue
To: Richard Henderson <richard.henderson@linaro.org>
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

On Mon, 7 Sep 2020 at 21:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Doing the PR on request from Edgar.
>
> Version 1 conflicted with a PR from thuth;
> patch 1 has already been merged.
>
>
> r~
>
>
> The following changes since commit e11bd71f89649da3cff439c030d2ccac0cc914e3:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-07' into staging (2020-09-07 16:51:00 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-mb-20200907-2
>
> for you to fetch changes up to 7df61837df419740963f020d7ee7b852f6401301:
>
>   configure: Do not set TARGET_ABI32 for microblaze (2020-09-07 12:58:08 -0700)
>
> ----------------------------------------------------------------
> Use lookup_and_goto_tb.
> Cleanup and fill in VMStateDescription.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

