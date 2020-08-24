Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB23C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:49:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADF8206B5
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 14:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQ0sYcLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADF8206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kADnI-0004KD-Bh
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 10:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51010)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADmO-0002r6-1N
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:49:00 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:40935)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kADmM-00061q-5P
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 10:48:59 -0400
Received: by mail-ed1-x543.google.com with SMTP id w2so8291337edv.7
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yurBVv7Z5hOEmPVsD9hHUnWP2HVRWYL8WjIY3DhW+Q8=;
 b=IQ0sYcLU7UDEtXNxpIM+5JuSucS/dA9nAR96cVxLIrMpxdidga/RQOk/fXSfm6kVxJ
 Vuey9pAYfaV1YCbqyFkWnoiCnlyiSpWnX/v/3nV3TYnf4vgF0j66Q6R8qErAwQEDRzpJ
 V2bSew5y/6coynKN/P+dDxHzm6fNR1kUCXExqHpfbtzCptM+gECf6aIftnDxiTQ/FFt8
 bL/dD8rqba1CwNsqlci+yn+uaenNoDnAoH7OAMcAuIeDdRdNDibCs19Iow7STfYU9gWq
 SkhRXwxMZYMfMAOyPE0RjbMzyMY34G0WORSHaOYhLTLR+lG70d2nlE9RglNk117Ys0ad
 JKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yurBVv7Z5hOEmPVsD9hHUnWP2HVRWYL8WjIY3DhW+Q8=;
 b=nWn3VliIPJFzDEZKtjvIB7not1L/+BJoetbTAD8G3fK5/Rixb+Nfz4HmCo1GD1BL9I
 lbf0tpIq/KUjO9NgXxEMKgMM6Urkbi6RfRDQIgco5/ZBjmTwjy+S7FCtZ+jF4g2PzeN7
 wsTxiNDadAzes/0PnM5hoYzr9gDcm9i1bXPg/ibzdqlHpjnCCYlSYGhYFsgSub4VwcWn
 oxXiT/vX3z9Dh+5tKXwF/ciPOebMc4xNpOg1xGw3pSznmuVjGFCLoltaFHA+1QDxhK5v
 9hPtXG68YLryGbZ8gjuoefhRF+VBk4cewC7QgP5zCMNseUldfJ9b5Bkz35qiqNYPMOIZ
 zZMg==
X-Gm-Message-State: AOAM53226ORvCGO9zFygM+HSSgxH2m43WVEXaGIwnfIqEE3DePuhj7CW
 6MSimwbm2r8kPYuBM+PoikCXBjJbkLVApVLaMW00UA==
X-Google-Smtp-Source: ABdhPJxWG7xXbVoc+RcOVYnU4d0PtPtxAYAbs+EHoplx4zRYqp19LvO1U/glSwOIitttapUtMJSikKAzNuICxP0bAMs=
X-Received: by 2002:aa7:ca14:: with SMTP id y20mr1842912eds.100.1598280536158; 
 Mon, 24 Aug 2020 07:48:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200821083853.356490-1-graeme@nuviainc.com>
In-Reply-To: <20200821083853.356490-1-graeme@nuviainc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 15:48:45 +0100
Message-ID: <CAFEAcA_GfXttD7Xq909jy9eE6E+8Kj0mTM+vv-dmicQarfS+Fw@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/sbsa-ref: fix typo breaking PCIe IRQs
To: Graeme Gregory <graeme@nuviainc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: Leif Lindholm <leif@nuviainc.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, rad@semihalf.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 21 Aug 2020 at 09:39, Graeme Gregory <graeme@nuviainc.com> wrote:
>
> Fixing a typo in a previous patch that translated an "i" to a 1
> and therefore breaking the allocation of PCIe interrupts. This was
> discovered when virtio-net-pci devices ceased to function correctly.
>
> Fixes: 48ba18e6d3f3 ("hw/arm/sbsa-ref: Simplify by moving the gic in the machine state")
> Signed-off-by: Graeme Gregory <graeme@nuviainc.com>
> ---
>  hw/arm/sbsa-ref.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


Applied to target-arm.next, thanks. (I added a cc: qemu-stable@nongnu.org;
seems worth fixing in 5.1.1.)

-- PMM

