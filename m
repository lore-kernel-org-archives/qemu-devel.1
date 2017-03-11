Received: from eggs.gnu.org ([2001:4830:134:3::10]:40024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cmhiV-0003al-UV
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:09:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1cmhiS-00067T-PJ
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:09:55 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:38567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1cmhiS-000670-FI
	for qemu-devel@nongnu.org; Sat, 11 Mar 2017 09:09:52 -0500
Date: Sat, 11 Mar 2017 06:09:47 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20170311140946.GA1860@bombadil.infradead.org>
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-4-git-send-email-wei.w.wang@intel.com>
	<20170309141411.GZ16328@bombadil.infradead.org>
	<58C28FF8.5040403@intel.com>
	<20170310175349-mutt-send-email-mst@kernel.org>
	<20170310171143.GA16328@bombadil.infradead.org>
	<58C3E6A3.1000000@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58C3E6A3.1000000@intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 kernel 3/5] virtio-balloon:
 implementation of VIRTIO_BALLOON_F_CHUNK_TRANSFER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, Liang Li <liang.z.li@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Hildenbrand <david@redhat.com>, Liang Li <liliang324@gmail.com>

On Sat, Mar 11, 2017 at 07:59:31PM +0800, Wei Wang wrote:
> I'm thinking what if the guest needs to transfer these much physically
> continuous
> memory to host: 1GB+2MB+64KB+32KB+16KB+4KB.
> Is it going to use Six 64-bit chunks? Would it be simpler if we just
> use the 128-bit chunk format (we can drop the previous normal 64-bit
> format)?

Is that a likely thing for the guest to need to do though?  Freeing a
1GB page is much more liikely, IMO.
