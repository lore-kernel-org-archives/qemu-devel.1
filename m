Received: from eggs.gnu.org ([2001:4830:134:3::10]:40388)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQaJg-00007q-6T
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:25:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <msuchanek@suse.de>) id 1fQaJf-0006SK-Cd
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 11:25:40 -0400
Date: Wed, 6 Jun 2018 17:25:23 +0200
From: Michal =?UTF-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Message-ID: <20180606172523.3816a882@kitsune.suse.cz>
In-Reply-To: <cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606113720.GA2661@work-vm>
	<2c833e2c-f0bb-ea98-a703-54fb9447bd2f@redhat.com>
	<20180606121624.GD2661@work-vm>
	<2d572c2f-8dda-87db-ec26-6f2230375424@redhat.com>
	<20180606140233.GF2660@work-vm>
	<66366ae1-1db8-7121-bfcc-f2096d0c954f@redhat.com>
	<20180606144140.GH2660@work-vm>
	<cea4f615-c768-7a2f-3849-5dd00c37b537@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/mUhfswZZeytpQY1DGA4b33f";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S.
	Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

--Sig_/mUhfswZZeytpQY1DGA4b33f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Jun 2018 16:55:08 +0200
Max Reitz <mreitz@redhat.com> wrote:

> On 2018-06-06 16:41, Dr. David Alan Gilbert wrote:
> > * Max Reitz (mreitz@redhat.com) wrote: =20
>=20
> [...]
>=20
> >> So why is it so dangerous to connect a disk you just downloaded to
> >> e.g. the wrong machine type?  I assumed it just wouldn't work and
> >> you'd try again, until you realized that maybe you should read the
> >> download description and do as it says ("download this config
> >> file, pass it"). =20
> >=20
> > That's bad!  Stuff should just-work; =20
>=20
> That's how it always should be.  Life's tough, though.
>=20
> >                                      it currently just works, =20
>=20
> Due to sheer blind luck, I'd say.

It's TimeProvenSolution(tm).

>=20
> >                                                               things
> > should get better and easier for our users. =20
>=20
> Users using a whole VM stack plus management, but then handling two
> files instead of one is too much to ask?

What you don't seem to realize is there are cases when there is an
'administrator' who has set up the VM stack plus management and 'joe
user' who wants to run some random VM on that stack.

And if you download an appliance compatible with the stack it should
just work. For a long time the 'appliance' for qemu based
virtualization was a simple qcow2 file which was sized sufficiently for
the VM to run but shrunk for transport. And although it is technically
wrong it JustWorked(tm).

>=20
> >                                              And anyway, not
> > working for EFI for exmaple can be just a blank screen.  Seriously
> > - keep it easy for the user! =20
>=20
> Thinking this through makes you end up with appliances.

And those can in general have more than one disk.

Thanks

Michal

--Sig_/mUhfswZZeytpQY1DGA4b33f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJbF/zrAAoJEFCz6i1PzvpbWuwIALCk0DNPlc7GVS474zf8jXm3
Rog9Yh/ZLRlbGSAOu51ALaNLDBv2Kjfv70XetAXYi0e2yZ30p7xcgerFC85A7p62
r2zudzLcXWDOIgJDdXpHK9lLMNamPdI5maA2Fp/8f8GiUGuQwGykHKS5hRFZOzpD
yGwwk2mugwAaHiUd/E5XVOBpJxaDbr/4AXruJHiIVUfmInD6CNcSvt6P3PeNG/QB
LewvRyqyizExolElcTyQFnAcmFhjjZMLvBd1ujGQRIFes9ThLMCmGq/lN7YpHx3I
N0BzCAg/pO2pc33GzPDaLUMCZ6rN8rSOcNiZr6yM+ZgTDK77o3AyaHkdHylQUI4=
=Ehly
-----END PGP SIGNATURE-----

--Sig_/mUhfswZZeytpQY1DGA4b33f--
