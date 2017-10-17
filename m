Received: from eggs.gnu.org ([2001:4830:134:3::10]:50794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e4MUw-0004Wy-IG
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:41:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pagupta@redhat.com>) id 1e4MUs-0004Gk-L4
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:41:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:63531)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pagupta@redhat.com>) id 1e4MUs-0004GD-Ex
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:41:06 -0400
Date: Tue, 17 Oct 2017 03:40:56 -0400 (EDT)
From: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
In-Reply-To: <20171017071633.GA9207@infradead.org>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171017071633.GA9207@infradead.org>
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


> 
> I think this driver is at entirely the wrong level.
> 
> If you want to expose pmem to a guest with flushing assist do it
> as pmem, and not a block driver.

Are you saying do it as existing i.e ACPI pmem like interface?
The reason we have created this new driver is exiting pmem driver
does not define proper semantics for guest flushing requests.

Regarding block support of driver, we want to achieve DAX support
to bypass guest page cache. Also, we want to utilize existing DAX
capable file-system interfaces(e.g fsync) from userspace file API's
to trigger the host side flush request.

Below link has details of previous discussion:
https://marc.info/?l=kvm&m=150091133700361&w=2

Thanks,
Pankaj  
