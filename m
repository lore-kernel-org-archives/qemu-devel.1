Received: from eggs.gnu.org ([2001:4830:134:3::10]:52867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMGj-0003Hw-En
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMGd-0003ka-Eh
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:23:17 -0500
Date: Tue, 6 Dec 2016 20:22:08 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206202208.GF2521@stefanha-x1.localdomain>
References: <20161206182020.25736-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <20161206182020.25736-1-eblake@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.8] qapi: Document
 introduction of gluster's 'debug' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, armbru@redhat.com, qemu-block@nongnu.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 12:20:20PM -0600, Eric Blake wrote:
> We intentionally renamed 'debug-level' to 'debug' in the QMP
> schema for 'blockdev-add' related to gluster, in order to
> match the command line (commit 1a417e46).  However, since
> 'debug-level' was visible in 2.7, that means that we should
> document that 'debug' was not available until 2.8.
>=20
> The change was intentional because 'blockdev-add' itself
> underwent incompatible changes (such as commit 0153d2f) for
> the same release; our intent is that after 2.8, these
> interfaces will now be stable.  [In hindsight, we should have
> used the name x-blockdev-add when we first introduced it]
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json | 1 +
>  1 file changed, 1 insertion(+)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRx3wAAoJEJykq7OBq3PIeT0IAK1+aYT1nF4JVLc02gzu5mSM
Y47oR0bq4P5FCBK37yGy+JG83ZS3dH7E5rhofAz0ON8Ewq3jFxSUFddPkF9plO7l
trKSM0OPpJNNuUB4X/1VIWLUyYUE4I9pOYdqip8EzJ1zQTl8Z2MW7Rwvs7+lIEQP
AEzsQA+IreNonF8gXE7d7W5viReyoY2fYbo/NE+u6eIYLq5/ObKzubQwvUI3lzg+
MG54sEQ48hsVQgj3Sub6n6nQC14B/JqhqfgvAcPe7KwLasRr7LwgrG4OiH6LMSTA
6dFXksQUNhL27AJRCJu8/n6VEbJYLgASboZCIT8iS+CTHVPZ/nRtyNYjMo/siIg=
=dE91
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
