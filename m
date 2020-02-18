Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D54BC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1A7A20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BmmRangD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1A7A20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46Ty-0005Qm-2s
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:16:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51754)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j46TL-0004kx-0f
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j46TJ-00009s-LD
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:15:46 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31985)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j46TJ-00009h-Ge
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582046145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pg0sd9662DiDnMDYJKB4bQZ2RabzVRMn3ZzPNw/v0VM=;
 b=BmmRangD2zCWSgHPfTrtUsuSAktGhxnEFPa+140ZTfHh2VRBUnwZuozHeI1VVjrVAwX/Aj
 dMyYp0L12Bx6M80WSBBKNJJjsTXiBI47TunHD5yn44r2bSqLX4M7EVlJjTzCI2mZ1N/ESQ
 TwUbeEh/P3z9IXmRYeeGggLKqhjjZTc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-B4cQqyLLPFeThtmyedAsqg-1; Tue, 18 Feb 2020 12:15:38 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E8DA1857345
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 17:15:37 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5659F90F73;
 Tue, 18 Feb 2020 17:15:27 +0000 (UTC)
Date: Tue, 18 Feb 2020 18:15:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
Message-ID: <20200218181526.30aadf0a@redhat.com>
In-Reply-To: <20200218161717.386723-1-jusual@redhat.com>
References: <20200218161717.386723-1-jusual@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: B4cQqyLLPFeThtmyedAsqg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
 qemu-devel@nongnu.org, Laine Stump <laine@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 17:17:17 +0100
Julia Suvorova <jusual@redhat.com> wrote:

> Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
> to manage it and restrict unplug for the entire machine. This is going
> to prevent user-initiated unplug in guests (Windows mostly).
> Usage:
>     -device pcie-root-port,disable-hotplug=true,...
> 
> Discussion related:
>     https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg00530.html
> 
> Signed-off-by: Julia Suvorova <jusual@redhat.com>
> ---
>  hw/core/machine.c                  | 1 +
>  hw/pci-bridge/pcie_root_port.c     | 3 ++-
>  hw/pci-bridge/xio3130_downstream.c | 2 +-
>  hw/pci/pcie.c                      | 8 ++++++--
>  include/hw/pci/pcie.h              | 2 +-
>  include/hw/pci/pcie_port.h         | 1 +
>  6 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index 84812a1d1c..5ff698ac3c 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -36,6 +36,7 @@ GlobalProperty hw_compat_4_2[] = {
>      { "usb-redir", "suppress-remote-wake", "off" },
>      { "qxl", "revision", "4" },
>      { "qxl-vga", "revision", "4" },
> +    { "pcie-root-port-base", "disable-hotplug", "false" },
this looks unnecessary as the property is 'off' by default

>  };
>  const size_t hw_compat_4_2_len = G_N_ELEMENTS(hw_compat_4_2);
>  
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index 0ba4e4dea4..d6a080bee8 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -94,7 +94,7 @@ static void rp_realize(PCIDevice *d, Error **errp)
>  
>      pcie_cap_arifwd_init(d);
>      pcie_cap_deverr_init(d);
> -    pcie_cap_slot_init(d, s->slot);
> +    pcie_cap_slot_init(d, s);
>      pcie_cap_root_init(d);
>  
>      pcie_chassis_create(s->chassis);
> @@ -147,6 +147,7 @@ static Property rp_props[] = {
>      DEFINE_PROP_BIT(COMPAT_PROP_PCP, PCIDevice, cap_present,
>                      QEMU_PCIE_SLTCAP_PCP_BITNR, true),
>      DEFINE_PROP_BOOL("disable-acs", PCIESlot, disable_acs, false),
> +    DEFINE_PROP_BOOL("disable-hotplug", PCIESlot, disable_hotplug, false),
>      DEFINE_PROP_END_OF_LIST()
>  };
>  
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 153a4acad2..04aae72cd6 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -94,7 +94,7 @@ static void xio3130_downstream_realize(PCIDevice *d, Error **errp)
>      }
>      pcie_cap_flr_init(d);
>      pcie_cap_deverr_init(d);
> -    pcie_cap_slot_init(d, s->slot);
> +    pcie_cap_slot_init(d, s);
>      pcie_cap_arifwd_init(d);
>  
>      pcie_chassis_create(s->chassis);
> diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> index 08718188bb..6dd9b89e21 100644
> --- a/hw/pci/pcie.c
> +++ b/hw/pci/pcie.c
> @@ -495,7 +495,7 @@ void pcie_cap_slot_unplug_request_cb(HotplugHandler *hotplug_dev,
>  
>  /* pci express slot for pci express root/downstream port
>     PCI express capability slot registers */
> -void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
> +void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s)
>  {
>      uint32_t pos = dev->exp.exp_cap;
>  
> @@ -505,13 +505,17 @@ void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot)
>      pci_long_test_and_clear_mask(dev->config + pos + PCI_EXP_SLTCAP,
>                                   ~PCI_EXP_SLTCAP_PSN);
>      pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
> -                               (slot << PCI_EXP_SLTCAP_PSN_SHIFT) |
> +                               (s->slot << PCI_EXP_SLTCAP_PSN_SHIFT) |
>                                 PCI_EXP_SLTCAP_EIP |
>                                 PCI_EXP_SLTCAP_HPS |
>                                 PCI_EXP_SLTCAP_HPC |

why not to set it to begin with instead of clearing it later as afterthought?

Also only _HPC but _HPS is left, wouldn't it confuse guests?

>                                 PCI_EXP_SLTCAP_PIP |
>                                 PCI_EXP_SLTCAP_AIP |
>                                 PCI_EXP_SLTCAP_ABP);
> +    if (s->disable_hotplug) {
> +        pci_long_test_and_clear_mask(dev->config + pos + PCI_EXP_SLTCAP,
> +                                     PCI_EXP_SLTCAP_HPC);

> +    }
>  
>      if (dev->cap_present & QEMU_PCIE_SLTCAP_PCP) {
>          pci_long_test_and_set_mask(dev->config + pos + PCI_EXP_SLTCAP,
> diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
> index 7064875835..14c58ebdb6 100644
> --- a/include/hw/pci/pcie.h
> +++ b/include/hw/pci/pcie.h
> @@ -104,7 +104,7 @@ void pcie_cap_deverr_reset(PCIDevice *dev);
>  void pcie_cap_lnkctl_init(PCIDevice *dev);
>  void pcie_cap_lnkctl_reset(PCIDevice *dev);
>  
> -void pcie_cap_slot_init(PCIDevice *dev, uint16_t slot);
> +void pcie_cap_slot_init(PCIDevice *dev, PCIESlot *s);
>  void pcie_cap_slot_reset(PCIDevice *dev);
>  void pcie_cap_slot_get(PCIDevice *dev, uint16_t *slt_ctl, uint16_t *slt_sta);
>  void pcie_cap_slot_write_config(PCIDevice *dev,
> diff --git a/include/hw/pci/pcie_port.h b/include/hw/pci/pcie_port.h
> index 4b3d254b08..796fc8f3ab 100644
> --- a/include/hw/pci/pcie_port.h
> +++ b/include/hw/pci/pcie_port.h
> @@ -55,6 +55,7 @@ struct PCIESlot {
>  
>      /* Disable ACS (really for a pcie_root_port) */
>      bool        disable_acs;
> +    bool        disable_hotplug;
>      QLIST_ENTRY(PCIESlot) next;
>  };
>  


