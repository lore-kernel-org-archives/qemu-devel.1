Received: from eggs.gnu.org ([2001:4830:134:3::10]:50863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFhxr-0003FK-Gz
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:17:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFhxn-0004Fc-G4
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:17:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFhxn-0004FU-8G
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:17:35 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6085CC059722
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 14:17:34 +0000 (UTC)
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
	<20170509173559.31598-4-marcandre.lureau@redhat.com>
	<87tw4cn7sh.fsf@dusky.pond.sub.org> <20170530034000.GA10390@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0d78167-e9c2-9519-90ae-8a68e5ce1236@redhat.com>
Date: Tue, 30 May 2017 09:17:29 -0500
MIME-Version: 1.0
In-Reply-To: <20170530034000.GA10390@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="DIBU8tjRu0Udlou8agv8KRHCr2gcSoItu"
Subject: Re: [Qemu-devel] [PATCH 03/17] tests: remove alt num-int cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--DIBU8tjRu0Udlou8agv8KRHCr2gcSoItu
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <a0d78167-e9c2-9519-90ae-8a68e5ce1236@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/17] tests: remove alt num-int cases
References: <20170509173559.31598-1-marcandre.lureau@redhat.com>
 <20170509173559.31598-4-marcandre.lureau@redhat.com>
 <87tw4cn7sh.fsf@dusky.pond.sub.org> <20170530034000.GA10390@lemon.lan>
In-Reply-To: <20170530034000.GA10390@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/29/2017 10:40 PM, Fam Zheng wrote:

> In-Reply-To: <20170509173559.31598-4-marcandre.lureau@redhat.com>
> 	(=3D?utf-8?Q?=3D22Marc-Andr=3DC3=3DA9?=3D
> 	Lureau"'s message of "Tue, 9 May 2017 20:35:45 +0300")
>=20

>> in-reply-to     =3D       "In-Reply-To:" 1*msg-id CRLF
>>

msg-id          =3D       [CFWS] "<" id-left "@" id-right ">" [CFWS]

then looking at 3.2.3 on folding white space and comments:

CFWS            =3D       *([FWS] comment) (([FWS] comment) / FWS)

comment         =3D       "(" *([FWS] ccontent) [FWS] ")"

> I can imagine if consider CFWS, patchew should probably just work (I ca=
n fix
> that), but it's still good to understand this.

So yes, I think the comment is valid per the grammar, and patchew should
be taught to recognize it.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--DIBU8tjRu0Udlou8agv8KRHCr2gcSoItu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLX75AAoJEKeha0olJ0Nqd/cH/jtrZQnPW7w4S86HZ4loysbz
Lp14W/k2wVOJhWo/UmefZizEYqpB/quFlgyKDxRHzqDZhltrqUYWCevAcL9I61Uh
vARO3FUGU4UhRn4+5swsSH1w/p7XdqZLTEFvxrpbGY2MmtVMknnp+bwNVQ8ZGyCG
5b1mHssv/KBDU9DaR85p4VeftA3UmiR8Nc2TUCJnRxyo1M1/t4UmvhThQjKufnQ0
f6ewRAnlxFu3zhG6+8H9peQYb/Cgpxcxzx2DEmiL6v5NPWQNStn/aPFxmcu8XaIg
Azkj0WKTmEs8OOqc7CgLuetxj/2ymsHoZRcZzmHEnWFjpnkuviPoMeZHbjM0YkM=
=dmip
-----END PGP SIGNATURE-----

--DIBU8tjRu0Udlou8agv8KRHCr2gcSoItu--
