Received: from eggs.gnu.org ([2001:4830:134:3::10]:38380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cteGJ-0003y0-Lo
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cteGG-0002zY-Jp
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:53:31 -0400
References: <1490894892-8055-1-git-send-email-minyard@acm.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0715ab2d-f367-03ef-1674-4c1e67756f85@redhat.com>
Date: Thu, 30 Mar 2017 12:53:25 -0500
MIME-Version: 1.0
In-Reply-To: <1490894892-8055-1-git-send-email-minyard@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3we7cKBIlNE7lTJxsLGGURqiUM892EXcu"
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2 resend] ipmi: Fix macro issues
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
--3we7cKBIlNE7lTJxsLGGURqiUM892EXcu
From: Eric Blake <eblake@redhat.com>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>,
 Corey Minyard <cminyard@mvista.com>
Message-ID: <0715ab2d-f367-03ef-1674-4c1e67756f85@redhat.com>
Subject: Re: [PATCH for-2.9? v2 resend] ipmi: Fix macro issues
References: <1490894892-8055-1-git-send-email-minyard@acm.org>
In-Reply-To: <1490894892-8055-1-git-send-email-minyard@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/30/2017 12:28 PM, minyard@acm.org wrote:
> From: Corey Minyard <cminyard@mvista.com>
>=20
> Macro parameters should almost always have () around them when used.
> llvm reported an error on this.
>=20
> Remove redundant parenthesis and put parenthesis around the entire
> macros with assignments in case they are used in an expression.
>=20
> Remove some unused macros.
>=20
> Reported in https://bugs.launchpad.net/bugs/1651167
>=20
> Signed-off-by: Corey Minyard <cminyard@mvista.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)

Already reviewed by me, so now I'm just adding commentary: Is this still
2.9 material?  It silences a build warning under clang, although I
didn't analyze whether the unpatched code actually caused an observable
behavior bug or just compiler noise.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--3we7cKBIlNE7lTJxsLGGURqiUM892EXcu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3UYVAAoJEKeha0olJ0Nq3wkIAJppgGGN2nor4ucvEYKfgKfA
nsgbfcHMPCEFrptOqALkiezQlaNyEG/pxYz2k/xDKgXwddIvhcD9TyZxazmDZ+LH
tU4soIJRCetgX2VZFw4taOd7Lx9hYHj72GGsnvfeH8pXQEBQuSPp1/WpV8T9G86q
D8IGXJMhlOeI1q3tnnd8zy6/zQFGN39kxwY6Vsn0K1SN9wKvr5Zqmc4Q+0zrfJns
Er1H3jiF/pET3zJmnwT8GF8WBdkLtpxUaAeIujDCtePtRBYRS/vua6M5c+cJ2H5E
jlyWdeP0J67elNVH0H2pAvoQTxO8XcAe3aJMffo4Hho7ExlpECwk8m+QbFLwndU=
=/xSm
-----END PGP SIGNATURE-----

--3we7cKBIlNE7lTJxsLGGURqiUM892EXcu--
