Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD60C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:57:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C989A208CA
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8XZ50Vq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C989A208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuvf-0005LE-Tz
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50759)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuuv-0004jo-T8
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuuu-0003Wp-RQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:56:17 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhuuu-0003Vf-Km
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:56:16 -0400
Received: by mail-ot1-x344.google.com with SMTP id n5so13200239otk.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D5nEZI+hxb+H44y17IXUNqKuOh3W4xbgrH7vKYCJ5qs=;
 b=c8XZ50VqDWVZ5XOskKo3UJkr0SIUt+zFAj7uQBVRamDXZkXIN5dzsFPxeVTox9wBkG
 kjMM/dSrh7ih071+uzrB6IqBTDXOTeMQr+odGUVgudX6vEYd/lWdhVoh/BKq3Cv7o+CI
 YnHmRxWBMO5YW8/pKmruNmKoFfjg5hRCfADhfKZXJrPMbtkwyMyJIrY1bUHny/j8nw9s
 HNsHR8g2JR1iJCkvQ+nRA4mjcEyWlemqDVi6lFGwn3NL3mqHXqBiqTOxcGMZyqwBZEIF
 Qb6LJECD5l3aIaRbMjx1LHFMQu4vzW7HSqk2540ViputxGnZsqQ4rc284zV0NvgS3UBE
 m7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D5nEZI+hxb+H44y17IXUNqKuOh3W4xbgrH7vKYCJ5qs=;
 b=e9INaf7iRKIYrTGyiOsx0tbp4pJZc9LaxGiPqOsS+CeaA+xIgnUfQsH66bopAIXU+7
 MqQclbvLoddinyVKyVe34hZGz1NaM6NZ8wz3goBtuu8pXiLBlztM6QMbhPRutO0XijOP
 CjDc4ENBIgGDrJ/djsYFU086n1Pyrqx4XjTPqn75gHrrQmY2poaW/OGAEqD7sOv2yuXL
 m6F8MbHEb7b6A3NKbWUuMMQkRRM25NKcV/8oAFqLQN6ENBDmpggxh7NdNSXDlRsO9ngj
 dX4fublci84UWAWGtiPcBAw17xShjjngEdl47bdISg7K3QL8S7/XZUSNZLtL1+0ByVHL
 Jz2Q==
X-Gm-Message-State: APjAAAWX6xVjlRbAdS6naHIR83vUpDKzigU1o/QwcDsDIbkfVUlXvdpc
 EMURQhxRQW3Df/lRQjveyVLtlyH53ksIE+cNDvZiNA==
X-Google-Smtp-Source: APXvYqx7kmXUpfXmk+jkd3J3hXZ4cXElfV/6Swtewouur+Wu/brJ4GB1cT7KFDjHi/+SIdN+1I2u7cbuKoJfPTiuXeg=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr19975476oti.91.1561982175236; 
 Mon, 01 Jul 2019 04:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190416013902.4941-1-andrew.smirnov@gmail.com>
 <20190416013902.4941-4-andrew.smirnov@gmail.com>
In-Reply-To: <20190416013902.4941-4-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 12:56:04 +0100
Message-ID: <CAFEAcA_=HpkXDriPRvnKRA=XKaK0Vpi8isZH5B8eETVVAr6=mw@mail.gmail.com>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 3/5] pci: designware: Update MSI mapping
 unconditionally
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
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Apr 2019 at 02:39, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Expression to calculate update_msi_mapping in code handling writes to
> DESIGNWARE_PCIE_MSI_INTR0_ENABLE is missing an ! operator and should
> be:
>
>     !!root->msi.intr[0].enable ^ !!val;
>
> so that MSI mapping is updated when enabled transitions from either
> "none" -> "any" or "any" -> "none". Since that register shouldn't be
> written to very often, change the code to update MSI mapping
> unconditionally instead of trying to fix the update_msi_mapping logic.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

