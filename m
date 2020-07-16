Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C61DC433F8
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 197112065E
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jd4assSL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 197112065E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6vF-000491-B2
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6uh-0003iV-3r
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:39:15 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43588)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6ue-0007ZE-VZ
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:39:14 -0400
Received: by mail-oi1-x241.google.com with SMTP id x83so5567474oif.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lPp6+IokqPgK4YUA5WlSoHeWA4HF9WmGYrBBco+QKOI=;
 b=jd4assSLnpqDTRmY8m4sMZV40gxxW7rCaELkOhrZgRpev0yLkSGJmH7QggHu16M88o
 2w6PJaC9FB4JDV5l5zoV99W3GmR6qAScagnXCM/6lPyxTtZYq9U8gAyd5ULS9LjwB0XM
 PdRd2a7zjndmf8jBhcsBplJ7cJyPa2f7P/YldFUbDcq2CUlcnQqMnGKQ8KFDamwOZZPM
 kyoRH7HZ5HG5I85Gsg+u+/HDvaU+R/EhCI8QE3bhDeSdeYkmxaA/q3EDbmMDng+HTbbV
 uIzSjQuktPZzSYIDZX6XENbbQyLYqGEFRwheA+HLiX4+jq8DnyBiDKgVL89y42WjsvKi
 B74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lPp6+IokqPgK4YUA5WlSoHeWA4HF9WmGYrBBco+QKOI=;
 b=LV2dKHlG3b1cT/EK/nUwTQjzy3PiL/k128IUtulovCPpu6OOBX9guV2SubzclX8AcD
 /0e41TzAxYW5tVhNqaEphCUXqcFcR6MHpp4fIctssX04Tj9kXCg1/l15QN5WmmxNHIh7
 T/ec8Ruvh5F4kOqda9elkPQfWboixefKWDGDiNSNIM3649A7L6Ap19t3E4EhSx5qm8ET
 iXxexo+N8PluHfH1P6FdrXJg+mUrvkYGYAlrbIzOZkB6riWaw3Z5OWbCqhyPY5DybtLg
 2qVFs3QtQb5EWlquuhh7HClCXfVz96ZpxzUN2trV0cXKC0NvMoLfHXb/Uc265zcceSQD
 3kIg==
X-Gm-Message-State: AOAM533aoobg977LR4bGkVE1OM3U+Lw9PPpOSyLSBzupW7rTG7D7KKYN
 dUUCv0mINT/kEbOgDNmEQm3vgyucCDQNeHz8J15WVw==
X-Google-Smtp-Source: ABdhPJz6Y189ecFPxH2OiBr2R0FL+VKw0s0hxJDn0w9dni3r//GmIQ8U980Sv1B0ldWuea0PN6+hcN047/0++0R4qd4=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4468620oib.163.1594917550033; 
 Thu, 16 Jul 2020 09:39:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-7-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-7-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 17:38:59 +0100
Message-ID: <CAFEAcA-wfDD1gxKymYppVCsaxOi=h0_0SrvR+=3aJ0-3_sWB7Q@mail.gmail.com>
Subject: Re: [PATCH v3 6/9] spapr_pci: add spapr msi read method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 13:31, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add spapr msi mmio read method to avoid NULL pointer dereference
> issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ppc/spapr_pci.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> Update v3: Add Acked-by: ...
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg08054.html
>
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 329002ac04..7033352834 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -52,6 +52,7 @@
>  #include "sysemu/kvm.h"
>  #include "sysemu/hostmem.h"
>  #include "sysemu/numa.h"
> +#include "qemu/log.h"
>
>  /* Copied from the kernel arch/powerpc/platforms/pseries/msi.c */
>  #define RTAS_QUERY_FN           0
> @@ -738,6 +739,12 @@ static PCIINTxRoute spapr_route_intx_pin_to_irq(void *opaque, int pin)
>      return route;
>  }
>
> +static uint64_t spapr_msi_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +    return 0;
> +}
> +
>  /*
>   * MSI/MSIX memory region implementation.
>   * The handler handles both MSI and MSIX.
> @@ -755,8 +762,10 @@ static void spapr_msi_write(void *opaque, hwaddr addr,
>  }
>
>  static const MemoryRegionOps spapr_msi_ops = {
> -    /* There is no .read as the read result is undefined by PCI spec */
> -    .read = NULL,
> +    /* .read result is undefined by PCI spec

QEMU multiline comments should have the '/*' on a line of its own.

> +     * define .read method to avoid assert failure in memory_region_init_io
> +     */

If this is undefined behaviour per the PCI spec then LOG_UNIMP
is the wrong thing -- this should either be LOG_GUEST_ERROR
(if the guest can do this or program the h/w to do this)
or assert() (if the only way this could happen would be a bug
in a QEMU model of a PCI device).

> +    .read = spapr_msi_read,
>      .write = spapr_msi_write,
>      .endianness = DEVICE_LITTLE_ENDIAN
>  };
> --
> 2.26.2

thanks
-- PMM

