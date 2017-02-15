Received: from eggs.gnu.org ([2001:4830:134:3::10]:36630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce2LZ-0004ZO-Db
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:22:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ce2LY-0004JN-Fs
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 11:22:25 -0500
Date: Wed, 15 Feb 2017 17:22:14 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170215162214.GG4935@noname.redhat.com>
References: <261ff7cb02d96c98ea068f3ca255a747b88ebc10.1487096041.git.jcody@redhat.com>
	<44cf0a51-5dc1-b144-f269-af9bebf7708e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
In-Reply-To: <44cf0a51-5dc1-b144-f269-af9bebf7708e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] qemu-iotests: redirect nbd server
 stdout to /dev/null
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 14.02.2017 um 19:42 hat Eric Blake geschrieben:
> On 02/14/2017 12:15 PM, Jeff Cody wrote:
> > Some iotests (e.g. 174) try to filter the output of _make_test_image by
> > piping the stdout.  Pipe the server stdout to /dev/null, so that filter
> > pipe does not need to wait until process completion.
> >=20
> > Signed-off-by: Jeff Cody <jcody@redhat.com>
> > ---
> >  tests/qemu-iotests/common.rc | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>

Thanks, applied to the block branch.

Kevin

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYpIA2AAoJEH8JsnLIjy/W4BIP/288b8++JFimwZM4mc62CIE7
BdiwhM53RaxkXl7ZhWofTNq7/U5nulByF1GY0s35SqZbPqz9Z+9U7Xv8HlJiE8gJ
dot20lBQ20/DopTggZ+6/46g04j0A/UB2Kl3PIPiSKXVd6R82gxMhoAXHwCrNQ5j
oJlrlfP7mRPz6tTqF/Tq8qqfkHqb/XOutTJLkHRmz37psduUZ7UlPJw/2uG4XMNu
d6UhEEjYRRLCsi1iIIdoov62yXaAbfzX0KY6gOUnFIJkRMCUxTgP65I/cgVXostv
m8WWySXYyRMITodGctRDgIdafbaQ5a6X3WuxB99/8Xz3gMg3f26wt2f7mo5KVa1M
Wy9ZgrTU2vVe2R1s5OU938Xu6gXB4PsPRDux7ASEexg7WUphyiGcILVTSZmQd0kF
Qgme+QHWPbIcC0jP0Zi/lFxDGX0/5sGujtHCZ2n+ZCpcnWcTZPONvfcjt8JAnou6
asLNLPs6U6XVLPdgXiusT0AiT1WRbAhEKqOOofYMs25OtT1vteHX58WayMjGPsli
h4fpi1e5LRzsK4kPBkH0JuA43IapBp5luJG15Y1PMdPs5btzKyDHuzRSHctw+yn+
MyoRuCHEF1wmeikTMbc65LXNwCsHm0AI/6DI+bQaQ1WBiib0ZpnlewVcnT8RwW9t
DOQLYNJIPjO3VhISlRzt
=mOfU
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
