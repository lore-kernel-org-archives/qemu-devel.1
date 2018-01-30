Received: from eggs.gnu.org ([2001:4830:134:3::10]:49047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZ6w-0002VQ-6X
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:50:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZ6r-00024s-K6
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:50:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47202)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egZ6r-00024d-Au
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:50:13 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F3DE6B25B
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 16:50:12 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-7-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2601be1e-62e5-13e6-a4eb-e5c3962fb0c0@redhat.com>
Date: Tue, 30 Jan 2018 10:50:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-7-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="409vJ7e6guo96d2slcrzrnsntSMWJjxLX"
Subject: Re: [Qemu-devel] [PATCH 06/18] Typedef the subtypes of QObject in
 qemu/typedefs.h, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--409vJ7e6guo96d2slcrzrnsntSMWJjxLX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2601be1e-62e5-13e6-a4eb-e5c3962fb0c0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 06/18] Typedef the subtypes of QObject in
 qemu/typedefs.h, too
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-7-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-7-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> This renders many inclusions of qapi/qmp/q*.h superfluous.  They'll be
> dropped in the next few commits.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

> +++ b/include/qemu/typedefs.h
> @@ -92,8 +92,13 @@ typedef struct QemuOptsList QemuOptsList;
>  typedef struct QEMUSGList QEMUSGList;
>  typedef struct QEMUTimer QEMUTimer;
>  typedef struct QEMUTimerListGroup QEMUTimerListGroup;
> -typedef struct QObject QObject;
> +typedef struct QBool QBool;
> +typedef struct QDict QDict;
> +typedef struct QList QList;
>  typedef struct QNull QNull;
> +typedef struct QNum QNum;
> +typedef struct QObject QObject;

And sorting QNull before QOjbect while at it, broken since 4d2d5c41a
(it's appalling how often we break sorting, in spite of a comment
requesting it).

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--409vJ7e6guo96d2slcrzrnsntSMWJjxLX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwokEACgkQp6FrSiUn
Q2poHgf/VszGZBiu8P/Nxj8SCGuar5AQOinHeXWUDLd2RGFBn92UbqaVowDCsyFK
M0HoRk7so7hw63bH0Dtd9s9lLvL57O99vWnDYY1jAPxLFnwbGRpT1dqPcmfLynuC
2yfGT3Hj8HtdzBx0YeDj7U01ttYlBTVooQTd3PCfNwV7rsOifEFOfqGVhL+l+n5W
tIxZtPGWVTADDHBYTF6tKbTWMtYgUKR3PupTg+GwMdJ+d4VhmiA7NjOcvTqEKJPp
G5zBELn8++SD7+xSsowiSmRffZxiVaU9ClRLQbn0Rn6CRefDyQnhCxJ+4PPmMPiJ
BRtLPot6zdLUKOSZbjk2ZarwuDr2pA==
=35ja
-----END PGP SIGNATURE-----

--409vJ7e6guo96d2slcrzrnsntSMWJjxLX--
