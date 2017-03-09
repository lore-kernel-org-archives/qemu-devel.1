Received: from eggs.gnu.org ([2001:4830:134:3::10]:53119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clvzK-0003I6-2L
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:12:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1clvzG-0004wE-Ti
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:12:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1clvzG-0004w6-N8
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 06:12:02 -0500
References: <1488876478-6889-1-git-send-email-jasowang@redhat.com>
	<20170307111618.43ffbd13.cornelia.huck@de.ibm.com>
	<cb84b888-4917-162d-31a5-f708f4783444@redhat.com>
	<20170308101922.730b1579.cornelia.huck@de.ibm.com>
	<64df071f-27b0-9ee6-0b76-d8fa7a9cc8ec@redhat.com>
	<20170308111214.591b49fe.cornelia.huck@de.ibm.com>
	<a8f854b2-bbd3-1665-0b09-2abcad928b9d@redhat.com>
	<20170309120734.390a7cda.cornelia.huck@de.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5de53ca5-ecd2-033e-17fb-6ecb2875dd5d@redhat.com>
Date: Thu, 9 Mar 2017 12:12:00 +0100
MIME-Version: 1.0
In-Reply-To: <20170309120734.390a7cda.cornelia.huck@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio: destroy region cache during reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com



On 09/03/2017 12:07, Cornelia Huck wrote:
>>> - Driver #2 uses the device without doing a reset or proper setup
>> Without this patch, even if driver #2 do a reset, it can still use the 
>> old map if it don't set queue pfn.
> 
> Yes, the cleanup-on-reset is definetly needed.

It is good to have for defensiveness, but it would still cause a
segfault so we should also add the checks on vq->vring.desc throughout.

Paolo
