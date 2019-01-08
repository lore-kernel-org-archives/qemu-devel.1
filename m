Received: from eggs.gnu.org ([209.51.188.92]:40576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoVi-0002fV-2Y
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:21:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ggoVh-0000jS-4S
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 05:21:26 -0500
Date: Tue, 8 Jan 2019 11:21:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190108112109.41a93a75.cohuck@redhat.com>
In-Reply-To: <20190107193020.21744-4-ehabkost@redhat.com>
References: <20190107193020.21744-1-ehabkost@redhat.com>
	<20190107193020.21744-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] machine: Use shorter format for
 GlobalProperty arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org

On Mon,  7 Jan 2019 17:30:20 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> Instead of verbose arrays with 4 lines for each entry, make each
> entry take only one line.  This makes long arrays that couldn't
> fit in the screen become short and readable.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  include/hw/i386/pc.h       |  18 +-
>  hw/core/machine.c          | 338 ++++-------------
>  hw/i386/pc.c               | 720 +++++++------------------------------
>  hw/i386/pc_piix.c          | 192 ++--------
>  hw/ppc/spapr.c             |  72 +---
>  hw/s390x/s390-virtio-ccw.c |  75 +---
>  hw/xen/xen-common.c        |  18 +-
>  7 files changed, 265 insertions(+), 1168 deletions(-)
> 

(...)

> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index c737507053..811fdf913d 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c

(...)

> @@ -810,15 +798,8 @@ static void ccw_machine_2_6_class_options(MachineClass *mc)
>  {
>      S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
>      static GlobalProperty compat[] = {
> -        {
> -            .driver   = TYPE_S390_IPL,
> -            .property = "iplbext_migration",
> -            .value    = "off",
> -        }, {
> -            .driver   = TYPE_VIRTUAL_CSS_BRIDGE,
> -            .property = "css_dev_path",
> -            .value    = "off",
> -        },
> +        { TYPE_S390_IPL, "iplbext_migration", "off", },
> +         { TYPE_VIRTUAL_CSS_BRIDGE, "css_dev_path", "off", },

The indentation looks off here.

>      };
>  
>      s390mc->ri_allowed = false;

(...)

With or without alignment:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
