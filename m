Received: from eggs.gnu.org ([2001:4830:134:3::10]:52736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dwP8k-000684-1z
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dwP8g-00005t-PA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:53:22 -0400
Received: from 4.mo173.mail-out.ovh.net ([46.105.34.219]:59905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dwP8g-0008Vf-Ik
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:53:18 -0400
Received: from player687.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 0F6D677911
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 10:53:10 +0200 (CEST)
Date: Mon, 25 Sep 2017 10:52:56 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170925105256.6b8b57ff@bahia.lan>
In-Reply-To: <30287e8a-e697-b33e-bcf0-94bf7fe291de@redhat.com>
References: <20170925083348.17126-1-clg@kaod.org>
	<30287e8a-e697-b33e-bcf0-94bf7fe291de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc/pnv: check for firmware
 file presence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Mon, 25 Sep 2017 10:46:13 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 25.09.2017 10:33, C=C3=A9dric Le Goater wrote:
> > and exit before uslessly trying to load it if the file does =20
>=20
> s/uslessly/uselessly/
>=20
> > not exists.
> >=20
> > Issue dicovered by Coverity Scan. =20
>=20
> /dicovered/discovered/
>=20

Mentioning the Coverity Id (ie, CID 1381410) is also a usual practice.

> > Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> > ---
> >  hw/ppc/pnv.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 47221158d415..7728eece2eec 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -570,6 +570,10 @@ static void ppc_powernv_init(MachineState *machine)
> >      }
> > =20
> >      fw_filename =3D qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
> > +    if (!fw_filename) {
> > +        error_report("Could not find OPAL '%s'", bios_name); =20
>=20
> I'd suggest to say "OPAL firmware" instead of just "OPAL". Not every
> user knows what OPAL is.
>=20

With all the suggested changes:

Reviewed-by: Greg Kurz <groug@kaod.org>

> > +        exit(1);
> > +    }
> > =20
> >      fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_=
SIZE);
> >      if (fw_size < 0) {
> >  =20
>=20
>  Thomas



--=20
Gregory Kurz                                     kurzgreg@fr.ibm.com
                                                 gkurz@linux.vnet.ibm.com
Software Engineer @ IBM/LTC                      http://www.ibm.com
Tel 33-5-6218-1607

"Anarchy is about taking complete responsibility for yourself."
        Alan Moore.
