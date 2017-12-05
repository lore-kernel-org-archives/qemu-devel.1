Received: from eggs.gnu.org ([2001:4830:134:3::10]:40410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMCyn-00065a-MI
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:09:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eMCyi-0005Tq-OO
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 08:09:45 -0500
Date: Wed, 6 Dec 2017 00:04:20 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171205130420.GM3057@umbus.fritz.box>
References: <20171205122740.15005-1-lvivier@redhat.com>
	<20171205124439.GB2405@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WuedheRyq6FDfQ9j"
Content-Disposition: inline
In-Reply-To: <20171205124439.GB2405@work-vm>
Subject: Re: [Qemu-devel] [PATCH] migration: fix analyze-migration.py script
 with radix table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, Greg Kurz <groug@kaod.org>


--WuedheRyq6FDfQ9j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 12:44:40PM +0000, Dr. David Alan Gilbert wrote:
> * Laurent Vivier (lvivier@redhat.com) wrote:
> > Since commit 3a38429748 ("Add a "no HPT" encoding to HTAB migration str=
eam")
> > the HTAB migration stream contains a header set to "-1", meaning there
> > is no HPT. Teach analyze-migration.py to ignore the section in this cas=
e.
> >=20
> > Without this fix, the script fails with a dump from a POWER9 guest:
> >=20
> > Traceback (most recent call last):
> >   File "./qemu/scripts/analyze-migration.py", line 602, in <module>
> >     dump.read(dump_memory =3D args.memory)
> >   File "./qemu/scripts/analyze-migration.py", line 539, in read
> >     section.read()
> >   File "./qemu/scripts/analyze-migration.py", line 250, in read
> >     self.file.readvar(n_valid * self.HASH_PTE_SIZE_64)
> >   File "./qemu/scripts/analyze-migration.py", line 64, in readvar
> >     raise Exception("Unexpected end of %s at 0x%x" % (self.filename, se=
lf.file.tell()))
> > Exception: Unexpected end of migrate.dump at 0x1d4763ba
> >=20
> > Fixes: 3a38429748 ("Add a "no HPT" encoding to HTAB migration stream")
> > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Should I queue this (for 2.12), or do you want to take it via the
migration tree?

>=20
> > ---
> >  scripts/analyze-migration.py | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
> > index 14553876a2..88ff4adb30 100755
> > --- a/scripts/analyze-migration.py
> > +++ b/scripts/analyze-migration.py
> > @@ -234,6 +234,10 @@ class HTABSection(object):
> > =20
> >          header =3D self.file.read32()
> > =20
> > +        if (header =3D=3D -1):
> > +            # "no HPT" encoding
> > +            return
> > +
> >          if (header > 0):
> >              # First section, just the hash shift
> >              return

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WuedheRyq6FDfQ9j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlommVEACgkQbDjKyiDZ
s5KfAxAAptYoGxrrXjjFJeN1Fbun9Me2sQfnWyPAXFuRgyoY1gcL6y+7QFL7/7pr
ZvwOsPg2tk7q7KQOhnvVhmijuI6DqkeaOtQ4F/1tXOAbwXAWdzJQDpk3km/58F58
1nzK6V5YnxOUdSqF7W3m5DDuZfV1Z16gbIoLJEjje1ecXXw7xbDXAuIwSLbIVgJo
WWKWKPohllD8pDHx3FOzC5aNCQMG5jMFsWnpBkGLN/gbDoAItmLD8uxhCRYSc4VB
blHlfUJv01Id8NJD0y93AJ1mPU9aGnVA5qs07mEGusy95VOb2V8+qKPXUHjstajP
BHOF/Wv+NbLwDrJuO64HTtUlinQ6+abkDqUAmkZty4pkck5arWpMcl7mRyjc2QGq
oul1teURXIZYSb/yrbNMcD2JZYedGmACu2OdK0fnQDp0rSI6czrtcoIHqnZVxcXW
T9ox/ZdaJrwGmE4ioNjxblApboAMGLrxbh/SHV8hTKL5wQ19yyLz+RQt9+aZSCuW
D4FA30mtb4VM7hfv5qd/Zvy/auZhaBMBQ6WAH2Msvqm0wIOZGzaXlCu3cW4blD/t
8ZPp9CaMLDMoinuFuCOTtotin5h5EvG/na9vfHI5kAUS9K10Uup4nlVw8X1H+GeY
sscxdzWB1ijFFYCR9zD5qh2zHmoR+N9VzdIrAdDMX0dq8hZyHAQ=
=S2Ib
-----END PGP SIGNATURE-----

--WuedheRyq6FDfQ9j--
