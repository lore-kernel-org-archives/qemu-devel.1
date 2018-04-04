Received: from eggs.gnu.org ([2001:4830:134:3::10]:52954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1f3Z5Y-00065l-5J
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 23:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.guo.simon@gmail.com>) id 1f3Z5X-00027K-CI
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 23:27:56 -0400
Date: Wed, 4 Apr 2018 11:27:44 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
Message-ID: <20180404032744.GA3261@simonLocalRHEL7.x64>
References: <20180320022319.17199-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320022319.17199-1-david@gibson.dropbear.id.au>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix backwards migration of
 msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: groug@kaod.org, lvivier@redhat.com, ldoktor@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

David,
On Tue, Mar 20, 2018 at 01:23:19PM +1100, David Gibson wrote:
> 21b786f "PowerPC: Add TS bits into msr_mask" added the transaction states
> to msr_mask for recent POWER CPUs to allow correct migration of machines
> that are in certain interim transactional memory states.
> 
> This was correct, but unfortunately breaks backwards of pseries-2.7 and
> earlier machine types which (stupidly) transferred the msr_mask in the
> migration stream and failed if it wasn't equal on each end.
> 
> This works around the problem by masking out the new MSR bits in the
> compatibility code to send the msr_mask on old machine types.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Sorry I didn't consider the backward compatibility in previous
commit. Thanks for fix that.

Thanks,
- Simon
