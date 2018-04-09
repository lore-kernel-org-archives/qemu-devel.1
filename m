Received: from eggs.gnu.org ([2001:4830:134:3::10]:36116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5W1Y-0007XI-1G
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 08:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5W1U-0000R2-Va
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 08:35:52 -0400
Date: Mon, 9 Apr 2018 14:35:41 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180409143541.5b2bc2d8.cohuck@redhat.com>
In-Reply-To: <20180409113019.14568-1-david@redhat.com>
References: <20180409113019.14568-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 0/2] s390x/kvm: last minute
 fixes
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

On Mon,  9 Apr 2018 13:30:17 +0200
David Hildenbrand <david@redhat.com> wrote:

> Patch 1 only applies to old KVM instances without the virtual memory access
> IOCTL in KVM.
> 
> Patch 2 could be problematic when toggling PER in a restart interrupt.
> Watchpoint recomputation only applies to TCG.
> 
> David Hildenbrand (2):
>   s390x/mmu: don't overwrite pending exception in mmu translate
>   s390x: load_psw() should only exchange the PSW for KVM
> 
>  target/s390x/helper.c     | 10 ++++++----
>  target/s390x/mmu_helper.c |  2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 

Thanks, queued to s390-fixes.
