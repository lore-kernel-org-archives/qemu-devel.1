Received: from eggs.gnu.org ([2001:4830:134:3::10]:50682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eWNFj-0000yz-Qp
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <willy@infradead.org>) id 1eWNFf-0001lh-4n
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:09:15 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:49051)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <willy@infradead.org>) id 1eWNFe-0001k9-R7
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 09:09:11 -0500
Date: Tue, 2 Jan 2018 06:09:06 -0800
From: Matthew Wilcox <willy@infradead.org>
Message-ID: <20180102140906.GC8222@bombadil.infradead.org>
References: <1513823406-43632-1-git-send-email-wei.w.wang@intel.com>
	<20171221210327.GB25009@bombadil.infradead.org>
	<5A3CC707.9070708@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A3CC707.9070708@intel.com>
Subject: Re: [Qemu-devel] [PATCH v20 3/7 RESEND] xbitmap: add more operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, linux-mm@kvack.org, mst@redhat.com, mhocko@kernel.org, akpm@linux-foundation.org, mawilcox@microsoft.com, penguin-kernel@I-love.SAKURA.ne.jp

On Fri, Dec 22, 2017 at 04:49:11PM +0800, Wei Wang wrote:
> Thanks for the improvement. I also found a small bug in xb_zero. With the
> following changes, it has passed the current test cases and tested with the
> virtio-balloon usage without any issue.

Thanks; I applied the change.  Can you supply a test-case for testing
xb_zero please?

> > @@ -25,8 +26,11 @@ idr-test: idr-test.o $(CORE_OFILES)
> >   multiorder: multiorder.o $(CORE_OFILES)
> > +xbitmap: xbitmap.o $(CORE_OFILES)
> > +	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o xbitmap
> > +
> 
> I think the "$(CC).." line should be removed, which will fix the build error
> when adding "xbitmap" to TARGET.

Not sure what build error you're talking about, but yes that CC line
should go.  Thanks, deleted.
