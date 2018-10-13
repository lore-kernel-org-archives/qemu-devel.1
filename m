Received: from eggs.gnu.org ([2001:4830:134:3::10]:39814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gBMn2-00083P-7A
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1gBMmy-0007Qo-2y
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:29:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1gBMmx-0007Kb-Rf
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 12:29:15 -0400
Date: Sat, 13 Oct 2018 12:29:12 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <2107404743.20781403.1539448152851.JavaMail.zimbra@redhat.com>
In-Reply-To: <CAPcyv4gEVxoNFUmFctSR6nRku_Pcz2GfXB+-iHBARmc+Wa+dfQ@mail.gmail.com>
References: <20181013050021.11962-1-pagupta@redhat.com>
	<CAPcyv4gEVxoNFUmFctSR6nRku_Pcz2GfXB+-iHBARmc+Wa+dfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/2] kvm "fake DAX" device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Jan Kara <jack@suse.cz>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, Rik van Riel <riel@surriel.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, David Hildenbrand <david@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Qemu Developers <qemu-devel@nongnu.org>, Christoph Hellwig <hch@infradead.org>, Vishal L Verma <vishal.l.verma@intel.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, zwisler@kernel.org, lcapitulino@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>


> >
> >  This patch series has implementation for "fake DAX".
> >  "fake DAX" is fake persistent memory(nvdimm) in guest
> >  which allows to bypass the guest page cache. This also
> >  implements a VIRTIO based asynchronous flush mechanism.
> 
> Can we stop calling this 'fake DAX', because it isn't 'DAX' and it's
> starting to confuse people. This enabling is effectively a
> host-page-cache-passthrough mechanism not DAX. Let's call the whole
> approach virtio-pmem, and leave DAX out of the name to hopefully
> prevent people from wondering why some DAX features are disabled with
> this driver. For example MAP_SYNC is not compatible with this
> approach.

Sure. I got your point. I will use "virtio-pmem" in future.  

> 
> Additional enabling is need to disable MAP_SYNC in the presence of a
> virtio-pmem device. See the rough proposal here:
> 
>     https://lkml.org/lkml/2018/4/25/756

Yes, I will handle disabling of MAP_SYNC for this use-case.


Thanks,
Pankaj
