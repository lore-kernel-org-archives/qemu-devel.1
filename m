Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26602C04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F235F208C3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 08:18:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F235F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQ6Ab-0004Qq-T0
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 04:18:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hQ690-0003Dn-DV
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:17:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hQ5uq-0001Mk-ID
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:02:33 -0400
Received: from 13.mo7.mail-out.ovh.net ([87.98.150.175]:48679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hQ5up-0001Ky-Uw
	for qemu-devel@nongnu.org; Mon, 13 May 2019 04:02:32 -0400
Received: from player772.ha.ovh.net (unknown [10.109.146.168])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id C6F8C110CDE
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:02:19 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player772.ha.ovh.net (Postfix) with ESMTPSA id E08C35A67086;
	Mon, 13 May 2019 08:02:10 +0000 (UTC)
Date: Mon, 13 May 2019 10:02:09 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190513100209.630b14b5@bahia.lan>
In-Reply-To: <20190513061939.3464-6-david@gibson.dropbear.id.au>
References: <20190513061939.3464-1-david@gibson.dropbear.id.au>
	<20190513061939.3464-6-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2633198407628659174
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrleefgdduvdegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 87.98.150.175
Subject: Re: [Qemu-devel] [PATCH v4 5/5] pci: Fold pci_get_bus_devfn() into
 its sole caller
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
Cc: mst@redhat.com, aik@ozlabs.ru,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 May 2019 16:19:39 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> The only remaining caller of pci_get_bus_devfn() is pci_nic_init_nofail(),
> itself an old compatibility function.  Fold the two together to avoid
> re-using the stale interface.
> 
> While we're there replace the explicit fprintf()s with error_report().
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/pci/pci.c | 60 ++++++++++++++++++++++++----------------------------
>  1 file changed, 28 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index 7e5f8d001b..d3893bdfe1 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -723,37 +723,6 @@ static int pci_parse_devaddr(const char *addr, int *domp, int *busp,
>      return 0;
>  }
>  
> -static PCIBus *pci_get_bus_devfn(int *devfnp, PCIBus *root,
> -                                 const char *devaddr)
> -{
> -    int dom, bus;
> -    unsigned slot;
> -
> -    if (!root) {
> -        fprintf(stderr, "No primary PCI bus\n");
> -        return NULL;
> -    }
> -
> -    assert(!root->parent_dev);
> -
> -    if (!devaddr) {
> -        *devfnp = -1;
> -        return pci_find_bus_nr(root, 0);
> -    }
> -
> -    if (pci_parse_devaddr(devaddr, &dom, &bus, &slot, NULL) < 0) {
> -        return NULL;
> -    }
> -
> -    if (dom != 0) {
> -        fprintf(stderr, "No support for non-zero PCI domains\n");
> -        return NULL;
> -    }
> -
> -    *devfnp = PCI_DEVFN(slot, 0);
> -    return pci_find_bus_nr(root, bus);
> -}
> -
>  static void pci_init_cmask(PCIDevice *dev)
>  {
>      pci_set_word(dev->cmask + PCI_VENDOR_ID, 0xffff);
> @@ -1895,6 +1864,8 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>      DeviceState *dev;
>      int devfn;
>      int i;
> +    int dom, busnr;
> +    unsigned slot;
>  
>      if (nd->model && !strcmp(nd->model, "virtio")) {
>          g_free(nd->model);
> @@ -1928,7 +1899,32 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
>          exit(1);
>      }
>  
> -    bus = pci_get_bus_devfn(&devfn, rootbus, devaddr);
> +    if (!rootbus) {
> +        error_report("No primary PCI bus");
> +        exit(1);
> +    }
> +
> +    assert(!rootbus->parent_dev);
> +
> +    if (!devaddr) {
> +        devfn = -1;
> +        busnr = 0;
> +    } else {
> +        if (pci_parse_devaddr(devaddr, &dom, &busnr, &slot, NULL) < 0) {
> +            error_report("Invalid PCI device address %s for device %s",
> +                         devaddr, nd->model);
> +            exit(1);
> +        }
> +
> +        if (dom != 0) {
> +            error_report("No support for non-zero PCI domains");
> +            exit(1);
> +        }
> +
> +        devfn = PCI_DEVFN(slot, 0);
> +    }
> +
> +    bus = pci_find_bus_nr(rootbus, busnr);
>      if (!bus) {
>          error_report("Invalid PCI device address %s for device %s",
>                       devaddr, nd->model);


