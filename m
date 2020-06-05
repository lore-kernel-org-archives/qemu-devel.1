Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F4BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 228382074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 13:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XBtQ4FfU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 228382074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhCnF-0002ou-6F
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 09:53:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42734)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhCko-0000Xl-So
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:51:26 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jhCkn-0001fa-SB
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 09:51:26 -0400
Received: by mail-oi1-x243.google.com with SMTP id c194so8265053oig.5
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hR8nvLRCuQUSXDiJTXdBxgIkQGPniExl3jMjL9eAfrY=;
 b=XBtQ4FfUFvxwu1DdSe3uePCUMKnl0NkZ1UxMyi9vctx4A0ALsfZ8Y7V/Bh9Q2x5kRy
 D96PQAg2f1O5EssSWyyiIYzAUY/0L5yqP5ZjgRadXrIL1A6XCv7w5cAO9urM/8EjaMHE
 Zrlm97K6xCHVDBjijmEUV/4inYGftgnoC1NLnDhwaDdqbHDvoO4bjv+7NNBDNHTneDI7
 ymbzdya0XkHWXywV8Zppx5R9dlPfOSLtJGGHq9fTX7AA9lJYfXfHehxuR6L3pbVQpa2u
 z9QmB+kOTbhwT36LSlFT9g+qFldqSwEpRrOVzmRRVqwCd8xstzdZQcUNd335U2ruJVLc
 FauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hR8nvLRCuQUSXDiJTXdBxgIkQGPniExl3jMjL9eAfrY=;
 b=PLV0N/qTYwgMz9bFqjpVSTwNAFnsnSD8oZyM3aOxEOOL+o10moB6aB6FpI8T0iq0ky
 d9alMwq/dxeI3SqoOWNBRzkCKZucF6TnAIuFRkRQ8pbdg/qmAwfb00eMjnvmkRkujfAJ
 zKTs69LCNAi16EiiRFaItFR9aLGtFfyJufKcpuFMPI1dZsDQxVlSeYZTrjIZO0HZEvWc
 aLnZcJEoH30CyiauPcuOtVuTD6UpFXx4cGNJwrqvNZjft+N9LfgJpbZ68tYjB1w8FDir
 NcrcJYD8oOr8Pnw/39x0SkiIjfEmG2mKCBwZhYiU4I4LLYXJM/wREvjASAp5IdllaEyi
 nBxQ==
X-Gm-Message-State: AOAM530eknLDucYQXJ3HwoPNccIc8lGn35bEFsxTeKR5xy9v8Q4swBBh
 Rley9OvEPGTI2dXoW6xZj2kU4tCPHl5bMMZknh2pXw==
X-Google-Smtp-Source: ABdhPJwmNlT6JhETWe7e7CtudwUO0b41FtY1uskuxVclNCTyoV/jc0H47W1sjoZMN0niLLUugc3LFwkAJ8NC1FBPca0=
X-Received: by 2002:aca:5152:: with SMTP id f79mr1895783oib.146.1591365084666; 
 Fri, 05 Jun 2020 06:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200602135050.593692-1-clg@kaod.org>
In-Reply-To: <20200602135050.593692-1-clg@kaod.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Jun 2020 14:51:12 +0100
Message-ID: <CAFEAcA9DLYnnpvkJzTW28_Rzv52gC5uECxhow9GVc1fDDeOtQg@mail.gmail.com>
Subject: Re: [PATCH] docs/system: Document Aspeed boards
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>,
 Joel Stanley <joel@jms.id.au>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jun 2020 at 14:51, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  docs/system/arm/aspeed.rst | 85 ++++++++++++++++++++++++++++++++++++++
>  docs/system/target-arm.rst |  1 +
>  2 files changed, 86 insertions(+)
>  create mode 100644 docs/system/arm/aspeed.rst



Applied to target-arm.next, thanks.

-- PMM

