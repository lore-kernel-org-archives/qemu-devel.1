Received: from eggs.gnu.org ([2001:4830:134:3::10]:53714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=1917c8cdb=Paul.Durrant@citrix.com>)
	id 1cWLVT-0003aN-6Q
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:12:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=1917c8cdb=Paul.Durrant@citrix.com>)
	id 1cWLVP-0007gE-Ai
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:12:51 -0500
Received: from smtp.eu.citrix.com ([185.25.65.24]:30629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=1917c8cdb=Paul.Durrant@citrix.com>)
	id 1cWLVP-0007fR-0b
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 06:12:47 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 25 Jan 2017 11:12:44 +0000
Message-ID: <92f11755b66845d091204a424cad9ed4@AMSPEX02CL03.citrite.net>
References: <1485266747-4694-1-git-send-email-paul.durrant@citrix.com>
	<1485266747-4694-3-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1701241520050.10192@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1701241520050.10192@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 2/3] xen-platform: add support for
 unplugging NVMe disks...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "olaf@aepfle.de" <olaf@aepfle.de>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 24 January 2017 23:49
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> Stabellini <sstabellini@kernel.org>; Anthony Perard
> <anthony.perard@citrix.com>; Michael S. Tsirkin <mst@redhat.com>; Paolo
> Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>;
> Eduardo Habkost <ehabkost@redhat.com>; olaf@aepfle.de
> Subject: Re: [PATCH v2 2/3] xen-platform: add support for unplugging NVMe
> disks...
>=20
> On Tue, 24 Jan 2017, Paul Durrant wrote:
> > ...not just IDE and SCSI.
> >
> > This patch allows the Xen tool-stack to fully support of NVMe as an
> > emulated disk type.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> Please update docs/misc/hvm-emulated-unplug.markdown in the Xen
> repository first. It might be also worth clarifying that `1` actually
> means all disks, not just IDE disks. Then, please add a reference to
> that commit in the description of this patch.
>

Patch posted to remove 'IDE' from the documentation for value '1'. Awaiting=
 ack.

  Paul=20
=20
>=20
> > ---
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/i386/xen/xen_platform.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
> > index f50915f..7d41ebb 100644
> > --- a/hw/i386/xen/xen_platform.c
> > +++ b/hw/i386/xen/xen_platform.c
> > @@ -120,6 +120,7 @@ static void unplug_disks(PCIBus *b, PCIDevice *d,
> void *o)
> >          break;
> >
> >      case PCI_CLASS_STORAGE_SCSI:
> > +    case PCI_CLASS_STORAGE_EXPRESS:
> >          object_unparent(OBJECT(d));
> >          break;
> >
> > --
> > 2.1.4
> >
