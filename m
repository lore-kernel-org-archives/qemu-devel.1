Received: from eggs.gnu.org ([2001:4830:134:3::10]:37020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgU1a-00062Q-2e
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:19:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cgU1W-0004Gp-0o
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:19:54 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:32854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cgU1V-0004Fw-Po
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 05:19:49 -0500
Received: by mail-wr0-x243.google.com with SMTP id s27so882829wrb.0
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 02:19:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20170221185901.3256-1-stefanha@redhat.com>
	<20170221185901.3256-3-stefanha@redhat.com>
	<20170222101653.4df25bc4.cornelia.huck@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7b0cb2d-8987-9fe9-e294-a517981453ef@redhat.com>
Date: Wed, 22 Feb 2017 11:19:45 +0100
MIME-Version: 1.0
In-Reply-To: <20170222101653.4df25bc4.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/2] virtio: add missing region cache init
 in virtio_load()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>



On 22/02/2017 10:16, Cornelia Huck wrote:
>> +
>> +            /* All ring addresses have been loaded now... */
>> +            virtio_init_region_cache(vdev, i);
> It feels a bit weird that the region cache was already initialized when
> update rings was called. Should the call to init_region_cache be moved
> from update_rings() to virtio_queue_set_addr()?

virtio_queue_set_addr isn't called at all, is it?

The alternative would be to call virtio_init_region_cache from a
postload callback of vmstate_virtqueue, but Stefan's patch is fine too IMHO.

Paolo
