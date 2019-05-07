Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D394CC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892E920578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 10:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892E920578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43671 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNwx1-000577-HY
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 06:03:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwvq-0004j0-VD
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:02:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hNwvl-0005Bf-PT
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:02:42 -0400
Received: from 10.mo6.mail-out.ovh.net ([87.98.157.236]:53690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hNwvl-0005AO-Gz
	for qemu-devel@nongnu.org; Tue, 07 May 2019 06:02:37 -0400
Received: from player697.ha.ovh.net (unknown [10.109.160.232])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 9496E1C18A2
	for <qemu-devel@nongnu.org>; Tue,  7 May 2019 12:02:33 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player697.ha.ovh.net (Postfix) with ESMTPSA id 8EC7F5826A32;
	Tue,  7 May 2019 10:02:24 +0000 (UTC)
Date: Tue, 7 May 2019 12:02:21 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190507120221.772eae29@bahia.lan>
In-Reply-To: <20190507062316.20916-5-david@gibson.dropbear.id.au>
References: <20190507062316.20916-1-david@gibson.dropbear.id.au>
	<20190507062316.20916-5-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 6321083552594500070
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkedtgddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.157.236
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 4/5] pci: Make is_bridge a
 bool
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue,  7 May 2019 16:23:15 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The is_bridge field in PCIDevice acts as a bool, but is declared as an int.
> Declare it as a bool for clarity, and change everything that writes it to
> use true/false instead of 0/1 to match.
> 

Reviewed-by: Greg Kurz <groug@kaod.org>

> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/pci-bridge/dec.c                | 4 ++--
>  hw/pci-bridge/i82801b11.c          | 2 +-
>  hw/pci-bridge/pci_bridge_dev.c     | 2 +-
>  hw/pci-bridge/pcie_pci_bridge.c    | 2 +-
>  hw/pci-bridge/pcie_root_port.c     | 2 +-
>  hw/pci-bridge/simba.c              | 2 +-
>  hw/pci-bridge/xio3130_downstream.c | 2 +-
>  hw/pci-bridge/xio3130_upstream.c   | 2 +-
>  include/hw/pci/pci.h               | 2 +-
>  9 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
> index 8484bfd434..ca40253730 100644
> --- a/hw/pci-bridge/dec.c
> +++ b/hw/pci-bridge/dec.c
> @@ -68,7 +68,7 @@ static void dec_21154_pci_bridge_class_init(ObjectClass *klass, void *data)
>      k->vendor_id = PCI_VENDOR_ID_DEC;
>      k->device_id = PCI_DEVICE_ID_DEC_21154;
>      k->config_write = pci_bridge_write_config;
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      dc->desc = "DEC 21154 PCI-PCI bridge";
>      dc->reset = pci_bridge_reset;
>      dc->vmsd = &vmstate_pci_device;
> @@ -129,7 +129,7 @@ static void dec_21154_pci_host_class_init(ObjectClass *klass, void *data)
>      k->device_id = PCI_DEVICE_ID_DEC_21154;
>      k->revision = 0x02;
>      k->class_id = PCI_CLASS_BRIDGE_PCI;
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      /*
>       * PCI-facing part of the host bridge, not usable without the
>       * host-facing part, which can't be device_add'ed, yet.
> diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
> index 10e590e5c6..6d8b0f54a7 100644
> --- a/hw/pci-bridge/i82801b11.c
> +++ b/hw/pci-bridge/i82801b11.c
> @@ -90,7 +90,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      k->vendor_id = PCI_VENDOR_ID_INTEL;
>      k->device_id = PCI_DEVICE_ID_INTEL_82801BA_11;
>      k->revision = ICH9_D2P_A2_REVISION;
> diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
> index ff6b8323da..c56ed1f52f 100644
> --- a/hw/pci-bridge/pci_bridge_dev.c
> +++ b/hw/pci-bridge/pci_bridge_dev.c
> @@ -253,7 +253,7 @@ static void pci_bridge_dev_class_init(ObjectClass *klass, void *data)
>      k->vendor_id = PCI_VENDOR_ID_REDHAT;
>      k->device_id = PCI_DEVICE_ID_REDHAT_BRIDGE;
>      k->class_id = PCI_CLASS_BRIDGE_PCI;
> -    k->is_bridge = 1,
> +    k->is_bridge = true;
>      dc->desc = "Standard PCI Bridge";
>      dc->reset = qdev_pci_bridge_dev_reset;
>      dc->props = pci_bridge_dev_properties;
> diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
> index d491b40d04..9a4fba413a 100644
> --- a/hw/pci-bridge/pcie_pci_bridge.c
> +++ b/hw/pci-bridge/pcie_pci_bridge.c
> @@ -143,7 +143,7 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
>  
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      k->vendor_id = PCI_VENDOR_ID_REDHAT;
>      k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
>      k->realize = pcie_pci_bridge_realize;
> diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
> index e94d918b6d..be3f4d5e03 100644
> --- a/hw/pci-bridge/pcie_root_port.c
> +++ b/hw/pci-bridge/pcie_root_port.c
> @@ -162,7 +162,7 @@ static void rp_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      k->config_write = rp_write_config;
>      k->realize = rp_realize;
>      k->exit = rp_exit;
> diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
> index dea4c8c5e7..7cf0d6e047 100644
> --- a/hw/pci-bridge/simba.c
> +++ b/hw/pci-bridge/simba.c
> @@ -76,7 +76,7 @@ static void simba_pci_bridge_class_init(ObjectClass *klass, void *data)
>      k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
>      k->revision = 0x11;
>      k->config_write = pci_bridge_write_config;
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
>      dc->reset = pci_bridge_reset;
>      dc->vmsd = &vmstate_pci_device;
> diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
> index 467bbabe4c..ab2a51e15d 100644
> --- a/hw/pci-bridge/xio3130_downstream.c
> +++ b/hw/pci-bridge/xio3130_downstream.c
> @@ -152,7 +152,7 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      k->config_write = xio3130_downstream_write_config;
>      k->realize = xio3130_downstream_realize;
>      k->exit = xio3130_downstream_exitfn;
> diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
> index b524908cf1..1d41a49ab0 100644
> --- a/hw/pci-bridge/xio3130_upstream.c
> +++ b/hw/pci-bridge/xio3130_upstream.c
> @@ -126,7 +126,7 @@ static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
>      DeviceClass *dc = DEVICE_CLASS(klass);
>      PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
>  
> -    k->is_bridge = 1;
> +    k->is_bridge = true;
>      k->config_write = xio3130_upstream_write_config;
>      k->realize = xio3130_upstream_realize;
>      k->exit = xio3130_upstream_exitfn;
> diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
> index da20c915ef..d082707dfa 100644
> --- a/include/hw/pci/pci.h
> +++ b/include/hw/pci/pci.h
> @@ -234,7 +234,7 @@ typedef struct PCIDeviceClass {
>       * This doesn't mean pci host switch.
>       * When card bus bridge is supported, this would be enhanced.
>       */
> -    int is_bridge;
> +    bool is_bridge;
>  
>      /* rom bar */
>      const char *romfile;


