Received: from eggs.gnu.org ([2001:4830:134:3::10]:42922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1cfq9v-0006zt-L2
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:45:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1cfq9s-0005wA-I4
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:45:51 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34929)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1cfq9s-0005w3-Dh
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:45:48 -0500
Received: by mail-qk0-x243.google.com with SMTP id n127so3807056qkf.2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 07:45:48 -0800 (PST)
Date: Mon, 20 Feb 2017 10:45:46 -0500
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20170220154546.GA25159@morn.lan>
References: <cover.1487286467.git.ben@skyportsystems.com>
	<20170220155752.32892bc3@nial.brq.redhat.com>
	<6ad09d32-8d26-3f55-3922-a913275fc9d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ad09d32-8d26-3f55-3922-a913275fc9d1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/8] Add support for VM Generation ID
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, ben@skyportsystems.com, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, mst@redhat.com

On Mon, Feb 20, 2017 at 04:41:38PM +0100, Laszlo Ersek wrote:
> On 02/20/17 15:57, Igor Mammedov wrote:
> > On Thu, 16 Feb 2017 15:15:32 -0800
> > ben@skyportsystems.com wrote:
> > 
> >> From: Ben Warren <ben@skyportsystems.com>
> >>
> >> This patch set adds support for passing a GUID to Windows guests.  It is a
> >> re-implementation of previous patch sets written by Igor Mammedov et al, but
> >> this time passing the GUID data as a fw_cfg blob.
> >>
> >> This patch set has dependencies on new guest functionality, in particular the
> >> support for a new linker-loader command and the ability to write back data
> >> to QEMU over a DMA link.  Work is in flight in both SeaBIOS and OVMF to support this.
> >>
> >> v7->v8:
> >>     - Rebased to top of tree.
> >>     - Fixed two small bugs in "write pointer" function
> >>     - minor re-ordering of data in patches
> >>     - Fixed unit test by adding delays/retries to reading RSDP table
> > Michael,
> > 
> > series looks good for merging.
> > Patch
> >  [PATCH v8 7/8] tests: Add unit tests for the VM  Generation ID feature
> > needs updated seabios blob to make 'make check' happy
> > so we probably should merge/update seabios first
> >   [PATCH v5 0/5] QEMU: Add capability to write back fw_cfg address to QEMU
> > 
> > CCing Gerd and Kevin.
> > 
> 
> That's sort of a circular dependency, as Kevin generally prefers to
> merge SeaBIOS patches once the underlying QEMU code has been committed :)
> 
> For a total ordering, all QEMU patches except v8 7/8 could be merged in
> QEMU, then the v5 SeaBIOS patches could be merged, then Gerd could
> refresh the bundled SeaBIOS binaries, then QEMU patch v8 7/8 could be
> merged.
> 
> I'm not actually suggesting that though, given that the soft freeze is
> in about a week.
> 
> Kevin, can you please make an exception this time and merge the SeaBIOS
> patches ahead of the QEMU patches?

Yes.

Gerd - are you planning to backport this series to the stable branch?

-Kevin
