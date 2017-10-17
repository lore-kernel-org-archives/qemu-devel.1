Received: from eggs.gnu.org ([2001:4830:134:3::10]:43607)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+60eda6e2277543397899+5168+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e4M80-0007qC-Vq
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:17:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+60eda6e2277543397899+5168+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e4M7Y-0006Mz-3J
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:17:28 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:60541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+60eda6e2277543397899+5168+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e4M7X-0005vt-Pj
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 03:16:59 -0400
Date: Tue, 17 Oct 2017 00:16:33 -0700
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20171017071633.GA9207@infradead.org>
References: <20171012155027.3277-1-pagupta@redhat.com>
	<20171012155027.3277-3-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171012155027.3277-3-pagupta@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2/2] KVM: add virtio-pmem driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pankaj Gupta <pagupta@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-nvdimm@ml01.01.org, linux-mm@kvack.org, jack@suse.cz, stefanha@redhat.com, dan.j.williams@intel.com, riel@redhat.com, haozhong.zhang@intel.com, nilal@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, ross.zwisler@intel.com, david@redhat.com, xiaoguangrong.eric@gmail.com

I think this driver is at entirely the wrong level.

If you want to expose pmem to a guest with flushing assist do it
as pmem, and not a block driver.
