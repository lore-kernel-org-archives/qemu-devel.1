Received: from eggs.gnu.org ([2001:4830:134:3::10]:55352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePTSR-00065c-An
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePTSO-0004s7-5G
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:21:51 -0500
Date: Thu, 14 Dec 2017 14:21:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171214142138.3a5c9eef.cohuck@redhat.com>
In-Reply-To: <20171211122146.162430-1-borntraeger@de.ibm.com>
References: <20171211122146.162430-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 1/1] s390-ccw-virtio: allow for systems
 larger that 7.999TB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>

On Mon, 11 Dec 2017 13:21:46 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
> limiting the memory per slot to 8TB-4k. As memory slots on s390/kvm must
> be a multiple of 1MB we need start a new memory region if we cross
> 8TB-1M.
> 
> With that (and optimistic overcommitment in the kernel) I was able to
> start a 24TB guest on a 1TB system.
> 
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  hw/s390x/s390-virtio-ccw.c | 28 +++++++++++++++++++++++++---
>  1 file changed, 25 insertions(+), 3 deletions(-)

Thanks, applied (with 1UL -> 1ULL).
