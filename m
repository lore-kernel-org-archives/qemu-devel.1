Received: from eggs.gnu.org ([2001:4830:134:3::10]:56810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fE8Wp-0002ud-G0
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:19:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fE8Wl-0005iU-DI
	for qemu-devel@nongnu.org; Thu, 03 May 2018 03:19:47 -0400
References: <20180503071037.31834-1-david@gibson.dropbear.id.au>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2bd5d47b-5561-fa4a-4277-6ef026ff8749@redhat.com>
Date: Thu, 3 May 2018 09:19:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180503071037.31834-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] spapr: Remove support for explicitly
 allocated RMAs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org
Cc: lvivier@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 03.05.2018 09:10, David Gibson wrote:
> Current POWER cpus allow for a VRMA, a special mapping which describes a
> guest's view of memory when in real mode (MMU off, from the guest's point
> of view).  Older cpus didn't have that which meant that to support a guest
> a special host-contiguous region of memory was needed to give the guest its
> Real Mode Area (RMA).
> 
> KVM used to provide special calls to allocate a contiguous RMA for those
> cases.  This was useful in the early days of KVM on Power to allow it to be
> tested on PowerPC 970 chips as used in Macintosh G5 machines.  Now, those
> machines are so old as to be almost irrelevant.

I still got my YDL PowerStation somewhere in a corner ... but well,
true, I haven't turned on its power since a year or two... or three...

> The normal qemu deprecation process would require this to be marked
> deprecated then removed in 2 releases.  However, this can only be used
> with corresponding support in the host kernel - which was dropped
> years ago (in c17b98cf "KVM: PPC: Book3S HV: Remove code for PPC970
> processors" of 2014-12-03 to be precise).  Therefore it should be ok
> to drop this immediately.

OK, fair.

> Just to be clear this only affects *KVM* guests with PowerPC 970, and those
> already require an ancient host kernel.  TCG guests with PowerPC 970 should
> still work.

Just to be sure: kvm-pr will continue to work on a 970 host, right? In
that case:

Acked-by: Thomas Huth <thuth@redhat.com>
