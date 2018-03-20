Received: from eggs.gnu.org ([2001:4830:134:3::10]:59268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eyCKQ-0004Se-VT
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 04:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eyCKM-00079f-7v
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 04:09:06 -0400
References: <20180320022319.17199-1-david@gibson.dropbear.id.au>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <7f2928ef-14a7-c431-028f-41597c5fda66@redhat.com>
Date: Tue, 20 Mar 2018 09:08:58 +0100
MIME-Version: 1.0
In-Reply-To: <20180320022319.17199-1-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org, wei.guo.simon@gmail.com
Cc: ldoktor@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 20/03/2018 03:23, David Gibson wrote:
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
> ---
>  target/ppc/machine.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
