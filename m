Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C1CBC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:04:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D45E120720
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 10:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nn/co+0i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D45E120720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jY5I3-00040N-VF
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 06:04:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5GD-0002aA-0L
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:02:09 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jY5GB-0006PC-09
 for qemu-devel@nongnu.org; Mon, 11 May 2020 06:02:07 -0400
Received: by mail-ot1-x341.google.com with SMTP id z25so7026566otq.13
 for <qemu-devel@nongnu.org>; Mon, 11 May 2020 03:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8UekYAM1/5RxUAc4jSid3+PRVfxCfJKQ6eC9ocSSB5g=;
 b=Nn/co+0iDbXT/X+Mq1a5m1GL2v2tRT40ULEEWSdEaB44lvOX/d62WfV3IK+rIEP2Ld
 YFqSNuLlZn87MBbnyViWXh3D+kohM0BXSLHs5m+ybcIJr3L2CKwxgHOz9XAq+7Z5cTQm
 a0PIXMdiIOs5xuAChUl232ifchg/nlVef2OraMfokS8tqob1ajFbfrad0hYJ/O2SsqMx
 IDNQsxHRsJWeYMNRUmWDDvKPscn9A5W+K03QvBIU8r4T0ZnyOgTn5zbSRDPubUhpO+U1
 1nktZJ6MEcEXsRlxzXHzogQhpDLdB8zQF39QzTmNCHN1/B4UlXx3T5/8A0PpXPJJUk5N
 tRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8UekYAM1/5RxUAc4jSid3+PRVfxCfJKQ6eC9ocSSB5g=;
 b=GBUpB+RH0Z4T+/afJbukUbGB0y3v0YpO2OX0v3koMc7mxSyP2BGP1/hIMyk7ce93er
 RnN10eNiDVvWV/TvzaK2O9yIRQNn9ynwh8IgMA5FjqC44mb0u8UgCtrP8btdszJPUvzt
 RfBupJ1hha1ycLxjyj3FCWfluYKtZZN2ZAPN3/pNHQeoU7ea7XDdKZbXnT4zliDK9APh
 x0YCqrqvoeHlC8GSJyh34GiV6iLdaKd9jpj+uUePV3HZhRVm3AI6CQlpRTv5DxX+KacB
 d3KjWV/yl0PvA7AxVfxI971MCS6ZyxpWIIZezH4LuKBsxdz3tB8gGmKJX++pbz1grxqY
 +QSQ==
X-Gm-Message-State: AGi0Pubb3i0sMRTVKKWgQjBJy3k3nj60llTwqC7a96Sh8GM/5nqgBZDQ
 6VDvqm2+14X+rKV3P/WUnCb/4qcmFiDe2mD1UMk4Ag==
X-Google-Smtp-Source: APiQypLtxKm6IeLftuH7wJsRFX2qSK8UHsI7ANR6bkT04TFrTAbgQ/aat7sqk8XUyW4KTjXors4n2BOtKHBrgk4cnzo=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr11801230otj.91.1589191321968; 
 Mon, 11 May 2020 03:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200505090136.341426-1-joel@jms.id.au>
In-Reply-To: <20200505090136.341426-1-joel@jms.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 May 2020 11:01:51 +0100
Message-ID: <CAFEAcA91CuKCL0v4U3eKjmc46eyM4bsBfk41ZYzUa61-Y09fXg@mail.gmail.com>
Subject: Re: [PATCH] aspeed: sdmc: Implement AST2600 locking behaviour
To: Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 May 2020 at 10:01, Joel Stanley <joel@jms.id.au> wrote:
>
> The AST2600 handles this differently with the extra 'hardlock' state, so
> move the testing to the soc specific class' write callback.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---



Applied to target-arm.next, thanks.

-- PMM

