Return-Path: <SRS0=0Zkw=4R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED34EC3F2CD
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 19:54:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC73A24677
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Feb 2020 19:54:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gT4V6fbr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC73A24677
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35384 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j88Bc-0007aq-Ry
	for qemu-devel@archiver.kernel.org; Sat, 29 Feb 2020 14:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45455)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j88Av-00075X-9h
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 14:53:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j88Au-0007KT-6Z
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 14:53:25 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j88Au-0007KF-0D
 for qemu-devel@nongnu.org; Sat, 29 Feb 2020 14:53:24 -0500
Received: by mail-pg1-x543.google.com with SMTP id 7so3316368pgr.2
 for <qemu-devel@nongnu.org>; Sat, 29 Feb 2020 11:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=+D2xWd22fCONtEOqQ3xwazCpKlOAdruXcWTXQzxS1+A=;
 b=gT4V6fbrk3Kfyv65hU2PcZzxbefzJkPdIARvDrMpN+EUv2Njl1FFkcDmsAroC4gvUd
 I78CxeskXQno1KAOsWIiXTDForhf2otCpnqh4g3bTiUwm/XsanoEQRq5EAKpCrPMWaAs
 Bl5B5UcNFF01SxD+tiKhs7J59yY3wDsG2pkQBK6Jk+y49gdqV5FTKmubkOgJpkeMTBkj
 VByNoUYYBPiHpifWEPHExBQTzpsWbtOPzKiGitrqQyEAFiTZEb4cidQfKpstUWFLuebq
 daXMBf7uVkKG1BCeeaJ5ZAHg7slLEm8ssz+g+ShHIBLjkWBVbANmlG+3lV01iwXybWht
 YllQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=+D2xWd22fCONtEOqQ3xwazCpKlOAdruXcWTXQzxS1+A=;
 b=Us5LHSzVt+I5roaBRcKPpklgQjM0XL3XVDcUMyx3O5C+b+MdKgVdGVPonm8NtUgM3y
 Jp4okocdTz+6Pf7JpTERwSiWwYTRIvTSI3HlFVOkjb/dMfEVqEgQwIqpbiF95dGVTIfx
 ILNwaOw+BGaKyndwdTYfpRBwsc8xRPRSlP0iEtATuYZhR0fKxhsUBIkSjFsASeaPgPk5
 4RRQvumhW2UuUI7S/MEf2JIySBstXD566+B2+uafFJ32CRVAnIyOeX2EGJFaxR8kXKpX
 6ya/5782U2Uud592aWXWDnhQOnJsYZ+Qe/B7ulBIrIPGXNZ2naAFIuZqTDg0wgd3+GVu
 xDSA==
X-Gm-Message-State: APjAAAVMU60CLKSXX1iNm4aatQJjsKVdjFk9PYY2SpYmYp505QuInw0w
 N4xzc4mes2JOJEoCvVyN35e5tA==
X-Google-Smtp-Source: APXvYqycpU59jgKQNNYDOosqjfA3q2YFlbAOOOepk0XZW65cvBjMl5ONH1adkItZxjG3LWxpXn+//Q==
X-Received: by 2002:a63:cf41:: with SMTP id b1mr10843754pgj.53.1583006002900; 
 Sat, 29 Feb 2020 11:53:22 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 b71sm3360199pfb.156.2020.02.29.11.53.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Feb 2020 11:53:22 -0800 (PST)
Subject: Re: [PATCH v2 00/18] hw: Clean up hw/i386 headers (and few alpha/hppa)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200228114649.12818-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a55dde10-01b4-9fe9-03b0-d9c6070767c6@linaro.org>
Date: Sat, 29 Feb 2020 11:53:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200228114649.12818-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/28/20 3:46 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (18):
>   vl: Add missing "hw/boards.h" include
>   hw/southbridge/ich9: Removed unused headers
>   hw/i386/ioapic_internal: Remove unused "hw/i386/ioapic.h" header
>   hw/timer: Remove unused "ui/console.h" header
>   hw/usb/dev-storage: Remove unused "ui/console.h" header
>   hw/i386/intel_iommu: Remove unused includes
>   hw/alpha/alpha_sys: Remove unused "hw/ide.h" header
>   hw/alpha/dp264: Include "net/net.h"
>   hw/hppa/machine: Include "net/net.h"
>   hw/acpi/cpu_hotplug: Include "hw/pci/pci.h"
>   hw/timer/hpet: Include "exec/address-spaces.h"
>   hw/pci-host/q35: Include "qemu/range.h"
>   hw/i2c/smbus_ich9: Include "qemu/range.h"
>   hw/pci-host/piix: Include "qemu/range.h"
>   hw/acpi: Include "hw/mem/nvdimm.h"
>   hw/i386: Include "hw/mem/nvdimm.h"
>   hw/pci-host/q35: Remove unused includes

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


