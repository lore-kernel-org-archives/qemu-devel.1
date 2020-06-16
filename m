Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC93C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:18:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7AFD20707
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 10:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hhgTb9vw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7AFD20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl8g7-0002m9-SH
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 06:18:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8df-0000im-IA
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:16:19 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jl8dd-0007Pe-6w
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 06:16:19 -0400
Received: by mail-oi1-x244.google.com with SMTP id d67so18720611oig.6
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 03:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=iOwywz5A6+76u6vWYLIS/BZrh1ORr7H8LGCueT1K7Mw=;
 b=hhgTb9vwRHyWB8OzXACpruAMD/yap1hTtL+dVVAyJ2u1pW2N293LY8WocecDxdUDAO
 t+vAiG8rNKu2dxl9SqdhH61VjzMsIGvkZZ3ofmslinVi0qd3lg+2zCkooWHcHt9mlKlJ
 +8lRdpReL4idYM2PSytrVMDDRdX1xWFwLTzK3cfubpszk6LkbV9k+xwf5oj/S+zULzLS
 ADMEOBzrccmIHLHoNIi/8pe4PjTrp7KajuhwTh2q8CBd8huF0cG0N2vy3Ga1q11z49Jc
 luEaScNMVvgo0zcvjgt04s6OVX/GVCFqAiJcpXS1IuzCIWR5HqfO0pEJvQRoT0JCJmup
 fuKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=iOwywz5A6+76u6vWYLIS/BZrh1ORr7H8LGCueT1K7Mw=;
 b=Jle6lfNvTrPv39qIslmUgSlEpqo+Xi+wszP/EPU9El73CwEMudi4TQMzo9vUeEbUpP
 r3PjInbtKGu9/lk0NBn9Ei2lyf/isVYXcEHdYgTPr4xmr1KCcIauwI4F/Nvxub7rkXfS
 guJx5kmjhHJ/IKccWybdfKS0Q7UxAj2dl/4CHd8RR1rCErB4kPxHngubrnYaXmcPJYd6
 SYVNDCLmmSMuvx6Sc2uhgTGSjsHaz+ZZyMicytc7tRIBCqtqiLQ7EUbKb2bZJAlUSnQY
 SkYuzKUJsqAnmLnFxN9Fopzw6rI8rkFkUSIthH5i8fp/LPhFJQY8XFbXv/L1RDmeMc+J
 A0DQ==
X-Gm-Message-State: AOAM530/NeCRk2DzVC6ttXxWKHA+DgCiewUx6lUSwBgfDV6IfWVe/7vw
 tWCWhko/us1FWzVKPPVOQur1IOM/RRkX/2Xx+/Yx5Q==
X-Google-Smtp-Source: ABdhPJzBFy6c6eX2hRkwuPhEZfXVsfV3bWItf2t3kUDD6vcpvEmHiaZgpXouff7vGuVS5Ryu52DEfdlIDg77/Hjai68=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr2688464oia.163.1592302575964; 
 Tue, 16 Jun 2020 03:16:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200616063157.16389-1-f4bug@amsat.org>
 <20200616063157.16389-3-f4bug@amsat.org>
In-Reply-To: <20200616063157.16389-3-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jun 2020 11:16:05 +0100
Message-ID: <CAFEAcA99=aiO3q+c2NnaSwax-6BusH0OREr5t2DesccNUA2HvA@mail.gmail.com>
Subject: Re: [PATCH 2/7] hw/arm/mps2: Rename dualtimer as apb-dualtimer
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Esteban Bosse <estebanbosse@gmail.com>,
 Joaquin de Andres <me@xcancerberox.com.ar>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 07:32, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> The dualtimer is connected to AMBA APB.

True, but that doesn't mean we need to name it "apb-something".
The AN385 TRM just calls it "Dual timer".

thanks
-- PMM

