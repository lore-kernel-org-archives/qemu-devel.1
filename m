Received: from eggs.gnu.org ([2001:4830:134:3::10]:51915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTnGX-0006Hw-Jk
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:51:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fTnGU-0008OR-HN
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:51:41 -0400
Date: Fri, 15 Jun 2018 13:51:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180615135134.05f1e018@redhat.com>
In-Reply-To: <20180615112500.19854-3-david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
	<20180615112500.19854-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/12] pc: rename
 pc_dimm_(plug|unplug|...)* into pc_memory_(plug|unplug|...)*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Fri, 15 Jun 2018 13:24:50 +0200
David Hildenbrand <david@redhat.com> wrote:

> Use a similar naming scheme as spapr. This way, we can go ahead and
> rename e.g. pc_dimm_memory_plug to pc_dimm_plug_plug, which avoids
                                     ^^^^^ typo?

> confusion.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/i386/pc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 622e49d6bc..f9250ffae7 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -1674,8 +1674,8 @@ void ioapic_init_gsi(GSIState *gsi_state, const char *parent_name)
>      }
>  }
>  
> -static void pc_dimm_plug(HotplugHandler *hotplug_dev,
> -                         DeviceState *dev, Error **errp)
> +static void pc_memory_plug(HotplugHandler *hotplug_dev,
> +                           DeviceState *dev, Error **errp)
>  {
>      HotplugHandlerClass *hhc;
>      Error *local_err = NULL;
> @@ -1728,8 +1728,8 @@ out:
>      error_propagate(errp, local_err);
>  }
>  
> -static void pc_dimm_unplug_request(HotplugHandler *hotplug_dev,
> -                                   DeviceState *dev, Error **errp)
> +static void pc_memory_unplug_request(HotplugHandler *hotplug_dev,
> +                                     DeviceState *dev, Error **errp)
>  {
>      HotplugHandlerClass *hhc;
>      Error *local_err = NULL;
> @@ -1759,8 +1759,8 @@ out:
>      error_propagate(errp, local_err);
>  }
>  
> -static void pc_dimm_unplug(HotplugHandler *hotplug_dev,
> -                           DeviceState *dev, Error **errp)
> +static void pc_memory_unplug(HotplugHandler *hotplug_dev,
> +                             DeviceState *dev, Error **errp)
>  {
>      PCMachineState *pcms = PC_MACHINE(hotplug_dev);
>      HotplugHandlerClass *hhc;
> @@ -2015,7 +2015,7 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
>                                        DeviceState *dev, Error **errp)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_plug(hotplug_dev, dev, errp);
> +        pc_memory_plug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_plug(hotplug_dev, dev, errp);
>      }
> @@ -2025,7 +2025,7 @@ static void pc_machine_device_unplug_request_cb(HotplugHandler *hotplug_dev,
>                                                  DeviceState *dev, Error **errp)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_unplug_request(hotplug_dev, dev, errp);
> +        pc_memory_unplug_request(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_request_cb(hotplug_dev, dev, errp);
>      } else {
> @@ -2038,7 +2038,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>                                          DeviceState *dev, Error **errp)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
> -        pc_dimm_unplug(hotplug_dev, dev, errp);
> +        pc_memory_unplug(hotplug_dev, dev, errp);
>      } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
>          pc_cpu_unplug_cb(hotplug_dev, dev, errp);
>      } else {
