Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD9BC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7511E20775
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 10:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gViAEQM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7511E20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0MiP-0003Fc-QQ
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 06:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Mhq-0002ie-2Q
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:19:34 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:42972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0Mhn-0008K6-CG
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 06:19:33 -0400
Received: by mail-oi1-x242.google.com with SMTP id j7so609883oij.9
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 03:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MZLqhHPbd1yGJM3lp3wAUsZ/dHhC4BUDsaOMlyyZJ1I=;
 b=gViAEQM0Z5itVcQrR5B0BpgY4ssFOKmKRy/AU/Elkm1Oc3dp0EHvNCzTg1ru5IwJoF
 fyWU/Wia1B0zmQ2XR1kizSBgv+7AoSpV5KCn/wgFcToe3uAh1Vms8kzCWYXC9YFS80N+
 ZPIKz2Ez0WwRpUCCTLUrVo+7+a/2z/8/ooCYh9aJEOPYVIbBo5itSM3dSTM8nV52EHrO
 LO2gz2H+/Y+1hko0yX9dxY7fFC0SqS1bqGqofkiDdtozDiFMKiS0zsS2LjnYoWQe0RAe
 SI1199dMZao820nU9/0xDfkC+curgxP1j8tLn2q79+mzYOLR8aruZ5B0/tChASFd9f5U
 hGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MZLqhHPbd1yGJM3lp3wAUsZ/dHhC4BUDsaOMlyyZJ1I=;
 b=nwLjgF/KA1mPdlwYAJOyjpxFemJVnxBKMWmH0HxWGv94Bt0FpLS+zc9TO53cKPhgbz
 Abthy0nnMvCFqGGlhREc30JTZOmrfGSurY1vcZgqIU0iR0xJ90w7r7JBkQgGJkAd+HNO
 PwvV+qcXvd6wvaSQlRcF3inVxpJT/VvECznPO9nHC25pizhL3RALNFHKioM7XBFdYnEl
 a7HAkglG0BCYkZN3MI1rN9yqfxSa1MqcWYQkc2JRvoPmp55fPCO5ujmQjtheBhWUgkDc
 DKmNa7YlG6qbxSZtMhzlKx75k+/K6VUYdasUBJqkCG4RcdahezuZoDZHCHg+BuSH3iPG
 IXWA==
X-Gm-Message-State: AOAM532zjR7x/cTbwLAtX1XruN2iZOS3e8NuYrSRw5FeLEVO0r9CJCGp
 bhhuXQejG33PIwsRvWqT964wO8KPT0Ga1pkNPSEhOA==
X-Google-Smtp-Source: ABdhPJzSJ/fVsGWiy1C9D/z6W4cZdsyMPPtAdZ0yS70Pn+9zD4dlPmRwXVN30uHc8i/epy4R+DHUG+uDk21dEB9AW+0=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr2831511oia.163.1595931570077; 
 Tue, 28 Jul 2020 03:19:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200727143812.1101547-1-mreitz@redhat.com>
In-Reply-To: <20200727143812.1101547-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 11:19:19 +0100
Message-ID: <CAFEAcA_8hhEUJdxGzmjVjG+CFosAtDf9GAR0D2x+-k_mU7Gfug@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches for 5.1
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 15:38, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 4215d3413272ad6d1c6c9d0234450b602e46a74c:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.1-20200727' into staging (2020-07-27 09:33:04 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2020-07-27
>
> for you to fetch changes up to 1855536256eb0a5708b04b85f744de69559ea323:
>
>   iotests/197: Fix for compat=0.10 (2020-07-27 16:35:17 +0200)
>
> ----------------------------------------------------------------
> Block patches for 5.1:
> - Coverity fix
> - iotests fix for rx and avr
> - iotests fix for qcow2 -o compat=0.10
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

