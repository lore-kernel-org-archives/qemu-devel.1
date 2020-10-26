Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D12C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:34:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC2122250
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DGodv2kP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC2122250
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0m0-0002F5-6H
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX0l9-0001lv-Nm
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:33:55 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:43996)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX0l4-0005Nv-A3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:33:55 -0400
Received: by mail-ej1-x642.google.com with SMTP id k3so12859265ejj.10
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 04:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8Nkx+bElGn6dz0NQi68hTJhxzLW2JUoeape4GPIAgyI=;
 b=DGodv2kPDu3CcG5tozHGKx0th8GFeF3gsqsV09Nu6PrT76XnSkw4MVBgyWU6jHR9mg
 w+60+G+mPBkJSP5VHQHazC/0Y5de3fQh41aqn2P6g93VnPbkxoBtOg/XbAgrRM4G/JOe
 5Czl6CN24HVjGFnT3Q8CbFzqDLFGxS9Y1CmbgD3/mu50gfEzaYrUX5+NeZOgdVq7p5KX
 /tK9ArwPbfmKuaRxkwTQbSacMHq+h4JHJe010ARD1HaNPl8WxvL8FzrzSjcA3kcYGME2
 9GHG+g8Pv19e+ZRSdIgls/vpi1IjI5EoHtMeDLEjeyLr5smfF9IJ+Xvoiv2Tt1FiZ1mJ
 Xdyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8Nkx+bElGn6dz0NQi68hTJhxzLW2JUoeape4GPIAgyI=;
 b=Pbc68RUbSoOd3RoUik2dTYduU10iyYFZ1zwhGlyVrnOSDHaEEWPUXoujIUnsKFbMfl
 9l+SR3P+H6jj3E6aGNGfxNStHfadww3kThpe1+EcnFLMXGPOkgf2LoKfoPrFnDZ8ks2C
 ZjP3NlqF5Ct3b+FUirzX0R8OuSb6ZK1F6ilAokPnxhPWKGV7a9U9az957hRp/JnH0Y5C
 2K5lPcXYfZOPbSShXTytEf25rsm1lIVinfF02PITpNEcmBuhvJl56+AjCck9UljCaip4
 iRRbQXo2UF/EeS8WpO20zwL65IfOG5+PwrWg9c51zlhaHHjBRQQV5CxlTat2YCI2+0zf
 9QPw==
X-Gm-Message-State: AOAM531zTOcXirt6PqmEXKU19dsJAsC13TtogLPkwvL/Y4INoKuLKM/Z
 /8N06VbtDImuKOgB0Preptjbw3HtM9A4plrS7OIYyg==
X-Google-Smtp-Source: ABdhPJypljLU6VeWHcP8EJBSwkY6EmzvAfrpH+qkHnZDDZHdepMGSqiEu/OgOVyupinQKKhxYRkFsmq+ozzhWYq5suk=
X-Received: by 2002:a17:906:1f42:: with SMTP id
 d2mr14875555ejk.407.1603712025375; 
 Mon, 26 Oct 2020 04:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <20201021173749.111103-1-richard.henderson@linaro.org>
In-Reply-To: <20201021173749.111103-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 11:33:34 +0000
Message-ID: <CAFEAcA9T0zSvtFPy+0ksq-UpFTKwxRR=w9pBkTFOYx15HW_caA@mail.gmail.com>
Subject: Re: [PATCH v12 00/12] linux-user: User support for AArch64 BTI
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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

On Wed, 21 Oct 2020 at 18:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The kernel abi for this was merged in v5.8, just as the qemu 5.1
> merge window was closing, so this slipped to the next dev cycle.
>
> Changes from v11:
>   * Fix the reported bti-2 crash.
>     Work around a bug in ld from binutils 2.34 (in our docker image,
>     and Linaro's aarch64 ubuntu 20 host), which has been fixed in
>     binutils 2.35 (in my laptop's cross-compiler installation).
>
> Changes from v10:
>   * Include Phil's plug of interp_name memory leak.
>   * Convert error reporting to Error api.
>   * Mirror the kernel's code structure for parsing notes
>     (though Error means that it's not exactly the same).
>   * Split aarch64 stuff from basic note parsing patch.
>
> Changes from v9:
>   * Split what is now patch 7 into 3 more (pmm).
>   * All prerequisites are now upstream.
>



Applied to target-arm.next, thanks.

-- PMM

