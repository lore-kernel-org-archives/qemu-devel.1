Received: from eggs.gnu.org ([2001:4830:134:3::10]:59653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fUxnR-0004co-6U
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:18:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fUxnL-0008Q0-EH
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:18:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43748 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fUxnL-0008N6-9E
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:18:23 -0400
Date: Mon, 18 Jun 2018 20:18:16 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180618201612-mutt-send-email-mst@kernel.org>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180613180508.GD24764@localhost.localdomain>
	<20180614080948.GF6355@redhat.com>
	<20180615025056.GB7451@localhost.localdomain>
	<20180615090314.GA31552@redhat.com>
	<20180618171431.GK7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618171431.GK7451@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH RFC] hw/pc: set q35 as the default x86
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, libvir-list@redhat.com

On Mon, Jun 18, 2018 at 02:14:31PM -0300, Eduardo Habkost wrote:
> > Sure if someone does that, we'll have no choice, but as long as 'pc' is
> > shipped we shouldn't gratuitously break apps by changing the default.
> 
> Right.  I just want to make sure "omitting the machine-type may
> stop working in the future" is documented somehow.

I still think we should just add links to the qemu binary and
use ARGV to detect the machine type.

qemu-pc-i386
qemu-q35-x86_64

etc.

> -- 
> Eduardo
