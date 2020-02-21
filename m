Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC3CC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:08:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62F22073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 14:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wTnUuK2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62F22073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58yh-0005P4-Rq
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 09:08:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j58y3-0004uD-62
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j58y1-0000Gw-Uu
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:07:47 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:37250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j58y1-0000GT-Og
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 09:07:45 -0500
Received: by mail-oi1-x241.google.com with SMTP id q84so1669412oic.4
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 06:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jRrCY8ivewk2YPDDhcTANhN06ruxAxSf+AS7eQGMH4k=;
 b=wTnUuK2EkkmDJZpLj4tmgHEqKVPhULq+9DKBHUK9iU38rUMNmOc/I4zk9rDHhxEFuq
 O/1uQiBW33+L9XDt7L+lOx+RfvBiKxJteC/df5Ub/RpCDiUgBoI9htfYdyQsRX3nA0pO
 IhTWX3XyCBr+PFR5vOzZJT1aH96Vty28jyER/5U5p9W0xUCr9udL/jjr6F8hmNXVfnYQ
 +gZPfYOkd77DeI9TVzjuCqDwF7nAPjYnDNnycJM7hDII9KRT4tx9hNKZ3JvIP9DQAM4E
 FhCu1om59A5iQYmeHYP4ZYQVF58PY7JpQlCv+fFLWIJvQi3ObOsitNgfTf51YPOUz1XP
 qcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jRrCY8ivewk2YPDDhcTANhN06ruxAxSf+AS7eQGMH4k=;
 b=tpTI/HU5A3/T2bz6RQGkTER1UTQXXHY1L9okZecM5I3zeagQkUfeyC7LySBKtg7iK9
 i2JhEVMC+a/Mlmc+YA7XSHsbqcLi5qqSNf26gN/eB0a/w7m3Dd96xb6w6Rx6NTzXTIxO
 +EyYVXUt0WuPQXfNTUtPxE+Jc+znn+TNlG2JQllgKmYJ3PFd0BkVxvfZjz2eR8j9UUAy
 +txY6ARiJKJm6/fwBzt9wwFo5EZ7qq59eAMHoRhcgZKl9dcT71v3e1KvMjRCrXX6uilb
 8m+1Kxd5W4wjnfqWJ9Y3B6DUzYyu94iC2V92x6lMyPaNIq5DpxCbcy+fI6udhyQ4VI4y
 SfOA==
X-Gm-Message-State: APjAAAWvoPL4xJYrtB2FNe0nG5Jtl2OTe1KwU7UFfk8kAJduBzYUSjRk
 q2KXfWSsIH3JTJa9zcZ8LZLzuW6xfzka6L763ZVnag==
X-Google-Smtp-Source: APXvYqwjXmjS0kIXrAdxCSwzyqX9j8aeVXh4lRUHp81kHrvWmlE7IV/sUVn+HHmyAzzQD2/6b57aeS2rRsDlIs/+2YA=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2127351oif.163.1582294064908; 
 Fri, 21 Feb 2020 06:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20200217131248.28273-1-gengdongjiu@huawei.com>
 <20200217131248.28273-2-gengdongjiu@huawei.com>
In-Reply-To: <20200217131248.28273-2-gengdongjiu@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 14:07:34 +0000
Message-ID: <CAFEAcA_smgw3cg=jqh_xRU1N+mYB1B6qR75EP14SNgZ4aa0zxg@mail.gmail.com>
Subject: Re: [PATCH v24 01/10] acpi: nvdimm: change NVDIMM_UUID_LE to a common
 macro
To: Dongjiu Geng <gengdongjiu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
 Eduardo Habkost <ehabkost@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Zheng Xiang <zhengxiang9@huawei.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Feb 2020 at 13:10, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
>
> The little end UUID is used in many places, so make
> NVDIMM_UUID_LE to a common macro to convert the UUID
> to a little end array.
>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Reviewed-by: Xiang Zheng <zhengxiang9@huawei.com>
> ---
>  hw/acpi/nvdimm.c    | 8 ++------
>  include/qemu/uuid.h | 5 +++++
>  2 files changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
> index 9fdad6d..232b701 100644
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
> @@ -60,17 +61,12 @@ static GSList *nvdimm_get_device_list(void)
>      return list;
>  }
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
> +      UUID_LE(0x66f0d379, 0xb4f3, 0x4074, 0xac, 0x43, 0x0d, 0x33,
>                       0x18, 0xb7, 0x8c, 0xdb);

You need to fix up the indentation on this following line.

>
>  /*
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 129c45f..bd38af5 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -34,6 +34,11 @@ typedef struct {
>      };
>  } QemuUUID;
>
> +#define UUID_LE(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)             \
> +  { (a) & 0xff, ((a) >> 8) & 0xff, ((a) >> 16) & 0xff, ((a) >> 24) & 0xff, \
> +     (b) & 0xff, ((b) >> 8) & 0xff, (c) & 0xff, ((c) >> 8) & 0xff,          \
> +     (d0), (d1), (d2), (d3), (d4), (d5), (d6), (d7) }
> +

If you want to make this a macro in a visible-to-the-rest-of-QEMU
header file, can you provide a documentation comment please that
describes what the macro is for? It would also be useful to
give the arguments (which should be documented in the doc comment)
more descriptive names than a, b, c...

>  #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
>                   "%02hhx%02hhx-%02hhx%02hhx-" \
>                   "%02hhx%02hhx-" \
> --
> 1.8.3.1


thanks
-- PMM

