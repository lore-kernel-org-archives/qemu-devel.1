Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78565C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439A920739
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SsHjIMDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439A920739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw6m5-0007n6-H4
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6lS-0007Nf-50
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:29:42 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43986)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw6lQ-0004yG-8t
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:29:41 -0400
Received: by mail-ot1-x342.google.com with SMTP id 95so4673253otw.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H5BlnYyS+7gDq/3ba89FBgqzoQkGyIN6lVFuG2dM2zk=;
 b=SsHjIMDJQ0hXPrT6kRNHPUzCbfSWllBlideCFrxAERyynBW4cXLEr6eohXITe/yeQ6
 goASdl2Q5pezRbVUpFffSoSKiuBCF5a/+BDa2QSx1F/pALBi1ANhwz7K8v+FOOd44oEG
 mYZrSvQcdWg1j6WGQfXU7ADidR2MuLlQPYbb+wxr3ptdZo5bRM+zLcfWdwuonAlCDeFO
 whhoKRbQFvkbQyLKQdBJlF6rjynZHWjrbNBovjmRCLBlekd0NYLD+3v/5a3BPXLlQCNq
 hbF08lWN5t6eBRxnFRxZRysQme+TwEezaBmB+H4mu7utVQnSoPp664rlgIZqYkT2yqSY
 zUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H5BlnYyS+7gDq/3ba89FBgqzoQkGyIN6lVFuG2dM2zk=;
 b=bQ4VfQPLUjRnD/dmi5yI61ueFmH3QjODvIgeCY5ye0fIZnyK5ZoPZ95M11P6pPuNqn
 e+f94Yn7z1hQovOpdjM359tmDmorYy1UbwI3TvazfBIA7vMkvsAF/EC/59M47Sk557Y6
 yKhgiOrlAPtaehJcErcQZqRAyQxpLmEfS4MqzFHJqqqXvx2n9l3FIJWeGP8QZ6P7Vl8W
 o5L69vD41MFzfw0almFrRdt26fQPA8JTz/NJwxuzwSgwOZdVotmxrjQ43c0iL7gdql6C
 2bGWiKUXUUjIgEmOkiungcaRb8wqIjP/UkMcmb2zQ88MsTxQFAbolWHFhLYttINdweHt
 kgbw==
X-Gm-Message-State: AOAM532lQ0mlVwvewHGBagI4xjL0MtApp8mVheSkWDKP1w6wpG4v+OuE
 Lsr7OXf1EZLpZ5dG/SCfbaexPD3nb9houv80QwzpLg==
X-Google-Smtp-Source: ABdhPJyGa7woCkzgcynyoxe39jekod8LVpr8Mn70YbYJf90OI+yJaW+2aNW7tVP1TdktzNcLo4NxKLP/OsTstIY1RJ4=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr5171608ota.91.1594916978894; 
 Thu, 16 Jul 2020 09:29:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-6-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-6-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 17:29:28 +0100
Message-ID: <CAFEAcA9GELeCvz2o44tHo7ewowohx5+cXqv2Qdq5ZxrF11tAOw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] nvram: add nrf51_soc flash read method
To: P J P <ppandit@redhat.com>
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
> Add nrf51_soc mmio read method to avoid NULL pointer dereference
> issue.
>
> Reported-by: Lei Sun <slei.casper@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/nvram/nrf51_nvm.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> Update v3: use g_assert_not_reached()
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09560.html
>
> diff --git a/hw/nvram/nrf51_nvm.c b/hw/nvram/nrf51_nvm.c
> index f2283c1a8d..82e89d965b 100644
> --- a/hw/nvram/nrf51_nvm.c
> +++ b/hw/nvram/nrf51_nvm.c
> @@ -273,6 +273,10 @@ static const MemoryRegionOps io_ops = {
>          .endianness = DEVICE_LITTLE_ENDIAN,
>  };
>
> +static uint64_t flash_read(void *opaque, hwaddr offset, unsigned size)
> +{

Could use a comment about why this is unreachable, since it's
not totally obvious:
    /*
     * This is a rom_device MemoryRegion which is always in
     * romd_mode (we never put it in MMIO mode), so reads always
     * go directly to RAM and never come here.
     */
> +    g_assert_not_reached();
> +}
>

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

