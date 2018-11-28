Received: from eggs.gnu.org ([2001:4830:134:3::10]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRvbj-0003iF-D7
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gRvPG-0005Tb-Lx
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:41:17 -0500
Date: Wed, 28 Nov 2018 09:41:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181128094107.70996fde.cohuck@redhat.com>
In-Reply-To: <d7084481-b638-e128-eb91-49911882e39e@linux.ibm.com>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<d7084481-b638-e128-eb91-49911882e39e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] vfio-ccw: add handling for asnyc
 channel instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>

On Tue, 27 Nov 2018 14:57:31 -0500
Farhan Ali <alifm@linux.ibm.com> wrote:

> On 11/22/2018 11:54 AM, Cornelia Huck wrote:
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 565669f95534..c01472ec77ea 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -304,6 +304,7 @@ struct vfio_region_info_cap_type {
> >   #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
> >   #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
> >   
> > +  
> 
> Whitespace error?

Probably crept in while I was looking for a home for the #define below.
Removed.

> 
> >   #define VFIO_REGION_TYPE_GFX                    (1)
> >   #define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
> >   
> > @@ -354,6 +355,9 @@ struct vfio_region_gfx_edid {
> >   #define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
> >   };
> >   
> > +/* ccw sub-types */
> > +#define VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD	(1)
> > +  
> 
