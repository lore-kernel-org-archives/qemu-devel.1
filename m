Return-Path: <SRS0=gE17=CB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325E2C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 13:57:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEC722075B
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Aug 2020 13:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B0JT7Rs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEC722075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9qUY-0005rE-6o
	for qemu-devel@archiver.kernel.org; Sun, 23 Aug 2020 09:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9qTz-0005PO-ND
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 09:56:27 -0400
Received: from mail-ej1-x643.google.com ([2a00:1450:4864:20::643]:39276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9qTx-0000lf-1k
 for qemu-devel@nongnu.org; Sun, 23 Aug 2020 09:56:27 -0400
Received: by mail-ej1-x643.google.com with SMTP id md23so7835066ejb.6
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2020 06:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qxbai1sRp7O7KPL2gGKkRPZRAkhcKgfrOruQA0nSuSk=;
 b=B0JT7Rs7GbUrB5+JKX/iSvuQKVBOyMrY/Ihk24oQSQKjARFwuyBC185oPY0JvUu2fR
 Ytg4ajFMWNKMuNWmC6IrfFFpNzrdBefup4cLqFs4FxQqovvBblAwq/882AGrsXJ7vZbb
 JfpLxITym3/SHrnxNQmGzykGQRnSJfetEeKGwvLel9kg2EOZp4ZykjbiYPXxbDnePV2m
 dPGkNHqAWFAFbKweTC9d+3TRtw+z0s7cWz8Jo4/hMDPD1u2v+2U/ozm/cnp/xKDbgysk
 pNy6zQhznxKosBh0qCORvew/3LkbspYOBfhAECTGsqNZJS2Ug+iCOlmvqJhMajIQftwz
 DNvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qxbai1sRp7O7KPL2gGKkRPZRAkhcKgfrOruQA0nSuSk=;
 b=cqetaeLJ43HBhY0awkXvx6g2isaTAqp8jPAXsx00Tk+kms1CsKdoh5hT8PAbn9iVYL
 ENDYHKR36zp3rUaohL2Df3ERHUsB7LVCrkbFCIdn0DLhlGLL3pEC6732FjHpsQhAk0Bg
 qqYB+YH2E/iKOaiYLbrJFifK++stgll/omhWgoQ+StvOLCifESQjjyfwPBiz5DWcvt93
 jzCh0NtUt2/b5i47olLCCui/hQT8qwkNTy5La91pzTt2XaAKAdILstvzOQJ9WgQFyATN
 teaBxAbpXSL6uk16Ze70RwH7d5W1oxV/XdFvnW52YAoXtnIbgXPtny7vDQmz66E8Q06N
 rCvA==
X-Gm-Message-State: AOAM533ck8gyaQAgcO4O9Pdi2A7syaYRhHr2J0jmHOt/REhMoK9vudex
 RoGnS9F/fT2vKmlP8LW5UsBBpOyWwVfvRRYoFe/spWPIzob7WXod
X-Google-Smtp-Source: ABdhPJx01Y5hXiDRGRIE4KHVCglG07tG73UJ6NjeUIlKOjoInwxt22FZHG701AOb8oXTIVPUe8U31M0MSBzEq0qHgY0=
X-Received: by 2002:a17:906:d8ca:: with SMTP id
 re10mr1507247ejb.382.1598190983614; 
 Sun, 23 Aug 2020 06:56:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200819192240.GA25305@dhcp-10-100-145-180.wdl.wdc.com>
In-Reply-To: <20200819192240.GA25305@dhcp-10-100-145-180.wdl.wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 23 Aug 2020 14:56:12 +0100
Message-ID: <CAFEAcA8-VgEDTZ7+T9ZgB2LR9KWRrejBtZN=iwy2GGPcuFuz2Q@mail.gmail.com>
Subject: Re: [PULL] nvme updates
To: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::643;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x643.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Klaus Jensen <k.jensen@samsung.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Klaus Jensen <its@irrelevant.dk>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 at 20:23, Keith Busch <kbusch@kernel.org> wrote:
>
> We're trying our first nvme pull request from a dedicated development
> tree containing various fixes, cleanups, spec compliance, and welcoming
> Klaus Jensen to maintaining the emulated nvme device development.
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   git://git.infradead.org/qemu-nvme.git nvme-next

Hi; it looks like this isn't a gpg-signed tag?

error: remotes/nvme/nvme-next: cannot verify a non-tag object of type commit.

thanks
-- PMM

