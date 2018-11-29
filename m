Received: from eggs.gnu.org ([2001:4830:134:3::10]:39553)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSNyQ-0003Xa-G3
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:11:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gSNyM-00019F-GL
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 10:11:26 -0500
Date: Thu, 29 Nov 2018 16:11:15 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181129161044.5b153ab0.cohuck@redhat.com>
In-Reply-To: <b56b8efd-2532-5028-d4c4-94d163104dd5@linux.ibm.com>
References: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
	<1542904555-1136-3-git-send-email-pmorel@linux.ibm.com>
	<20181129124545.18e74622.cohuck@redhat.com>
	<b56b8efd-2532-5028-d4c4-94d163104dd5@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/6] s390x/vfio: ap: Use the APdevice as
 a child of the APBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, pasic@linux.ibm.com

On Thu, 29 Nov 2018 10:02:24 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 11/29/18 6:45 AM, Cornelia Huck wrote:
> > On Thu, 22 Nov 2018 17:35:51 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

> >> diff --git a/hw/vfio/ap.c b/hw/vfio/ap.c
> >> index 65de952..94e5a1a 100644
> >> --- a/hw/vfio/ap.c
> >> +++ b/hw/vfio/ap.c
> >> @@ -35,9 +35,6 @@ typedef struct VFIOAPDevice {
> >>       VFIODevice vdev;
> >>   } VFIOAPDevice;
> >>   
> >> -#define VFIO_AP_DEVICE(obj) \
> >> -        OBJECT_CHECK(VFIOAPDevice, (obj), VFIO_AP_DEVICE_TYPE)  
> > 
> > Hm?  
> 
> I received a comment from Thomas Huth in Message ID
> <2291104a-4cbf-e4fd-3496-fa0910beb96a@redhat.com>
> that DO_UPCAST should be avoided in new code. This macro
> should probably be restored and an AP_DEVICE() macro added.

Yes, that makes sense.
