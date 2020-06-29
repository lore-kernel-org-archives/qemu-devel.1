Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A858C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660CA23A01
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 11:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cT4aTSh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660CA23A01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jprte-0002St-LW
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 07:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jprsv-0001NI-JV
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:23:37 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41416)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1jprsu-0002GL-0N
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 07:23:37 -0400
Received: by mail-oi1-x242.google.com with SMTP id y22so1443383oie.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 04:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mBASn8Pk7TYIAdTyb8mu1OGofskM/q+vJVdSCwO3YDk=;
 b=cT4aTSh8TMJycsx5SVi1OlFd+R/BmdzbV9beppL/demJMqC6mDpJyLz/yVGpI7LG3H
 iwEoHjl9gw641gLslNQ/neX9Yp80Ch8CCCyVw/KHsV+skKhRGZZumRODF//nyjKcn+AA
 pZVYsbazv2WKe+dVhi3XSuHMj5m5Y357zSw0SUf9KZsySUuJ8Zr76Irmzv7UNiCN7EYS
 ZCzB/G+OlHPFItOUaOVkGqskr9xkFWEHQgv65eFNAw7JkD9XrF2SKBR3WI1GglD7qqi2
 8aDYO1wImn6MwErkWLh2QQEzRdsOS51gRokaMnhj1X/8Jsrd/uWwDEx4oqCNf3EvwMD1
 JgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mBASn8Pk7TYIAdTyb8mu1OGofskM/q+vJVdSCwO3YDk=;
 b=WIvNw5O88xKHFNigAJpv1cAMPa0xH9C/Bz//+JU27p6fptBLqoMAUJ4SkjIRW6VfP/
 AgBK+1dCMs7aDOS5uvNWnGe0nay+D6IZpSeXoEbGBiiLNERFh8ewB8qzAQOoN1uuuC1B
 IoIJX008r7sA703rpSns9ETCn6SNO+bLMzSnWP/D9os5Lu2lmWC2rUoJdOLDpz7De3ml
 K2sXXYiVInk318YnE4HJO/pIW291NdN7WGS8ULFImosq/twbt9UNkkTz6q9rwaRIYp0C
 m5ILU1Ccph+Cqp3TPs9iM6am7E6gJx316CK6CY8oHCBlEdBuZHx1Fpk+Bkd0VudybqUH
 h0jg==
X-Gm-Message-State: AOAM5321F1bWXERm0hB8Rlfn8iATkjf6YDN4wunpajOYsp7AadYeCfZn
 z2mULOiD6+PS4gaMtiF6WhtdePRKPXtRo7kwkHA=
X-Google-Smtp-Source: ABdhPJy4FsfOgaorX+MRapxxtd4bNwX4Re5bQSd6pHGhBOzJrjQ2qPMtc9uapfgKApt0PgTOtYAdn0x9KCDTaRJoENk=
X-Received: by 2002:aca:494d:: with SMTP id w74mr5959420oia.97.1593429814877; 
 Mon, 29 Jun 2020 04:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200624185523.762240-1-ppandit@redhat.com>
 <20200624185523.762240-5-ppandit@redhat.com>
In-Reply-To: <20200624185523.762240-5-ppandit@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Jun 2020 19:22:59 +0800
Message-ID: <CAKXe6SJy0Pocgd2EuF6jfdOn8AN4xFmzepgJMgKK=x-ouA5JQA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] prep: add ppc-parity write method
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Lei Sun <slei.casper@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

P J P <ppandit@redhat.com> =E4=BA=8E2020=E5=B9=B46=E6=9C=8825=E6=97=A5=E5=
=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=883:00=E5=86=99=E9=81=93=EF=BC=9A
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add ppc-parity mmio write method to avoid NULL pointer dereference
> issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/ppc/prep_systemio.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> Update v2: use LOG_GUEST_ERROR
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg04975.html
>
> diff --git a/hw/ppc/prep_systemio.c b/hw/ppc/prep_systemio.c
> index bbc51b6e9a..03a2f8af6e 100644
> --- a/hw/ppc/prep_systemio.c
> +++ b/hw/ppc/prep_systemio.c
> @@ -23,6 +23,7 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/irq.h"
>  #include "hw/isa/isa.h"
>  #include "hw/qdev-properties.h"
> @@ -235,8 +236,15 @@ static uint64_t ppc_parity_error_readl(void *opaque,=
 hwaddr addr,
>      return val;
>  }
>
> +static void ppc_parity_error_writel(void *opaque, hwaddr addr,
> +                                    uint64_t data, unsigned size)
> +{
> +    qemu_log_mask(LOG_GUEST_ERROR, "%s not implemented\n", __func__);
> +}

I'm not familiar with this platform-related stuff. I think a
'qemu_log_mask(LOG_UNIMP, xxx)' is ok.

Thanks,
Li Qiang

> +
>  static const MemoryRegionOps ppc_parity_error_ops =3D {
>      .read =3D ppc_parity_error_readl,
> +    .write =3D ppc_parity_error_writel,
>      .valid =3D {
>          .min_access_size =3D 4,
>          .max_access_size =3D 4,
> --
> 2.26.2
>

