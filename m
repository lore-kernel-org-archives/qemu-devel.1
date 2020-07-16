Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD638C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D20A2071B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZHFk55n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D20A2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7yn-0005Ul-Mn
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7y4-00055n-JY
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:46:48 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41493)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7y2-0005zv-Cb
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:46:48 -0400
Received: by mail-oi1-x244.google.com with SMTP id y22so5742339oie.8
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rly3aI04MVBE5TV2umQ+61TZNa7+QwUKiAU0d4Y4/5E=;
 b=nZHFk55n1v+Y28wFAYgDakVloGsQcrJyT1OqiLMwedJKxL4zz1LsYny6ToJDjpL1fh
 vulKwHyVmixuZ2h7lHCF5lWM+sY/Fk6BLSbFKsu6ex72StULPTbfUpmrXfxNOynODKyf
 q7z8FIhpE4kWXLIMkMOSZWIBM1qKToMLF756P+fgsbersQi+ZufnL6MEI78FM60PmbNM
 pivLqkKuzQP93ej3dvkk2a2S8UBdz6tFSct6dtShKk52ZFliIiLwqtd1jwswlxwhAoSd
 VasTKbK74LSuEhLdzm91urmgtvFcMfWsXUnxs5arckhVhG63K+y3Pzg28iTQyia2NF8P
 636A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rly3aI04MVBE5TV2umQ+61TZNa7+QwUKiAU0d4Y4/5E=;
 b=cUM+vKlzjzQt8Rc2zo4sWnzno9M5Tayt+k5tyXQMck/xeTkZ30IeWo9xQNRaLoBsYK
 CnGgVrLAOVNPFzpeMZI17E059WtjlLFI+JfNpsgGFKFHy7IIVJCi9sZ54Zj9+iTWeX2T
 PPeErlfy+jTJIluiRP9S4rfqyLlGYof8oYyLmZ4kphEooOFjkHApsLuBaOtWRAsSwHdZ
 EHOEkehRlgAQU/xYHi0Z/xVEluxjGk4um8d/uzxM9OJIVmm1SpsOkvTkII/hq6jiSQH4
 HbhQykuQi4/3CTFXVnWwPoZKgXXmSe5gG/HPuWja6rx7ODL0bC6VfaUw2/KP/CGDG/Rf
 gAzQ==
X-Gm-Message-State: AOAM5306Ph1ogN6hIZluhwrmJHQR9zmEpaDLs4OwX+tJsWcemzaSN/hN
 Tm3xlGGn549hY5PW2ZOTp7aa0xvTL4L9f4DvEikLxA==
X-Google-Smtp-Source: ABdhPJwzfsyJ9TbuMynSjo/HUi1blMrZAeY8rCruWfyS8Tt1EAHXBLiUKoG93JodG4YugwCdTXknS60YJbjXjlw1MOQ=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4698341oib.163.1594921604368; 
 Thu, 16 Jul 2020 10:46:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-4-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-4-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 18:46:33 +0100
Message-ID: <CAFEAcA-1EhD=0vU1r=48HhFPpovns2M5DBgTu7g2074kueaEuw@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] vfio: add quirk device write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, 30 Jun 2020 at 13:30, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add vfio quirk device mmio write method to avoid NULL pointer
> dereference issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/vfio/pci-quirks.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Update v3: Add Reviewed-by: ...
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09406.html
>
> diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> index d304c81148..cc6d5dbc23 100644
> --- a/hw/vfio/pci-quirks.c
> +++ b/hw/vfio/pci-quirks.c
> @@ -14,6 +14,7 @@
>  #include "config-devices.h"
>  #include "exec/memop.h"
>  #include "qemu/units.h"
> +#include "qemu/log.h"
>  #include "qemu/error-report.h"
>  #include "qemu/main-loop.h"
>  #include "qemu/module.h"
> @@ -264,8 +265,15 @@ static uint64_t vfio_ati_3c3_quirk_read(void *opaque,
>      return data;
>  }
>
> +static void vfio_ati_3c3_quirk_write(void *opaque, hwaddr addr,
> +                                        uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
> +}
> +
>  static const MemoryRegionOps vfio_ati_3c3_quirk = {
>      .read = vfio_ati_3c3_quirk_read,
> +    .write = vfio_ati_3c3_quirk_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>  };


Alex (Williamson) -- as the vfio maintainer, do you have a view
on whether we should be logging write accesses to port 0x3c3
here as guest-errors or unimplemented-QEMU-functionality?

Guest-error seems plausible to me, anyway.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

