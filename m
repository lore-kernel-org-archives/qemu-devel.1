Received: from eggs.gnu.org ([2001:4830:134:3::10]:46529)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<BATV+c96c7f713f0eb2402da4+5171+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e5Zoz-0003XI-Nt
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<BATV+c96c7f713f0eb2402da4+5171+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e5Zov-0007W7-Pb
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:06:53 -0400
Received: from bombadil.infradead.org ([65.50.211.133]:43618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<BATV+c96c7f713f0eb2402da4+5171+infradead.org+hch@bombadil.srs.infradead.org>)
	id 1e5Zov-0007Vm-I0
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 12:06:49 -0400
Date: Fri, 20 Oct 2017 09:06:44 -0700
From: Christoph Hellwig <hch@infradead.org>
Message-ID: <20171020160644.GA27946@infradead.org>
References: <20171017071633.GA9207@infradead.org>
	<1441791227.21027037.1508226056893.JavaMail.zimbra@redhat.com>
	<20171017080236.GA27649@infradead.org>
	<670833322.21037148.1508229041158.JavaMail.zimbra@redhat.com>
	<20171018130339.GB29767@stefanha-x1.localdomain>
	<CAPcyv4h6aFkyHhh4R4DTznbSCLf9CuBoszk0Q1gB5EKNcp_SeQ@mail.gmail.com>
	<20171019080149.GB10089@infradead.org>
	<CAPcyv4j=Cdp68C15HddKaErpve2UGRfSTiL6bHiS=3gQybz9pg@mail.gmail.com>
	<20171020080049.GA25471@infradead.org>
	<CAPcyv4hHjCpm4AnLz2SdtjNMasV182Cw-jA+Cv9DjmE1Fa26kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hHjCpm4AnLz2SdtjNMasV182Cw-jA+Cv9DjmE1Fa26kA@mail.gmail.com>
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
Cc: Christoph Hellwig <hch@infradead.org>, Kevin Wolf <kwolf@redhat.com>, Jan Kara <jack@suse.cz>, xiaoguangrong eric <xiaoguangrong.eric@gmail.com>, KVM list <kvm@vger.kernel.org>, Pankaj Gupta <pagupta@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, David Hildenbrand <david@redhat.com>, ross zwisler <ross.zwisler@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Qemu Developers <qemu-devel@nongnu.org>, Linux MM <linux-mm@kvack.org>, Stefan Hajnoczi <stefanha@redhat.com>, linux-nvdimm <linux-nvdimm@ml01.01.org>, Paolo Bonzini <pbonzini@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>

On Fri, Oct 20, 2017 at 08:05:09AM -0700, Dan Williams wrote:
> Right, that's the same recommendation I gave.
> 
>     https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg08404.html
> 
> ...so maybe I'm misunderstanding your concern? It sounds like we're on
> the same page.

Yes, the above is exactly what I think we should do it.  And in many
ways virtio seems overkill if we could just have a hypercall or doorbell
page as the queueing infrastructure in virtio shouldn't really be
needed.
