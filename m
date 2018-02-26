Received: from eggs.gnu.org ([2001:4830:134:3::10]:57546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqFKJ-0004Jk-7O
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:44:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eqFKG-0008Nv-5Q
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:44:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42760 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1eqFKG-0008Nn-0Y
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 04:44:04 -0500
Date: Mon, 26 Feb 2018 10:43:45 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180226094345.l4diagfxcnurln55@kamzik.brq.redhat.com>
References: <20180223215858.16987-1-wei@redhat.com>
	<20180223215858.16987-5-wei@redhat.com>
	<20180226093031.dtyixlskbawaw4tm@kamzik.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226093031.dtyixlskbawaw4tm@kamzik.brq.redhat.com>
Subject: Re: [Qemu-devel] [PATCH V5 4/4] tests: Add migration test for
 aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: peter.maydell@linaro.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On Mon, Feb 26, 2018 at 10:30:31AM +0100, Andrew Jones wrote:
> On Fri, Feb 23, 2018 at 03:58:58PM -0600, Wei Huang wrote:
> > +        /* aarch64 virt machine physical memory starts at 0x40000000, which
> > +         * is also the kernel loader base address. It should be fine to
> 
> It's not the kernel base address.
> 
> > +         * allocate & modify the test memory 1MB away.
> 
> It's only 512K away - which is still probably fine, but you
> said he found data once when reading every 4K after 1M, so
> maybe not.
>

BTW, I'd just drop this comment altogether, rather than fix it.
Or fix it, but put it in the header. The point of the header
is to avoid these addresses spreading around too much. Putting
them in comments doesn't help.

drew
