Received: from eggs.gnu.org ([2001:4830:134:3::10]:54525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNDy-0001Pf-Rl
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:28:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciNDy-0002PI-4H
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:28:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciNDx-0002P4-U1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 10:28:30 -0500
References: <baa954b4-53fc-2b4e-b79c-917ba9171a60@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <267193a6-dc5c-db4c-e0eb-3b5723727114@redhat.com>
Date: Mon, 27 Feb 2017 16:28:26 +0100
MIME-Version: 1.0
In-Reply-To: <baa954b4-53fc-2b4e-b79c-917ba9171a60@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] segfault use VRingMemoryRegionCaches for avail and
 used ring vs num-queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>



On 27/02/2017 15:09, Christian Borntraeger wrote:
> Paolo,
> 
> commit 97cd965c070152bc626c7507df9fb356bbe1cd81
> "virtio: use VRingMemoryRegionCaches for avail and used rings"
> does cause a segfault on my s390 system when I use num-queues.

I've sent a patch for this already:
[PATCH] virtio: check for vring setup in virtio_queue_empty

Paolo
