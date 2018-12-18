Received: from eggs.gnu.org ([2001:4830:134:3::10]:54829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZJ6K-0001af-Rf
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:24:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gZJ6I-0002VV-4k
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 12:24:12 -0500
Date: Tue, 18 Dec 2018 18:24:00 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181218182400.6305b061.cohuck@redhat.com>
In-Reply-To: <d3442c5d-06e9-d87a-3bc3-903f40b0cedf@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-2-cohuck@redhat.com>
	<d3442c5d-06e9-d87a-3bc3-903f40b0cedf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] vfio-ccw: add capabilities chain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Mon, 17 Dec 2018 16:53:34 -0500
Eric Farman <farman@linux.ibm.com> wrote:

> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> 
> ...snip...
> 
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 813102810f53..565669f95534 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -297,6 +297,7 @@ struct vfio_region_info_cap_type {
> >   
> >   #define VFIO_REGION_TYPE_PCI_VENDOR_TYPE	(1 << 31)
> >   #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
> > +#define VFIO_REGION_TYPE_CCW			(1 << 30)  
> 
> Oof.  So the existing VFIO_REGION_TYPE_PCI_VENDOR_TYPE gets OR'd with 
> another value (e.g., 8086).  But in 4.20, there was a 
> VFIO_REGION_TYPE_GFX is added as simply "1" ... Which direction are 
> these definitions being added from?  I guess asked another way, is 
> _TYPE_CCW going to be OR'd with anything else that necessitates its 
> presence as an identifier with some Other Thing, or should this follow 
> the TYPE_GFX enumeration?  Perhaps the type field needs to be tidied up 
> to help this sit more cleanly now?  (Sorry!)

The semantics of that type stuff are really a bit unclear to me :(

I don't think we'll ever do any fancy mask handling for ccw. It is
probably enough to have any kind of uniqueness within the different
types, so maybe counting up would be indeed enough...

> 
>   - Eric
> 
> >   
> >   /* 8086 Vendor sub-types */
> >   #define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
> >   
> 
