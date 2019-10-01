Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0DCDC352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:05:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EA820815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 14:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EA820815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFImr-0001da-D9
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 10:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34849)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iFIlf-0000Ok-Kh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:04:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iFIle-0007gE-8A
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:04:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iFIle-0007fl-0Z
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 10:04:42 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08AF9C056808
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 14:04:41 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id q9so1459605wmj.9
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 07:04:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NwCNBax/BCJ3LWDkFw2oWrLRTl+HbS0wPMa8AHlid7k=;
 b=Ba0EPiYg6k0hcF5XxyQaKinIxV+n8lP8nIelbPzzkAKY5zOC7BcmcHKzveRKPHdwD1
 E5OW4PupOKvdx/olvNoRtfBkNZPfwjnaPwL82fTijgEPFikzG3IHxnOOUcqKchFPOAOg
 tUMQC7FRJBECa5B9kLfzO1/d8hAk8fgWphzEpe4ueul86nm7hpWMdpX+hQL6qwwodhUQ
 buJdMi5NXTdyhkZ/4hPp7zA09iyM9Ouspurs47lhK5kHxX/+Ytjh9veffudYpXvCN2km
 oCpi5DsDrsdNmbUf94UCxXjS4t0J6EP5AXY04ygFiQ5bTKIEfJFvg7eVnAzrnzFhBYg5
 CZng==
X-Gm-Message-State: APjAAAURi5e4WRL+0Sj9SwbfCw18b1UwKqpHN6eWLyT/aezZ2jPpeSl1
 ooSnFMObjYMe+HXrbjczpL2DKqnWtac1ygsh1R/tiyc2ZPLenPGisszw3NaMWPyg2cdmt4YQZjC
 gGJYDnzeC5u9cZs8=
X-Received: by 2002:adf:dd41:: with SMTP id u1mr18755854wrm.49.1569938679194; 
 Tue, 01 Oct 2019 07:04:39 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyC5DwcsrvXyYQ58D9AYuxfVlMDLSNgV4Nzg+RrwjHDgP+o1DHWDTaIxyXtdjzE5ChBDpdgyA==
X-Received: by 2002:adf:dd41:: with SMTP id u1mr18755832wrm.49.1569938678993; 
 Tue, 01 Oct 2019 07:04:38 -0700 (PDT)
Received: from [192.168.1.35] (240.red-88-21-68.staticip.rima-tde.net.
 [88.21.68.240])
 by smtp.gmail.com with ESMTPSA id s1sm22379139wrg.80.2019.10.01.07.04.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Oct 2019 07:04:38 -0700 (PDT)
Subject: Re: [PATCH 7/8] lm32: do not leak memory on object_new/object_unref
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
 <1569936988-635-8-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <4d56a237-f90c-2cfd-656e-86abad0b9d0b@redhat.com>
Date: Tue, 1 Oct 2019 16:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <1569936988-635-8-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 3:36 PM, Paolo Bonzini wrote:
> Bottom halves and ptimers are malloced, but nothing in these
> files is freeing memory allocated by instance_init.  Since
> these are sysctl devices that are never unrealized, just moving
> the allocations to realize is enough to avoid the leak in
> practice (and also to avoid upsetting asan when running
> device-introspect-test).
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/timer/lm32_timer.c       |  6 +++---
>   hw/timer/milkymist-sysctl.c | 10 +++++-----
>   2 files changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
> index ac3edaf..cf316ed 100644
> --- a/hw/timer/lm32_timer.c
> +++ b/hw/timer/lm32_timer.c
> @@ -186,9 +186,6 @@ static void lm32_timer_init(Object *obj)
>  =20
>       sysbus_init_irq(dev, &s->irq);
>  =20
> -    s->bh =3D qemu_bh_new(timer_hit, s);
> -    s->ptimer =3D ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
> -
>       memory_region_init_io(&s->iomem, obj, &timer_ops, s,
>                             "timer", R_MAX * 4);
>       sysbus_init_mmio(dev, &s->iomem);
> @@ -198,6 +195,9 @@ static void lm32_timer_realize(DeviceState *dev, Er=
ror **errp)
>   {
>       LM32TimerState *s =3D LM32_TIMER(dev);
>  =20
> +    s->bh =3D qemu_bh_new(timer_hit, s);
> +    s->ptimer =3D ptimer_init(s->bh, PTIMER_POLICY_DEFAULT);
> +
>       ptimer_set_freq(s->ptimer, s->freq_hz);
>   }
>  =20
> diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
> index 9583507..6aedc11 100644
> --- a/hw/timer/milkymist-sysctl.c
> +++ b/hw/timer/milkymist-sysctl.c
> @@ -283,11 +283,6 @@ static void milkymist_sysctl_init(Object *obj)
>       sysbus_init_irq(dev, &s->timer0_irq);
>       sysbus_init_irq(dev, &s->timer1_irq);
>  =20
> -    s->bh0 =3D qemu_bh_new(timer0_hit, s);
> -    s->bh1 =3D qemu_bh_new(timer1_hit, s);
> -    s->ptimer0 =3D ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
> -    s->ptimer1 =3D ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
> -
>       memory_region_init_io(&s->regs_region, obj, &sysctl_mmio_ops, s,
>               "milkymist-sysctl", R_MAX * 4);
>       sysbus_init_mmio(dev, &s->regs_region);
> @@ -297,6 +292,11 @@ static void milkymist_sysctl_realize(DeviceState *=
dev, Error **errp)
>   {
>       MilkymistSysctlState *s =3D MILKYMIST_SYSCTL(dev);
>  =20
> +    s->bh0 =3D qemu_bh_new(timer0_hit, s);
> +    s->bh1 =3D qemu_bh_new(timer1_hit, s);
> +    s->ptimer0 =3D ptimer_init(s->bh0, PTIMER_POLICY_DEFAULT);
> +    s->ptimer1 =3D ptimer_init(s->bh1, PTIMER_POLICY_DEFAULT);
> +
>       ptimer_set_freq(s->ptimer0, s->freq_hz);
>       ptimer_set_freq(s->ptimer1, s->freq_hz);
>   }
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

