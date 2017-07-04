Received: from eggs.gnu.org ([2001:4830:134:3::10]:44724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSJYv-0000wP-JR
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:52:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dSJYs-00033v-Fw
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:52:01 -0400
Received: from 15.mo4.mail-out.ovh.net ([91.121.62.11]:53743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dSJYs-000329-9v
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:51:58 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id B341781BE5
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 10:51:56 +0200 (CEST)
Date: Tue, 4 Jul 2017 10:51:46 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170704105146.6ef17b9f@bahia.lan>
In-Reply-To: <b11aa61c-ff73-3568-f924-e10828c0e92c@redhat.com>
References: <20170703131455.25424-1-lvivier@redhat.com>
	<20170703131455.25424-2-lvivier@redhat.com>
	<b11aa61c-ff73-3568-f924-e10828c0e92c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/BDW=eYuFklBxtazt1h+KxOv";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC v3 1/2] target/ppc/cpu-models: set
 POWER9_v1.0 as POWER9 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Suraj Singh <sursingh@redhat.com>, joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>

--Sig_/BDW=eYuFklBxtazt1h+KxOv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Jul 2017 09:42:33 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 03.07.2017 15:14, Laurent Vivier wrote:
> > CPU_POWERPC_POWER9_DD1 is 0x004E0100, so this is the POWER9 v1.0.
> >=20
> > When we run qemu on a POWER9 DD1 host, we must use either
> > "-cpu host" or "-cpu POWER9", but in the latter case it fails with
> >=20
> >     Unable to find sPAPR CPU Core definition
> >=20
> > because POWER9 DD1 doesn't appear in the list of known CPUs.
> >=20
> > This patch fixes this by defining POWER9_v1.0 with POWER9 DD1
> > PVR instead of CPU_POWERPC_POWER9_BASE. It also adds POWER_v2.0
> > with POWER9 DD2 PVR to avoid to trigger kernel POWER9 DD1 workaround
> > in TCG mode.
> >=20
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > ---
> >  hw/ppc/spapr_cpu_core.c | 5 ++++-
> >  target/ppc/cpu-models.c | 6 ++++--
> >  target/ppc/cpu-models.h | 1 +
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> > index 9fb896b..00918a5 100644
> > --- a/hw/ppc/spapr_cpu_core.c
> > +++ b/hw/ppc/spapr_cpu_core.c
> > @@ -249,8 +249,11 @@ static const char *spapr_core_models[] =3D {
> >      /* POWER8NVL */
> >      "POWER8NVL_v1.0",
> > =20
> > -    /* POWER9 */
> > +    /* POWER9 DD1 */
> >      "POWER9_v1.0",
> > +
> > +    /* POWER9 DD2 */
> > +    "POWER9_v2.0", =20
>=20
> In case you re-spin, what about a more compact listing:
>=20
>     /* POWER9 */
>     "POWER9_v1.0",
>     "POWER9_v2.0",
>=20
> ?
>=20

I second that but anyway:

Reviewed-by: Greg Kurz <groug@kaod.org>

> Anyway, patch looks good to me, so:
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>


--Sig_/BDW=eYuFklBxtazt1h+KxOv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAllbVyIACgkQAvw66wEB28IM8ACeJ1NkLO8o0fiOVAFtpGorv4t0
OcoAnAyLfdjOnNeLkLuYGssYK2+OHp9u
=yjky
-----END PGP SIGNATURE-----

--Sig_/BDW=eYuFklBxtazt1h+KxOv--
