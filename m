Received: from eggs.gnu.org ([2001:4830:134:3::10]:41335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVguQ-0001BS-4F
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:28:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fVguL-0001mk-80
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:28:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fVguL-0001mO-1v
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 13:28:37 -0400
Date: Wed, 20 Jun 2018 14:28:24 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180620172824.GS7451@localhost.localdomain>
References: <20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180613180508.GD24764@localhost.localdomain>
	<20180614080948.GF6355@redhat.com>
	<20180615025056.GB7451@localhost.localdomain>
	<20180615090314.GA31552@redhat.com>
	<20180618171431.GK7451@localhost.localdomain>
	<20180618201612-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618201612-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, libvir-list@redhat.com

On Mon, Jun 18, 2018 at 08:18:16PM +0300, Michael S. Tsirkin wrote:
> On Mon, Jun 18, 2018 at 02:14:31PM -0300, Eduardo Habkost wrote:
> > > Sure if someone does that, we'll have no choice, but as long as 'pc' is
> > > shipped we shouldn't gratuitously break apps by changing the default.
> > 
> > Right.  I just want to make sure "omitting the machine-type may
> > stop working in the future" is documented somehow.
> 
> I still think we should just add links to the qemu binary and
> use ARGV to detect the machine type.
> 
> qemu-pc-i386
> qemu-q35-x86_64

Why having separate QEMU binaries would help?  We still need to
define and document what will happen when both the machine-type
and the QEMU binary are omitted in the domain XML.

Personally I prefer to document this as "we recommend you always
specify the machine-type" instead of "we recommend you always
specify the QEMU binary path".

-- 
Eduardo
