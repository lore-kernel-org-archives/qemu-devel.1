Received: from eggs.gnu.org ([2001:4830:134:3::10]:54458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eKJfk-0003Xl-8z
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eKJfg-0006mh-9n
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 02:54:16 -0500
References: <20171129162219.16288-1-mallachiev@ispras.ru>
	<20171129162219.16288-2-mallachiev@ispras.ru>
	<20171130035841.GT3023@umbus.fritz.box>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <34c1ac48-0fe4-dd44-7dd8-c49bb0e510a3@redhat.com>
Date: Thu, 30 Nov 2017 08:54:06 +0100
MIME-Version: 1.0
In-Reply-To: <20171130035841.GT3023@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] target-ppc: Don't invalidate
 non-supported msr bits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Kurban Mallachiev <mallachiev@ispras.ru>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On 30/11/2017 04:58, David Gibson wrote:
> On Wed, Nov 29, 2017 at 07:22:19PM +0300, Kurban Mallachiev wrote:
>> The msr invalidation code (commits 993eb and 2360b) inverts all
>> bits except MSR_TGPR and MSR_HVB. On non PowerPC 601 processors
>> this leads to incorrect change of excp_prefix in hreg_store_msr()
>> function. The problem is that new msr value get multiplied by msr_mask
>> and inverted msr does not, thus values of MSR_EP bit in new msr value
>> and inverted msr are distinct, so that excp_prefix changes but should
>> not.
>>
>> Signed-off-by: Kurban Mallachiev <mallachiev@ispras.ru>
> 
> So, the whole logic of ppc_store_msr() / hreg_store_msr() looks much
> harier than it should be to me.  Nonetheless, this definitely looks
> like an improvement over the current code.
> 
> Applied to ppc-for-2.11.
> 
> Laurent, could this be related to the loadvm state problems you were
> seeing in several BZs?

Thank you David, I've tried and this doesn't solve my problems.

Laurent
