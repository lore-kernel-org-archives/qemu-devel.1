Received: from eggs.gnu.org ([2001:4830:134:3::10]:50439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpggQ-0008JK-T1
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:12:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpggM-00034M-8J
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:12:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dpggL-00033w-Tl
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:12:18 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31A105AFD9
	for <qemu-devel@nongnu.org>; Wed,  6 Sep 2017 20:12:16 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-12-eblake@redhat.com>
	<f065d46f-e295-b4dd-ed9b-a2708b89b5a2@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4edd36c2-771c-587c-fd45-01dd1f40f8b0@redhat.com>
Date: Wed, 6 Sep 2017 15:12:12 -0500
MIME-Version: 1.0
In-Reply-To: <f065d46f-e295-b4dd-ed9b-a2708b89b5a2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9f9C1Hqdm1Uo5x049mWqHkCCKg2pEuJtO"
Subject: Re: [Qemu-devel] [PATCH v6 11/29] libqtest: Inline
 qtest_query_target_endianness()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9f9C1Hqdm1Uo5x049mWqHkCCKg2pEuJtO
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com
Message-ID: <4edd36c2-771c-587c-fd45-01dd1f40f8b0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 11/29] libqtest: Inline
 qtest_query_target_endianness()
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-12-eblake@redhat.com>
 <f065d46f-e295-b4dd-ed9b-a2708b89b5a2@redhat.com>
In-Reply-To: <f065d46f-e295-b4dd-ed9b-a2708b89b5a2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 04:25 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> There was only one caller; it's easier to inline things.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/libqtest.c | 22 ++++++----------------
>>  1 file changed, 6 insertions(+), 16 deletions(-)
>>

>=20
> Ah, well, now that's another way of getting rid of the forward
> declaration in the previous patch - so may I suggest to drop the
> previous patch, and simply do the code inlining here instead?

Will do.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--9f9C1Hqdm1Uo5x049mWqHkCCKg2pEuJtO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmwVpwACgkQp6FrSiUn
Q2rFnwgAhRCiiXly6s6Fj0ECpnxbLod5jXyEBYoPJzWEZihzJ/wmNL1WGzwv55ta
TqNlTTqWWjgwhc8n1NJ85GS1ZX9W7yDqSraZnF8tTeYWdCBfQkm1Dfmef7hN+aR9
nIVlIpBqibFxF2VBR2pFKcIPvD0vPXWet8do05/T6xPUM6cWRYeXLh7GscU4EsQm
9WkTqkPcIUIID6Eu6uoB44GNq+p03hPXGLb9kHa4IQsFoiDVvbK4ApExwdiU7cEf
0loI/psPOjYx+i0pS/D1zY00kH9gKQ7fZ2fLtRFscp9aGMoYOlCFQA0ZNaXB1CCW
xQ3GlHdWuPqSO1SkbcjyqzgYv827tA==
=RKMA
-----END PGP SIGNATURE-----

--9f9C1Hqdm1Uo5x049mWqHkCCKg2pEuJtO--
