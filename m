Received: from eggs.gnu.org ([2001:4830:134:3::10]:50354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epCcc-0005DS-PR
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1epCcX-0002RW-PO
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 07:38:42 -0500
Date: Fri, 23 Feb 2018 13:38:23 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180223133823.238ad4a4.cohuck@redhat.com>
In-Reply-To: <20180223101919.21075-1-cohuck@redhat.com>
References: <20180223101919.21075-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x: remove s390_get_memslot_count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri, 23 Feb 2018 11:19:19 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> Not needed anymore after removal of the memory hotplug code.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  include/hw/s390x/sclp.h  | 1 -
>  target/s390x/cpu.c       | 9 ---------
>  target/s390x/cpu.h       | 4 ----
>  target/s390x/kvm-stub.c  | 5 -----
>  target/s390x/kvm.c       | 5 -----
>  target/s390x/kvm_s390x.h | 1 -
>  6 files changed, 25 deletions(-)

Queued to s390-next.
