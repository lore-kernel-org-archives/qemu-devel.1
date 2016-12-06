Received: from eggs.gnu.org ([2001:4830:134:3::10]:50897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECqq-0000fj-B0
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cECqk-0003Si-Hy
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:19:56 -0500
Date: Tue, 6 Dec 2016 10:18:25 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206101825.GA20860@stefanha-x1.localdomain>
References: <20161205234235.5728-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <20161205234235.5728-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] doc: Propose NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: nbd-general@lists.sourceforge.net, qemu-devel@nongnu.org, xieyingtai@huawei.com, subo7@huawei.com, eric.fangyi@huawei.com, pbonzini@redhat.com, qemu-block@nongnu.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 05:42:35PM -0600, Eric Blake wrote:
> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
> team discovered that it is useful if a server can advertise
> whether an export is in a known-all-zeroes state at the time
> the client connects.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  doc/proto.md | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> This replaces the following qemu patch attempt:
> https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00357.html
> which tried to add NBD_CMD_HAS_ZERO_INIT with poor semantics. The
> semantics in this proposal should be much better.
>=20
> Patch is to the merge of the master branch and the
> extension-write-zeroes branch.  By the way, qemu 2.8 is due
> to be released "real soon now", and implements NBD_CMD_WRITE_ZEROES,
> so maybe it is time to consider promoting the extension-write-zeroes
> branch into master.

Useful, thanks!

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRpBxAAoJEJykq7OBq3PIdegH/2PLLVJ93RR72pDQIMoJ+7+M
xBQNwC36ko3RQnfU4Hkfm6XbDv0ifVopBvxKtwmNdc/TduK3sBkwc8UxhJiP+Qk/
AdrGfj0LjSmmTAEV5LNT8oIXJhmeivBm9c/kifyprZl7fqZDmSvlSeAuSE/brj3j
IGsJtwzPaNOvRj10ExQ4kLFpqu9/gTLOld/jeapB+6zqjV7bzpLOcPmNjI7v4DTC
7xLJQZ60LTjHowAVjrKBZyeZXZTCEsgOWm2AOocRPisDJ370pGzYIJWhcOJn7doJ
A17LY73X+gxbOg00Ru1CFgel3IxXBoIO8DTmlONF1RB4d9je4EjhfyFTPLu8JeQ=
=zebu
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
