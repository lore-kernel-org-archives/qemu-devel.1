Received: from eggs.gnu.org ([2001:4830:134:3::10]:34384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXPLj-0003ho-13
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:03:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXPLf-0002FK-Vw
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:03:27 -0400
Date: Tue, 18 Jul 2017 12:03:19 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170718120319.2f54ffa5@gondolin>
In-Reply-To: <20170718115840.3017dd18@gondolin>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-12-f4bug@amsat.org>
	<20170718115840.3017dd18@gondolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 11/29] s390x/sclp: use QEMU_IS_ALIGNED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-trivial@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On Tue, 18 Jul 2017 11:58:40 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 18 Jul 2017 03:09:47 -0300
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
>=20
> > Applied using the Coccinelle semantic patch scripts/coccinelle/use_osde=
p.cocci
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > ---
> >  hw/s390x/sclp.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
> > index 9253dbbc64..0a207c7345 100644
> > --- a/hw/s390x/sclp.c
> > +++ b/hw/s390x/sclp.c
> > @@ -237,7 +237,7 @@ static void assign_storage(SCLPDevice *sclp, SCCB *=
sccb)
> >      }
> >      assign_addr =3D (assign_info->rn - 1) * mhd->rzm;
> > =20
> > -    if ((assign_addr % MEM_SECTION_SIZE =3D=3D 0) &&
> > +    if (QEMU_IS_ALIGNED(assign_addr, MEM_SECTION_SIZE) &&
> >          (assign_addr >=3D mhd->padded_ram_size)) {
> >          /* Re-use existing memory region if found */
> >          mr =3D memory_region_find(sysmem, assign_addr, 1).mr;
> > @@ -297,7 +297,7 @@ static void unassign_storage(SCLPDevice *sclp, SCCB=
 *sccb)
> >      unassign_addr =3D (assign_info->rn - 1) * mhd->rzm;
> > =20
> >      /* if the addr is a multiple of 256 MB */
> > -    if ((unassign_addr % MEM_SECTION_SIZE =3D=3D 0) &&
> > +    if (QEMU_IS_ALIGNED(unassign_addr, MEM_SECTION_SIZE) &&
> >          (unassign_addr >=3D mhd->padded_ram_size)) {
> >          mhd->standby_state_map[(unassign_addr -
> >                             mhd->padded_ram_size) / MEM_SECTION_SIZE] =
=3D 0; =20
>=20
> Acked-by: Cornelia Huck <cohuck@redhat.com>

Oh, and I assume this will go through trivial, right?
