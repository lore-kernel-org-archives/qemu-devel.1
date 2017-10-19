Received: from eggs.gnu.org ([2001:4830:134:3::10]:44326)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+a28bd260a4ecf58d2edb+5170+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e55mg-0006jR-Ed
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:02:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+a28bd260a4ecf58d2edb+5170+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e55ma-0002uS-De
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:02:30 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:34019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+a28bd260a4ecf58d2edb+5170+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e55ma-0002ea-7c
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 04:02:24 -0400
Date: Thu, 19 Oct 2017 01:01:49 -0700
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20171019080149.GB10089@infradead.org>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
	<20171017071633.GA9207@infradead.org>
	<1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
	<20171017080236.GA27649@infradead.org>
	<670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
	<20171018130339.GB29767@stefanha-x1.localdomain>
	<CAPcyv4h6aFkyHhh4R4DTznbSCLf9CuBoszk0Q1gB5EKNcp_SeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4h6aFkyHhh4R4DTznbSCLf9CuBoszk0Q1gB5EKNcp_SeQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Pankaj Gupta <pagupta@redhat.com>, Christoph Hellwig <hch@infradead.org>, Kevin Wolf <kwolf@redhat.com>, haozhong zhang <haozhong.zhang@intel.com>, Jan Kara <jack@suse.cz>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, ross zwisler <ross.zwisler@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, Linux MM <linux-mm@kvack.org>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>

On Wed, Oct 18, 2017 at 08:51:37AM -0700, Dan Williams wrote:
> This use case is not "Persistent Memory". Persistent Memory is
> something you can map and make persistent with CPU instructions.
> Anything that requires a driver call is device driver managed "Shared
> Memory".

How is this any different than the existing nvdimm_flush()? If you
really care about the not driver thing it could easily be a write
to a doorbell page or a hypercall, but in the end that's just semantics.
