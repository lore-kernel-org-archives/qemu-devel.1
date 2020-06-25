Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D234FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:31:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE6B20707
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 09:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xIQ7geU4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE6B20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOE1-0007F2-TI
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 05:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51272)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joODO-0006nn-Kl
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:30:38 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:37166)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joODM-00040R-TH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 05:30:38 -0400
Received: by mail-ot1-x329.google.com with SMTP id v13so4651961otp.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 02:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1fBBhYrpN3qLtMVrsfW+Z+2J729eiOPlU6oyAnJ1nB8=;
 b=xIQ7geU4+cTHsI/wfY2cyPg+DojrG2M0YQ/DDZdxXJJYF1yb1HING83gMtRDu9fsfX
 HaWPxpEDckHHkQMjOo3cNbvSiHZILI9D7kuTHPfApI7vvbl90AJLN6ltsyBEmibLT1YU
 Qres7bo2eyVy6ACya0QTk/L9FgcJku3RnBAb0FHsCZGIZ5i88cccFmVWkw3PWUshW7cc
 hel1GPy+0rDKcIEymCyKVWj9nDsfbqOrt3bxl6rAQ9wJZ2OcQjrcRxmErnewP9kfJ9uE
 MwqXv7/F4Ui3bMIkxIVp2+B9qT9L3gLBF5URJn9zoGtijW28zJCMHZhNnF31ZdTXTE93
 KVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1fBBhYrpN3qLtMVrsfW+Z+2J729eiOPlU6oyAnJ1nB8=;
 b=B7nX0aC30684gERAb+CP8gx1dPDUtE7TyKSiuavYZkDDqfFa3KdZytC38w3Xvheu9T
 yespxgkHxbXBtmrCyF0PI6YvJAtxGpH/BdLltE+CLf+AlBp5+wPwgnvOAdfWe2maoduY
 ACja2THIVjHpkVV7UAA0gJyPxaO/Hq++jtZzGxNa6RShU7+R/WmxTPVOUgphuWxzQQHe
 72zeZBA+QU8z0C0XEqGpgFFWE4FVPJyGNcoBK52wVqPwIlKHKlaXe3R1FGoNBByQTbng
 SdKuRk0NCy2xx0rjAbIORt2jAtvKc6A7r3Us5Y4PtMA+Fu82EX+7AwJEbwL/uDN/442p
 Nw3g==
X-Gm-Message-State: AOAM5309UJFWYgJuk75SS8uJ5Ivxxkp4wCzW8UQSAnBxHNUF3vWcxViB
 ybJ+bIal+xjBKVlQUUm61Gpm12r4qQ7SdM/eEnaIgQ==
X-Google-Smtp-Source: ABdhPJzK1Ix7slcbuY5wTFSkQpXLVDpZlZA75sbk7uYsjNBsQ88Yawub6zeBiYJBQI+BYgl88vBX9Vas/3cI1vK76uw=
X-Received: by 2002:a9d:67d6:: with SMTP id c22mr24810566otn.221.1593077435259; 
 Thu, 25 Jun 2020 02:30:35 -0700 (PDT)
MIME-Version: 1.0
References: <1592486508-6135-1-git-send-email-jasowang@redhat.com>
 <1592486508-6135-30-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592486508-6135-30-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 10:30:24 +0100
Message-ID: <CAFEAcA-1K_zVHPFz31W9Tx7CmAXo=4-qQNJxrZnYT0Heg5_1NA@mail.gmail.com>
Subject: Re: [PULL V2 29/33] net/colo-compare.c: Correct ordering in complete
 and finalize
To: Jason Wang <jasowang@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x329.google.com
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
Cc: Zhang Chen <chen.zhang@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 18 Jun 2020 at 14:23, Jason Wang <jasowang@redhat.com> wrote:
>
> From: Lukas Straub <lukasstraub2@web.de>
>
> In colo_compare_complete, insert CompareState into net_compares
> only after everything has been initialized.
> In colo_compare_finalize, remove CompareState from net_compares
> before anything is deinitialized.

Hi; this code-motion seems to have prompted Coverity to
discover a possible deref-of-NULL-pointer (cID 1429969):


> @@ -1409,6 +1397,19 @@ static void colo_compare_finalize(Object *obj)
>      }
>      qemu_mutex_unlock(&colo_compare_mutex);
>
> +    qemu_chr_fe_deinit(&s->chr_pri_in, false);
> +    qemu_chr_fe_deinit(&s->chr_sec_in, false);
> +    qemu_chr_fe_deinit(&s->chr_out, false);
> +    if (s->notify_dev) {
> +        qemu_chr_fe_deinit(&s->chr_notify_dev, false);
> +    }
> +
> +    if (s->iothread) {

Here we check s->iothread, which implies that it could be NULL...

> +        colo_compare_timer_del(s);
> +    }
> +
> +    qemu_bh_delete(s->event_bh);
> +
>      AioContext *ctx = iothread_get_aio_context(s->iothread);

...but here we pass it to iothread_get_aio_context(), which
unconditionally dereferences it, so will crash if it is NULL.

Either we need to avoid calling this if s->iothread is NULL,
or if it can't ever be NULL then the earlier NULL check was
pointless and can be removed.

>      aio_context_acquire(ctx);
>      AIO_WAIT_WHILE(ctx, !s->out_sendco.done);
> --
> 2.5.0

thanks
-- PMM

