Received: from eggs.gnu.org ([2001:4830:134:3::10]:53429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6H9l-00048a-Pl
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:50:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d6H9g-0004Gw-19
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:50:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52226)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d6H9f-0004GD-Mh
	for qemu-devel@nongnu.org; Thu, 04 May 2017 09:50:51 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 947C94DB14
	for <qemu-devel@nongnu.org>; Thu,  4 May 2017 13:50:50 +0000 (UTC)
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
	<20170504125432.21653-4-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <98514164-37f9-3ad0-a05e-10f9f5eaaf57@redhat.com>
Date: Thu, 4 May 2017 08:50:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170504125432.21653-4-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XRsrv4DhawJk1plNQXbJiPQ8VGg4av3Dv"
Subject: Re: [Qemu-devel] [PATCH 3/4] qmp-shell: don't show version greeting
 if unavailable
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
--XRsrv4DhawJk1plNQXbJiPQ8VGg4av3Dv
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
Message-ID: <98514164-37f9-3ad0-a05e-10f9f5eaaf57@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/4] qmp-shell: don't show version greeting
 if unavailable
References: <20170504125432.21653-1-marcandre.lureau@redhat.com>
 <20170504125432.21653-4-marcandre.lureau@redhat.com>
In-Reply-To: <20170504125432.21653-4-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/04/2017 07:54 AM, Marc-Andr=C3=A9 Lureau wrote:
> qemu-ga doesn't have greeting.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  scripts/qmp/qmp-shell | 3 +++
>  1 file changed, 3 insertions(+)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

> diff --git a/scripts/qmp/qmp-shell b/scripts/qmp/qmp-shell
> index 04b8fa3eae..db24c87cdd 100755
> --- a/scripts/qmp/qmp-shell
> +++ b/scripts/qmp/qmp-shell
> @@ -265,6 +265,9 @@ class QMPShell(qmp.QEMUMonitorProtocol):
> =20
>      def show_banner(self, msg=3D'Welcome to the QMP low-level shell!')=
:
>          print msg
> +        if not self._greeting:
> +            print 'Connected'
> +            return
>          version =3D self._greeting['QMP']['version']['qemu']
>          print 'Connected to QEMU %d.%d.%d\n' % (version['major'],versi=
on['minor'],version['micro'])
> =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XRsrv4DhawJk1plNQXbJiPQ8VGg4av3Dv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCzG2AAoJEKeha0olJ0Nq660H/iQ7fgqEwY1j4WDUR2SfPCCT
vGwMRflmxDj/1Jy+b9qzY00p9m6x6RfKKxY5FP72P3R0nY5LmY7GXblddJImaBlk
Az060QwW8jR82b3cIfRblFoVgR6XfR+3HM1hGvD7ezO284lvM8dRtXVSF05ql3Hg
fInZsFFqendZSg8HtFgFszl3DSm1jpAU/1godVxiceHcDi2VTaU3dAdj3kX/YrVy
BZlbnWR1YQJ7x0CfAVKlVgpCXLGCRtF0LGgIOyfyjXPkiJ8X7qp9ZbaE1RJ3du5e
OCmUTtn4GvTP2SU64q9jgD1BqWsz/jkewGnvuJgoy1f9XBDr48iY9mD88a18P4I=
=SaSn
-----END PGP SIGNATURE-----

--XRsrv4DhawJk1plNQXbJiPQ8VGg4av3Dv--
