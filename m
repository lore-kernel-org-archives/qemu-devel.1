Received: from eggs.gnu.org ([2001:4830:134:3::10]:49182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRD0W-00040s-Tw
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fRD0T-00045Q-Qp
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:44:28 -0400
Date: Fri, 8 Jun 2018 10:44:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180608104416.6704577d@redhat.com>
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
Cc: qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Greg Kurz <groug@kaod.org>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On Thu,  7 Jun 2018 18:52:15 +0200
David Hildenbrand <david@redhat.com> wrote:

> We'll be handling unplug of e.g. CPUs and PCDIMMs  via the general
> hotplug handler soon, so let's add that handler function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
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
