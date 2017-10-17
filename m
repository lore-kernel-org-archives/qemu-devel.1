Received: from eggs.gnu.org ([2001:4830:134:3::10]:32850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e4NH0-0006S5-If
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e4NGx-00022L-GP
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:30:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1e4NGx-000223-AG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 04:30:47 -0400
Date: Tue, 17 Oct 2017 04:30:41 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171017080236.GA27649@infradead.org>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171017071633.GA9207@infradead.org>
	<1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
	<20171017080236.GA27649@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoph Hellwig <hch@infradead.org>
Cc: kwolf@redhat.com, haozhong zhang <haozhong.zhang@intel.com>, jack@suse.cz, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, kvm@vger.kernel.org, david@redhat.com, linux-nvdimm@ml01.01.org, ross zwisler <ross.zwisler@intel.com>, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, linux-mm@kvack.org, stefanha@redhat.com, pbonzini@redhat.com, dan j williams <dan.j.williams@intel.com>, nilal@redhat.com


> > Are you saying do it as existing i.e ACPI pmem like interface?
> > The reason we have created this new driver is exiting pmem driver
> > does not define proper semantics for guest flushing requests.
> 
> At this point I'm caring about the Linux-internal interface, and
> for that it should be integrated into the nvdimm subsystem and not
> a block driver.  How the host <-> guest interface looks is a different
> idea.
> 
> > 
> > Regarding block support of driver, we want to achieve DAX support
> > to bypass guest page cache. Also, we want to utilize existing DAX
> > capable file-system interfaces(e.g fsync) from userspace file API's
> > to trigger the host side flush request.
> 
> Well, if you want to support XFS+DAX better don't make it a block
> devices, because I'll post patches soon to stop using the block device
> entirely for the DAX case.

o.k I will look at your patches once they are in mailing list.
Thanks for the heads up.

If I am guessing it right, we don't need block device additional features
for pmem? We can bypass block device features like blk device cache flush etc.
Also, still we would be supporting ext4 & XFS filesystem with pmem?

If there is time to your patches can you please elaborate on this a bit.

Thanks,
Pankaj
