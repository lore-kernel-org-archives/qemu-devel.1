Received: from eggs.gnu.org ([2001:4830:134:3::10]:53584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG6lX-0004W5-B2
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:46:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dG6lT-0000cV-FA
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:46:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dG6lT-0000cF-8O
	for qemu-devel@nongnu.org; Wed, 31 May 2017 12:46:31 -0400
Date: Wed, 31 May 2017 17:46:26 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170531164625.GD3342@work-vm>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/7] migration: s390x css migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

* Halil Pasic (pasic@linux.vnet.ibm.com) wrote:
> The scope of this patch series is now limited to decoupling channel
> subsystem migration from the migration of virtio-ccw proxies.
> 
> The vmstatifying of virtio-ccw proxies is now done by another series
> currently consisting of a single  patch running under the name 'vmstatify
> config migration for virtio-ccw'. Since this series depends on that
> patch, I have included it here too (for convenience).
> 
> The reorganization was requested by Dave.

Yes, I think that's OK now.
We've now got a clearer split and no new qemu_put_*'s

Dave

> 
> v1 --> v2:
> * Split out the vmystatify virtio-ccw part, reorganize
> * Use WITH_TMP instead of one-shot VMStateInfo's 
> 
> Halil Pasic (7):
>   s390x: vmstatify config migration for virtio-ccw
>   s390x: add helper get_machine_class
>   s390x: add css_migration_enabled to machine class
>   s390x/css: add missing css state conditionally
>   s390x/css: add ORB to SubchDev
>   s390x/css: activate ChannelSubSys migration
>   s390x/css: use SubchDev.orb
> 
>  hw/intc/s390_flic.c                |  48 ++++
>  hw/s390x/ccw-device.c              |  10 +
>  hw/s390x/ccw-device.h              |   4 +
>  hw/s390x/css.c                     | 494 +++++++++++++++++++++++++------------
>  hw/s390x/s390-virtio-ccw.c         |  58 +++--
>  hw/s390x/virtio-ccw.c              | 155 ++++++------
>  include/hw/s390x/css.h             |  17 +-
>  include/hw/s390x/s390-virtio-ccw.h |   7 +
>  include/hw/s390x/s390_flic.h       |   5 +
>  9 files changed, 544 insertions(+), 254 deletions(-)
> 
> -- 
> 2.11.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
