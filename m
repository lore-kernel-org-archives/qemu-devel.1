Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A0DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:04:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33D51206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I+ruPTLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D51206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkomx-00059k-Er
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:04:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkomD-0004bh-Sf
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:03:49 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:45931)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkomC-0008Mw-7c
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:03:49 -0400
Received: by mail-ot1-x342.google.com with SMTP id m2so12997195otr.12
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=J/F25bttsw8SdxqO6QIv2TREGEGLu98IP9Mvu9kOtuU=;
 b=I+ruPTLP/NfTcO5bDgtKeRcYNS6AYB2cX/VcMiIYBIHQwZxlmou4kUKtBH73oBQy4M
 /76rLqDVcUAVbZ6JKBikcW41k5lARds1aYLLc43Ijuca5oV1P3brsdlXSND+ouJuxhg7
 9pRXiG3cxLZgC1IKV0vrwSl45RXnPCp5zv8DwwUf/zfwZcp28YF9TAAlD4t6PMYLKHfU
 LAw6HY/1N6oJv98QtSPxoX59GhkRRs2mKhvGaxwoTJlOwR04f59dW95pBt7f7TOWbxBM
 2Rr8VcPvZdqR3pnQybznfGe49Hr62l/ORPuKSdRKiK5DCinP3hjkMJ8DNq2FXm3UAmee
 Yj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=J/F25bttsw8SdxqO6QIv2TREGEGLu98IP9Mvu9kOtuU=;
 b=Jh91ptkV2okPP9B6o211+dpRs7xa5LlGVqOF5yw9qxFtFlW4ErH6QVRwKY3uKjg0s7
 1AsvbROcHXb7TGCNCuh/5AsSNYZ6uNep/RgdvyJHKlwDb9Pjc4aLbhCVCev9twrYyr37
 wseKzKMmNgfQmcARPM5fljDUQoU2D6JoMyzEVdcUdWQTCaHrXmGprroqNgKvTiHVD45Z
 OgtEAGaE32EH9uKFrMqaFvBI48v/mfPc+0DA6GyA5zrgmvjhjxBga+CEOuj69cn4/fJY
 1jSLvFqOZMducCBOO2p3kUv9k8TUSRSBviHASqesOru22IvBZwFFgMb6phmXx6ZMTOuq
 JfGg==
X-Gm-Message-State: AOAM531d5zI54vcYpfZrVi8d2/q7ui15XZzHMvwZpfqB62soqcn7jGjc
 xtXQIBXoOYyc8oITeZyRTtFo10t+dKkjH8tskyHetg==
X-Google-Smtp-Source: ABdhPJwlRCvSDXCQKmkoOMLpsyQtKvFc97KyIfH2LpIUZFVNb/1rN67EVhjNoYIwi2CZLGBSYkHF85GYOCtxxFxMFTo=
X-Received: by 2002:a05:6830:18da:: with SMTP id
 v26mr21877594ote.135.1592226226838; 
 Mon, 15 Jun 2020 06:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591272275.git.jcd@tribudubois.net>
 <cbafa49a59659051387e43b7b35d8f280e59f1a3.1591272275.git.jcd@tribudubois.net>
In-Reply-To: <cbafa49a59659051387e43b7b35d8f280e59f1a3.1591272275.git.jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 14:03:35 +0100
Message-ID: <CAFEAcA-ivCjAcK=mVBktdN_ms09M096WF=9zoKM+11=HzgmwSA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] hw/net/imx_fec: improve PHY implementation.
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 4 Jun 2020 at 13:39, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
>
> improve the PHY implementation with more generic code.
>
> This patch remove a lot of harcoded values to replace them with
> generic symbols from header files.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>  v2: Not present
>  v3: Not present
>  v4: Not present
>  v5: improve PHY implementation.
>
>  hw/net/imx_fec.c     | 76 +++++++++++++++++++++++++++-----------------
>  include/hw/net/mii.h |  4 +++
>  2 files changed, 50 insertions(+), 30 deletions(-)


> -    case 5:     /* Auto-neg Link Partner Ability */
> -        val = 0x0f71;
> +    case MII_ANLPAR:     /* Auto-neg Link Partner Ability */
> +        val = MII_ANLPAR_CSMACD | MII_ANLPAR_10 | MII_ANLPAR_10FD |
> +              MII_ANLPAR_TX | MII_ANLPAR_TXFD | MII_ANLPAR_PAUSE |
> +              MII_ANLPAR_PAUSEASY;

The old value is 0x0f71, but the new one with the constants
is 0x0de1.


> -    case 30:    /* Interrupt mask */
> +    case MII_SMC911X_IM:    /* Interrupt mask */
>          val = s->phy_int_mask;
>          break;
> -    case 17:
> -    case 18:
> +    case MII_NSR:
> +        val = 1 << 6;
> +        break;

The old code didn't have a case for MII_NSR (16).

> +    case MII_LBREMR:
> +    case MII_REC:
>      case 27:
>      case 31:


> -    case 4:     /* Auto-neg advertisement */
> -        s->phy_advertise = (val & 0x2d7f) | 0x80;
> +    case MII_ANAR:     /* Auto-neg advertisement */
> +        s->phy_advertise = (val & (MII_ANAR_PAUSE_ASYM | MII_ANAR_PAUSE |
> +                                   MII_ANAR_TXFD | MII_ANAR_TX |
> +                                   MII_ANAR_10FD | MII_ANAR_10 | 0x1f)) |
> +                                   MII_ANAR_TX;

The old code does & 0x2d7f; the new code is & 0xdff.

>          break;

If some of these are bug fixes, please can you put them in a separate
patch, so that the "use symbolic constants" change can be reviewed
as making no functional changes?

thanks
-- PMM

