Received: from eggs.gnu.org ([2001:4830:134:3::10]:34883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6acB-0007eS-Ei
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:42:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f6ac8-0002uy-Aq
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 07:42:07 -0400
Date: Thu, 12 Apr 2018 13:41:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180412134153.5cebdec6.cohuck@redhat.com>
In-Reply-To: <20180412093521.2469-1-david@redhat.com>
References: <20180412093521.2469-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/kvm: cleanup calls to
 cpu_synchronize_state()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On Thu, 12 Apr 2018 11:35:21 +0200
David Hildenbrand <david@redhat.com> wrote:

> We have a call to cpu_synchronize_state() on every kvm_arch_handle_exit().
> 
> Let's remove the ones that are no longer needed.
> 
> Remaining places (for s390x) are in
> - target/s390x/sigp.c, on the target CPU
> - target/s390x/cpu.c:s390_cpu_get_crash_info()
> 
> While at it, use kvm_cpu_synchronize_state() instead of
> cpu_synchronize_state() in KVM code. (suggested by Thomas Huth)
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/s390x/s390-pci-inst.c |  8 --------
>  target/s390x/kvm.c       | 20 +-------------------
>  2 files changed, 1 insertion(+), 27 deletions(-)

Nice :)

Will apply to s390-next, but would not mind some r-bs.
