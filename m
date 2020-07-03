Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234E6C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E71B020BED
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8t8RC/L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E71B020BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrLDD-0000Mr-63
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 08:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38176)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLCc-0008HK-Ad
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:54:02 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:33703)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jrLCY-0002at-Jq
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 08:54:02 -0400
Received: by mail-oi1-x243.google.com with SMTP id k22so15087654oib.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 05:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xoXAkHV9BNTNXR+n/Fpi0WsFKP+QXQPwqueqnn44d1E=;
 b=q8t8RC/L4adX59xJs+kQpdCRunP7CqGk38KIbatQ68VOKC4LZOIBH3oF24nbennFVJ
 xFvEZUAUCkdzsg51FRYLVxpQRI1MyVuxipwaDnr6iPUdbY+daJHCTK5pSuMUhdISgJg9
 1yNcgoybVJwP1Bi1SlOApylUYNbW7CcI2CKkCvgXeERBUt1DUis1H5PnGe4elhLlej0g
 ia8idkqtl30wz/0myuZB2e9m+l5kn0WsXASRDIUU1PGon2Q2MkB3ADYXRkj7O+OdZXjR
 NTQatYxf9L5iM31uPr75fLkD9N6ofoC7ylYTNRSUx22PZqpFPRgdu1o658Izp6NOHrVK
 5C2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xoXAkHV9BNTNXR+n/Fpi0WsFKP+QXQPwqueqnn44d1E=;
 b=dqG/pl2MZcV7Keq47++Kz1RaGOv7+AxZIQrXIgAIApt5xUBFQHQZg7CXn7juRgXZcF
 NuXMdhz2YJ4wAHqK/zrQr9seHmxgrwTPlPMAr1OZJ65E7TWmx/xJBwz6EbZuFj0oq8WV
 9CE26di0MvaKrfgYqdERkCBT2nQBA862/+Gtp5CK9KKDmaANhJp5GBqqO4TlLskuHYKs
 BvYx9lxTvjMdPFYWhDKUCm5p8weGXJp/4mZHasTMDqumSmEeQiUQN6uB+bESVbgl/tZZ
 vDMqATRrbmtpHDe2ada1Gz4LCMdu90hTb2oHBPGoI/1HRQ9P8WzxJ9r9/B2cR06SzuKy
 f9/w==
X-Gm-Message-State: AOAM530VBCpMJWthjccTifsIHfB661BeoHy2+lPiSYLgqHRkKrMDmNOW
 sFl6GHpWfQqFJhEzRoIrMCSiq+2rUgJl3g+X6RXHGQ==
X-Google-Smtp-Source: ABdhPJz5amai7K/e8HJhw/wAjyPoNhPr1AbBueUw1c0g2NatIE/o/IRJ1SJlTEURItN60xed/g24TKiTgYh5rPapaT0=
X-Received: by 2002:aca:1706:: with SMTP id j6mr384027oii.146.1593780837178;
 Fri, 03 Jul 2020 05:53:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200629070404.10969-1-eric.auger@redhat.com>
In-Reply-To: <20200629070404.10969-1-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2020 13:53:46 +0100
Message-ID: <CAFEAcA-1qE2_6LwavqjGEVqmPfNUxCwPxgGr9KC+3MXWvfR0XQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] VIRTIO-IOMMU probe request support and MSI bypass
 on ARM
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x243.google.com
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 bbhushan2@marvell.com, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 08:04, Eric Auger <eric.auger@redhat.com> wrote:
>
> By default the virtio-iommu translates MSI transactions. This
> behavior is inherited from ARM SMMU. However the virt machine
> code knows where the MSI doorbells are, so we can easily
> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
> setting the guest iommu subsystem will not need to map MSIs.
> This setup will simplify the VFIO integration.
>
> In this series, the ITS or GICV2M doorbells are declared as
> HW MSI regions to be bypassed by the VIRTIO-IOMMU.
>
> This also paves the way to the x86 integration where the MSI
> region, [0xFEE00000,0xFEEFFFFF], will be exposed by the q35
> machine.  However this will be handled in a separate series
> when not-DT support gets resolved.
>
> Best Regards
>
> Eric



Applied to target-arm.next, thanks.

-- PMM

