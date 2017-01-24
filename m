Received: from eggs.gnu.org ([2001:4830:134:3::10]:34805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW6ZI-00005K-G5
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:15:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cW6ZF-0000LA-50
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:15:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cW6ZE-0000L2-T2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 14:15:45 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EC3297E9F1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 19:15:44 +0000 (UTC)
References: <20170124095332.23955-1-berrange@redhat.com>
	<20170124095332.23955-9-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0dda8b6d-b305-1e97-1cc7-89b06eebc735@redhat.com>
Date: Tue, 24 Jan 2017 13:15:42 -0600
MIME-Version: 1.0
In-Reply-To: <20170124095332.23955-9-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sivhNqRaRu5UBw2uOvalkcDwqfI45OMOw"
Subject: Re: [Qemu-devel] [PATCH v2 8/8] ui: add ability to specify multiple
 VNC listen addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sivhNqRaRu5UBw2uOvalkcDwqfI45OMOw
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <0dda8b6d-b305-1e97-1cc7-89b06eebc735@redhat.com>
Subject: Re: [PATCH v2 8/8] ui: add ability to specify multiple VNC listen
 addresses
References: <20170124095332.23955-1-berrange@redhat.com>
 <20170124095332.23955-9-berrange@redhat.com>
In-Reply-To: <20170124095332.23955-9-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/24/2017 03:53 AM, Daniel P. Berrange wrote:
> This change allows the listen address and websocket address
> options for -vnc to be repeated. This causes the VNC server
> to listen on multiple addresses. e.g.
>=20
>  $ $QEMU -vnc vnc=3Dlocalhost:1,vnc=3Dunix:/tmp/vnc,\
>               websocket=3D127.0.0.1:8080,websocket=3D[::]:8081
>=20
> results in listening on
>=20
> 127.0.0.1:5901, 127.0.0.1:8080, ::1:5901, :::8081 & /tmp/vnc
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  ui/vnc.c | 198 +++++++++++++++++++++++++++++++++++++++++++------------=
--------
>  1 file changed, 135 insertions(+), 63 deletions(-)
>=20

> @@ -3835,7 +3901,9 @@ void vnc_display_open(const char *id, Error **err=
p)
>          return;
>      }
> =20
> -    if (vnc_display_get_addresses(opts, &saddr, &wsaddr, errp) < 0) {
> +    if (vnc_display_get_addresses(opts, &saddr, &nsaddr,
> +                                  &wsaddr, &nwsaddr, errp) < 0) {
> +        g_printerr("failing\n");
>          goto fail;

Leftover debugging?

Otherwise looks okay, so with that line gone,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sivhNqRaRu5UBw2uOvalkcDwqfI45OMOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYh6feAAoJEKeha0olJ0NqTaMIAKA7f2ErlnJjXPsucCDeimDf
FzUsNawQMY7E7Lgaxb3NrqkgrVMCl/RJPh9x5gj7+3xDBTN5ssNiVjMFE/t0qLKK
mfZwWqZxsccsb69Lxe9q4OaJWdLLmSpLw/VhKEvzF61ZiTOlyojZ+xCFi58Wwe7K
uGl1RRGrlxQ3vdONCmsbYzYc2z1MjQEgE+Dd/284dTu6jeBZ5YqLvUkcvA+3XN9D
8FtzNgFHMN9CgVVFbxf9yb1yyAfYt9Dbvago32/DmsRv/zZEVQkHvE3L1d3AwAub
kLb6QZKTTITX8Qc/tXbY5HPegggFO+rzRo8eu7UnXGiG1Xc144rsxwqlimsrAlw=
=/WRQ
-----END PGP SIGNATURE-----

--sivhNqRaRu5UBw2uOvalkcDwqfI45OMOw--
