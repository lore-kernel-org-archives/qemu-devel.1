Received: from eggs.gnu.org ([209.51.188.92]:37654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmcFg-0001C7-Fh
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:28:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gmcFe-0007tf-FR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:28:52 -0500
References: <20190124073626.20534-1-richardw.yang@linux.intel.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <49187963-3df7-faf6-9d7f-e4568b47cf73@vivier.eu>
Date: Thu, 24 Jan 2019 11:28:13 +0100
MIME-Version: 1.0
In-Reply-To: <20190124073626.20534-1-richardw.yang@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc.c: fix one typo in function name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>

On 24/01/2019 08:36, Wei Yang wrote:
> Rename pc_get_hotpug_handler to pc_get_hotplug_handler.
> 
> No functional change.
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> ---
>  hw/i386/pc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 115bc2825c..5317e08f60 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2059,7 +2059,7 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
>      }
>  }
>  
> -static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
> +static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
>                                               DeviceState *dev)
>  {
>      if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
> @@ -2389,7 +2389,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      pcmc->save_tsc_khz = true;
>      pcmc->linuxboot_dma_enabled = true;
>      assert(!mc->get_hotplug_handler);
> -    mc->get_hotplug_handler = pc_get_hotpug_handler;
> +    mc->get_hotplug_handler = pc_get_hotplug_handler;
>      mc->cpu_index_to_instance_props = pc_cpu_index_to_props;
>      mc->get_default_cpu_node_id = pc_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids = pc_possible_cpu_arch_ids;
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
