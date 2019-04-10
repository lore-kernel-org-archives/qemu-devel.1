Received: from eggs.gnu.org ([209.51.188.92]:45830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEEGu-0004f2-OT
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hEEGt-00087R-Ls
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:32:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hEEGt-00086o-BT
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 10:32:15 -0400
Date: Wed, 10 Apr 2019 16:31:39 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190410163139.4a04175e.cohuck@redhat.com>
In-Reply-To: <127904196.20807948.1554904981681.JavaMail.zimbra@redhat.com>
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-3-pagupta@redhat.com>
	<20190410091216-mutt-send-email-mst@kernel.org>
	<127904196.20807948.1554904981681.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/5] virtio-pmem: Add virtio pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, jack@suse.cz, kvm@vger.kernel.org, david@redhat.com, jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, adilger kernel <adilger.kernel@dilger.ca>, zwisler@kernel.org, aarcange@redhat.com, dave jiang <dave.jiang@intel.com>, linux-nvdimm@lists.01.org, vishal l verma <vishal.l.verma@intel.com>, willy@infradead.org, hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com, linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl, riel@surriel.com, yuval shaia <yuval.shaia@oracle.com>, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, darrick wong <darrick.wong@oracle.com>, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, imammedo@redhat.com

On Wed, 10 Apr 2019 10:03:01 -0400 (EDT)
Pankaj Gupta <pagupta@redhat.com> wrote:

> > 
> > On Wed, Apr 10, 2019 at 09:38:22AM +0530, Pankaj Gupta wrote:  
> > > This patch adds virtio-pmem driver for KVM guest.
> > > 
> > > Guest reads the persistent memory range information from
> > > Qemu over VIRTIO and registers it on nvdimm_bus. It also
> > > creates a nd_region object with the persistent memory
> > > range information so that existing 'nvdimm/pmem' driver
> > > can reserve this into system memory map. This way
> > > 'virtio-pmem' driver uses existing functionality of pmem
> > > driver to register persistent memory compatible for DAX
> > > capable filesystems.
> > > 
> > > This also provides function to perform guest flush over
> > > VIRTIO from 'pmem' driver when userspace performs flush
> > > on DAX memory range.
> > > 
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>

> > > diff --git a/include/uapi/linux/virtio_ids.h
> > > b/include/uapi/linux/virtio_ids.h
> > > index 6d5c3b2d4f4d..346389565ac1 100644
> > > --- a/include/uapi/linux/virtio_ids.h
> > > +++ b/include/uapi/linux/virtio_ids.h
> > > @@ -43,5 +43,6 @@
> > >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> > >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> > >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > > +#define VIRTIO_ID_PMEM         25 /* virtio pmem */
> > >  
> > >  #endif /* _LINUX_VIRTIO_IDS_H */  
> > 
> > Didn't Paolo point out someone is using 25 for audio?  
> 
> 
> Sorry! I did not notice this.
> 
> > 
> > Please, reserve an ID with the Virtio TC before using it.  
> 
> I thought I requested[1] ID 25.
> 
> [1] https://github.com/oasis-tcs/virtio-spec/issues/38
> [2] https://lists.oasis-open.org/archives/virtio-dev/201805/threads.html
> 
> In that case I will send request for next available ID i.e 26?

Have the folks using this for audio sent a reservation request as well?
If not, I'd say the first requester should get the id...

(And yes, we need to be quicker with voting on/applying id
reservations :/)
