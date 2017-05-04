Received: from eggs.gnu.org ([2001:4830:134:3::10]:53284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6H9B-0003ND-1b
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6H97-0003zR-WB
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:50:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40843)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6H97-0003z7-MN
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:50:17 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99CAD26B09
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 13:50:16 +0000 (UTC)
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
	<20170504125432.21653-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <471cdc89-855f-889b-a83f-baadc62e5c84@redhat.com>
Date: Thu, 4 May 2017 08:50:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170504125432.21653-3-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wkGQEXCdlqJdxTdkHlQu9gcx44nQ70NeT"
Subject: Re: [Qemu-devel] [PATCH 2/4] qmp-shell: ignore query-commands error
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
--wkGQEXCdlqJdxTdkHlQu9gcx44nQ70NeT
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <471cdc89-855f-889b-a83f-baadc62e5c84@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/4] qmp-shell: ignore query-commands error
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
 <20170504125432.21653-3-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 07:54 AM, Marc-Andr=C3=A9 Lureau wrote:
> qemu-ga doesn't implement it.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index f80d02312a..04b8fa3eae 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -126,7 +126,10 @@ class QMPShell(qmp.QEMUMonitorProtocol):
>          return arg
> =20
>      def _fill_completion(self):
> -        for cmd in self.cmd('query-commands')['return']:
> +        cmds =3D self.cmd('query-commands')
> +        if cmds.has_key('error'):
> +            return
> +        for cmd in cmds['return']:
>              self._completer.append(cmd['name'])
> =20
>      def __completer_setup(self):
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wkGQEXCdlqJdxTdkHlQu9gcx44nQ70NeT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCzGVAAoJEKeha0olJ0Nq5GsIAJsBVKm1XA2BDNQsgxcCwBT6
fHmDfhesmV+fwJ668BWyQt0fWYjKSzJM2kbDNRznfAWENJaMmHJXGwd+ORdOkT3M
35U2ioBgGBr62dcbpaqj9O5PqHS/Toe3pcWzd6ghX9LEMS82Y8xsiY+KSUOXzohs
hWZg+a+SLus+hxGytA94P2AfkSlVKLsUzIK1+yqqNm9cEZY6kuutB0QEp4lbR0QY
PhNOiRJh9cPBNb01r3IIIQamaxHwZjfpMCzAetssgUjilSVkDVM8AyhzA0PcoMXZ
j8KIauEMljsxiMorl9NzKJ0i0kv0mIKuaWkHnyfBFWJlugxEn/bNSkdYhHqENBc=
=nVjh
-----END PGP SIGNATURE-----

--wkGQEXCdlqJdxTdkHlQu9gcx44nQ70NeT--
