Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF09C388F9
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:31:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7E1A20719
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 20:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ywKhj+8/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E1A20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZgTv-0004Wx-BR
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 15:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44374)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZgSZ-0003Y1-In
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:29:47 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:35614)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZgSW-0006SV-Uo
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 15:29:47 -0500
Received: by mail-ej1-x62b.google.com with SMTP id p5so20704659ejj.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 12:29:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=C3BIBZzDu/fKEqxHWXrBLsmrPOgfX5hBFD0Qn+l1iQ0=;
 b=ywKhj+8/K9WsMo/V9M07iRTijzHQE6cIhPIq8y1Q5MwFSbtQhfhF9gDBNc6pMfSuHJ
 INbJazsF6p+0trgZKiI26ISvg1Uo2oOu1tzxjml7k762PtbLAWGGg1549NiLfi0Ya5fI
 mY0w1+cZtL4awLMCXR3qfhopHSldLeDShdUvnigzPjlsPbm5Eq0S6wi2MQe1WjutQ1HW
 puRQ5xSuDfcAWbI+oWIycx5ar2F2GLBw3zbmJ4dzYEeY2DSmAmjWOa7xrJvUCiaAadXe
 vH68z+FghFJk6OqEiPo4wwdPWFCtSZi7+q5zP+Ju1oofgblUyGM0bRIu1Oj/1hVJJ9wJ
 nwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=C3BIBZzDu/fKEqxHWXrBLsmrPOgfX5hBFD0Qn+l1iQ0=;
 b=O5bUxXgAtT8DVVsQRGqC+ViyuBtBLgtvYGs19XtHw/CsycVzWla3FrPB626dfqwT4M
 eDlnnNyQ5i+2LYJR9mPlbxt3zrDhTT6a1Vd5q+jSIc8N0ZVWEd3mCX+gLOVDkMgb4rkR
 sfUERMaJ+v8R33rWX8IGWkU9XC/s1Ht2mnIgNr4F8Uod1CUbmHibUTMRWtYiCJAAmm55
 YqKgU8xvSdIEBFfUDW3dVNKguMbKS5JAuM+RVzrFKS6gS01Yw8ty7rEIGpRSKw8dvd58
 9sG+QzDcFbJnv52MKsE3Tuvoet/whyJtteNXruTkWgLTQGq3LW5NoBYKiylb1MrgrFw2
 1tOQ==
X-Gm-Message-State: AOAM533pgnynahoLnw6ryZoUoBgfzxQoJsheNBkzfl31XouZ3g+30CDw
 738Yju+fM2hqrVRX6QFvrS9YAHc+acDeZvNDcY6Ecw==
X-Google-Smtp-Source: ABdhPJxjeAVW/bTsn/4BA+pdmaeKm+unI/nzT5scmOnOEmrezEfVT1FtZRfEZatGH05Bj85XyrcBeTO3akahBcwhP5k=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr16675446ejk.407.1604348983449; 
 Mon, 02 Nov 2020 12:29:43 -0800 (PST)
MIME-Version: 1.0
References: <20201102152747.GA28552@redsun51.ssa.fujisawa.hgst.com>
In-Reply-To: <20201102152747.GA28552@redsun51.ssa.fujisawa.hgst.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 2 Nov 2020 20:29:32 +0000
Message-ID: <CAFEAcA-0MM1QWMMQomp99HddpTev23M8iyv=yUqYZYbPDyBa1g@mail.gmail.com>
Subject: Re: [PULL] nvme emulation patches for 5.2
To: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62b.google.com
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
Cc: Klaus Jensen <its@irrelevant.dk>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2 Nov 2020 at 15:27, Keith Busch <kbusch@kernel.org> wrote:
>
> Hi Peter,
>
> We are sorting out Klaus' signature authentication this week, but in the
> interest of timing, I've signed our pull request for this round.
>
> The following changes since commit 1dc887329a10903940501b43e8c0cc67af7c06d5:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/sd-next-20201026' into staging (2020-10-26 17:19:26 +0000)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/qemu-nvme.git tags/pull-nvme-20201102
>
> for you to fetch changes up to 843c8f91a7ad63f8f3e4e564d3f41f3d030ab8a9:
>
>   hw/block/nvme: fix queue identifer validation (2020-10-27 11:29:25 +0100)
>
> nvme emulation patches for 5.2
>
>   - lots of cleanups
>   - add support for scatter/gather lists
>   - add support for multiple namespaces (adds new nvme-ns device)
>   - change default pci vendor/device id
>   - add support for per-namespace smart log
>
> ----------------------------------------------------------------
> nvme pull 2 Nov 2020
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

