Received: from eggs.gnu.org ([2001:4830:134:3::10]:49298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eMDUM-0007Q7-0q
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eMDUG-0004cf-GR
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:42:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58756)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eMDUG-0004cE-AS
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:42:16 -0500
Date: Tue, 5 Dec 2017 21:42:07 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171205134207.GD31705@lemon>
References: <20171129084628.12336-1-david@gibson.dropbear.id.au>
	<151194617493.816.13426298875361921541@bafd83ae6430>
	<20171129091847.GC12220@lemon>
	<20171205064753-mutt-send-email-mst@kernel.org>
	<20171205050558.GA31705@lemon>
	<20171205051151.GF3057@umbus.fritz.box>
	<20171205064635.GB31705@lemon>
	<20171205130636.GN3057@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171205130636.GN3057@umbus.fritz.box>
Subject: Re: [Qemu-devel] [for-2.12 0/7] PCI cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, marcel@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com

On Wed, 12/06 00:06, David Gibson wrote:
> > > Another approach would be to have a "known good" build that runs every
> > > so often.  If the known good build fails, the bot disables itself (and
> > > tells you to investigate).  Obviously there are ways that could not
> > > work as well, but it should catch a fair range of spurious failures.
> > 
> > Interesting idea, yes. A slightly simplified way is to test the "base" of the
> > series and only report errors if the base can pass.
> 
> Right.  I think that would catch even more cases, but means doing the
> "base" build every time, which might slow things down significantly.

Every time when a test on topic branch failed, but not necessarily when it
passed, which is not that bad.

Fam
