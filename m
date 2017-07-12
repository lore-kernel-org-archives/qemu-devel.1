Received: from eggs.gnu.org ([2001:4830:134:3::10]:42183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVH5p-0008GX-Bj
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dVH5o-0004Ml-JT
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48154)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dVH5o-0004MB-DQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 08:50:12 -0400
Date: Wed, 12 Jul 2017 13:50:01 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170712125001.GC30658@work-vm>
References: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711145441.33925-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] migration: s390x css migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> Like for v2 the scope of this patch series is now limited to decoupling
> channel subsystem migration from the migration of virtio-ccw proxies.
> 
> There wasn't a whole lot of criticism regarding v2, so very little
> changed since then. All issues identified in the previous round were
> addressed as agreed upon. I hope this series is now good for 2.10.
> 
> @Dave You helped me quite a lot with these, thanks a lot! I could not
> find any r-b's or similar form you so if you would like to take the
> well deserved credit for your work...

No problem, as long as we've got a happy migration that's enough,
and we've finally got VMSTATE_QTAILQ used as well.

Dave

> v2 --> v3:
> * rebased onto current master, since 's390x: vmstatify config migration
>   for virtio-ccw' is already there we don't need it here any more
> * added ack's and r-b'
> * got rid of loads of nits (thanks Connie and Thomas)
> * added explanation why certain members are not migrated
> 
> v1 --> v2:
> * Split out the vmystatify virtio-ccw part, reorganize
> * Use WITH_TMP instead of one-shot VMStateInfo's
> 
> Halil Pasic (6):
>   s390x: add helper get_machine_class
>   s390x: add css_migration_enabled to machine class
>   s390x/css: add missing css state conditionally
>   s390x/css: add ORB to SubchDev
>   s390x/css: activate ChannelSubSys migration
>   s390x/css: use SubchDev.orb
> 
>  hw/intc/s390_flic.c                |  20 ++++++
>  hw/s390x/css.c                     | 144 +++++++++++++++++++++++++++++++++----
>  hw/s390x/s390-virtio-ccw.c         |  58 +++++++++------
>  include/hw/s390x/css.h             |  11 ++-
>  include/hw/s390x/s390-virtio-ccw.h |   7 ++
>  5 files changed, 199 insertions(+), 41 deletions(-)
> 
> -- 
> 2.11.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
