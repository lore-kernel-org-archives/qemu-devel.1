Received: from eggs.gnu.org ([2001:4830:134:3::10]:33322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBlL-0008Nu-65
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQBlF-0004NX-Au
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:08:03 -0400
Date: Wed, 28 Jun 2017 13:07:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170628120744.GA7538@stefanha-x1.localdomain>
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-5-el13635@mail.ntua.gr>
	<20170626145234.GE29664@stefanha-x1.localdomain>
	<20170626165832.32mzemh4jiwpquo4@postretch>
	<w5160fhza8s.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
In-Reply-To: <w5160fhza8s.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH RFC v3 4/8] block: convert
 ThrottleGroup to object with QOM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Manos Pitsidianakis <el13635@mail.ntua.gr>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 27, 2017 at 06:05:55PM +0200, Alberto Garcia wrote:
> On Mon 26 Jun 2017 06:58:32 PM CEST, Manos Pitsidianakis wrote:
> > On Mon, Jun 26, 2017 at 03:52:34PM +0100, Stefan Hajnoczi wrote:
> >>On Fri, Jun 23, 2017 at 03:46:56PM +0300, Manos Pitsidianakis wrote:
> >>> +static bool throttle_group_exists(const char *name)
> >>> +{
> >>> +    ThrottleGroup *iter;
> >>> +    bool ret =3D false;
> >>> +
> >>> +    qemu_mutex_lock(&throttle_groups_lock);
> >>
> >>Not sure if this lock or the throttle_groups list are necessary.
>=20
> As Manos says accesses to the throttle_groups list need to be locked.

Explicit locking is only necessary if the list is accessed outside the
QEMU global mutex.  If the monitor is the only thing that accesses the
list then a lock is not necessary.

Anyway, this point might be moot if every ThrottleGroup is a QOM object
and we drop this code in favor of using QOM APIs to find and iterate
over objects.

Stefan

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZU5wPAAoJEJykq7OBq3PIYi0H/2LGOufqVbiU0uHza0Kolypx
pE0u8M52U1OQ0vhvkO93x3UVOTiYO5wJJkKimYUYJNg/elKk7TlPbDxQDszCGfNz
iEa7gF0M4bXG82TrABN8PvuhoMxSpFDyQxNGBghRRkhXtagnGA539339nvC/QJSr
JVlJeSD0ppFyGpdr8Zn/nr0FRbxW7HbvL4NdLJT2TJUCK4D4ScnKe18oGyoOmk4F
v/1Hbh+4xdZF3w6tTicJilSikjgiZc68/FxaKb3RAHmwb1OEFVQs6emjjmC59XOH
KXCVJ+Qbv14iPOj+Ou+EpiRBbbVUw5VxYa0YyA9xLsiuJ6apsJTfwWxtfGwQQ6k=
=dbYA
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
