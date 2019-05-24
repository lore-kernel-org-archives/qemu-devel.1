Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D88C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:34:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FF79217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 13:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF79217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54698 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUALK-0002x2-EQ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 09:34:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hUAJk-0001gR-EO
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hUAJH-0007oq-1E
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:32:36 -0400
Received: from 8.mo4.mail-out.ovh.net ([188.165.33.112]:59243)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hUAJG-0007nj-Qd
	for qemu-devel@nongnu.org; Fri, 24 May 2019 09:32:34 -0400
Received: from player788.ha.ovh.net (unknown [10.109.159.68])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 7D6B11EE57F
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 15:32:31 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player788.ha.ovh.net (Postfix) with ESMTPSA id C3B5861CEB7B;
	Fri, 24 May 2019 13:32:23 +0000 (UTC)
Date: Fri, 24 May 2019 15:32:19 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190524153219.15b21c74@bahia.lan>
In-Reply-To: <20190523052918.1129-1-david@gibson.dropbear.id.au>
References: <20190523052918.1129-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 17468900008271649254
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudduiedgieejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.33.112
Subject: Re: [Qemu-devel] [PATCH 1/8] spapr: Clean up device node name
 generation for PCI devices
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

On Thu, 23 May 2019 15:29:11 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> spapr_populate_pci_child_dt() adds a 'name' property to the device tree
> node for PCI devices.  This is never necessary for a flattened device tree,
> it is implicit in the name added when the node is constructed.  In fact
> anything we do add to a 'name' property will be overwritten with something
> derived from the structural name in the guest firmware (but in fact it is
> exactly the same bytes).
> 
> So, remove that.  In addition, pci_get_node_name() is very simple, so fold
> it into its (also simple) sole caller spapr_create_pci_child_dt().
> 
> While we're there rename pci_find_device_name() to the shorter and more
> accurate dt_name_from_class().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  hw/ppc/spapr_pci.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 97961b0128..b2db46ef1d 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1173,8 +1173,8 @@ static const PCIClass pci_classes[] = {
>      { "data-processing-controller", spc_subclass },
>  };
>  
> -static const char *pci_find_device_name(uint8_t class, uint8_t subclass,
> -                                        uint8_t iface)
> +static const char *dt_name_from_class(uint8_t class, uint8_t subclass,
> +                                      uint8_t iface)
>  {
>      const PCIClass *pclass;
>      const PCISubClass *psubclass;
> @@ -1216,23 +1216,6 @@ static const char *pci_find_device_name(uint8_t class, uint8_t subclass,
>      return name;
>  }
>  
> -static gchar *pci_get_node_name(PCIDevice *dev)
> -{
> -    int slot = PCI_SLOT(dev->devfn);
> -    int func = PCI_FUNC(dev->devfn);
> -    uint32_t ccode = pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> -    const char *name;
> -
> -    name = pci_find_device_name((ccode >> 16) & 0xff, (ccode >> 8) & 0xff,
> -                                ccode & 0xff);
> -
> -    if (func != 0) {
> -        return g_strdup_printf("%s@%x,%x", name, slot, func);
> -    } else {
> -        return g_strdup_printf("%s@%x", name, slot);
> -    }
> -}
> -
>  static uint32_t spapr_phb_get_pci_drc_index(SpaprPhbState *phb,
>                                              PCIDevice *pdev);
>  
> @@ -1300,11 +1283,6 @@ static void spapr_populate_pci_child_dt(PCIDevice *dev, void *fdt, int offset,
>          _FDT(fdt_setprop(fdt, offset, "udf-supported", NULL, 0));
>      }
>  
> -    _FDT(fdt_setprop_string(fdt, offset, "name",
> -                            pci_find_device_name((ccode >> 16) & 0xff,
> -                                                 (ccode >> 8) & 0xff,
> -                                                 ccode & 0xff)));
> -
>      buf = spapr_phb_get_loc_code(sphb, dev);
>      _FDT(fdt_setprop_string(fdt, offset, "ibm,loc-code", buf));
>      g_free(buf);
> @@ -1348,10 +1326,23 @@ static int spapr_create_pci_child_dt(SpaprPhbState *phb, PCIDevice *dev,
>                                       void *fdt, int node_offset)
>  {
>      int offset;
> -    gchar *nodename;
> +    const gchar *basename;
> +    char *nodename;

Not sure why you're changing nodename to be a char * instead of a gchar * ...

Apart from that, LGTM.

Reviewed-by: Greg Kurz <groug@kaod.org>

> +    int slot = PCI_SLOT(dev->devfn);
> +    int func = PCI_FUNC(dev->devfn);
> +    uint32_t ccode = pci_default_read_config(dev, PCI_CLASS_PROG, 3);
> +
> +    basename = dt_name_from_class((ccode >> 16) & 0xff, (ccode >> 8) & 0xff,
> +                                  ccode & 0xff);
> +
> +    if (func != 0) {
> +        nodename = g_strdup_printf("%s@%x,%x", basename, slot, func);
> +    } else {
> +        nodename = g_strdup_printf("%s@%x", basename, slot);
> +    }
>  
> -    nodename = pci_get_node_name(dev);
>      _FDT(offset = fdt_add_subnode(fdt, node_offset, nodename));
> +
>      g_free(nodename);
>  
>      spapr_populate_pci_child_dt(dev, fdt, offset, phb);


