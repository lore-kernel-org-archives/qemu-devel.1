Received: from eggs.gnu.org ([2001:4830:134:3::10]:41876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eGWMy-0006OY-D9
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 15:39:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eGWMu-0005lV-G4
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 15:39:12 -0500
Received: from mail1.hostfission.com ([139.99.139.48]:37996)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1eGWMu-0005km-5d
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 15:39:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Nov 2017 07:39:02 +1100
From: geoff@hostfission.com
In-Reply-To: <20171115073144.14758-1-lprosek@redhat.com>
References: <20171115073144.14758-1-lprosek@redhat.com>
Message-ID: <1f8754babd990beb90c516d2973b21d3@hostfission.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] ivshmem: MSI bug fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com, marcandre.lureau@redhat.com

I just updated to the latest build and applied this patch set, now on VM 
reset the qemu crashes with the following assert:

ivshmem.c:467: ivshmem_add_kvm_msi_virq: Assertion 
`!s->msi_vectors[vector].pdev' failed.

On 2017-11-15 18:31, Ladi Prosek wrote:
> Fixes bugs in the ivshmem device implementation uncovered with the new
> Windows ivshmem driver:
> https://github.com/virtio-win/kvm-guest-drivers-windows/tree/master/ivshmem
> 
> v1->v2:
> * Patch 1 - added reproducer info to commit message (Markus)
> * Patch 2 - restructured conditionals, fixed comment formatting 
> (Markus)
> * Patch 3 - added reproducer info to commit message (Markus)
> 
> Ladi Prosek (3):
>   ivshmem: Don't update non-existent MSI routes
>   ivshmem: Always remove irqfd notifiers
>   ivshmem: Improve MSI irqfd error handling
> 
>  hw/misc/ivshmem.c | 77 
> +++++++++++++++++++++++++++++++++++++++++--------------
>  1 file changed, 58 insertions(+), 19 deletions(-)
