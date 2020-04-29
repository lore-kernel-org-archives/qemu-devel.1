Return-Path: <SRS0=Qmby=6N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61071C83003
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:07:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E7F2073E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2020 07:07:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E7F2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTgoV-0007hP-E1
	for qemu-devel@archiver.kernel.org; Wed, 29 Apr 2020 03:07:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jTglH-0004bv-Tm
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:04:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1jTglG-0008EG-So
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:04:03 -0400
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:42434)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jTglG-0007u9-BF
 for qemu-devel@nongnu.org; Wed, 29 Apr 2020 03:04:02 -0400
Received: from player696.ha.ovh.net (unknown [10.108.35.131])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id EE6BA1D2348
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2020 09:03:52 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player696.ha.ovh.net (Postfix) with ESMTPSA id 3CBE611E799BB;
 Wed, 29 Apr 2020 07:03:45 +0000 (UTC)
Date: Wed, 29 Apr 2020 09:03:42 +0200
From: Greg Kurz <groug@kaod.org>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 16/17] spapr_pci: Drop some dead error handling
Message-ID: <20200429090342.68fdedf8@bahia.lan>
In-Reply-To: <20200428163419.4483-17-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
 <20200428163419.4483-17-armbru@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2798987169230199182
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedriedvgdduudduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthejredtredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrheileeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.172.75; envelope-from=groug@kaod.org;
 helo=4.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/29 03:03:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Received-From: 87.98.172.75
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, pbonzini@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Apr 2020 18:34:18 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> chassis_from_bus() uses object_property_get_uint() to get property
> "chassis_nr" of the bridge device.  Failure would be a programming
> error.  Pass &error_abort, and simplify its callers.
> 
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr_pci.c | 86 ++++++++++------------------------------------
>  1 file changed, 18 insertions(+), 68 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 1d73d05a0a..b6036be51c 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1203,46 +1203,36 @@ static SpaprDrc *drc_from_devfn(SpaprPhbState *phb,
>                             drc_id_from_devfn(phb, chassis, devfn));
>  }
>  
> -static uint8_t chassis_from_bus(PCIBus *bus, Error **errp)
> +static uint8_t chassis_from_bus(PCIBus *bus)
>  {
>      if (pci_bus_is_root(bus)) {
>          return 0;
>      } else {
>          PCIDevice *bridge = pci_bridge_get_device(bus);
>  
> -        return object_property_get_uint(OBJECT(bridge), "chassis_nr", errp);
> +        return object_property_get_uint(OBJECT(bridge), "chassis_nr",
> +                                        &error_abort);
>      }
>  }
>  
>  static SpaprDrc *drc_from_dev(SpaprPhbState *phb, PCIDevice *dev)
>  {
> -    Error *local_err = NULL;
> -    uint8_t chassis = chassis_from_bus(pci_get_bus(dev), &local_err);
> -
> -    if (local_err) {
> -        error_report_err(local_err);
> -        return NULL;
> -    }
> +    uint8_t chassis = chassis_from_bus(pci_get_bus(dev));
>  
>      return drc_from_devfn(phb, chassis, dev->devfn);
>  }
>  
> -static void add_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
> +static void add_drcs(SpaprPhbState *phb, PCIBus *bus)
>  {
>      Object *owner;
>      int i;
>      uint8_t chassis;
> -    Error *local_err = NULL;
>  
>      if (!phb->dr_enabled) {
>          return;
>      }
>  
> -    chassis = chassis_from_bus(bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    chassis = chassis_from_bus(bus);
>  
>      if (pci_bus_is_root(bus)) {
>          owner = OBJECT(phb);
> @@ -1256,21 +1246,16 @@ static void add_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
>      }
>  }
>  
> -static void remove_drcs(SpaprPhbState *phb, PCIBus *bus, Error **errp)
> +static void remove_drcs(SpaprPhbState *phb, PCIBus *bus)
>  {
>      int i;
>      uint8_t chassis;
> -    Error *local_err = NULL;
>  
>      if (!phb->dr_enabled) {
>          return;
>      }
>  
> -    chassis = chassis_from_bus(bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    chassis = chassis_from_bus(bus);
>  
>      for (i = PCI_SLOT_MAX * PCI_FUNC_MAX - 1; i >= 0; i--) {
>          SpaprDrc *drc = drc_from_devfn(phb, chassis, i);
> @@ -1488,17 +1473,11 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>  }
>  
>  static void spapr_pci_bridge_plug(SpaprPhbState *phb,
> -                                  PCIBridge *bridge,
> -                                  Error **errp)
> +                                  PCIBridge *bridge)
>  {
> -    Error *local_err = NULL;
>      PCIBus *bus = pci_bridge_get_sec_bus(bridge);
>  
> -    add_drcs(phb, bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    add_drcs(phb, bus);
>  }
>  
>  static void spapr_pci_plug(HotplugHandler *plug_handler,
> @@ -1529,11 +1508,7 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
>      g_assert(drc);
>  
>      if (pc->is_bridge) {
> -        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev), &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        spapr_pci_bridge_plug(phb, PCI_BRIDGE(plugged_dev));
>      }
>  
>      /* Following the QEMU convention used for PCIe multifunction
> @@ -1560,12 +1535,7 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
>          spapr_drc_reset(drc);
>      } else if (PCI_FUNC(pdev->devfn) == 0) {
>          int i;
> -        uint8_t chassis = chassis_from_bus(pci_get_bus(pdev), &local_err);
> -
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        uint8_t chassis = chassis_from_bus(pci_get_bus(pdev));
>  
>          for (i = 0; i < 8; i++) {
>              SpaprDrc *func_drc;
> @@ -1587,17 +1557,11 @@ out:
>  }
>  
>  static void spapr_pci_bridge_unplug(SpaprPhbState *phb,
> -                                    PCIBridge *bridge,
> -                                    Error **errp)
> +                                    PCIBridge *bridge)
>  {
> -    Error *local_err = NULL;
>      PCIBus *bus = pci_bridge_get_sec_bus(bridge);
>  
> -    remove_drcs(phb, bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        return;
> -    }
> +    remove_drcs(phb, bus);
>  }
>  
>  static void spapr_pci_unplug(HotplugHandler *plug_handler,
> @@ -1619,11 +1583,7 @@ static void spapr_pci_unplug(HotplugHandler *plug_handler,
>      pci_device_reset(PCI_DEVICE(plugged_dev));
>  
>      if (pc->is_bridge) {
> -        Error *local_err = NULL;
> -        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev), &local_err);
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -        }
> +        spapr_pci_bridge_unplug(phb, PCI_BRIDGE(plugged_dev));
>          return;
>      }
>  
> @@ -1654,13 +1614,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
>          SpaprDrcClass *func_drck;
>          SpaprDREntitySense state;
>          int i;
> -        Error *local_err = NULL;
> -        uint8_t chassis = chassis_from_bus(pci_get_bus(pdev), &local_err);
> -
> -        if (local_err) {
> -            error_propagate(errp, local_err);
> -            return;
> -        }
> +        uint8_t chassis = chassis_from_bus(pci_get_bus(pdev));
>  
>          if (pc->is_bridge) {
>              error_setg(errp, "PCI: Hot unplug of PCI bridges not supported");
> @@ -1741,7 +1695,7 @@ static void spapr_phb_unrealize(DeviceState *dev)
>          }
>      }
>  
> -    remove_drcs(sphb, phb->bus, &error_abort);
> +    remove_drcs(sphb, phb->bus);
>  
>      for (i = PCI_NUM_PINS - 1; i >= 0; i--) {
>          if (sphb->lsi_table[i].irq) {
> @@ -1980,11 +1934,7 @@ static void spapr_phb_realize(DeviceState *dev, Error **errp)
>      }
>  
>      /* allocate connectors for child PCI devices */
> -    add_drcs(sphb, phb->bus, &local_err);
> -    if (local_err) {
> -        error_propagate(errp, local_err);
> -        goto unrealize;
> -    }
> +    add_drcs(sphb, phb->bus);
>  
>      /* DMA setup */
>      for (i = 0; i < windows_supported; ++i) {


