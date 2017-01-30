Received: from eggs.gnu.org ([2001:4830:134:3::10]:53960)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=196d01cee=Paul.Durrant@citrix.com>)
	id 1cY7g6-0001Tp-Tg
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=196d01cee=Paul.Durrant@citrix.com>)
	id 1cY7g3-00078n-Ra
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:51:10 -0500
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:59562
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=196d01cee=Paul.Durrant@citrix.com>)
	id 1cY7g3-00072O-Ib
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 03:51:07 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 30 Jan 2017 08:51:01 +0000
Message-ID: <39438b53d7ab43e7b57a91b39938bd6c@AMSPEX02CL03.citrite.net>
References: <1485423445-12302-1-git-send-email-paul.durrant@citrix.com>
	<1485423445-12302-3-git-send-email-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1701271533580.2884@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1701271533580.2884@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 2/3] xen-platform: add support for
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
	Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 27 January 2017 23:35
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> Stabellini <sstabellini@kernel.org>; Anthony Perard
> <anthony.perard@citrix.com>; Michael S. Tsirkin <mst@redhat.com>; Paolo
> Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>;
> Eduardo Habkost <ehabkost@redhat.com>
> Subject: Re: [PATCH v3 2/3] xen-platform: add support for unplugging NVMe
> disks...
>=20
> On Thu, 26 Jan 2017, Paul Durrant wrote:
> > ...not just IDE and SCSI.
> >
> > This patch allows the Xen tool-stack to fully support of NVMe as an
> > emulated disk type. See [1] for the relevant tool-stack patch discussio=
n.
> >
> > [1] https://lists.xen.org/archives/html/xen-devel/2017-01/msg01225.html
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
>=20
> I queued the whole series. FYI I am waiting for another patch to fix a
> regression before sending a pull request.
>=20

Cool. Thanks Stefano.

  Paul

>=20
> > Cc: Stefano Stabellini <sstabellini@kernel.org>
> > Cc: Anthony Perard <anthony.perard@citrix.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Eduardo Habkost <ehabkost@redhat.com>
> >
> > v3:
> > - Add reference to xen-devel patch discussion in commit message as
> >   requested by Stefano.
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
