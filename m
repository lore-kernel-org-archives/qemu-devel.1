Received: from eggs.gnu.org ([2001:4830:134:3::10]:53214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaHRp-00025x-0P
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:50:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gaHRl-0002SC-PW
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:50:24 -0500
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:37516)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gaHRl-0002RI-Gp
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 04:50:21 -0500
Received: from player756.ha.ovh.net (unknown [10.109.143.220])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id DC53720C412
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 10:50:19 +0100 (CET)
Date: Fri, 21 Dec 2018 10:50:00 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181221105000.3cedaa41@bahia.lan>
In-Reply-To: <cd3bad6c-ff0d-41ea-6619-bff313e585e9@kaod.org>
References: <154535246529.862554.6113740443866753456.stgit@bahia.lan>
	<154535261366.862554.2330587135163596442.stgit@bahia.lan>
	<cd3bad6c-ff0d-41ea-6619-bff313e585e9@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/15] spapr_pci: Define SPAPR_MAX_PHBS in
 hw/pci-host/spapr.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Alexey Kardashevskiy <aik@ozlabs.ru>, Michael Roth <mdroth@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>

On Fri, 21 Dec 2018 09:03:49 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 12/21/18 1:36 AM, Greg Kurz wrote:
> > PHB hotplug will bring more users for it. Let's define it along with
> > the PHB defines from which it is derived for simplicity.
> >=20
> > While here fix a misleading comment about manual placement, which was
> > abandoned with 30b3bc5aa9f4.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org> =20
>=20
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> > ---
> >  hw/ppc/spapr.c              |    2 --
> >  include/hw/pci-host/spapr.h |    6 ++++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 621006eaa862..fe3f9829ae6c 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3838,8 +3838,6 @@ static void spapr_phb_placement(sPAPRMachineState=
 *spapr, uint32_t index,
> >       * 1TiB 64-bit MMIO windows for each PHB.
> >       */
> >      const uint64_t base_buid =3D 0x800000020000000ULL;
> > -#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
> > -                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
> >      int i;
> > =20
> >      /* Sanity check natural alignments */
> > diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
> > index 9d2ec1a410e8..83d5075a6ef3 100644
> > --- a/include/hw/pci-host/spapr.h
> > +++ b/include/hw/pci-host/spapr.h
> > @@ -94,11 +94,13 @@ struct sPAPRPHBState {
> >      ((1ULL << 32) - SPAPR_PCI_MEM_WIN_BUS_OFFSET)
> >  #define SPAPR_PCI_MEM64_WIN_SIZE     0x10000000000ULL /* 1 TiB */
> > =20
> > -/* Without manual configuration, all PCI outbound windows will be
> > - * within this range */
> > +/* All PCI outbound windows will be within this range */
> >  #define SPAPR_PCI_BASE               (1ULL << 45) /* 32 TiB */
> >  #define SPAPR_PCI_LIMIT              (1ULL << 46) /* 64 TiB */
> > =20
> > +#define SPAPR_MAX_PHBS ((SPAPR_PCI_LIMIT - SPAPR_PCI_BASE) / \
> > +                        SPAPR_PCI_MEM64_WIN_SIZE - 1)
> > + =20
>=20
> Which is 32. Good, this is in sync with the IRQ number ranges.
>=20
> C.
>=20

Yeah 32 * 4 LSIs fit well in the 0x1200-0x127f range :)

> >  #define SPAPR_PCI_2_7_MMIO_WIN_SIZE  0xf80000000
> >  #define SPAPR_PCI_IO_WIN_SIZE        0x10000
> > =20
> >  =20
>=20
