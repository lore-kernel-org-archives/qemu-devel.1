Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940B1C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:05:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3AA2089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 07:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3AA2089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7aDG-0007x7-H4
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 03:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44573)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7aCT-0007Lf-R0
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7aCR-0001t6-Vc
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53530)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7aCR-0001sW-MR
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 03:04:27 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 88E2C3C919
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 07:04:26 +0000 (UTC)
Received: by mail-qk1-f197.google.com with SMTP id u17so7806045qkj.7
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 00:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=IaVb8yBjEF94Mg0DWZ77DVk/o8Q47z23e+gwIBTWsO8=;
 b=JZIohZpbAdE8K9Muqx587Ki30Xp6kPNn5LC7+g2P00Pp/inWCr15/nJ/LRLykQpOEG
 H6krPlWgWHG9IWsBA+4g1hOd4QAVSeL/jlkjlHKFCL/7tnL1kMp6wk2eLkqFPNLhy+hu
 mnNgNMZ2RI6msAaYoWlZqUvjXP6stkbYOF98p8DOFq7hsW7bb2qcUXJGqD2/Tpzkwx/J
 ydw80sqcTf6VxZv6IGnbhDwzaHE84AB20pm6O9WOzs7pLM90E+Ekz8CHrAc/3VRazXTj
 dcSThKkwuQUoGev2UqZavzEoXyTCtNtMZp0BzwpjS85TDXz0RR4foSVH6N69/ZNKvT3U
 Zoiw==
X-Gm-Message-State: APjAAAVfrr72mGQFVLXYPAW+fB7RAenH2bXhxD6RdZOEeLvVbQz8EjQW
 ce0AFhd3d25LI7uGCJXJNyL7OqxAEeu7/iG+tANaL3DJGaneS62x1rJSAETzxFtjGpA3QctItDf
 EMoIPZZ2eC4BSK2c=
X-Received: by 2002:a37:4c4d:: with SMTP id z74mr26745817qka.459.1568099065854; 
 Tue, 10 Sep 2019 00:04:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyZcZLi2cMnfYhX0D7AZAR1ZrCAojZJeedmqOqkER1ofiV5JQJh0tudEHZS7J+h/WSlqp29tQ==
X-Received: by 2002:a37:4c4d:: with SMTP id z74mr26745805qka.459.1568099065677; 
 Tue, 10 Sep 2019 00:04:25 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id a134sm8977372qkc.95.2019.09.10.00.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 00:04:24 -0700 (PDT)
Date: Tue, 10 Sep 2019 03:04:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: andychiu <andychiu@synology.com>
Message-ID: <20190910025404-mutt-send-email-mst@kernel.org>
References: <1568049517-10261-1-git-send-email-andychiu@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568049517-10261-1-git-send-email-andychiu@synology.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
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
Cc: jsnow@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 01:18:37AM +0800, andychiu wrote:
> If Windows 10 guests have enabled 'turn off hard disk after idle'
> option in power settings, and the guest has a SATA disk plugged in,
> the SATA disk will be turned off after a specified idle time.
> If the guest is live migrated or saved/loaded with its SATA disk
> turned off, the following error will occur:
> 
> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
> qemu-system-x86_64: Failed to load ich9_ahci:ahci
> qemu-system-x86_64: error while loading state for instance 0x0 of device '0000:00:1a.0/ich9_ahci'
> qemu-system-x86_64: load of migration failed: Operation not permitted
> 
> Observation from trace logs shows that a while after Windows 10 turns off
> a SATA disk (IDE disks don't have the following behavior),
> it will disable the PCI_COMMAND_MASTER flag of the pci device containing
> the ahci device. When the the disk is turning back on,
> the PCI_COMMAND_MASTER flag will be restored first.
> But if the guest is migrated or saved/loaded while the disk is off,
> the post_load callback of ahci device, ahci_state_post_load(), will fail
> at ahci_cond_start_engines() if the MemoryRegion
> pci_dev->bus_master_enable_region is not enabled, with pci_dev pointing
> to the PCIDevice struct containing the ahci device.
> 
> This patch enables pci_dev->bus_master_enable_region before calling
> ahci_cond_start_engines() in ahci_state_post_load(), and restore the
> MemoryRegion to its original state afterwards.
> 
> Signed-off-by: andychiu <andychiu@synology.com>

Poking at PCI device internals like this seems fragile.  And force
enabling bus master can lead to unpleasantness like corrupting guest
memory, unhandled interrupts, etc.  E.g. it's quite reasonable,
spec-wise, for the guest to move thing in memory around while bus
mastering is off.

Can you teach ahci that region being disabled
during migration is ok, and recover from it?

> ---
>  hw/ide/ahci.c | 53 ++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)
> 
> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
> index d45393c..83f8c30 100644
> --- a/hw/ide/ahci.c
> +++ b/hw/ide/ahci.c
> @@ -1649,33 +1649,52 @@ static const VMStateDescription vmstate_ahci_device = {
>      },
>  };
>  
> +static int ahci_state_load_engines(AHCIState *s, AHCIDevice *ad)
> +{
> +    AHCIPortRegs *pr = &ad->port_regs;
> +    DeviceState *dev_state = s->container;
> +    PCIDevice *pci_dev = (PCIDevice *) object_dynamic_cast(OBJECT(dev_state),
> +                                                           TYPE_PCI_DEVICE);
> +    bool pci_bus_master_enabled = pci_dev->bus_master_enable_region.enabled;
> +
> +    if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
> +        error_report("AHCI: DMA engine should be off, but status bit "
> +                     "indicates it is still running.");
> +        return -1;
> +    }
> +    if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_ON)) {
> +        error_report("AHCI: FIS RX engine should be off, but status bit "
> +                     "indicates it is still running.");
> +        return -1;
> +    }
> +
> +    memory_region_set_enabled(&pci_dev->bus_master_enable_region, true);
> +
> +    /*
> +     * After a migrate, the DMA/FIS engines are "off" and
> +     * need to be conditionally restarted
> +     */
> +    pr->cmd &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
> +    if (ahci_cond_start_engines(ad) != 0) {
> +        return -1;
> +    }
> +    memory_region_set_enabled(&pci_dev->bus_master_enable_region,
> +                              pci_bus_master_enabled);
> +
> +    return 0;
> +}
> +
>  static int ahci_state_post_load(void *opaque, int version_id)
>  {
>      int i, j;
>      struct AHCIDevice *ad;
>      NCQTransferState *ncq_tfs;
> -    AHCIPortRegs *pr;
>      AHCIState *s = opaque;
>  
>      for (i = 0; i < s->ports; i++) {
>          ad = &s->dev[i];
> -        pr = &ad->port_regs;
> -
> -        if (!(pr->cmd & PORT_CMD_START) && (pr->cmd & PORT_CMD_LIST_ON)) {
> -            error_report("AHCI: DMA engine should be off, but status bit "
> -                         "indicates it is still running.");
> -            return -1;
> -        }
> -        if (!(pr->cmd & PORT_CMD_FIS_RX) && (pr->cmd & PORT_CMD_FIS_ON)) {
> -            error_report("AHCI: FIS RX engine should be off, but status bit "
> -                         "indicates it is still running.");
> -            return -1;
> -        }
>  
> -        /* After a migrate, the DMA/FIS engines are "off" and
> -         * need to be conditionally restarted */
> -        pr->cmd &= ~(PORT_CMD_LIST_ON | PORT_CMD_FIS_ON);
> -        if (ahci_cond_start_engines(ad) != 0) {
> +        if (ahci_state_load_engines(s, ad)) {
>              return -1;
>          }
>  
> -- 
> 2.7.4

