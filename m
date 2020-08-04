Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C18AC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 358F3206D7
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 10:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYerZPVm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 358F3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2ua0-0005af-Ep
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 06:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2uZH-0004y8-Cc
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:53:15 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:46561)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2uZF-00049s-Ed
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 06:53:14 -0400
Received: by mail-oi1-x243.google.com with SMTP id v13so19314189oiv.13
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lTjIN1QGhmwyhDOOkzujdm+gLrnzQTEmjZKfLlIu/yk=;
 b=kYerZPVmNFvarScYI5P3WTXW3rdM55fHI+X+n8lvEdtNuz2RWa28MpsXoUxTdD74wV
 XEqF4zi0XTveD1yT53ut+PzlCs0gAEIDtPSjuXji6V2Ab8YsJMYR2Fi2uRHHMMb2r8FG
 LlxeMqqBiyem6wL1mF1AX2hfCFZTv7czEn9Aq9LxzP0IPbyPuyt9yFtMURy32xrYKgZ6
 hhqpOwNRfJWxJcjPmHzwJIVVc5o3VGGWk3TRKGyqzMyWLVpYqgNCcoxmpdHPlO0aimbL
 xd9SAo8X14jurv/2o4hC3sOAy+scqBrEUxw1Y3VCCLpByYUFQ/mmy/TucRMtWvT/rhgG
 x4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lTjIN1QGhmwyhDOOkzujdm+gLrnzQTEmjZKfLlIu/yk=;
 b=W8l/PwaMdKblEqWHTiFkx/Me1BR/n+MCw1t+0H2zDsDeH3n3UJWhfZLoFdcJUUzb+z
 yNsdYdWoDVOXfOrrzWsrDEGjFwy2PZfVqoEhVWgv8sDWJFG8XcL6f6zIyPQSWgJWhzHw
 5NZ/Tqn7MBGcJSpillZ4PTH/NBRQQrvpYOJBbIXz7KAN1WVzmYX17zQZ3jhorD2IFjHc
 g/hOSuvCOgptl7X8e1B60RVXTcOxJEKXlfE+nkCKTdxv7WmXth+jLurP5ept6QaOQkIk
 euBY+cq4uOmndiLmDz/TGOJKx9Qrd+WNdhCyCSDh44EBv6NTz8O10Rb8z8jqvXp7xrdv
 YFrw==
X-Gm-Message-State: AOAM532Vtv6V/hEwWNY4tjNHsdEnRRZik1vQU77phOmLA/ymoNPEYUZo
 1iyVmDjqB2JoKdtnDrlYpIymdZmpeQwjysba4KHQgQ==
X-Google-Smtp-Source: ABdhPJw8EXT/s7LuWVHple7cQ3ZavTNu232paJNxmJilSdX3VJzjnnPYeI44S5WXj2JaHizBd8bloYBE46IrRmF/pM4=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr2790357oia.163.1596538392020; 
 Tue, 04 Aug 2020 03:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
In-Reply-To: <1596523270-5492-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 11:53:01 +0100
Message-ID: <CAFEAcA8+sFuAU+WdtUT4V-SUCk9qeFenXg24FeKzwCTx7bFFtg@mail.gmail.com>
Subject: Re: [PULL 0/2] Net patches
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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

On Tue, 4 Aug 2020 at 07:41, Jason Wang <jasowang@redhat.com> wrote:
>
> The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf10:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200803' into staging (2020-08-03 20:34:26 +0100)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 035e69b063835a5fd23cacabd63690a3d84532a8:
>
>   hw/net/net_tx_pkt: fix assertion failure in net_tx_pkt_add_raw_fragment() (2020-08-04 14:14:48 +0800)
>
> ----------------------------------------------------------------
>
> ----------------------------------------------------------------
> Lukas Straub (1):
>       colo-compare: Remove superfluous NULL-pointer checks for s->iothread
>
> Mauro Matteo Cascella (1):
>       hw/net/net_tx_pkt: fix assertion failure in net_tx_pkt_add_raw_fragment()

Hi; this pullreq includes a patch where there's mangled UTF-8 in
one of the commit messages: the "colo-compare: Remove superfluous
NULL-pointer checks for s->iothread" patch has a mangled version
of the e-with-acute-accent character in Philippe's surname in his
Reviewed-by: tag.

Since this is the day of rc3 and I think you're at a timezone
offset that would make rerolling the series in time tricky,
I'm going to let this through. But please can you fix your
patch-handling workflow to ensure it doesn't corrupt UTF-8 ?

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

