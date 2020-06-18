Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63D8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E9BC21D7B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 09:48:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MWCBdgb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E9BC21D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlrA7-0008TG-Uv
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 05:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlr8u-0007Ao-Qi
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:47:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlr8s-0006Lv-2x
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 05:47:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id a137so4517432oii.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 02:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CIucyMeJKaA+LsK2RwWRGVfv22Qaa0LNuHGmMQDCzjI=;
 b=MWCBdgb1lAygK0HbArspSjsmeDe/TjFMSf8mP2pHZ6RC5NkfLHtdzJ0nxyqnVYJrTm
 aUH4GcggsPR3wOc31ejHVJ8TYeY18af/TOil0IssvG8IarIZG5jb9+8HkR6KLhLqlsZh
 AL4XniBa0WK6ajza0hNTYrkA/TWnuqvVBI04JVxL0uCZOMRVQ3f4n64Zn6H0vnu5ppgX
 vvJ/JQqovv/A5F2aRLGfL4v5Ly9GUfybqGI4Gert8U+yVpv8snjsIDuWeH/t3KWgkxin
 EMC7SR736ssAZvEGKXenttb5u6LPg82i4jh9i07GSP3iNRYT96Q1t6lOfK8tOQm8QQYK
 4J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CIucyMeJKaA+LsK2RwWRGVfv22Qaa0LNuHGmMQDCzjI=;
 b=T+KvZv1BiEejIlBX2P1ODdO8dVuNgAy/G8hGhuSp/Ev8AKc6gpS5MsakTyJbDI9yuu
 bFKjHg2iObit25EIp+cXxvZuXPKD8mmnF3BI2/DO+hcSeE7nUyaate3HI6oGV08Q4BLT
 OyXXkcHWYtL3HJM3L9qglUIhUvTNFyeTYppyVwnq3CHOcwGcRlemU6C+xoLg9YUvCNCC
 cnbAKENpSE3x2jQjc9iQHJTG29bIJnUpTHB93fKIKBAFKsL+HRqN0xwh+18iLhSQ6xKq
 oAdk6q3z7bN1qruZh9OWD2xjMiQ/AGG61rq4Njw6qhSqGMi3+B4AZGddcisikp5PW6y2
 D+9A==
X-Gm-Message-State: AOAM533Iov+JTzfbtMCowVMm75Hz+Xy4as84tVeA269Jk9sg1qiGaVUd
 KILsVkTDbpxyCoP3qbWtD2O/Ds7VCyBzc8NpFhE5rQ==
X-Google-Smtp-Source: ABdhPJyRhENgS0/zYUOnr9iRk0E/vanwRrDpdSD4Tj74ePGvIOHemmA7ZV50dl/UdfYH91lvABMEh8HL7k0AzHEa6Vw=
X-Received: by 2002:aca:568c:: with SMTP id k134mr2061342oib.48.1592473648297; 
 Thu, 18 Jun 2020 02:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200616140803.25515-1-drjones@redhat.com>
In-Reply-To: <20200616140803.25515-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 10:47:17 +0100
Message-ID: <CAFEAcA9hpF6CSs=XGxopeVH0kLso5t6SbBar5cRy7Uk3wTxLXQ@mail.gmail.com>
Subject: Re: [PATCH] hw/arm/virt: Add 5.0 HW compat props
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 15:08, Andrew Jones <drjones@redhat.com> wrote:
>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> ---
>  hw/arm/virt.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index caceb1e4a05f..8b6e6aa7b138 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -2375,6 +2375,7 @@ DEFINE_VIRT_MACHINE_AS_LATEST(5, 1)
>  static void virt_machine_5_0_options(MachineClass *mc)
>  {
>      virt_machine_5_1_options(mc);
> +    compat_props_add(mc->compat_props, hw_compat_5_0, hw_compat_5_0_len);
>  }
>  DEFINE_VIRT_MACHINE(5, 0)



Applied to target-arm.next, thanks.

-- PMM

