Received: from eggs.gnu.org ([2001:4830:134:3::10]:33839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8oWC-0000O0-3q
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:57:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1f8oWB-0005FJ-1I
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:57:08 -0400
Date: Wed, 18 Apr 2018 11:56:03 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180418145603.GN29865@localhost.localdomain>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
	<1524061685-83305-4-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524061685-83305-4-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.13 v2 3/5] pc: simplify
 MachineClass::get_hotplug_handler handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, mst@redhat.com

On Wed, Apr 18, 2018 at 04:28:03PM +0200, Igor Mammedov wrote:
> By default MachineClass::get_hotplug_handler is NULL and concrete board
> should set it to it's own handler.
> Considering there isn't any default handler, drop saving empty
> MachineClass::get_hotplug_handler in child class and make PC code
> consistent with spapr/s390x boards.
> 
> We can bring this back when actual usecase surfaces and do it
> consistently across boards that use get_hotplug_handler().
> 
> Suggested-by: David Gibson <david@gibson.dropbear.id.au>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>


[...]
> @@ -2344,7 +2341,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
>      HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
>      NMIClass *nc = NMI_CLASS(oc);
>  
> -    pcmc->get_hotplug_handler = mc->get_hotplug_handler;

What about assert(!mc->get_hotplug_handler) just before
overwriting it?

-- 
Eduardo
