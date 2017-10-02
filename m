Received: from eggs.gnu.org ([2001:4830:134:3::10]:55971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz22N-0000nT-Dy
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:49:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dz22K-00011w-39
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:49:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dz22J-00011l-Q3
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:49:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CB2BE5F2963
	for <qemu-devel@nongnu.org>; Mon,  2 Oct 2017 14:49:34 +0000 (UTC)
References: <20171002134538.23332-1-armbru@redhat.com>
	<20171002134538.23332-4-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <40c06810-0b7c-6fc0-ed89-1ff53bc837e8@redhat.com>
Date: Mon, 2 Oct 2017 09:49:32 -0500
MIME-Version: 1.0
In-Reply-To: <20171002134538.23332-4-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pNVwgHJU65pk6244BVp1jFca4HvMCVxwB"
Subject: Re: [Qemu-devel] [PATCH 3/3] hmp-commands-info: Change "@findex
 FOO" to "@findex info FOO"
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
List-ID: <qemu-devel.nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pNVwgHJU65pk6244BVp1jFca4HvMCVxwB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com
Message-ID: <40c06810-0b7c-6fc0-ed89-1ff53bc837e8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hmp-commands-info: Change "@findex FOO"
 to "@findex info FOO"
References: <20171002134538.23332-1-armbru@redhat.com>
 <20171002134538.23332-4-armbru@redhat.com>
In-Reply-To: <20171002134538.23332-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/02/2017 08:45 AM, Markus Armbruster wrote:
> qemu-doc has the monitor commands in the "Function Index".  The "info
> FOO" are listed as "FOO" there.  List them as "info FOO" instead.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hmp-commands-info.hx | 118 +++++++++++++++++++++++++------------------=
--------
>  1 file changed, 59 insertions(+), 59 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

We have a lot of info subcommands ;)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pNVwgHJU65pk6244BVp1jFca4HvMCVxwB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnSUfwACgkQp6FrSiUn
Q2rXpQf/YU6uuBTwiFjztJIb1Rf24nW+9KSB2HWRwqZ/Fe+UPMYaloq2u1bi2etQ
jtEjJ345l8C9VXPR8vfQj4TWFDFqemDJzbijipIVapOvIDnM4n6K3V5MQpppcagF
zq+7D/kAvnhZy0KylsWZMvrVr34Lgu5y211cHgybFEN8maH4YhR3XRQddGN+8wKS
Vp2xJxPa5O19QJum8NlmMzjoM26wXmE5m9o/mc7wDZVEajnp7y+5AuFgILFWGTSQ
7mear6NPVzBYOwdxSDVG7belONdPZsK+ZL3WUiI9jbObDHe4kKYXOfkB4m5HygGv
Y4gN0chuJ5eGRdzH6DGjKJn4INiqfA==
=Yb3Z
-----END PGP SIGNATURE-----

--pNVwgHJU65pk6244BVp1jFca4HvMCVxwB--
