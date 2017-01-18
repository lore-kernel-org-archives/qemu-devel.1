Received: from eggs.gnu.org ([2001:4830:134:3::10]:58702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTtwJ-0000oF-Cw
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:22:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTtwE-0002iV-Hl
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:22:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTtwE-0002hS-CK
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 12:22:22 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1380C05B1C8
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 17:22:21 +0000 (UTC)
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-6-pbonzini@redhat.com>
	<20170118145833.GF30347@stefanha-x1.localdomain>
	<b370689f-e600-bde7-bc42-917fc72585f9@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4046b79c-ddce-55ad-946d-cd2df9eef7bc@redhat.com>
Date: Wed, 18 Jan 2017 11:22:19 -0600
MIME-Version: 1.0
In-Reply-To: <b370689f-e600-bde7-bc42-917fc72585f9@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="JRdOEF8wWO56nXbRCWwLfMOQewrntwAFN"
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
 AioContexts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JRdOEF8wWO56nXbRCWwLfMOQewrntwAFN
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <4046b79c-ddce-55ad-946d-cd2df9eef7bc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/16] io: make qio_channel_yield aware of
 AioContexts
References: <20170113131731.1246-1-pbonzini@redhat.com>
 <20170113131731.1246-6-pbonzini@redhat.com>
 <20170118145833.GF30347@stefanha-x1.localdomain>
 <b370689f-e600-bde7-bc42-917fc72585f9@redhat.com>
In-Reply-To: <b370689f-e600-bde7-bc42-917fc72585f9@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/18/2017 10:43 AM, Paolo Bonzini wrote:
> By the way, v2 will have a better comment on how to use the API:
>=20
> + * You can move a #QIOChannel from an #AioContext to another even if

s/from an/from one/

> + * I/O handlers are set for a coroutine.  However, #QIOChannel provide=
s
> + * no synchronization between the calls to qio_channel_yield() and
> + * qio_channel_set_aio_context().
> + *

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--JRdOEF8wWO56nXbRCWwLfMOQewrntwAFN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYf6RLAAoJEKeha0olJ0NqWgsH/0IQ/dfYWrzXPQWBG/20xxSz
ssRY7uQJ0A1Eidf7tD1xuvBHrH6MBJZigGuRHwRAv7NdLnpjRhAHCXiljwzC+7q+
qKAmD+Ra2dfFQ8+5Oj73kEXAIZTMdsJxyfI6eohDdFAYw7Eq3GquncIGsqoolIX5
Y3vTOEhI6SvvmKWVv1bYzJJ5H6x+nPCCJtO0poCG5u5iwUfTJfEJhGrAR6GbzUGd
HuQF1FGJbWtBqiMOPJZGdobnSPgvV1LSCplnoqnNq/22pBA3YU0L8986Lfzn2urC
d0pCeT5X6VyaFR3e8e0h4f0KmpeXTH08OL3ZYPHvJIo92T7sqwXBpeRH7319L4E=
=dKgY
-----END PGP SIGNATURE-----

--JRdOEF8wWO56nXbRCWwLfMOQewrntwAFN--
