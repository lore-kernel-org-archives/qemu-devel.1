Received: from eggs.gnu.org ([2001:4830:134:3::10]:53520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6HAE-0004NJ-HQ
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6HAD-0004Wf-8c
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:51:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6HAC-0004Vn-VW
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:51:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B66097575D
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 13:51:23 +0000 (UTC)
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
	<20170504125432.21653-5-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3bee3200-b3b7-9a6a-7aa7-4cfb53de37a6@redhat.com>
Date: Thu, 4 May 2017 08:51:20 -0500
MIME-Version: 1.0
In-Reply-To: <20170504125432.21653-5-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TV0o9DNMpCpRwpHx4UBAJ51MF4gNhOJkv"
Subject: Re: [Qemu-devel] [PATCH 4/4] qmp-shell: improve help
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TV0o9DNMpCpRwpHx4UBAJ51MF4gNhOJkv
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <3bee3200-b3b7-9a6a-7aa7-4cfb53de37a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] qmp-shell: improve help
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
 <20170504125432.21653-5-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-5-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 07:54 AM, Marc-Andr=C3=A9 Lureau wrote:
> Describe the arguments & fix the tool name.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index db24c87cdd..fce1ab6c49 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -375,7 +375,11 @@ def die(msg):
>  def fail_cmdline(option=3DNone):
>      if option:
>          sys.stderr.write('ERROR: bad command-line option \'%s\'\n' % o=
ption)
> -    sys.stderr.write('qemu-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX so=
cket path> | < TCP address:port >\n')
> +    sys.stderr.write('qmp-shell [ -v ] [ -p ] [ -H ] [ -N ] < UNIX soc=
ket path> | < TCP address:port >\n')
> +    sys.stderr.write('    -v     Verbose (echo command sent and receiv=
ed)\n')
> +    sys.stderr.write('    -p     Pretty-print JSON\n')
> +    sys.stderr.write('    -H     Use HMP interface\n')
> +    sys.stderr.write('    -N     Skip negotiate (for qemu-ga)\n')
>      sys.exit(1)
> =20
>  def main():
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TV0o9DNMpCpRwpHx4UBAJ51MF4gNhOJkv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCzHYAAoJEKeha0olJ0NqhukH/0UhFNbkxbxg0y/asFSiBxeN
V7l/5Spku8ygGg2OjZ1/fQ5r4GiRz1j8JCQ/uZgVFYhbrYt31tGfbiOi57r2rqPT
NkwNdkZeCfnkDpxsV6Ex1z50agU6uXSsWehsAUqwSYjAG3TqXxIO+lYtTYYPjQy/
fImWMOI+n4Xo9I01NhLfEWsRvwoPu/KYPQyTrwjbCSGSocJkb3NNujaDup5iUOYJ
WHMqAKFqw1DG09l+CFxmkjXlLNGMEqS99RBSFoN2llDrhVuzGeVaw0oSRzvmMger
HmmS5i2adih0cMtCgjTKxmS6fDHZA/v0E9CmwNihsVfLGd5oNDRBXt368BTMNpM=
=y/HD
-----END PGP SIGNATURE-----

--TV0o9DNMpCpRwpHx4UBAJ51MF4gNhOJkv--
