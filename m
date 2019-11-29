Return-Path: <SRS0=xfvu=ZV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED269C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B791C21736
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2019 18:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PgwRPJB0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B791C21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ialGl-0006jk-PO
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 13:45:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ialDK-0004o8-GA
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:41:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ialD1-0000kF-3A
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:41:40 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:33406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ialD0-0000fr-Qq
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 13:41:38 -0500
Received: by mail-oi1-x241.google.com with SMTP id x21so19728178oic.0
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2019 10:41:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=wbHRnIUN/EjXdUcXJtXLLT0G/6702axIE22+LsDF6bE=;
 b=PgwRPJB0ckpaookKsYqOYCtHRrDQaOdtter/6e6NL6CFxje4nFKXabqr3d4rymAtvT
 dXtgAC3UJLETnUflHTHYyUOYenljgpjfi3mkMC83VDUigXKnfLz0zVlUPGaxORnVVhmo
 XxExkSTTW5F1sahUGI0ZJhTGIkWR7w+IbgDSyl6qHQxXnSC0Zg9pnMHTQVNU7zixHB7Z
 xvfBmCgY7tgijriqAATlYG0sQLgOZj09Of6VwRibzBX0lkk9l6+Uzy5pPDj1abMcenIp
 5vBa4JBndqwH5Vkm2j8buvQ6rHDaY57+ASGqq0hxUqQrqCDf3ntNhx3UqTKhHbljH2BS
 75fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=wbHRnIUN/EjXdUcXJtXLLT0G/6702axIE22+LsDF6bE=;
 b=r1AP4mx0WkfQAtaHxmNUBDi1RVmi+Cgf1PlCQTy6wsm4nJkYPtZMzAiy7KMv4qwRZ+
 6QUmlDE/Kv1SXnosVDA3CqHXFfJYLfaWTgC59FgJ/AerL2yXsaF4hofNZaKmzulPX2ua
 HwqQtTU3s3iVCTlkEBi9vxIufLt8Tor0r8zcsaWCKOeJue0C6HNPNMvjm5xZXixFo9Pw
 tfUY9sL7EkU2O+z8wdwOq7TOokBkMnUEl9amGUlvnlcQPrBSiMMZWud3KDbIzNrrhqIj
 OmrLeYm3UAqk8LEszEvwLdjjkf4R9XR9riwvAuqO983yISMO2pyN7iXe0epzfmR39pog
 C94A==
X-Gm-Message-State: APjAAAXB3HinNX0rGwGCp9VWlvLLCLwRY0VCWBLMwnGkYhiIeJYVIqbF
 FqvogBMnH4YyqFrhlvW7D4dk3rbUhxDFHM91TmtHng==
X-Google-Smtp-Source: APXvYqw5FX5A5MXKCRgEF928anGiykYLWSdwW/r9K5X/MWa1ul28UR5m/m5oEA9C5RfOl6leit8oE6DrRcLPEoRY4e8=
X-Received: by 2002:aca:f5cc:: with SMTP id
 t195mr10518398oih.163.1575052897060; 
 Fri, 29 Nov 2019 10:41:37 -0800 (PST)
MIME-Version: 1.0
References: <20191018150630.31099-1-damien.hedde@greensocs.com>
 <20191018150630.31099-7-damien.hedde@greensocs.com>
In-Reply-To: <20191018150630.31099-7-damien.hedde@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 Nov 2019 18:41:26 +0000
Message-ID: <CAFEAcA981i_W=8y+7_8JV=oMLT51TBMB8bTJJaiJJZqj6MuSAQ@mail.gmail.com>
Subject: Re: [PATCH v5 06/13] hw/core/qdev: handle parent bus change regarding
 resettable
To: Damien Hedde <damien.hedde@greensocs.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 Cornelia Huck <cohuck@redhat.com>, Mark Burton <mark.burton@greensocs.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Edgar Iglesias <edgari@xilinx.com>,
 qemu-arm <qemu-arm@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 16:07, Damien Hedde <damien.hedde@greensocs.com> wrote:
