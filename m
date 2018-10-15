Received: from eggs.gnu.org ([2001:4830:134:3::10]:59006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gC0pb-0006MY-Mv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:14:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gC0pY-0000nN-Eg
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 07:14:39 -0400
References: <20181012032431.32693-1-david@gibson.dropbear.id.au>
	<20181012032431.32693-2-david@gibson.dropbear.id.au>
	<20181012140306-mutt-send-email-mst@kernel.org>
	<996ed901-14b6-7461-a094-771a715cd6b2@redhat.com>
	<20181015063430-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <899a7b64-93d0-5636-d15b-c71a250b8a9e@redhat.com>
Date: Mon, 15 Oct 2018 13:14:25 +0200
MIME-Version: 1.0
In-Reply-To: <20181015063430-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/5] virtio-balloon: Remove unnecessary
 MADV_WILLNEED on deflate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, dhildenb@redhat.com, imammedo@redhat.com, ehabkost@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org


>> (And "Expect access in the near future." does not sound like guarantees
>> to me either way)
> 
> Should we be concerned about impact on performance though?

Yes, it really depends on the use case (and most of the time, the memory
won't be directly reused). Let's document it in the commit log just as
you suggest.

> 
> Thinking aloud it might have an impact.  But there is also a benefit.
> Let's document known effects so people know what to look for
> if they see issues?
> 
> 	WILLNEED aggressively faults all memory in, removing it
> 	will cause just as much memory as needed to be allocated on access,
> 	slowing down the CPU at that point but conserving host memory.
> 
> 	With this patch device assignment (e.g. with VFIO) hotplug will take longer
> 	as it needs to allocate all this memory on hotplug.
> 	While this happens all VM is paused right now.


-- 

Thanks,

David / dhildenb
