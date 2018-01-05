Received: from eggs.gnu.org ([2001:4830:134:3::10]:47933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=536b6079c=anthony.perard@citrix.com>)
	id 1eXSjA-00055F-JD
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=536b6079c=anthony.perard@citrix.com>)
	id 1eXSj7-0001HC-Bz
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:12:08 -0500
Received: from smtp02.citrix.com ([66.165.176.63]:62897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=536b6079c=anthony.perard@citrix.com>)
	id 1eXSj7-0001GI-3H
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 09:12:05 -0500
Date: Fri, 5 Jan 2018 14:12:01 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20180105141201.GC1905@perard.uk.xensource.com>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-6-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20171125151610.20547-6-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] xen: Add only xen-sysdev to dynamic
 sysbus device list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, xen-devel@lists.xenproject.org

On Sat, Nov 25, 2017 at 01:16:09PM -0200, Eduardo Habkost wrote:
> There's no need to make the machine allow every possible sysbus
> device.  We can now just add xen-sysdev to the allowed list.
> 
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: Anthony Perard <anthony.perard@citrix.com>
> Cc: xen-devel@lists.xenproject.org
> Cc: Juergen Gross <jgross@suse.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

I've tested the patch series with every hotplug things I could think of,
and it worked fine.

Acked-by: Anthony PERARD <anthony.perard@citrix.com>

> ---
> Changes series v1 -> v2:
> * New patch added to series
> ---
>  hw/xen/xen_backend.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
> index 82380ea9ee..7445b506ac 100644
> --- a/hw/xen/xen_backend.c
> +++ b/hw/xen/xen_backend.c
> @@ -564,12 +564,7 @@ static void xen_set_dynamic_sysbus(void)
>      ObjectClass *oc = object_get_class(machine);
>      MachineClass *mc = MACHINE_CLASS(oc);
>  
> -    /*
> -     * Emulate old mc->has_dynamic_sysbus=true assignment
> -     *
> -     *TODO: add only Xen devices to the list
> -     */
> -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_XENSYSDEV);
>  }
>  
>  int xen_be_register(const char *type, struct XenDevOps *ops)

-- 
Anthony PERARD
