Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E94DC2D0EF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:17:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCA72064A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 13:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aNmEuET4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCA72064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPQs3-0006q3-VM
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 09:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34288)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jPQqZ-0005yG-GB
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:15:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jPQqW-0005NA-Se
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:15:55 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:33335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jPQqV-0005IT-Kb
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 09:15:52 -0400
Received: by mail-ot1-x343.google.com with SMTP id j26so1388778ots.0
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 06:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TboapKpbscmz855YSAFg2nIeGN97zkquFhVh21atq0U=;
 b=aNmEuET4pqkT1KkeKmgk6Cq9vBqgNu/ROxL2C7ezmo+e7TvlW/pt7eEDU2mGbKJOYa
 pd2IUEcQqcu4qx19uoBru9MI0rbUtrwjwrkXUi0Ao+bT9k5etlzBouSiftkQ6eyDLiCI
 kfDwLc5+qmzQPd+i133nQVievrA8CLz5BR0nFhlw01DpsQ3cus95k3U8AP+INw0F7ats
 tpVmUE1/T6IyhGtSyuHv5532KsG61E7Qyxpy4pOswNmwijgv3AE0FsuSUsoUL7C0gaet
 qpwFeJgOjQ532CXC3K6ADBOAEqxmh0qPU9rKOp7PwwVEFLHUzPx1/4TIDAXx3R/9a3pW
 GHjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TboapKpbscmz855YSAFg2nIeGN97zkquFhVh21atq0U=;
 b=NIgwLBJep2bQlmr4oMVkMnk9TuvfpcWy1UQblEE+pp0N2UX2S6x6XEy9N5ipeBVJNB
 zGLoCPU/lfPnu9gqDNOrZfRGaLi/i+GTEmYdEGpDoE5RhMcB6L7xaacBBxC1l1tmGdk2
 1Kvm3nlUToEQZf2eI4Y5KI9+xQRIK74E9aSMlyWaMHHp6uYlIVkSHuHscxDf083Zi2Te
 dv29EnDLU9TGsMqTJkkdeys1GZLO0tj620wfBLoJrt+x9hupa00ENkCd69oaVcnGvpsb
 u5uQ5hqvIz28tZGcKikt1r3ppyHKL/CKb8CyhCgDeYqbgbKMr0OEoA2UbCDHoCK6IAHZ
 GiLg==
X-Gm-Message-State: AGi0PuZSR+zohc6Ff7a4UZb8SkvvvKDLZ3tJwl0TeJ3sMQ0jpyZ8ErUE
 69IkZYPzACgPeJS7gRFLw1WU/6Jj1arAuJgXAuVauw==
X-Google-Smtp-Source: APiQypJVaXiKK+fekesrRmbkfJcK99mF8Dr0rTE3xJsFEyEaAUaA62DI5BSqDrUkQBtY4+41nUKVJE9aSQIFgr7kBl8=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr2432927otj.91.1587129345185; 
 Fri, 17 Apr 2020 06:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200410114639.32844-1-gengdongjiu@huawei.com>
 <20200410114639.32844-2-gengdongjiu@huawei.com>
In-Reply-To: <20200410114639.32844-2-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Apr 2020 14:15:33 +0100
Message-ID: <CAFEAcA_vqtFuoaLhczs-5ZXyjBWH4j4rF+5SUHMxVt_qTLyR5Q@mail.gmail.com>
Subject: Re: [PATCH v25 01/10] acpi: nvdimm: change NVDIMM_UUID_LE to a common
 macro
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Fam Zheng <fam@euphon.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Zheng Xiang <zhengxiang9@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 10 Apr 2020 at 12:45, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> The little end UUID is used in many places, so make
> NVDIMM_UUID_LE to a common macro to convert the UUID
> to a little end array.
>
> Reviewed-by: Xiang Zheng <zhengxiang9@huawei.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> ---
>  hw/acpi/nvdimm.c    | 10 +++-------
>  include/qemu/uuid.h |  9 +++++++++
>  2 files changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index eb6a37b..a747c63 100644
> --- a/hw/acpi/nvdimm.c
> +++ b/hw/acpi/nvdimm.c
> @@ -27,6 +27,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/uuid.h"
>  #include "hw/acpi/acpi.h"
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/bios-linker-loader.h"
> @@ -34,18 +35,13 @@
>  #include "hw/mem/nvdimm.h"
>  #include "qemu/nvdimm-utils.h"
>
> -#define NVDIMM_UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
> -   { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> -     (b) & 0xff, ((b) >> 8) & 0xff, (c) & 0xff, ((c) >> 8) & 0xff,          \
> -     (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }
> -
>  /*
>   * define Byte Addressable Persistent Memory (PM) Region according to
>   * ACPI 6.0: 5.2.25.1 System Physical Address Range Structure.
>   */
>  static const uint8_t nvdimm_nfit_spa_uuid[] =
> -      NVDIMM_UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d, 0x33,
> -                     0x18, 0xb7, 0x8c, 0xdb);
> +      UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d, 0x33,
> +              0x18, 0xb7, 0x8c, 0xdb);
>
>  /*
>   * NVDIMM Firmware Interface Table
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 129c45f..c55541b 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -34,6 +34,15 @@ typedef struct {
>      };
>  } QemuUUID;
>
> +/**
> + * convert UUID to little-endian array
> + * The input parameter is the member of  UUID
> + */

This isn't in the right form to be a proper doc-comment comment,
and it's too brief to really help somebody who doesn't already
know what the macro does.

The parameter names to the macro are still terrible, and
"member of UUID" doesn't help -- assuming you mean "members
of the QemuUUID struct, those are named 'time_low' , 'time_mid',
and so on, not this random selection of alphabetic and d0..d7.

> +#define UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
> +  { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> +     (b) & 0xff, ((b) >> 8) & 0xff, (c) & 0xff, ((c) >> 8) & 0xff,          \
> +     (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }
> +
>  #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
>                   "%02hhx%02hhx-%02hhx%02hhx-" \
>                   "%02hhx%02hhx-" \
> --
> 1.8.3.1

thanks
-- PMM

