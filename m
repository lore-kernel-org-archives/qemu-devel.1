Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6AB5C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 267832231B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 15:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWYnIXik"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 267832231B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUX4t-00085w-1X
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 11:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUX3J-0006LI-Gw
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:26:26 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUX3D-0004Wx-3u
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:26:25 -0400
Received: by mail-ed1-x542.google.com with SMTP id p13so10678804edi.7
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aGYSXS2tqeFOGeLvtcXqnFJ2d/lZHIsVFndSch3OHDk=;
 b=HWYnIXikuuDV0XeA2FbGWyKzO9q5V6AFyuSvvxZ/YgrOJeEH2el7ukC4eFQCaF85tP
 ztAw7QWTR+s0SNB9YZFZR8Em91ca12A86Uw4dgXETjOHhYrKlEiH10QS/JnLawgrhoB5
 oMCQtLAr5Jr1M/vMItFLt6ce75ZHJIXQFtwBZUpozeIcQK3qM48R3FGY8q70WUNgyz4K
 Hn6+mncQB1QuhmHmFgOI6yBS1IOWwE+2E3c19V7Kc4Fbqsx9SUs4W4gSZ0NRlf3iMCst
 Enccwd4xJenSI75hyyoDue1newf3JrEDVtdPSrJUp4zq9l8Vk544eq7md1X/szu5g0ff
 iwww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aGYSXS2tqeFOGeLvtcXqnFJ2d/lZHIsVFndSch3OHDk=;
 b=p0+Vp5JWcqoxJd5MRbhQM8QX141C0aDv/rTLiZaeJZctXxEOx8HHunV57EmGmLaqvS
 vVLsQCkgmcGR3ZU0WJ2qLpHriyFNrqbgjFFMmdOv9PJNwT36N/OEcCtIQPnVSu/34Dlr
 BsnWkKZpFSWaWTLuuw+Lph7q5eM8Sc+XL/8dVZW6/rCm3cjZQCfKzkG1/9JErHYQblxc
 wgxn0Tnls77hLr6SZgOIiMkx3auZWSr+BKN06s7p909CqSkGVpzC6t5uAv+ZgxD6UjHB
 Uhzcq8/UDzKr7HBWy5zawqv8KokFzBaesaPEqtfMCO1Kx1y5GrOOk1oTJpTG6e+hwxbK
 a4Mw==
X-Gm-Message-State: AOAM530e1udyveoxP31RKS3bKqpO4HgCvWO0l+X1N53eloVoRPUeRZ2p
 LIS/nPpyoUBek7661AQYqAlXy71hlXahPdpWo1jmXA==
X-Google-Smtp-Source: ABdhPJz7YvX1nznHKuFL3D14aJjbPx3+zUY7giapUfPD68lFPsFJExtoQrc463neQLYwr1sVcybIC2tkvtPEFDz9sxo=
X-Received: by 2002:aa7:c7d7:: with SMTP id o23mr366156eds.44.1603121177742;
 Mon, 19 Oct 2020 08:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20201008161414.2672569-1-philmd@redhat.com>
In-Reply-To: <20201008161414.2672569-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 16:26:06 +0100
Message-ID: <CAFEAcA-O847-ATWLYKfFDoDWapeFfLy-CH1Fg0G0E8PVq0xYng@mail.gmail.com>
Subject: Re: [PATCH v3] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Dongjiu Geng <gengdongjiu@huawei.com>,
 Xiang Zheng <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Oct 2020 at 17:14, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> While APEI is a generic ACPI feature (usable by X86 and ARM64), only
> the 'virt' machine uses it, by enabling the RAS Virtualization. See
> commit 2afa8c8519: "hw/arm/virt: Introduce a RAS machine option").
>
> Restrict the APEI tables generation code to the single user: the virt
> machine. If another machine wants to use it, it simply has to 'select
> ACPI_APEI' in its Kconfig.
>
> Fixes: aa16508f1d ("ACPI: Build related register address fields via hardw=
are error fw_cfg blob")
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> Reviewed-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Acked-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

