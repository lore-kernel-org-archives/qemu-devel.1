Received: from eggs.gnu.org ([2001:4830:134:3::10]:51660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDCc-0001b4-1x
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fRDCX-0002rz-5Q
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:56:58 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:42467)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fRDCW-0002qW-VN
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:56:53 -0400
Received: from player726.ha.ovh.net (unknown [10.109.120.110])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 2666918C2A
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 10:56:50 +0200 (CEST)
Date: Fri, 8 Jun 2018 10:56:32 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180608105632.20d5c723@bahia.lan>
In-Reply-To: <20180607165218.9558-6-david@redhat.com>
References: <20180607165218.9558-1-david@redhat.com>
	<20180607165218.9558-6-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/8] spapr: introduce machine unplug
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

On Thu,  7 Jun 2018 18:52:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> We'll be handling unplug of e.g. CPUs and PCDIMMs  via the general
> hotplug handler soon, so let's add that handler function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  hw/ppc/spapr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4447cb197f..bcb72d9fa7 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3586,6 +3586,11 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
>      error_propagate(errp, local_err);
>  }
>  
> +static void spapr_machine_device_unplug(HotplugHandler *hotplug_dev,
> +                                        DeviceState *dev, Error **errp)
> +{
> +}
> +
>  static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
>                                                  DeviceState *dev, Error **errp)
>  {
> @@ -3988,6 +3993,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
>      mc->get_default_cpu_node_id = spapr_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = spapr_possible_cpu_arch_ids;
>      hc->unplug_request = spapr_machine_device_unplug_request;
> +    hc->unplug = spapr_machine_device_unplug;
>  
>      smc->dr_lmb_enabled = true;
>      mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power8_v2.0");
