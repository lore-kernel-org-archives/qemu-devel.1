Received: from eggs.gnu.org ([2001:4830:134:3::10]:41801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dde4o-00018m-NT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dde4m-0001oR-Rr
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:59:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dde4m-0001mK-Mx
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:59:44 -0400
Date: Fri, 4 Aug 2017 16:59:34 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170804165934.4d6fb98f@gondolin>
In-Reply-To: <20170804112946.5247-1-cohuck@redhat.com>
References: <20170804112946.5247-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Greg Kurz <groug@kaod.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

On Fri,  4 Aug 2017 13:29:37 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Next version, not so many changes from v3.
> 
> As you might have guessed, the goals are still the same:
> - Being able to disable PCI support in a build completely.
> - Properly fencing off PCI if the relevant facility bit is not provided.
> 
> Changes v3->v4:
> - introduce pci_available boolean
> - use pci_available to fence off setting the zcpi facility bit
> - collected tags
> 
> Branch is still git://github.com/cohuck/qemu no-zpci-cpumodel

make check on a build with pci disabled revealed an interesting
inconsistency: We create a virtio-9p-ccw device, but the base
virtio-9p-device is in code that is not built for !pci.

If I remove the pci dependency for hw/9pfs/ and fsdev/, things look
fine (at least on s390x). We probably need a different dependency,
though.

virtio-9p maintainers, any suggestions?
