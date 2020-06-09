Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B884CC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80C4220774
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 01:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="hWMWcBYy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80C4220774
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiTIn-0000C2-MB
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 21:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTBl-00034l-9V; Mon, 08 Jun 2020 21:36:29 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43188)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1jiTBk-00006z-Lj; Mon, 08 Jun 2020 21:36:29 -0400
Received: by mail-ej1-x642.google.com with SMTP id l12so16704694ejn.10;
 Mon, 08 Jun 2020 18:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KhvhSmf6bHsXItz7ZSJvhp4Th42f2tl5qO1RgZS7OsY=;
 b=hWMWcBYy1DVfhC97tNo3P90gaAxEIrsttTfKaP3L/ZdUzUgxlxbPCy/9nk1Ur8bksm
 aDVZ/zYlOMqfavhO6lQMPKb6itQpeuGqWM8N1Dyuvg4YwvyTlCkM/UAkDMU2VCTVb5aQ
 jP1GA3J0yDPQMGSIFyrNDZWTvNBh/XJa+RLrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KhvhSmf6bHsXItz7ZSJvhp4Th42f2tl5qO1RgZS7OsY=;
 b=gD4SitNoZSfzTTejr3gjJqId78QkUa+M+VNFPuXnikjQ5n/nhqGQbU4W5z0+bV6B3o
 M3A8vPLq+cK/+TXtJ7C8DFBtXbE74VPCG7xw9fW59cof5YUhkuMFIArFSiq++i5JwerY
 cr4sbp7X38nrGsYrcma/ATAqVUHm4tseP/YiZL93vqyTt8HKdZu0CQFYYXbMUBmnIYEB
 md0/un0fGiFYrn2vdBoTLcCM/HGVcl30mHUuX2rQi4ZOHv9XlGAtvuC7MQxjPNQfgW3r
 3dVvByt1ul+1M0fYFj3KPaK59ZPDhRB0+mggsFHk0WXhLDba7JWHD49N/5Pig9MI/K17
 x2oA==
X-Gm-Message-State: AOAM530MjlTrH7jTXxVFUr4UIa6a1e4hCH57tdcfh8AoILQfdBZcDiNL
 T82YfbZlvTzAELKIFlB/Avu19OMPgDkjfoPuQDC1LGdP
X-Google-Smtp-Source: ABdhPJxoXXRF43u2mZ/Yga6tUfXgWdi/Pic6NbHHSbqHSLnVcs/08qVhfsJv2G5aKAN+vYZkdN82+N4ku+OMipcALqA=
X-Received: by 2002:a17:906:fcb7:: with SMTP id
 qw23mr21981896ejb.229.1591666586645; 
 Mon, 08 Jun 2020 18:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200521192133.127559-1-hskinnemoen@google.com>
 <20200521192133.127559-3-hskinnemoen@google.com>
In-Reply-To: <20200521192133.127559-3-hskinnemoen@google.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 9 Jun 2020 01:36:14 +0000
Message-ID: <CACPK8XcYNmBYb+OXKZP1sSHqC-1pTN4=S+B7TdOapYkmEC18SA@mail.gmail.com>
Subject: Re: [PATCH 2/6] hw/misc: Add NPCM7xx System Global Control Registers
 device model
To: Havard Skinnemoen <hskinnemoen@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=joel.stan@gmail.com; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kfting@nuvoton.com,
 Avi Fishman <Avi.Fishman@nuvoton.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 May 2020 at 20:40, Havard Skinnemoen <hskinnemoen@google.com> wrote:
>
> Implement a device model for the System Global Control Registers in the
> NPCM730 and NPCM750 BMC SoCs.
>
> This is primarily used to enable SMP boot (the boot ROM spins reading
> the SCRPAD register); other registers are best effort for now.
>
> The reset values of the MDLR and PWRON registers are determined by the
> SoC variant (730 vs 750) and board straps respectively.
>
> Reviewed-by: Tyrone Ting <kfting@nuvoton.com>
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>

This looks similar to the aspeed scu model :)

Reviewed-by: Joel Stanley <joel@jms.id.au>

