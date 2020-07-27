Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C720C433E8
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5759C2083B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 14:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYGh+atc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5759C2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04KY-00014w-Jk
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 10:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04Jc-00087h-M2
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:41:20 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46047)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k04Ja-0002Qr-EK
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 10:41:20 -0400
Received: by mail-ot1-x341.google.com with SMTP id h1so12445536otq.12
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 07:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=k0Nc/mzW4Au/cLCFSSt16cyxxq25OSsf6soFbxRpQoU=;
 b=OYGh+atcPw8DAhWBx1kqldcXjp+SYb7b+9EdldBv0zHqSKKD2l0JOoOCE5agPwkwly
 hvdRVmJtMqnYTH0wBCD02BAR4sJ/ci8oxOooh8+FkRh7YfADldFb+0QZ52HIAXZHEbio
 SvoqYQ44eRHC/wk3kNb8+VziPZreaK00z+QpR/ADx7jzojnPN+6CAtj9VbeEsLQlo9K8
 8EzuKuh+yG/o3bHF81ZaWFMw0z/uzp4n9fG6pOVNejYMVOsXDFzq0koarojHhaft1IOj
 3hQwVMVTRjVDApEQ+1s/gd+NKvi9l/XEZuUHiwVFwa3ejeaYC4A6gZizvqJ63KilN2np
 SfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=k0Nc/mzW4Au/cLCFSSt16cyxxq25OSsf6soFbxRpQoU=;
 b=Zlx0hzKQw3avYgmBWjcIo/bfLaQVJBhKvUAZ11gKTouKfIMQ6pD9ZoQxiEYSHA+4jc
 3ZDutNlb37CjMBneT4HKe8HDmNh6T4NNzllEx9mqPOoA/GHtJ1vmGIDYhw9aeFIn0rwd
 8t6sXWPPW+NjZC6APZmI+ze8asMR8uLgQr/fARWS2gTxOwGLy0za482q708zG5uAOHWy
 LiB8KXgGcU+QAD8+m+26UdGl1rl5NMK5C3AoPeFQ8vhOJBtytD4kU7VTrZmjtwoduGUF
 JLVgtaFMtSwRw1QpRbJyJ6I8GNnmHOuTI7FDcVexfjOMTH9TC4HsxfxUBu8Nmbgj3Gaf
 b8SA==
X-Gm-Message-State: AOAM530N3rsbUObY38n0Z0xHMNSWHRYkIVo2TORVhoJISDWDyF9XWWrA
 046kDzds+wy86x/7s+o2zRVVqqmCoPZnMcn1x6sitQ==
X-Google-Smtp-Source: ABdhPJyX41GOo2exmAQYTvgs+WR1pjnn4nLR9zjXQ93tFGUKifn49PGwdL01iQSlU9mcFe7Cco6UnAE3upp8wWe4dDo=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr19686034otk.221.1595860876984; 
 Mon, 27 Jul 2020 07:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200727130225.32640-1-zhukeqian1@huawei.com>
In-Reply-To: <20200727130225.32640-1-zhukeqian1@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jul 2020 15:41:06 +0100
Message-ID: <CAFEAcA9vQMP0YLAuzdPW2m3RcRNySxA0gJQZmeXBUYRy4=Dk+w@mail.gmail.com>
Subject: Re: [PATCH] bugfix: irq: Avoid covering object refcount of qemu_irq
To: Keqian Zhu <zhukeqian1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, Esteban Bosse <estebanbosse@gmail.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, yezengruan@huawei.com,
 qemu-arm <qemu-arm@nongnu.org>, wanghaibin.wang@huawei.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 27 Jul 2020 at 14:03, Keqian Zhu <zhukeqian1@huawei.com> wrote:
>
> Avoid covering object refcount of qemu_irq, otherwise it may causes
> memory leak.
>
> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
> ---
>  hw/core/irq.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/core/irq.c b/hw/core/irq.c
> index fb3045b912..59af4dfc74 100644
> --- a/hw/core/irq.c
> +++ b/hw/core/irq.c
> @@ -125,7 +125,9 @@ void qemu_irq_intercept_in(qemu_irq *gpio_in, qemu_irq_handler handler, int n)
>      int i;
>      qemu_irq *old_irqs = qemu_allocate_irqs(NULL, NULL, n);
>      for (i = 0; i < n; i++) {
> -        *old_irqs[i] = *gpio_in[i];
> +        old_irqs[i]->handler = gpio_in[i]->handler;
> +        old_irqs[i]->opaque = gpio_in[i]->opaque;
> +
>          gpio_in[i]->handler = handler;
>          gpio_in[i]->opaque = &old_irqs[i];
>      }

This function is leaky by design, because it doesn't do anything
with the old_irqs array and there's no function for un-intercepting
the IRQs (which would need to free that memory). This is not ideal
but OK because it's only used in the test suite.

Is there a specific bug you're trying to fix here?

thanks
-- PMM

