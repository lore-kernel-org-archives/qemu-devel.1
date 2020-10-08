Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6BEC43467
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:51:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F90A215A4
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 10:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hSIeB36o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F90A215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60376 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQTWQ-0007Yf-8s
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 06:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTVP-00079M-LA
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:50:39 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:41901)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQTVN-0008Jy-T4
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 06:50:39 -0400
Received: by mail-ed1-x543.google.com with SMTP id l24so5336992edj.8
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 03:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ghvnSAdL67cXKelyecMQPqZ99k27GAn9Bx0COZlV1tQ=;
 b=hSIeB36oSflEkyQLN5+tqEzHji9kLKMm7O2Y4UKswm3yyimjL7KV3tXi3RQBwQmZAC
 Wixl1kwt+Xj/1dlz8FtkXnFLH3K1bS3JKt5mJcHiZRnfHx96Ol5QfQLH+8fDEQXy/O3E
 mFeUN5wXm7vYn/ZvEcNcOKC5iQVvuHCgAQ/nGZPb4c4XqE+mDtZ9CHv6WlmcGACA39ic
 2arAKnE/XiDOlyf5P4D+U0/CXu0hbzUevpwlmXUGtzOdaf0MgaxUG08s+Ll0IhYvlrnZ
 K4FJwdX+Lz8muxeq933i3I/d3Z7qFgaqeRmjRLatR5mak2NfpOJ3Q5maPEKL8DKOqF/H
 BD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ghvnSAdL67cXKelyecMQPqZ99k27GAn9Bx0COZlV1tQ=;
 b=KIoUDF6vjI3j8J1bxvGj3rLLIrDMJpjM3/y8d51TapMPrKqeIymQPENNRULkfqvaGl
 9igrIjMJfQptf+zLBTY49YAsGMcG2q21vpjbL9ovgsG2hzKh7qjaG7D0u/W83DOyDIpv
 0vwV2Ui2t2OmY3VC9t8aKYmBlch660MbfL0olWar+umrUGePz7UqxDPKQ/AVbS+LTD9p
 t0wGsLdsYflGmb1huHVwghIW0kgVUx/uDbYmavdg/eCZxrLatRw7PwOHDFcEt/17WOFh
 hfTCIazjEJBQ7iHu+A3F0eKk9ctGs3KgN7dgN2S49+K8GDg0XUU9ORAIGdakQqatkyvH
 KKqw==
X-Gm-Message-State: AOAM531KGN7xGY4+igKbEsEUymfbngKOZDSxZzDzeBBFYZ/NzsVeVapb
 ONFdweeQrtLYskcVzr7o/GjNSaMN5lxV3qU/xJmopg==
X-Google-Smtp-Source: ABdhPJw6uR/DUpiKCQ99Per69G1bCxMBuVl1zDhDMAs7X+J0FbieLtk+rEhYEHgy8voE/6L7mZ+wVkFFEVuIbgq0aTg=
X-Received: by 2002:a50:9ea6:: with SMTP id a35mr8703700edf.52.1602154236161; 
 Thu, 08 Oct 2020 03:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <20201001162207.1566127-1-philmd@redhat.com>
In-Reply-To: <20201001162207.1566127-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 11:50:25 +0100
Message-ID: <CAFEAcA-EH3=Bg4zdu5=Y2MKOYA4Rdpzj+QCU=48yKHQdB5FXcw@mail.gmail.com>
Subject: Re: [PATCH v2] hw/arm: Restrict APEI tables generation to the 'virt'
 machine
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, 1 Oct 2020 at 17:22, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
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
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Reworded
>
> Cc: Laszlo Ersek <lersek@redhat.com>
> Cc: Xiang Zheng <zhengxiang9@huawei.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> ---
>  default-configs/arm-softmmu.mak | 1 -
>  hw/arm/Kconfig                  | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)

I assume this needs a respin now Paolo's reworking of
default-configs/ has gone into master.

thanks
-- PMM

