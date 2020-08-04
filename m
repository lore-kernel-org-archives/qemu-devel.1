Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C8C4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:35:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BA982075D
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="byNs4VdQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BA982075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tM0-0003T7-L2
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2tLC-0002US-Sv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:34:38 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:34468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2tLA-0001no-Cm
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:34:38 -0400
Received: by mail-oo1-xc42.google.com with SMTP id k63so5023241oob.1
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 02:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5DUf40pCQbFYHkc1Tbjm8GFzA5xVuUuNQGJWNbYvNNQ=;
 b=byNs4VdQTamo4mjc8HwudHHCP2ZNIYvdCUzYaPRJPXVuCobLoRbt/go0jiFzfY8VXG
 hZw5U5qPKt+D20+2pcT8SM5GbJ8YuOKKBB6YGSmd3GoytiPb+5/dmxGn8dgVhCfondWp
 hvje1humQM4iFm1YAdWLNpRCd+/BYvku/jmNU0f7SxzwdpXCzyHBvN+v8GUjz+WAjf4c
 Hfm2uU28538y+Xly+nMg+IXEIw2k1cel4ytxDCqhsagHLsDSjbIqHkIH2OSosHJDy+3s
 Z8VWg85JYDNiTHJN29HFzi6s9Aljgxb8hv0d2mr1rK4qy1P32lyyWZ/LZP6qyN1JTP+c
 L8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5DUf40pCQbFYHkc1Tbjm8GFzA5xVuUuNQGJWNbYvNNQ=;
 b=UYvXQO8z+Z08+z7wnPi7mao5PYeCAyf+9gs0lUY3lSUrD9mcelHwFz84NjkEGi+mU3
 EHq+yxNvajNVn8/x88hQ12+3Chu0RwJmxueeNyHnm7h6H8wgG9P32LNwMJynECj4sLOc
 h+37tAuCwPmAvnzKzf/i0r8/zKj6eqBCVMSqpNo7NhHOSiv81+y3lBCfSOSV4vBQzL1G
 9v1rslOAioTdlzTqGmA0uNI45CumnYBIg8g8AQXkpA5wECNCeuJ/sRgZsfu+UXKkJEWK
 5mbveN599nQzLpafL3zH7T4I1rI8BvhApt7YT6cBA8VZz3kTAfoHIY/uKcNxR28mj/z8
 DrxA==
X-Gm-Message-State: AOAM530cEpLy5B7YLZC5luNzkwBpxNfRAa0vWf/mP9g4qwLgCOCoe9CP
 mDYPY08ahlaG00hxpiP7pnc1ryW78QdtfYNiULiyTQ==
X-Google-Smtp-Source: ABdhPJxD5puDKTMsyqTMmkdzAhfQ+1ela99Uti8Hlulk7i9X/IjBCrHNOimSomMJgvPmJ1SXQsGLk4/+iLyIH/yNAUM=
X-Received: by 2002:a4a:8dc1:: with SMTP id a1mr17802438ool.69.1596533674960; 
 Tue, 04 Aug 2020 02:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200804002712.27733-1-pcc@google.com>
In-Reply-To: <20200804002712.27733-1-pcc@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 10:34:23 +0100
Message-ID: <CAFEAcA_TGmk+YMkc=5OF9rarQT_4cwrRBFLZsmkeDSgnmu0P5w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: Rename function disas_ldst_pac to disas_ld_pac
To: Peter Collingbourne <pcc@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Aug 2020 at 01:27, Peter Collingbourne <pcc@google.com> wrote:
>
> The name disas_ldst_pac is misleading as it implies the existence
> of authenticating store instructions, so rename it to avoid that
> implication.
>
> Signed-off-by: Peter Collingbourne <pcc@google.com>

The use of ldst here matches the name of this group of instructions
in the Arm ARM (DDI0487F.c page C4-308, "Load/store register (pac)"),
I think.

thanks
-- PMM

