Received: from eggs.gnu.org ([2001:4830:134:3::10]:59543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWSJ2-0001Ce-M9
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cWSIy-0004NI-93
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:28:28 -0500
Received: from mail.kernel.org ([198.145.29.136]:42750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cWSIx-0004Mr-Vj
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 13:28:24 -0500
Date: Wed, 25 Jan 2017 10:28:19 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <wcjxhmvd59ytc41igo0k68g2.1485368517410@email.android.com>
Message-ID: <alpine.DEB.2.10.1701251027560.2693@sstabellini-ThinkPad-X260>
References: <wcjxhmvd59ytc41igo0k68g2.1485368517410@email.android.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, xen-devel <xen-devel@lists.xenproject.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "olaf@aepfle.de" <olaf@aepfle.de>

On Wed, 25 Jan 2017, Paul Durrant wrote:
> On 25 January 2017, at 17:54, Stefano Stabellini <sstabellini@kernel.or=
g> wrote:
>=20
> >
> >
> >On Wed, 25 Jan 2017, Paul Durrant wrote:
> >> > -----Original Message-----
> >> > From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> >> > Sent: 24 January 2017 23:49
> >> > To: Paul Durrant <Paul.Durrant@citrix.com>
> >> > Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Stefano
> >> > Stabellini <sstabellini@kernel.org>; Anthony Perard
> >> > <anthony.perard@citrix.com>; Michael S. Tsirkin <mst@redhat.com>; =
Paolo
> >> > Bonzini <pbonzini@redhat.com>; Richard Henderson <rth@twiddle.net>=
;
> >> > Eduardo Habkost <ehabkost@redhat.com>; olaf@aepfle.de
> >> > Subject: Re: [PATCH v2 2/3] xen-platform: add support for unpluggi=
ng NVMe
> >> > disks...
> >> >
> >> > On Tue, 24 Jan 2017, Paul Durrant wrote:
> >> > > ...not just IDE and SCSI.
> >> > >
> >> > > This patch allows the Xen tool-stack to fully support of NVMe as=
 an
> >> > > emulated disk type.
> >> > >
> >> > > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> >> >
> >> > Please update docs/misc/hvm-emulated-unplug.markdown in the Xen
> >> > repository first. It might be also worth clarifying that `1` actua=
lly
> >> > means all disks, not just IDE disks. Then, please add a reference =
to
> >> > that commit in the description of this patch.
> >> >
> >>
> >> Patch posted to remove 'IDE' from the documentation for value '1'. A=
waiting ack.
> >Done.
> >When you repost this patch, could you also add to the description a
> >reference to the commit that enables NVMe in QEMU with Xen? I guess it
> >is a libxl commit?
>=20
> I think there is a chicken and egg issue here. Wei wanted to ensure tha=
t QEMU is able to unplug
> NVMe drives before accepting my patch to libxl.

No problems. In that case, please add a link to the xen-devel email
thread.


> >> > > ---
> >> > > Cc: Stefano Stabellini <sstabellini@kernel.org>
> >> > > Cc: Anthony Perard <anthony.perard@citrix.com>
> >> > > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> >> > > Cc: Richard Henderson <rth@twiddle.net>
> >> > > Cc: Eduardo Habkost <ehabkost@redhat.com>
> >> > > ---
> >> > >=C2=A0 hw/i386/xen/xen_platform.c | 1 +
> >> > >=C2=A0 1 file changed, 1 insertion(+)
> >> > >
> >> > > diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platfo=
rm.c
> >> > > index f50915f..7d41ebb 100644
> >> > > --- a/hw/i386/xen/xen_platform.c
> >> > > +++ b/hw/i386/xen/xen_platform.c
> >> > > @@ -120,6 +120,7 @@ static void unplug_disks(PCIBus *b, PCIDevic=
e *d,
> >> > void *o)
> >> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> > >
> >> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case PCI_CLASS_STORAGE_SCSI:
> >> > > +=C2=A0=C2=A0=C2=A0 case PCI_CLASS_STORAGE_EXPRESS:
> >> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 object_unp=
arent(OBJECT(d));
> >> > >=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> >> > >
> >> > > --
> >> > > 2.1.4
> >> > >
> >>
> >
>=20
>=20
>=20
