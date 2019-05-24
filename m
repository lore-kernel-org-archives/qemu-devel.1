Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8330C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:36:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7753020815
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:36:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7753020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56354 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUCFB-0001VM-8D
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:36:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hUCDJ-0000GF-SK
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hUCDH-00033s-Ti
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:34:33 -0400
Received: from 9.mo4.mail-out.ovh.net ([46.105.40.176]:42472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hUCD9-0002wU-BI
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:34:28 -0400
Received: from player787.ha.ovh.net (unknown [10.109.159.222])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 8E9B01F315C
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 17:34:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player787.ha.ovh.net (Postfix) with ESMTPSA id B5C4363EB954;
	Fri, 24 May 2019 15:34:11 +0000 (UTC)
Date: Fri, 24 May 2019 17:34:10 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190524173410.2d362c9a@bahia.lan>
In-Reply-To: <20190523052918.1129-2-david@gibson.dropbear.id.au>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
	<20190523052918.1129-2-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 1079175062239156710
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduiedgleduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.40.176
Subject: Re: [Qemu-devel] [PATCH 2/8] spapr: Clean up device tree
 construction for PCI devices
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
Cc: mdroth@linux.ibm.com, mst@redhat.com, qemu-ppc@nongnu.org, clg@kaod.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 15:29:12 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_create_pci_child_dt() is a trivial wrapper around
> spapr_populate_pci_child_dt(), but is the latter's only caller.  So fold
> them together into spapr_dt_pci_device(), which closer matches our modern
> naming convention.
> 
> While there, make a number of cleanups to the function itself.  This is
> mostly using more temporary locals to avoid awkwardly long lines, and in
> some cases avoiding double reads of PCI config space variables.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c | 119 +++++++++++++++++++++------------------------
>  1 file changed, 55 insertions(+), 64 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index b2db46ef1d..4075b433fd 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1219,57 +1219,75 @@ static const char *dt_name_from_class(uint8_t class, uint8_t subclass,
>  static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
>                                              PCIDevice *pdev);
>  
> -static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
> -                                       SpaprPhbState *sphb)
> +/* create OF node for pci device and required OF DT properties */
> +static int spapr_dt_pci_device(SpaprPhbState *sphb, PCIDevice *dev,
> +                               void *fdt, int parent_offset)
>  {
> +    int offset;
> +    const gchar *basename;
> +    char *nodename;

Being curious... what's the rationale for using gchar or char, if any ?

> +    int slot = PCI_SLOT(dev->devfn);
> +    int func = PCI_FUNC(dev->devfn);
>      ResourceProps rp;
> -    bool is_bridge = false;
> -    int pci_status;
> -    char *buf = NULL;
>      uint32_t drc_index = spapr_phb_get_pci_drc_index(sphb, dev);
> +    uint32_t header_type = pci_default_read_config(dev, PCI_HEADER_TYPE, 1);
> +    bool is_bridge = (header_type == PCI_HEADER_TYPE_BRIDGE);
> +    uint32_t vendor_id = pci_default_read_config(dev, PCI_VENDOR_ID, 2);
> +    uint32_t device_id = pci_default_read_config(dev, PCI_DEVICE_ID, 2);
> +    uint32_t revision_id = pci_default_read_config(dev, PCI_REVISION_ID, 1);
>      uint32_t ccode = pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> -    uint32_t max_msi, max_msix;
> +    uint32_t irq_pin = pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1);
> +    uint32_t subsystem_id = pci_default_read_config(dev, PCI_SUBSYSTEM_ID, 2);
> +    uint32_t subsystem_vendor_id =
> +        pci_default_read_config(dev, PCI_SUBSYSTEM_VENDOR_ID, 2);
> +    uint32_t cache_line_size =
> +        pci_default_read_config(dev, PCI_CACHE_LINE_SIZE, 1);
> +    uint32_t pci_status = pci_default_read_config(dev, PCI_STATUS, 2);
> +    gchar *loc_code;
> +    

