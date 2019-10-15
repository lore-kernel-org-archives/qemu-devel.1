Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126CC10F14
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:55:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F11F02054F
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xub1vEGE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F11F02054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKOE7-0003Ur-IT
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41483)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iKOCH-0001TM-5l
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:53:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iKOCF-0007y5-Rq
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:53:12 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iKOCF-0007wp-KL
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:53:11 -0400
Received: by mail-oi1-x243.google.com with SMTP id i185so17010802oif.9
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2019 07:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pJHLxWBHfbqmvzOZUSxQLaGo5BYoxOcdXmYT8MESVjw=;
 b=xub1vEGEH9eORcaWMny1wqHLHVDX8S+d+vqaqqeWA5aKqQSbiX7OrCIGAthe6hu1/d
 Mrp97VpPtfEgTqcvJ62iH5fRPmM3VcGoRg/OBifl4WEPwpYj64dGvu8B6yBHQ82l5neY
 eaEnn00p8ynrcNEPceCCijGcb42XzIddNsoN6st0PvBxXwPKwN/36BY7RG6KBgSmNy6p
 7/IzPL33RNCtbClPxUtV7wBEfETxpz57wORrtVJodn0AlQ+9IEfAc2E46iFBGz54CXva
 puTcYU/tgOJ3lLl32zPvdBjNWrRTFQjp+D+CFZksw41S9zGnVWzuT5WBCdW7khas7YPq
 B/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pJHLxWBHfbqmvzOZUSxQLaGo5BYoxOcdXmYT8MESVjw=;
 b=svsffNyxvNJqXPZhfI7NyCC2XOtDVYBGM4naxWue870SWCi1x9TH0AxThdIAlCeWpE
 1rh//9rwq+RmuJUZ2yTDrACJByXnbRf+YL83I56poy+q5b5P8oD4v2iXb/aKmxy8iOXb
 V53uv9vAjROEeJ/fJ/1+DQ/Ox7ftncc06eLhzYA4TQdf3IYZ/hPBuPbh0lUyi/Bx8B6q
 k4itUEYR4ogAmenv1VfpPqtW1JSiS7VD48jXz4zheAVLcg0P1IUYWiW8WYQG6Cfv9F8O
 1p7pOOx1oTHbtQH6rxQ4FbMns2UvnCmpwTpJy17yjWbBA7nXGrCD0T4blZ3+IiLuaXzM
 I4aA==
X-Gm-Message-State: APjAAAXVeo0XmghRTyoQrnQAZEO0TT1tFmqDmAPFd/miY7jT6GEvHHDU
 IFuCg8uCnquKiY4zPH2xnMpxCI8zpJ6Bb7KN84i5vtRbVAo=
X-Google-Smtp-Source: APXvYqzqvQComCBgFaQw5Q1kH9xNYO35eAfDsvhDHQduxNV0EVl/ym25KkAdWnopvPsA8eHPMLcixw9oewjaRJjJJ+s=
X-Received: by 2002:a54:4e83:: with SMTP id c3mr29597998oiy.170.1571151190401; 
 Tue, 15 Oct 2019 07:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20191015140140.34748-1-zhengxiang9@huawei.com>
 <20191015140140.34748-4-zhengxiang9@huawei.com>
In-Reply-To: <20191015140140.34748-4-zhengxiang9@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 Oct 2019 15:52:59 +0100
Message-ID: <CAFEAcA9CWPKF5XibFtZRwavVj4PboGoaM5368Omje6qrOjV3AQ@mail.gmail.com>
Subject: Re: [PATCH v19 3/5] ACPI: Add APEI GHES table generation support
To: Xiang Zheng <zhengxiang9@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, wanghaibin.wang@huawei.com,
 Marcelo Tosatti <mtosatti@redhat.com>, Linuxarm <linuxarm@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>, gengdongjiu <gengdongjiu@huawei.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 James Morse <james.morse@arm.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "xuwei \(O\)" <xuwei5@huawei.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 15 Oct 2019 at 15:02, Xiang Zheng <zhengxiang9@huawei.com> wrote:
>
> From: Dongjiu Geng <gengdongjiu@huawei.com>
>
> This patch implements APEI GHES Table generation via fw_cfg blobs. Now
> it only supports ARMv8 SEA, a type of GHESv2 error source. Afterwards,
> we can extend the supported types if needed. For the CPER section,
> currently it is memory section because kernel mainly wants userspace to
> handle the memory errors.
>
> This patch follows the spec ACPI 6.2 to build the Hardware Error Source
> table. For more detailed information, please refer to document:
> docs/specs/acpi_hest_ghes.rst
>
> Suggested-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>

> +    /* Error Status Address */
> +    build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
> +                     4 /* QWord access */, 0);

Hi; this doesn't seem to compile with clang:

/home/petmay01/linaro/qemu-from-laptop/qemu/hw/acpi/acpi_ghes.c:330:34:
error: implicit conversion from
      enumeration type 'AmlRegionSpace' to different enumeration type
'AmlAddressSpace'
      [-Werror,-Wenum-conversion]
    build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
    ~~~~~~~~~~~~~~~~             ^~~~~~~~~~~~~~~~~
/home/petmay01/linaro/qemu-from-laptop/qemu/hw/acpi/acpi_ghes.c:351:34:
error: implicit conversion from
      enumeration type 'AmlRegionSpace' to different enumeration type
'AmlAddressSpace'
      [-Werror,-Wenum-conversion]
    build_append_gas(table_data, AML_SYSTEM_MEMORY, 0x40, 0,
    ~~~~~~~~~~~~~~~~             ^~~~~~~~~~~~~~~~~
2 errors generated.

Should these be AML_AS_SYSTEM_MEMORY, or should the build_append_gas()
function be taking an AmlRegionSpace rather than an AmlAddressSpace ?

thanks
-- PMM

