Received: from eggs.gnu.org ([2001:4830:134:3::10]:58128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egqg9-0001Oi-Vv
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 06:35:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1egqg4-000574-2o
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 06:35:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55994)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1egqg3-000557-TW
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 06:35:44 -0500
Date: Wed, 31 Jan 2018 12:35:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180131123533.52c47971.cohuck@redhat.com>
In-Reply-To: <20180130094715.11578-3-zyimin@linux.vnet.ibm.com>
References: <20180130094715.11578-1-zyimin@linux.vnet.ibm.com>
	<20180130094715.11578-3-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/3] s390x/pci: fixup global refresh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alex.williamson@redhat.com, marcel@redhat.com

On Tue, 30 Jan 2018 10:47:14 +0100
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> The VFIO common code doesn't provide the possibility to modify a
> previous mapping entry in another way than unmapping and mapping again
> with new properties.

I'm wondering why other architectures don't need that. Is this
refreshing an unique ability on s390 (due to that instruction)?

> 
> To avoid -EEXIST DMA mapping error, this we introduce a GHashTable to

s/this//

> store S390IOTLBEntry instances in order to cache the mapped entries.
> When intercepting rpcit instruction, ignore the identical mapped
> entries to avoid doing map operations multiple times and do unmap and
> re-map operations for the case of updating the valid entries. To
> achieve that goal, we also export the DMA walking function and
> optimize the code handling errors in rpcit handler.

How often does such a thing happen in practice?

> 
> Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> ---
>  hw/s390x/s390-pci-bus.c  | 28 +++++++++-----
>  hw/s390x/s390-pci-bus.h  |  3 ++
>  hw/s390x/s390-pci-inst.c | 95 ++++++++++++++++++++++++++++++++++--------------
>  3 files changed, 90 insertions(+), 36 deletions(-)

Can't really review the rest due to -ENODOC, sorry.
