Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8B91C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:35:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8968420693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:35:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8968420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsnow-0000El-T1
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 08:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34998)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsnoO-0008H3-Ra
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsnoN-0001F8-RZ
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:34:32 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53940)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsnoN-0001Et-MG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:34:31 -0400
Received: by mail-wm1-f67.google.com with SMTP id x15so60660379wmj.3
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 05:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=O4d6PQnNXl49eGgPxln7OX7q0+n+iu+R+qVU2oaJReA=;
 b=exu8XJnXsvspP4J2/7g5GIHRJpI68cZvDDPDkvz2ria3gn9XWHh3y4mcGvlhw64nsP
 NKJoGI1Mixo3pxYceUNaij7QHHMyGyIxYAoJ1r/taNoWk7xWYRollwmprFw/oHKxJMj5
 icH/eZvYxr3KKUlRfqLEwbp6V2c1zxavJdGVmEEv2/Os4/l3sdluuL/b/o6B/Cxm/PtP
 I9gHNWbaCIEs43U6Fj3fSdd8il0guZqN554bDsEByi7r3dlq0+S0q7LYggrFfToYxMZe
 Ngv0mFRNaqmv8+oHxnV2WHzqbUr894V+gqWyLpFJcd3Dtlziae2SHLfb9/T9nz+y5vAF
 JElg==
X-Gm-Message-State: APjAAAUfghzi2rsoe5fNfWz28H8RsjiJ//k4mi66PtZlV4O3Muh+/ft7
 CKEgkr7cBuUtEBhfxJ5JL+v/LQ==
X-Google-Smtp-Source: APXvYqwW3cYj4IK7GZWHSdQCWYPucZHRoB/cXPlvUVpdlb75bUxD3d04obggboR63MAhxcAnosvDsw==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr112566069wmf.52.1564576470678; 
 Wed, 31 Jul 2019 05:34:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3?
 ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
 by smtp.gmail.com with ESMTPSA id i18sm90322413wrp.91.2019.07.31.05.34.29
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 05:34:30 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7dc8ecea-f7ea-2ff8-e3bd-353e2cacbe9f@redhat.com>
Date: Wed, 31 Jul 2019 14:34:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731075652.17053-1-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] [PATCH for-4.2 v2 0/8] Kconfig switches
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/19 09:56, Thomas Huth wrote:
> Here are some more Kconfig patches that clean up the switches of
> existing devices and introduce proper config switches for some
> other devices that were always enabled before.
> 
> v2:
>  - Included Philippe's patches to avoid a conflict with XLNX_ZYNQMP
>  - Don't rely on indirect dependencies, always "select XYZ" if it is
>    adequate
>  - Added patch for the generic loader device
> 
> Philippe Mathieu-Daudé (3):
>   hw/Kconfig: Move the generic XLNX_ZYNQMP to the root hw/Kconfig
>   hw/intc: Only build the xlnx-iomod-intc device for the MicroBlaze PMU
>   hw/dma: Do not build the xlnx_dpdma device for the MicroBlaze machines
> 
> Thomas Huth (5):
>   hw/core: Add a config switch for the "register" device
>   hw/core: Add a config switch for the "or-irq" device
>   hw/core: Add a config switch for the "split-irq" device
>   hw/misc: Add a config switch for the "unimplemented" device
>   hw/core: Add a config switch for the generic loader device
> 
>  hw/Kconfig            |  4 ++++
>  hw/arm/Kconfig        | 15 +++++++++++++++
>  hw/core/Kconfig       | 13 +++++++++++++
>  hw/core/Makefile.objs |  8 ++++----
>  hw/dma/Kconfig        |  1 +
>  hw/dma/Makefile.objs  |  1 -
>  hw/intc/Makefile.objs |  2 +-
>  hw/microblaze/Kconfig |  1 +
>  hw/misc/Kconfig       |  3 +++
>  hw/misc/Makefile.objs |  2 +-
>  hw/pci-host/Kconfig   |  3 ++-
>  hw/sparc64/Kconfig    |  1 +
>  hw/timer/Kconfig      |  3 ---
>  13 files changed, 46 insertions(+), 11 deletions(-)
> 

Looks good.  Peter, are you picking it?

Paolo

