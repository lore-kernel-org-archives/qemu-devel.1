Received: from eggs.gnu.org ([2001:4830:134:3::10]:39599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCOE-0006e4-FV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fRCO9-0005h2-Ij
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:04:54 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:36025)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fRCO9-0005gb-Ap
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 04:04:49 -0400
Received: by mail-wr0-x241.google.com with SMTP id f16-v6so12398561wrm.3
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 01:04:49 -0700 (PDT)
Date: Fri, 8 Jun 2018 09:04:46 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180608080446.GH29183@stefanha-x1.localdomain>
References: <20180604080630.10946-1-peterx@redhat.com>
	<87tvqeyfs2.fsf@dusky.pond.sub.org> <20180608044235.GA7736@xz-mi>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dx9iWuMxHO1cCoFc"
Content-Disposition: inline
In-Reply-To: <20180608044235.GA7736@xz-mi>
Subject: Re: [Qemu-devel] [PATCH] monitor: postpone
 monitor_qmp_cleanup_queues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, John Snow <jsnow@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--Dx9iWuMxHO1cCoFc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 12:42:35PM +0800, Peter Xu wrote:
> On Thu, Jun 07, 2018 at 01:53:01PM +0200, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> >=20
> > > Previously we cleanup the queues when we got CLOSED event.  It was us=
ed
> >=20
> > we clean up
> >=20
> > > to make sure we won't leftover replies/events of a old client to a new
> >=20
> > we won't send leftover replies/events of an old client
> >=20
> > > client.  Now this patch postpones that until OPENED.
> >=20
> > What if OPENED never comes?
>=20
> Then we clean that up until destruction of the monitor.  IMHO it's
> fine, but I'm not sure whether that's an overall acceptable approach.

I think this patch fixes the problem at the wrong level.  Marc-Andr=E9's
fix seemed like a cleaner solution.

Stefan

--Dx9iWuMxHO1cCoFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGjieAAoJEJykq7OBq3PIuEMIAMrQne479JljdNgk1fxGyKf3
BDaKTxVuTsSAyeCi/yanPJPUDk51K3NWYoD5SbSw7kauwwiewvyIOdErnUI8vLci
SBr+bsXwqrCUDBYiJnxUO0FlrJECc2ELQ3DU9nTvbW0DPM9LX60aYCheD6YeoVNv
88r47XjpU8oh3LqCHaG2S4PkpHUXWI/NqMHcAOH8XOhOwnTh9nkI9kyu1Ii1J6KQ
oe7Rwo3ifL1vE8opk7Qd836urPDZbp5B+EaKK1oiAqJ+v4hYobbzegdu7sydCSKH
SxTG5iDWp7r4gd3Ym7cTutbyzMXilfzWa2IW5UMpRfZDLQbK7ILPlgNH/PDhCw8=
=GRuT
-----END PGP SIGNATURE-----

--Dx9iWuMxHO1cCoFc--
