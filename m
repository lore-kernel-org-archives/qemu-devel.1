Received: from eggs.gnu.org ([2001:4830:134:3::10]:51456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxFDV-0008Uy-Tx
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:29:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxFDV-000625-26
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 12:29:45 -0400
References: <20170926175942.GE14717@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d53e621c-9c9a-3661-8b1c-3bdf4f651f79@redhat.com>
Date: Wed, 27 Sep 2017 18:29:33 +0200
MIME-Version: 1.0
In-Reply-To: <20170926175942.GE14717@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="HxlUI1j4tWXKA68Gn3xup8fUDf901WDVV"
Subject: Re: [Qemu-devel] blockdev-commit design
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, stefanha@redhat.com, jcody@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HxlUI1j4tWXKA68Gn3xup8fUDf901WDVV
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, stefanha@redhat.com,
 jcody@redhat.com
Message-ID: <d53e621c-9c9a-3661-8b1c-3bdf4f651f79@redhat.com>
Subject: Re: blockdev-commit design
References: <20170926175942.GE14717@localhost.localdomain>
In-Reply-To: <20170926175942.GE14717@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-09-26 19:59, Kevin Wolf wrote:

[...]

>   * The old block-commit command decides between an "actual" commit job=

>     and the mirror-based active commit based on whether top is the
>     active layer.
>=20
>     We don't get an option for the active layer any more now, so this
>     isn't how things can work for blockdev-commit. We could probably
>     check whether top has a BlockBackend parent, but that's not really
>     what we're interested in anyway. Maybe the best we could do to
>     decide this automatically is to check whether there is any parent o=
f
>     top that requires write permissions. If there is, we need active
>     commit, otherwise the "normal" one is good enough.
>=20
>     However, who says that the intentions of the user stay as we deduce=

>     them at the start of the block job? Who says that the user doesn't
>     want to add a writable disk as a user of the node while the block
>     job is running?
>=20
>     The optimal solution to this would be that the commit filter node
>     responds to permission requests and switches between active and
>     "normal" commit mode. I'm not sure how hard this would be to
>     implement.
>=20
>     As long as we don't have the automatic switch, do we have to allow
>     the user to specify explicitly which mode they want instead of
>     automatically choosing one?

Probably a stupid question: What advantage does the commit job have over
the mirror job? I.e. would it be possible to just always do a mirror?

Max


--HxlUI1j4tWXKA68Gn3xup8fUDf901WDVV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnL0e0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2hYH/17Suss87xN6J/8//NfJJyCKzLC/g66S
AcmNNwhCi6CV/SRUi4J1sEvWHpFHfr8N3jCJOMIlTKqtQNYWwBZ6xpCirG06W3ic
w8mHXvtdBcmoY4UUHbvtGAuB00dWNFTYN4oJCY34r8q+WR7PeT6Iiqw9DjRpCn0x
/Cepsw0447xj1llLGwdFWp3ZfEJXlsj2xvV4VUO4JOh0KQckC132gi/pDMEKijdc
wfL3LaFtMOXZFVBjmthSrzIs3wjRsH2jOhDUBkxzxY2Idc8nWTSSDudjXfTwvZi5
6TfudZgW4cMzVHnhtbtSvPtDwzQOXNhpCQ8ryTcGKBCAjyE+XahGEx4=
=v6rl
-----END PGP SIGNATURE-----

--HxlUI1j4tWXKA68Gn3xup8fUDf901WDVV--
