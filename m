Received: from eggs.gnu.org ([2001:4830:134:3::10]:50784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRdnk-000449-P4
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:53:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gRdng-0006Ar-Bw
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:53:20 -0500
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:53395)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gRdnc-0005wI-JU
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:53:14 -0500
Received: from player718.ha.ovh.net (unknown [10.109.160.46])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 936001E8F53
	for <qemu-devel@nongnu.org>; Tue, 27 Nov 2018 14:53:09 +0100 (CET)
Date: Tue, 27 Nov 2018 14:52:58 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20181127145258.606bf412@bahia.ttt.fr.ibm.com>
In-Reply-To: <2ed1d297-abd8-8d33-fb9a-f89e2bfb3cff@redhat.com>
References: <154332389387.541746.8099441653585015043.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<154332392916.541746.3772338098005086592.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
	<2ed1d297-abd8-8d33-fb9a-f89e2bfb3cff@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 3/9] ppc405_boards: use g_new(T,
 n) instead of g_malloc(sizeof(T) * n)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Tue, 27 Nov 2018 14:41:53 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 27/11/18 14:05, Greg Kurz wrote:
> > Because it is a recommended coding practice (see HACKING).
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  hw/ppc/ppc405_boards.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
> > index 3be3fe4432b4..f35b412c88dd 100644
> > --- a/hw/ppc/ppc405_boards.c
> > +++ b/hw/ppc/ppc405_boards.c
> > @@ -149,7 +149,7 @@ static void ref405ep_init(MachineState *machine)
> >      MemoryRegion *bios;
> >      MemoryRegion *sram =3D g_new(MemoryRegion, 1);
> >      ram_addr_t bdloc;
> > -    MemoryRegion *ram_memories =3D g_malloc(2 * sizeof(*ram_memories));
> > +    MemoryRegion *ram_memories =3D g_new(MemoryRegion, 2);
> >      hwaddr ram_bases[2], ram_sizes[2];
> >      target_ulong sram_size;
> >      long bios_size;
> > @@ -446,7 +446,7 @@ static void taihu_405ep_init(MachineState *machine)
> >      qemu_irq *pic;
> >      MemoryRegion *sysmem =3D get_system_memory();
> >      MemoryRegion *bios;
> > -    MemoryRegion *ram_memories =3D g_malloc(2 * sizeof(*ram_memories));
> > +    MemoryRegion *ram_memories =3D g_new(MemoryRegion, 2);
> >      MemoryRegion *ram =3D g_malloc0(sizeof(*ram)); =20
>=20
> Why not change both lines here?
>=20
>        MemoryRegion *ram =3D g_new0(MemoryRegion, 1);
>=20

Because HACKING says:

Declarations like T *v =3D g_malloc(sizeof(*v)) are acceptable, though.

but if there's a consensus on fixing these as well, I'll happily do
it :)

> >      hwaddr ram_bases[2], ram_sizes[2];
> >      long bios_size;
> >=20
> >  =20
