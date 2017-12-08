Received: from eggs.gnu.org ([2001:4830:134:3::10]:56138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eNGrX-00033b-Pi
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:30:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1eNGrU-0000ME-MS
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:30:39 -0500
Received: from mga09.intel.com ([134.134.136.24]:46639)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1eNGrU-0000M0-5H
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 06:30:36 -0500
Date: Fri, 8 Dec 2017 19:29:55 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20171208112955.GC8672@yangzhon-Virtual>
References: <20171205063313.GB4102@yangzhon-Virtual>
	<20171205120623.GB31150@stefanha-x1.localdomain>
	<5f9f2835-5811-3ee0-9049-0d2cddc08958@redhat.com>
	<20171206151155.GC22757@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206151155.GC22757@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] About the light VM solution!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, pbonzini@redhat.com, rjones@redhat.com
Cc: qemu-devel@nongnu.org, berrange@redhat.com, anthony.xu@intel.com, chao.p.peng@linux.intel.com

On Wed, Dec 06, 2017 at 03:11:55PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 02:35:42PM +0100, Paolo Bonzini wrote:
> > On 05/12/2017 13:06, Stefan Hajnoczi wrote:
> > > On Tue, Dec 05, 2017 at 02:33:13PM +0800, Yang Zhong wrote:
> > Referring to your slides, the remaining points for fast boot are:
> > 
> > * parallelize VCPU initialization: do you have patches? :)
> > 
> > * q35-lite: any other machine options that have not been merged yet?
> > 
> > * SeaBIOS+Option ROM: can you take new numbers with DMA-based option
> > ROM, or with qboot?
> > 
> > * guest kernel: my proposal to make Linux a multiboot kernel has been
> > nacked upstream, but Oracle is working on supporting Xen PVH binaries in
> > QEMU.  These are very similar to multiboot and in particular they're
> > uncompressed.
> 
> By the way, sending a separate patch series for each optimization is
> good.  That way patches requiring more discussion don't hold up patches
> that could be applied immediately.  It also makes reviewing and
> understanding performance results easier since there is only one change.
> 
> Stefan

  Hello Stefan,Paolo and Richard,

  Many thanks for your detailed comments! Really thanks for your great help!

  We are talking about light VM solution with our customers firstly and want
  to know their concerns. Then we will continue to talk this on this thread.

  Richard, your paper and test script will do great help for our further work.

  I also CC PengChao and Anthony in this thread, they will join this talk.

  Regards,

  Yang 
