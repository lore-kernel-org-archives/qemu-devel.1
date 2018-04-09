Received: from eggs.gnu.org ([2001:4830:134:3::10]:34316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5QW5-0002M5-5P
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 02:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1f5QW2-0007Zz-23
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 02:43:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34344 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1f5QW1-0007Ui-Qc
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 02:42:57 -0400
References: <20180405104834.10457-1-pagupta@redhat.com>
	<20180405104834.10457-4-pagupta@redhat.com>
	<ad08ca09-71ee-08d5-3479-8b3d06380a03@redhat.com>
	<416823501.16310251.1522930166070.JavaMail.zimbra@redhat.com>
	<20180409032601.GA1648@stefanha-x1.localdomain>
From: David Hildenbrand <david@redhat.com>
Message-ID: <36218ea8-5fa8-e670-104d-616da790a333@redhat.com>
Date: Mon, 9 Apr 2018 08:42:35 +0200
MIME-Version: 1.0
In-Reply-To: <20180409032601.GA1648@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] qemu: Add virtio pmem device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Pankaj Gupta <pagupta@redhat.com>
Cc: kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, riel@surriel.com, linux-nvdimm@ml01.01.org, mst@redhat.com, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, hch@infradead.org, pbonzini@redhat.com, stefanha@redhat.com, niteshnarayanlal@hotmail.com, marcel@redhat.com, imammedo@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com

On 09.04.2018 05:26, Stefan Hajnoczi wrote:
> On Thu, Apr 05, 2018 at 08:09:26AM -0400, Pankaj Gupta wrote:
>>> Will this raw file already have the "disk information header" (no idea
>>> how that stuff is called) encoded? Are there any plans/possible ways to
>>>
>>> a) automatically create the headers? (if that's even possible)
>>
>> Its raw. Right now we are just supporting raw format.  
>>
>> As this is direct mapping of memory into guest address space, I don't
>> think we can have an abstraction of headers for block specific features.
>> Or may be we can get opinion of others(Qemu block people) it is at all possible?
> 
> memdev and the block layer are completely separate.  The block layer
> isn't designed for memory-mapped access.
> 

Not questioning if this is the right thing to do now. I was wondering if
we could expose any block device in the future as virtio-pmem. And I
think with quite some work it could be possible.

As you said, we will need some buffering. Maybe userfaultfd and friends
(WP) could allow to implement that.

> I think it makes sense to use memdev here.  If the user wants a block
> device, they should use an emulated block device, not virtio-pmem,
> because buffering is necessary anyway when an image file format is used.
> 
> Stefan
> 


-- 

Thanks,

David / dhildenb
