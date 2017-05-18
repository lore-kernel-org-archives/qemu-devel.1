Received: from eggs.gnu.org ([2001:4830:134:3::10]:55250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHSG-0005Qm-LS
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:10:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBHSD-0003iD-EO
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:10:44 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:37463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBHSD-0003i9-7U
	for qemu-devel@nongnu.org; Thu, 18 May 2017 05:10:41 -0400
Received: by mail-wm0-x22c.google.com with SMTP id d127so44703580wmf.0
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 02:10:41 -0700 (PDT)
Date: Thu, 18 May 2017 10:10:37 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170518091037.GF30862@stefanha-x1.localdomain>
References: <20170517124042.1430-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7cm2iqirTL37Ot+N"
Content-Disposition: inline
In-Reply-To: <20170517124042.1430-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] .gdbinit: load QEMU sub-commands when
 gdb starts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>


--7cm2iqirTL37Ot+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 17, 2017 at 01:40:42PM +0100, Stefan Hajnoczi wrote:
> The scripts/qemu-gdb.py file is not easily discoverable.  Add a .gdbinit
> file so GDB either loads qemu-gdb.py automatically or prints a message
> informing the user how to enable them (some systems disable ./.gdbinit
> loading for security reasons).
>=20
> Symlink .gdbinit and the scripts directory in order to make out-of-tree
> builds work.  The scripts directory is used to find the qemu-gdb.py file
> specified by a relative path in .gdbinit.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Support out-of-tree builds [Daniel, Markus]
>=20
>  configure | 1 +
>  .gdbinit  | 8 ++++++++
>  2 files changed, 9 insertions(+)
>  create mode 100644 .gdbinit

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--7cm2iqirTL37Ot+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHWUNAAoJEJykq7OBq3PI+GAIAI0FObgEyjgsZ0J2POKrW4QQ
wZLmABXc8cJwtl/2DKhPfk8FwLnKUu/IJOCvlf2UexQDME79H/rtyr2wAJS58Ila
we7vsQ2C0Fcaaa8Ftnh7/xdGgC12uBPBfHiZQcN7J1xgg18KdeADYOQVTrB+CjPj
yYbK2f/i1LAlNlnxU5CHF/SG/mordx5iJcloPwvKo22dOdzq3S3ZDSEJ0PrixAd9
RGTZutlSdz1x2eEEDaJmzPgstKoLeTFNjIUgMmBx529SkJa9c1WKO9myjYySis/b
cjv80Rn9vmkqF+nM9vVQgp0VW1M29wZr8/10W77YUVc9IMp1SnF1HtO8gbc8S5Y=
=vNsJ
-----END PGP SIGNATURE-----

--7cm2iqirTL37Ot+N--
