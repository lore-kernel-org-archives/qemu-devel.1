Received: from eggs.gnu.org ([2001:4830:134:3::10]:37530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzNNu-0006fR-TN
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzNNp-0003ce-WC
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 09:37:18 -0400
Date: Tue, 3 Oct 2017 10:37:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171003133705.GH17385@localhost.localdomain>
References: <20170929140540.13766-1-otubo@redhat.com>
	<20170929193139.GB17385@localhost.localdomain>
	<9c365c30-8b63-f762-aa56-5b952b491aec@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c365c30-8b63-f762-aa56-5b952b491aec@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv2] dma/i82374: avoid double creation of
 i82374 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Otubo <otubo@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>

On Mon, Oct 02, 2017 at 02:50:07PM +0200, Paolo Bonzini wrote:
> On 29/09/2017 21:31, Eduardo Habkost wrote:
> >> -void DMA_init(ISABus *bus, int high_page_enable)
> >> +void DMA_init(ISABus *bus, int high_page_enable, Error **errp)
> > 
> > If you make the function return a boolean to indicate success (in
> > addition to setting *errp), you avoid the need for a local_err
> > variable on the caller.
> 
> I think in this case, rather than a bool, it would be better to return 0
> or -EBUSY.  A check for "< 0" would be more self-explanatory in the caller.

I'm OK with that, too.

We really need to document the available and preferred error
reporting styles somewhere (probably on qapi/error.h).  We
discussed that a lot recently[1], but the conclusions were not
documented anywhere.

[1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg461702.html

-- 
Eduardo
