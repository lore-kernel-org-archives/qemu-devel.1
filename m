Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 371A8C433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00C422074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WEg/dTzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00C422074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7AY-0003EF-4z
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw79m-0002OW-4U
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:54:50 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:45091)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw79k-0003nK-6e
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:54:49 -0400
Received: by mail-oi1-x243.google.com with SMTP id j11so5601883oiw.12
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xrxbVp0+KfRQ5lEE8m1hgWS4brHe9TqmR01tWtTDzN0=;
 b=WEg/dTzpYAtO3ZRgF7di3YcRR9Bafk1+DykITVCPE6YSnlz/cXOkqqigpV9IVAqKrv
 Q4pNWgQMO7aT9m1qJIxTGZQqO2RP//mwYjjrp1WR4HnS1JTsneVDtbuleE8SmMvbLc+A
 hMhuxccX/nU2tvokdGXE6PlFB02fuHWgDkpkhUXgZX53rjQCSxHRfzqpHyMd3vT30hh6
 HAAKSbwFguAkRHiEzmnT6xUvGWuFMKVr0fl1i4AO+FW+ArS6anP4s+JfixlebH6bDG0R
 Z5OBfyEUKBAKYreMdgJdGRWH7D+2WbfjehKPJoucDIhpJvQsfcGPEirua0vT18pRjfho
 dhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xrxbVp0+KfRQ5lEE8m1hgWS4brHe9TqmR01tWtTDzN0=;
 b=eBeRjpfZ9GPiVx1hS1sKr3U/NqWZxgqLwRTWRS9yCcQVEAVKJfqar3RrAAl6Q6sg7h
 XndgsYq4I4yJVaSj32F149wgNj7hGGAv9WMkmUY0eoscCKY2vk96i4NladAENLY6CMm4
 f5bizbFY41waeYU/Sn7WOGfGokuo27Vx1ijui5XvVf9ihV53yOqzI5gF+stIN69yeqIV
 pBdhZGZrRRYOudqZBc31XVc3Ilv8XNqiFyfvz6ZkNvr3Kel1K+XITVLGsjVPxiKG/Nyq
 osVxbe3W5Rpcujf7T4nkpugMH0ksqvluhgcVe0bk4v5YDErXNLiSjH2zj3JP1cwkcUSi
 eIrQ==
X-Gm-Message-State: AOAM530Idh6moYkeYddyMCZn7BnKlNuQ2saQiDW6bVEWrVeccQfQ+WyI
 rkIXl9zY63AkYV/ql89ytFgYQYVukvT3ijKoL5sv2Q==
X-Google-Smtp-Source: ABdhPJw+ZRY0s4ItArEp8luG1n/hK+5ZJNHq5bFizzTj2JJNOGB/EJsE6p4tEBEh6iINe36h46pNJrDf4JQc3cECm+s=
X-Received: by 2002:aca:2819:: with SMTP id 25mr4257028oix.48.1594918486642;
 Thu, 16 Jul 2020 09:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-3-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-3-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 17:54:35 +0100
Message-ID: <CAFEAcA_ux5iTNhCuevNz6O7_umhkZcVm+o68owhbNKGOUHZnGg@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] pci-host: add pcie-msi read method
To: P J P <ppandit@redhat.com>
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

On Tue, 30 Jun 2020 at 13:30, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> Add pcie-msi mmio read method to avoid NULL pointer dereference
> issue.

This change is specific to the designware pci host controller;
it would be nice to have "designware" in the commit subject.


> Reported-by: Lei Sun <slei.casper@gmail.com>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>  hw/pci-host/designware.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> Update v3: Add Reviewed-by: ...
>   -> https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09400.html

> +static uint64_t designware_pcie_root_msi_read(void *opaque, hwaddr addr,
> +                                              unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
> +    return 0;

This is the right change, but is missing an explanation
of why it's right:

Looking at the data sheet, in the real hardware MSI interrupts
are handled by looking at writes to see whether they match the
configured address; if so then the write gets quashed and never
gets put out onto the AXI bus (to the CPU, memory, etc). This only
happens for writes, so reads from the magic address are just
allowed to pass through and will read from the system address
space like any other read from any other address. That's not trivial
to implement, though, and well-behaved guests won't care, so
we can just explain why we're not doing anything with a suitable
comment:

    /*
     * Attempts to read from the MSI address are undefined in
     * the PCI specifications. For this hardware, the datasheet
     * specifies that a read from the magic address is simply not
     * intercepted by the MSI controller, and will go out to the
     * AHB/AXI bus like any other PCI-device-initiated DMA read.
     * This is not trivial to implement in QEMU, so since
     * well-behaved guests won't ever ask a PCI device to DMA from
     * this address we just log the missing functionality.
     */
    qemu_log_mask(LOG_UNIMP, "%s not implemented\n", __func__);
    return 0;

> +}
> +
>  static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
>                                             uint64_t val, unsigned len)
>  {
> @@ -77,6 +85,7 @@ static void designware_pcie_root_msi_write(void *opaque, hwaddr addr,
>  }
>
>  static const MemoryRegionOps designware_pci_host_msi_ops = {
> +    .read = designware_pcie_root_msi_read,
>      .write = designware_pcie_root_msi_write,
>      .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {

With that comment,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

