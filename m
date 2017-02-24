Received: from eggs.gnu.org ([2001:4830:134:3::10]:34920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGM0-00088e-Hn
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:56:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGLz-00064C-KU
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 08:56:12 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-33-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0550d32b-dd38-3bd8-074c-a76f5a0a35fc@redhat.com>
Date: Fri, 24 Feb 2017 14:56:02 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-33-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oEFp0LGM2KmjrUAUjiuwl0dEIR7GXrojv"
Subject: Re: [Qemu-devel] [PATCH 32/54] block: Add
 BdrvChildRole.get_parent_desc()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oEFp0LGM2KmjrUAUjiuwl0dEIR7GXrojv
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <0550d32b-dd38-3bd8-074c-a76f5a0a35fc@redhat.com>
Subject: Re: [PATCH 32/54] block: Add BdrvChildRole.get_parent_desc()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-33-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-33-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> For meaningful error messages in the permission system, we need to get
> some human-readable description of the parent of a BdrvChild.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   |  9 +++++++++
>  block/block-backend.c     | 21 +++++++++++++++++++++
>  include/block/block_int.h |  6 ++++++
>  3 files changed, 36 insertions(+)

Once more modulo patchew's nagging (I've complained about asterisk
placement already so much it's enough for a lifetime):

Reviewed-by: Max Reitz <mreitz@redhat.com>


--oEFp0LGM2KmjrUAUjiuwl0dEIR7GXrojv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwO3ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AsagH/3RCDCXYFDzny1I0TRioJcT2faHh45uS
SE8cp1XasMNoHCxhsutAkfY7IhtWGMV1FCfCrMsbASWQWswri+kUDn5w9FTJ8qx8
doP/QxJSQZGCxgaBsEn6bHh0J1PHLXp55w1/z5ZIjX4x6XBdP3QApsiIhXMqiCZ0
5b63qA/qGABE4TMdE5QajfF38Q+QBFDxHOScb1R+Arb2R90GxRqhJgOdSxEdxMIb
3+DlLJmbAiTYcJQD3S+XI9gvmWajx2swFge1EBFAu7p5wLxhSRA7NF5RR3vc8GS8
Y+uV6oBMlbxwgZhaFB7Hcixnndg2ELuQ9ut7Riv3/BtDDzkvUIEQS8Y=
=Grvh
-----END PGP SIGNATURE-----

--oEFp0LGM2KmjrUAUjiuwl0dEIR7GXrojv--
