Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDD0CA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A7B6207BC
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:56:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TyvHNECd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A7B6207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYa4W-000660-B8
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:56:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYa2b-0004jL-OQ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:54:10 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44184)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYa2a-0006ww-Ml
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:54:09 -0400
Received: by mail-oi1-x241.google.com with SMTP id a2so18975292oia.11
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zDMDGUDLIIV2w3JEBDU9Tu0VJVThDRl9GdExMaVDV84=;
 b=TyvHNECd05U6+Rh2w0T+7Iux3h2RSl20j0jlEW9E8XX2cz8PAgvQ4kYOThd23nrypD
 Dwts06WgjKqOHNnskfQDsghWaQhKqjHfRT0WIbLkxvHrJn0xkfmlX20K0bg19rcdLIdt
 xEOvPWFD6sqgGHnLMyA7fwgPccpUru1LgMok35JvNXEi8ng8AVHZQB8+BbGsIOWOQLaV
 JTUU1klArt1gBkceJEgzboqVgIKy+BbydfTbMmnnqT7VN4M7HiuR6BsBio3QUOM9d6dw
 AYTyt9m9KCsMnzk1OS05JMjRxmAHO5/fGAZHTZfyh75qspk6DW+OehVqXtkruOUQ3qzd
 WSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zDMDGUDLIIV2w3JEBDU9Tu0VJVThDRl9GdExMaVDV84=;
 b=jC5cf/uYXIJ/HReM/31zufg+lFpXc0phBaGIJuwPFL6y1ya7I1aV6CNIvuxXO3jXQh
 C55Zb9NLXDx8tt6/idpCljZGdUVwI5mpkz8VKm/BgI25ACpjgA+559YrHqtsIrAWX75L
 s/n1+UhCsO8Vakwxou74bHcTltxO6Woouhq8+EbBskoG/3jehjuIt33tKQPz/4MmmdSJ
 XSW/uMY1hMAXsM/G7/iVoBpX+d+uPbGEI2ycbXgI0NfR38rzZiF+h9A6ZWMkfPHRlZy6
 E3hnurqHox6IbOA7QECPNJYA2LseRa5mSpNCNUNqCB/282wLrGDD9qhZtD3OsVsDnC+Q
 bShQ==
X-Gm-Message-State: AGi0PubIWbatFwb6mWyMSBZnfdAgAHZWhSeP9dQzO6CcfwdDhSBwu7fC
 kg1oK0mZN9XNvFaTGQN3oDji6sp9S3PG27xP1BME2w==
X-Google-Smtp-Source: APiQypITEbrWcKXv2LK4vWzm08syyj3x4iUdSZBbCqcXYr/lRDMCDfL8u3XQX//gmjkMJ4La2s2iNymwrE2d8Uq8uPM=
X-Received: by 2002:aca:4a45:: with SMTP id x66mr22898590oia.48.1589309646216; 
 Tue, 12 May 2020 11:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200507105718.1319187-1-ppandit@redhat.com>
 <20200507105718.1319187-3-ppandit@redhat.com>
In-Reply-To: <20200507105718.1319187-3-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 19:53:55 +0100
Message-ID: <CAFEAcA_01feEPG-PbQ9Msy3MNV4qSb2zVJyLAMGcOwfrhezkfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] megasas: use unsigned type for positive numeric fields
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Ren Ding <rding@gatech.edu>,
 Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 7 May 2020 at 12:02, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Use unsigned type for the MegasasState fields which hold positive
> numeric values.
>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---

> @@ -2259,9 +2259,9 @@ static const VMStateDescription vmstate_megasas_gen1 = {
>          VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
>          VMSTATE_MSIX(parent_obj, MegasasState),
>
> -        VMSTATE_INT32(fw_state, MegasasState),
> -        VMSTATE_INT32(intr_mask, MegasasState),
> -        VMSTATE_INT32(doorbell, MegasasState),
> +        VMSTATE_UINT32(fw_state, MegasasState),
> +        VMSTATE_UINT32(intr_mask, MegasasState),
> +        VMSTATE_UINT32(doorbell, MegasasState),
>          VMSTATE_UINT64(reply_queue_pa, MegasasState),
>          VMSTATE_UINT64(consumer_pa, MegasasState),
>          VMSTATE_UINT64(producer_pa, MegasasState),
> @@ -2278,9 +2278,9 @@ static const VMStateDescription vmstate_megasas_gen2 = {
>          VMSTATE_PCI_DEVICE(parent_obj, MegasasState),
>          VMSTATE_MSIX(parent_obj, MegasasState),
>
> -        VMSTATE_INT32(fw_state, MegasasState),
> -        VMSTATE_INT32(intr_mask, MegasasState),
> -        VMSTATE_INT32(doorbell, MegasasState),
> +        VMSTATE_UINT32(fw_state, MegasasState),
> +        VMSTATE_UINT32(intr_mask, MegasasState),
> +        VMSTATE_UINT32(doorbell, MegasasState),
>          VMSTATE_UINT64(reply_queue_pa, MegasasState),
>          VMSTATE_UINT64(consumer_pa, MegasasState),
>          VMSTATE_UINT64(producer_pa, MegasasState),

Does an INT32->UINT32 change in vmstate break migration compat?
I forget, but this is the kind of detail it's worth calling out
in the commit message if you've checked and it really is still
compatible.

thanks
-- PMM

