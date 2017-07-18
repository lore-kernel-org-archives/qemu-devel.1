Received: from eggs.gnu.org ([2001:4830:134:3::10]:53590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXOlx-0005Ib-5s
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXOlt-0003A1-48
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:26:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41492)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXOls-00039V-Ta
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 05:26:25 -0400
Date: Tue, 18 Jul 2017 11:26:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170718112619.6f455bc2@gondolin>
In-Reply-To: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] vfio-ccw bugfixs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com

On Tue, 18 Jul 2017 03:49:24 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Dear Conny,
> 
> Here we got two bugfix patches for vfio-ccw:
> - fix commit 7da624e2 which missed to initialize a new introduced
>   pointer for the vfio-ccw case
> - fix a memory allocation that used a wrong size for an irq info
>   variable
> 
> Dong Jia Shi (1):
>   vfio/ccw: fix initialization of the Object DeviceState pointer in the
>     common base-device
> 
> Jing Zhang (1):
>   vfio/ccw: allocate irq info with the right size
> 
>  hw/vfio/ccw.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks, queued to my s390-next branch.

As these are bugfixes, I'll send a pullreq next week.
