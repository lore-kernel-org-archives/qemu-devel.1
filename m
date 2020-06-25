Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 729D8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:02:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B0F120702
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 10:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VkaXzJxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B0F120702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joOiA-0005e7-Gu
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 06:02:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOh8-0004mn-LD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:01:23 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40628)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1joOh5-00016K-La
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 06:01:22 -0400
Received: by mail-ot1-x341.google.com with SMTP id k4so1540260otr.7
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QDHmhdyLqCIt8cj5fl5kE0ahQW/35hOFRU/Hkf8e9gE=;
 b=VkaXzJxB4n0UW91ebEBkoVJOgOllQu0k++WW6Espo9Vhl9B7F1HPA723vuxHs7JbtM
 4tk7j6WjtQzYMHZiysRRt3VE/BtcVqPjrQNJw70E6MKuJ65082yqFt79sq1x8ej/l2sI
 lWnTSLnfky3v2bxI9fTSDMbYe6LiKpNK0ebG+rOm2MiHNjddNK+X034Zojo8QXVTBIgh
 K+g9BE2M42jCL3Z0AbFVxHEcc4jw7Fer68iHAkmU5U1hjrTxvIPYyzRru5ZrohxPT4UZ
 HmgMGSRs+6MzNiwEBvrdPiE6kIM7nHKXT0ZFf3cER4ZJTuctheNL6FvvnlruInPNRTJR
 ouDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QDHmhdyLqCIt8cj5fl5kE0ahQW/35hOFRU/Hkf8e9gE=;
 b=EVq75O7OknAqWCvECUnUySsoTSqgzrGxARBkC0FgZdtpyt4Q6gTR3JIsOeeV3+3k5T
 8onK+XUiGjduNFQiqXsBjoTgJpu5FCuW/huz2zdLyiZ1l9gmOaYLWcAHg0KAwekbRZu3
 6R8ODHoUTMmOJT+p1lDXh24LcbIVhwzSxE+HCPiaaXVAPc01CkjKter+DMberO/1KCNB
 vBYwCs1TRZlwIyW2dddTqBgdbrtVf0zacwUGLuclPAFoFsV3BL7Z0oiOJkPqZ/+YQ6ZI
 1UvbMJbgJ+/FXtFEEn7cvQRzxb//tiINf7nxInhzY38N27OWukIBioqCJRdKBgnNuO75
 WleQ==
X-Gm-Message-State: AOAM530FnykB2pfU7ya/rgSUSigeTtoF/tfJhdzU/XrM5woVCDtPRB5J
 2sGoHDC3uymvQFZB1L/6uJ737nCP483f42QlvE2ghA==
X-Google-Smtp-Source: ABdhPJzBOBbQLObvNoqDfpI+4s7+ujAdKhb4w9/XiD7b8nxcmqz5s39xXYbsoeqMnZnVxllC9BpwYRu9ALen2yqNOYo=
X-Received: by 2002:a4a:221a:: with SMTP id f26mr26811882ooa.69.1593079278026; 
 Thu, 25 Jun 2020 03:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200624132625.27453-1-eric.auger@redhat.com>
 <20200624132625.27453-6-eric.auger@redhat.com>
In-Reply-To: <20200624132625.27453-6-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jun 2020 11:01:06 +0100
Message-ID: <CAFEAcA_gDTuW_13a6MgC1XBMtR1XMkxAY39iUWRePp2U6Ow6XA@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] hw/arm/virt: Let the virtio-iommu bypass MSIs
To: Eric Auger <eric.auger@redhat.com>
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

On Wed, 24 Jun 2020 at 14:27, Eric Auger <eric.auger@redhat.com> wrote:
>
> At the moment the virtio-iommu translates MSI transactions.
> This behavior is inherited from ARM SMMU. The virt machine
> code knows where the guest MSI doorbells are so we can easily
> declare those regions as VIRTIO_IOMMU_RESV_MEM_T_MSI. With that
> setting the guest will not map MSIs through the IOMMU and those
> transactions will be simply bypassed.
>
> Depending on which MSI controller is in use (ITS or GICV2M),
> we declare either:
> - the ITS interrupt translation space (ITS_base + 0x10000),
>   containing the GITS_TRANSLATOR or
> - The GICV2M single frame, containing the MSI_SETSP_NS register.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
>

>  static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
>                                              DeviceState *dev, Error **errp)
>  {
> +    VirtMachineState *vms = VIRT_MACHINE(hotplug_dev);
> +
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
>          virt_memory_pre_plug(hotplug_dev, dev, errp);
> +    } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI)) {
> +        /* we declare a VIRTIO_IOMMU_RESV_MEM_T_MSI region */
> +
> +        if (vms->msi_controller == VIRT_MSI_CTRL_ITS) {
> +            /* GITS_TRANSLATER page */
> +            qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +            qdev_prop_set_string(dev, "reserved-regions[0]",
> +                                 "0x8090000:0x809FFFF:1");
> +        } else if (vms->msi_controller == VIRT_MSI_CTRL_GICV2M) {
> +            /* MSI_SETSPI_NS page */
> +            qdev_prop_set_uint32(dev, "len-reserved-regions", 1);
> +            qdev_prop_set_string(dev, "reserved-regions[0]",
> +                                 "0x8020000:0x8020FFF:1");

This hardcodes addresses and lengths that are in the
base_memmap[] array for VIRT_GIC_ITS and VIRT_GIC_V2M,
so it's setting up a bear trap if we ever decide to
move those. Could we construct the string from the
base_memmap[] array entry values instead, please ?

thanks
-- PMM

