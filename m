Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C750C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2653A21473
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 20:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T25X1jmE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2653A21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnpcb-0008D6-Do
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 16:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40868)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnpbX-0007LG-Gs
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:33:15 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnpbU-0003lu-Ps
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 16:33:14 -0400
Received: by mail-ot1-x342.google.com with SMTP id g7so18000293oti.13
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zt2TL6Ciy49VcsERABEYnO0sN3LERR95bKJpdJlrWVA=;
 b=T25X1jmEz86QgDJ4yWmmWhVLEPW1DhnpCztVxcnrWV6waLvj0GuEtNmhT+II7AnbaJ
 577Ifz5jhkBKYS8zKOyRqAkVRpaX4TmkGuUHEKYETcNLCbC8UT6Y7GDwqZT97LC66tje
 1J6h2ZRm/Yqd3QBIHZZdZEHw5I/KHDFJGqBbzWJ9+UHKc9jQev4oFko4eE6tz8VRYlZo
 C4RS6JMVSjpR8TEXYcY7y1nvXRYoAHrcwjSc3fFqvwd5o/4Q7tSy1GLqFlOWlLps5xHK
 FwKF0IPLWvCCFl4R1Ih9one2jTAVwvfxu+/YJYcbiiHnR5oQ0i/J/o5Py9g4DjLJ4owN
 xgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zt2TL6Ciy49VcsERABEYnO0sN3LERR95bKJpdJlrWVA=;
 b=j1XrtiSBZM420ULrMYh3VG13ikj6ATzg4yCWYj6uoWf/6qJer2QTlsX1eJlGPm1JG5
 8GS5pm9krNMYDoa9IfDq8foOBXJzj4xHgWGDMcXoOFfiz98g31LCvun60Z+b45Khzhd8
 y4Mjx+ofDodPVShcWcu8aoRCCpDAsnMqifzui7rnwuGHAl91psNs6C3yMXtP+ZxlXWtc
 Y7slii6ldwqDKpG3iqM5Ft1BJycssoF8ODPIdUt8IxcCXf2zL32pEWEjYD6hiOLvS7ED
 YC5veNvNIBt2qEVZoJVBXe2qD0t5mM0OfmG5037v56CHUFnDjp69FGVrf39Y4m3XQGCj
 z3Yg==
X-Gm-Message-State: AOAM531DI5yiv4jBAQwGvwsfi5dGlc0iBqOdbYndpr5pMECOEpJ+KIQ3
 jAArhHdSSzbggm6Ye72xxfFdPZg7EMFaut2wle1hLg==
X-Google-Smtp-Source: ABdhPJxTsVOfT0WRglM77/9Z9GGDwpHwVtIEM2nqeSj+MfX+cS/YQkIOfnSXZ1TtinsmJ5dW6NiKr+O/fcHeBp3D2/w=
X-Received: by 2002:a4a:9528:: with SMTP id m37mr20393904ooi.85.1592944391282; 
 Tue, 23 Jun 2020 13:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200623195441.14646-1-pbonzini@redhat.com>
In-Reply-To: <20200623195441.14646-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Jun 2020 21:33:00 +0100
Message-ID: <CAFEAcA9WgqKKa6f8nU-c7VEq5AhruBHRBVcCHDiq-XRnub58jQ@mail.gmail.com>
Subject: Re: [PATCH] ibex_uart: fix XOR-as-pow
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

cc'ing Alistair as listed maintainer for the device...

On Tue, 23 Jun 2020 at 21:07, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The xor-as-pow warning in clang actually detected a genuine bug.
> Fix it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/char/ibex_uart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/char/ibex_uart.c b/hw/char/ibex_uart.c
> index 3e0dd9968e..45cd724998 100644
> --- a/hw/char/ibex_uart.c
> +++ b/hw/char/ibex_uart.c
> @@ -331,7 +331,7 @@ static void ibex_uart_write(void *opaque, hwaddr addr,
>          if (value & UART_CTRL_NCO) {
>              uint64_t baud = ((value & UART_CTRL_NCO) >> 16);
>              baud *= 1000;
> -            baud /= 2 ^ 20;
> +            baud >>= 20;
>
>              s->char_tx_time = (NANOSECONDS_PER_SECOND / baud) * 10;
>          }
> --
> 2.26.2

