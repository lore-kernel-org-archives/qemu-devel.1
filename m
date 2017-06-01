Received: from eggs.gnu.org ([2001:4830:134:3::10]:47397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOdi-00038D-Ik
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dGOde-0005MJ-Lx
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:51:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dGOde-0005M5-CK
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 07:51:38 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v51BnKHE083192
	for <qemu-devel@nongnu.org>; Thu, 1 Jun 2017 07:51:37 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2atdc0g4n8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 01 Jun 2017 07:51:36 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Thu, 1 Jun 2017 12:51:34 +0100
Date: Thu, 1 Jun 2017 13:51:29 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
References: <20170529135520.101429-1-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170601135129.5d482c7c.cornelia.huck@de.ibm.com>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org

On Mon, 29 May 2017 15:55:13 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The scope of this patch series is now limited to decoupling channel
> subsystem migration from the migration of virtio-ccw proxies.
> 
> The vmstatifying of virtio-ccw proxies is now done by another series
> currently consisting of a single  patch running under the name 'vmstatify
> config migration for virtio-ccw'. Since this series depends on that
> patch, I have included it here too (for convenience).
> 
> The reorganization was requested by Dave.
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

This patch set looks good to me, just some comments on the individual
patches.
