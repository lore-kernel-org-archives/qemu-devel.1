Received: from eggs.gnu.org ([2001:4830:134:3::10]:43209)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIeU9-0001eK-80
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 12:43:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1eIeU4-000886-8l
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 12:43:25 -0500
Received: from 6.mo2.mail-out.ovh.net ([87.98.165.38]:38683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1eIeU4-00086p-2B
	for qemu-devel@nongnu.org; Sat, 25 Nov 2017 12:43:20 -0500
Received: from player718.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo2.mail-out.ovh.net (Postfix) with ESMTP id 2F94BCB067
	for <qemu-devel@nongnu.org>; Sat, 25 Nov 2017 18:43:18 +0100 (CET)
Date: Sat, 25 Nov 2017 18:43:03 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20171125184303.6961e772@bahia.lan>
In-Reply-To: <20171125151610.20547-5-ehabkost@redhat.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 4/6] spapr: Allow only supported dynamic
 sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Sat, 25 Nov 2017 13:16:08 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> TYPE_SPAPR_PCI_HOST_BRIDGE is the only dynamic sysbus device not
> rejected by ppc_spapr_reset(), so it can be the only entry on the
> allowed list.
> 

So we don't need the code that rejects other sysbus devices anymore, right ?
We should drop the related code then, but I guess this can be done in a 
followup patch.

Reviewed-by: Greg Kurz <groug@kaod.org>

> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Changes series v1 -> v2:
> * New patch added to series
> ---
>  hw/ppc/spapr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 82040cc5d1..3c6d6f2cea 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3603,8 +3603,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      mc->default_boot_order = "";
>      mc->default_ram_size = 512 * M_BYTE;
>      mc->kvm_type = spapr_kvm_type;
> -    /*TODO: allow only sysbus devices that really work with this machine */
> -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SPAPR_PCI_HOST_BRIDGE);
>      mc->pci_allow_0_address = true;
>      mc->get_hotplug_handler = spapr_get_hotplug_handler;
>      hc->pre_plug = spapr_machine_device_pre_plug;