trailing space ^^

Apart from that, LGTM.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +    basename = dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8) & 0xff,
> +                                  ccode & 0xff);
>  
> -    if (pci_default_read_config(dev, PCI_HEADER_TYPE, 1) ==
> -        PCI_HEADER_TYPE_BRIDGE) {
> -        is_bridge = true;
> +    if (func != 0) {
> +        nodename = g_strdup_printf("%s@%x,%x", basename, slot, func);
> +    } else {
> +        nodename = g_strdup_printf("%s@%x", basename, slot);
>      }
>  
> +    _FDT(offset = fdt_add_subnode(fdt, parent_offset, nodename));
> +
> +    g_free(nodename);
> +
>      /* in accordance with PAPR+ v2.7 13.6.3, Table 181 */
> -    _FDT(fdt_setprop_cell(fdt, offset, "vendor-id",
> -                          pci_default_read_config(dev, PCI_VENDOR_ID, 2)));
> -    _FDT(fdt_setprop_cell(fdt, offset, "device-id",
> -                          pci_default_read_config(dev, PCI_DEVICE_ID, 2)));
> -    _FDT(fdt_setprop_cell(fdt, offset, "revision-id",
> -                          pci_default_read_config(dev, PCI_REVISION_ID, 1)));
> +    _FDT(fdt_setprop_cell(fdt, offset, "vendor-id", vendor_id));
> +    _FDT(fdt_setprop_cell(fdt, offset, "device-id", device_id));
> +    _FDT(fdt_setprop_cell(fdt, offset, "revision-id", revision_id));
> +
>      _FDT(fdt_setprop_cell(fdt, offset, "class-code", ccode));
> -    if (pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)) {
> -        _FDT(fdt_setprop_cell(fdt, offset, "interrupts",
> -                 pci_default_read_config(dev, PCI_INTERRUPT_PIN, 1)));
> +    if (irq_pin) {
> +        _FDT(fdt_setprop_cell(fdt, offset, "interrupts", irq_pin));
>      }
>  
>      if (!is_bridge) {
> -        _FDT(fdt_setprop_cell(fdt, offset, "min-grant",
> -            pci_default_read_config(dev, PCI_MIN_GNT, 1)));
> -        _FDT(fdt_setprop_cell(fdt, offset, "max-latency",
> -            pci_default_read_config(dev, PCI_MAX_LAT, 1)));
> +        uint32_t min_grant = pci_default_read_config(dev, PCI_MIN_GNT, 1);
> +        uint32_t max_latency = pci_default_read_config(dev, PCI_MAX_LAT, 1);
> +        _FDT(fdt_setprop_cell(fdt, offset, "min-grant", min_grant));
> +        _FDT(fdt_setprop_cell(fdt, offset, "max-latency", max_latency));
>      }
>  
> -    if (pci_default_read_config(dev, PCI_SUBSYSTEM_ID, 2)) {
> -        _FDT(fdt_setprop_cell(fdt, offset, "subsystem-id",
> -                 pci_default_read_config(dev, PCI_SUBSYSTEM_ID, 2)));
> +    if (subsystem_id) {
> +        _FDT(fdt_setprop_cell(fdt, offset, "subsystem-id", subsystem_id));
>      }
>  
> -    if (pci_default_read_config(dev, PCI_SUBSYSTEM_VENDOR_ID, 2)) {
> +    if (subsystem_vendor_id) {
>          _FDT(fdt_setprop_cell(fdt, offset, "subsystem-vendor-id",
> -                 pci_default_read_config(dev, PCI_SUBSYSTEM_VENDOR_ID, 2)));
> +                              subsystem_vendor_id));
>      }
>  
> -    _FDT(fdt_setprop_cell(fdt, offset, "cache-line-size",
> -        pci_default_read_config(dev, PCI_CACHE_LINE_SIZE, 1)));
> +    _FDT(fdt_setprop_cell(fdt, offset, "cache-line-size", cache_line_size));
> +
>  
>      /* the following fdt cells are masked off the pci status register */
> -    pci_status = pci_default_read_config(dev, PCI_STATUS, 2);
>      _FDT(fdt_setprop_cell(fdt, offset, "devsel-speed",
>                            PCI_STATUS_DEVSEL_MASK & pci_status));
>  
> @@ -1283,9 +1301,9 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>          _FDT(fdt_setprop(fdt, offset, "udf-supported", NULL, 0));
>      }
>  
> -    buf = spapr_phb_get_loc_code(sphb, dev);
> -    _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", buf));
> -    g_free(buf);
> +    loc_code = spapr_phb_get_loc_code(sphb, dev);
> +    _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", loc_code));
> +    g_free(loc_code);
>  
>      if (drc_index) {
>          _FDT(fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_index));
> @@ -1297,13 +1315,13 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>                            RESOURCE_CELLS_SIZE));
>  
>      if (msi_present(dev)) {
> -        max_msi = msi_nr_vectors_allocated(dev);
> +        uint32_t max_msi = msi_nr_vectors_allocated(dev);
>          if (max_msi) {
>              _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi", max_msi));
>          }
>      }
>      if (msix_present(dev)) {
> -        max_msix = dev->msix_entries_nr;
> +        uint32_t max_msix = dev->msix_entries_nr;
>          if (max_msix) {
>              _FDT(fdt_setprop_cell(fdt, offset, "ibm,req#msi-x", max_msix));
>          }
> @@ -1319,33 +1337,6 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>      }
>  
>      spapr_phb_nvgpu_populate_pcidev_dt(dev, fdt, offset, sphb);
> -}
> -
> -/* create OF node for pci device and required OF DT properties */
> -static int spapr_create_pci_child_dt(SpaprPhbState *phb, PCIDevice *dev,
> -                                     void *fdt, int node_offset)
> -{
> -    int offset;
> -    const gchar *basename;
> -    char *nodename;
> -    int slot = PCI_SLOT(dev->devfn);
> -    int func = PCI_FUNC(dev->devfn);
> -    uint32_t ccode = pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> -
> -    basename = dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8) & 0xff,
> -                                  ccode & 0xff);
> -
> -    if (func != 0) {
> -        nodename = g_strdup_printf("%s@%x,%x", basename, slot, func);
> -    } else {
> -        nodename = g_strdup_printf("%s@%x", basename, slot);
> -    }
> -
> -    _FDT(offset = fdt_add_subnode(fdt, node_offset, nodename));
> -
> -    g_free(nodename);
> -
> -    spapr_populate_pci_child_dt(dev, fdt, offset, phb);
>  
>      return offset;
>  }
> @@ -1393,7 +1384,7 @@ int spapr_pci_dt_populate(SpaprDrc *drc, SpaprMachineState *spapr,
>      SpaprPhbState *sphb = SPAPR_PCI_HOST_BRIDGE(plug_handler);
>      PCIDevice *pdev = PCI_DEVICE(drc->dev);
>  
> -    *fdt_start_offset = spapr_create_pci_child_dt(sphb, pdev, fdt, 0);
> +    *fdt_start_offset = spapr_dt_pci_device(sphb, pdev, fdt, 0);
>      return 0;
>  }
>  
> @@ -2086,7 +2077,7 @@ static void spapr_populate_pci_devices_dt(PCIBus *bus, PCIDevice *pdev,
>      int offset;
>      SpaprFdt s_fdt;
>  
> -    offset = spapr_create_pci_child_dt(p->sphb, pdev, p->fdt, p->node_off);
> +    offset = spapr_dt_pci_device(p->sphb, pdev, p->fdt, p->node_off);
>      if (!offset) {
>          error_report("Failed to create pci child device tree node");
>          return;


