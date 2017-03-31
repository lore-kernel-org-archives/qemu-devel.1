Received: from eggs.gnu.org ([2001:4830:134:3::10]:45292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cty66-0000wI-Vz
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cty63-0004Q6-Pl
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 11:04:18 -0400
References: <1490970783-29231-1-git-send-email-minyard@acm.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8e26dbca-d2be-01bc-bfa3-a73fcb9d1498@redhat.com>
Date: Fri, 31 Mar 2017 10:04:12 -0500
MIME-Version: 1.0
In-Reply-To: <1490970783-29231-1-git-send-email-minyard@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uTmtCCX225vnCGM7pBXbCKQswu3Clqlgo"
Subject: Re: [Qemu-devel] [PATCH for-2.9? v4] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>, Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uTmtCCX225vnCGM7pBXbCKQswu3Clqlgo
From: Eric Blake <eblake@redhat.com>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>,
 Corey Minyard <cminyard@mvista.com>
Message-ID: <8e26dbca-d2be-01bc-bfa3-a73fcb9d1498@redhat.com>
Subject: Re: [PATCH for-2.9? v4] ipmi: Fix macro issues
References: <1490970783-29231-1-git-send-email-minyard@acm.org>
In-Reply-To: <1490970783-29231-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 09:33 AM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Macro parameters should almost always have () around them when used.
> llvm reported an error on this.
>=20
> Remove redundant parenthesis and put parenthesis around the entire
> macros with assignments in case they are used in an expression.
>=20
> The macros were doing ((v) & 1) for a binary input, but that only works=

> if v =3D=3D 0 or if v & 1.  Changed to !!(v) so they work for all value=
s.

s/&/=3D=3D/

>=20
> Remove some unused macros.
>=20
> Reported in https://bugs.launchpad.net/bugs/1651167

Might also be worth adding that an audit of the code finds no semantic
change, that this is just cleaning up the compiler warning.

>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> ---
>=20
> Changes since the last revision:
>=20
>   * Added the !!(v) change
>=20
>  hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uTmtCCX225vnCGM7pBXbCKQswu3Clqlgo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3m/sAAoJEKeha0olJ0NqHEsH/A1EhGfg5W48cAPkdCBq8JVL
M7EA6TxGLS7Mlc1OHrXMtd0HYFAYnFU4yGdCuEWCvblmVzNqMl/WF41eVXwFWGvJ
bxxmIkJ9ELzkBrCqqSUFhq0zf1Ox5ZBu/s5GURTyhFFepWmFa0yuZZC7G24hTuRR
J9eoWsa4x7weXMKSA/ptwWddndqx5U0J6hPb+mfGGStPWVn5NfUfNm5dKEY089Rs
v2mUL0oegLCOjknGz+WRYiIuf2OJnxlmwLGBEON1mQgyCLFizJISittA0qyG3NnC
ARVfd79SigQg6iApFn5f/EMOKlDfnyTr37FIm2n2gIfV1dkQF0dFbtB8vMhjwkY=
=nCq2
-----END PGP SIGNATURE-----

--uTmtCCX225vnCGM7pBXbCKQswu3Clqlgo--
