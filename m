Received: from eggs.gnu.org ([2001:4830:134:3::10]:36122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJzFB-0006zB-Op
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:05:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJzF8-0001AM-Ep
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:05:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eJzF8-00019R-5g
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:05:26 -0500
Date: Wed, 29 Nov 2017 08:05:19 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171129100519.GW3037@localhost.localdomain>
References: <20171127043517.22441-1-haozhong.zhang@intel.com>
	<20171127043517.22441-2-haozhong.zhang@intel.com>
	<20171128010713.GC3037@localhost.localdomain>
	<20171129003329.g562dwn233rftyty@hz-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171129003329.g562dwn233rftyty@hz-desktop>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hostmem-file: add "align" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Nov 29, 2017 at 08:33:29AM +0800, Haozhong Zhang wrote:
> On 11/27/17 23:07 -0200, Eduardo Habkost wrote:
> > On Mon, Nov 27, 2017 at 12:35:15PM +0800, Haozhong Zhang wrote:
> > > When mmap(2) the backend files, QEMU uses the host page size
> > > (getpagesize(2)) by default as the alignment of mapping address.
> > > However, some backends may require alignments different than the page
> > > size. For example, mmap a device DAX (e.g., /dev/dax0.0) on Linux
> > > kernel 4.13 to an address, which is 4K-aligned but not 2M-aligned,
> > > fails with a kernel message like
> > > 
> > > [617494.969768] dax dax0.0: qemu-system-x86: dax_mmap: fail, unaligned vma (0x7fa37c579000 - 0x7fa43c579000, 0x1fffff)
> > > 
> > > Because there is no common approach to get such alignment requirement,
> > > we add the 'align' option to 'memory-backend-file', so that users or
> > > management utils, which have enough knowledge about the backend, can
> > > specify a proper alignment via this option.
> > > 
> > > Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> > 
> > The new option needs to be documented on qemu-options.hx.
> 
> will add in the next version.

Note that there are patches on on machine-next that change the memory backend
documentation.

See:
  git://github.com/ehabkost/qemu.git machine-next
  https://github.com/ehabkost/qemu/commit/869f7f61c557a46b46e41b5e38a61551d45b6d0d

But the conflicts should be trivial to solve if you document the new option in
a separate paragraph.

-- 
Eduardo