>
> In qdev_set_parent_bus(), when changing the parent bus of a
> realized device, if the source and destination buses are not in the
> same reset state, some adaptation are required. This patch adds

"adaptations"

> needed call to resettable_change_parent() to make sure a device reset
> state stays coherent with its parent bus.
>
> The addition is a no-op if:
> 1. the device being parented is not realized.
> 2. the device is realized, but both buses are not under reset.
>
> Case 2 means that as long as qdev_set_parent_bus() is called
> during the machine realization procedure (which is before the
> machine reset so nothing is in reset), it is a no op.
>
> There are 49 call sites of qdev_set_parent_bus(). All but one fall
> into the no-op case:
> + 28 calls related to virtio (in hw/{s390x,display,virtio}/
>   {vhost,virtio}-xxx.c) to set a _vdev_/_vgpu_ composing device
>   parent bus just before realizing the _vdev_/_vgpu_.
> + hw/qdev.c: when creating a device in qdev_try_create()
> + hw/sysbus.c: when initializing a device in the sysbus
> + hw/display/virtio-gpu-pci.c: before realizing VirtIOGPUPCIBase/vgpu
> + hw/display/virtio-vga.c: before realizing VirtIOVGABase/vgpu
> + hw/i386/amd_iommu.c: before realizing AMDVIState/pci
> + hw/misc/auxbus.c: when creating an AUXBus
> + hw/misc/auxbus.c: when creating an AUXBus child
> + hw/misc/macio/macio.c: when initializing a MACIOState child
> + hw/misc/macio/macio.c: before realizing NewWorldMacIOState/pmu
> + hw/misc/macio/macio.c: before realizing NewWorldMacIOState/cuda
> + hw/pci-host/designware.c: before realizing DesignwarePCIEHost/root
> + hw/pci-host/gpex.c: before realizing GPEXHost/root
> + hw/pci-host/prep.c: when initializaing PREPPCIState/pci_dev
> + hw/pci-host/q35.c: before realizing Q35PCIHost/mch
> + hw/pci-host/versatile.c: when initializing PCIVPBState/pci_dev
> + hw/pci-host/xilinx-pcie.c: before realizing XilinxPCIEHost/root
> + hw/s390x/event-facility.c: when creating SCLPEventFacility/
>                              TYPE_SCLP_QUIESCE
> + hw/s390x/event-facility.c: ditto with SCLPEventFacility/
>                              TYPE_SCLP_CPU_HOTPLUG
> + hw/s390x/sclp.c: Not trivial because it is called on a SLCPDevice
>   just after realizing it. Ok because at this point the destination
>   bus (sysbus) is not in reset; the realize step is before the
>   machine reset.
> + hw/sd/core.c: Not OK. Used in sdbus_reparent_card(). See below.
> + hw/ssi/ssi.c: Used to put spi slave on spi bus and connect the cs
>   line in ssi_auto_connect_slave(). Ok because this function is only
>   used in realize step in hw/ssi/aspeed_smc.ci, hw/ssi/imx_spi.c,
>   hw/ssi/mss-spi.c, hw/ssi/xilinx_spi.c and hw/ssi/xilinx_spips.c.
> + hw/xen/xen-legacy-backend.c: when creating a XenLegacyDevice device
> + qdev-monitor.c: in device hotplug creation procedure before realize

This is a really useful analysis to have in the commit message;
thanks!

(Side note: I wonder if the sclp.c case could be reordered so
it realizes the device after parenting it? Anyway, not something
to worry about now.)

> Note that this commit alone will have no effect, right now there is no
> use of resettable API to reset anything. So a bus will never be tagged
> as in-reset by this same API.
>
> The one place where side-effect will occurs is in hw/sd/core.c in
> sdbus_reparent_card(). This function is only used in the raspi machines,
> including during the sysbus reset procedure. This case will be fixed by
> a following commit before globally enabling resettable API for sysbus
> reset.
>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

