Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC36C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A58F2075F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 14:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pG/YoIYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A58F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjOJt-0003ef-MO
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 10:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37466)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOJ8-0002Iv-E9
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:35:54 -0400
Received: from mail-oo1-xc2d.google.com ([2607:f8b0:4864:20::c2d]:42887)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jjOJ6-0001eC-Vh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 10:35:53 -0400
Received: by mail-oo1-xc2d.google.com with SMTP id h7so1261965ooc.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 07:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1Bj5rh4IZPlihgkdL6bh2XPkT5irMZsdZPkoI/M0Ltg=;
 b=pG/YoIYY6urNhebbA1CEIY6+YX9oNYMqjB3E582MNDoPzeKOOL3oWjrL7A+pLT3Aru
 YPb7218MkN7n7uWJi15D3PkpwUQKysJkUmZQE9bgD18bm946mSqGJqC5e5Pm/X4KugGC
 h/xxdxCpff8T+EJs9l+Ky3IzQSBesjKqNS+aSP6c+HtiZWgWDmcwBsE5Bkv/MmecL5Nh
 57ePPpeUcZ986vbT/mKFcyvA/XWQGqcbp+qLprLBvGO28aFhuVKv80e4FqsMru5olHlF
 j+nNQ2NZYGbLMAvnm78zGtaffrN7fKEaUJxiUW/g9ak41tb6t5TnoLlJ2agmue9PURHb
 V1Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1Bj5rh4IZPlihgkdL6bh2XPkT5irMZsdZPkoI/M0Ltg=;
 b=F6oh67e9KF0orw0SRRXx5RjtOJj6D4ifUzW12hxF0IGKJSd6U8JXx9PAav1y4R6BkX
 ng6+USwUPBrHBff0gjfrFBhBJN4zqosdlB8qVkAwxPx2e55DGJhD47LsSo1k31JqICZu
 3Pw0casBsRZj52/xD6DyAUVTf6gwXnVLsiWPWL3dBtdr9ZG4cIa6LLlDocZA25yg1rQF
 9Eb4mATUmKbuAZ9TyU0pOMGK7DJT+geMr8DabaGBEAAKe24AYPYz2ACXWpMdVS2RphOT
 B/0LZYg28vLuAKf5Ar0wM1+H7k1qDVQvhMSBn/s30XliRydIQBG5olajdtd+qHl6ULLE
 bTBQ==
X-Gm-Message-State: AOAM533rvvuhC1zA1Ud45jVR9LyF4XZpZ9WZscKF0i05zieavnx/NLNY
 ZiriR0bLUKS39TfO8T0/VaSMdoI3yX3mwAM6dxNTrA==
X-Google-Smtp-Source: ABdhPJy6YSUwd7pJME9hf3/GRJ/VER2oFWOmROBS+FDwd6/uwqjFPbO3v3n4XSlIrjhqBv8IrpduOC5VMsJlGXvOH6c=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr6734822ooi.85.1591886142149; 
 Thu, 11 Jun 2020 07:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
In-Reply-To: <1591720118-7378-1-git-send-email-aleksandar.qemu.devel@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jun 2020 15:35:31 +0100
Message-ID: <CAFEAcA-bEdy+7t=snke4zYrUubMxvDxbB+=qjVaQHbGpA7vFqA@mail.gmail.com>
Subject: Re: [PULL 00/20] MIPS queue for June 9th, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2d;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc2d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On Tue, 9 Jun 2020 at 17:28, Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> The following changes since commit 49ee11555262a256afec592dfed7c5902d5eefd2:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-5.1-pull-request' into staging (2020-06-08 11:04:57 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jun-09-2020
>
> for you to fetch changes up to 6db06115d246ea6d24755657a98c185ed2a50210:
>
>   target/mips: Enable hardware page table walker and CMGCR features for P5600 (2020-06-09 17:32:45 +0200)
>
> ----------------------------------------------------------------
>
> MIPS queue for June 9th, 2020
>
> Highlights:
>
>   - Registring change of email address for two contributors
>   - Cleanup and improvements of FPU helpers
>   - Enabling some features of P5600
>   - Adding two Loongson-3A CPU definitions
>   - A checkpatch warning is known and should be ignored
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

