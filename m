Received: from eggs.gnu.org ([2001:4830:134:3::10]:48721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVzd2-0003Mk-U9
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:23:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVzcz-0007zw-0i
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:23:28 -0400
Received: from smtp1.ntua.gr ([2001:648:2000:de::183]:64075)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dVzcy-0007yX-KH
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 08:23:24 -0400
Date: Fri, 14 Jul 2017 15:22:21 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170714122221.pyx2pwubtaylqdu6@postretch>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ybzeb565qdyb44zc"
Content-Disposition: inline
In-Reply-To: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v7 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Cc: eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, jani kokkonen <jani.kokkonen@huawei.com>


--ybzeb565qdyb44zc
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pradeep, you might be interested in my work on refactoring the=20
block layer's throttling interface in my series:
https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04191.html

In this series you copy the existing legacy interface we want to get rid=20
of. I think it will be easier work for you to use the changes introduced=20
in my patches when they are merged.=20

Have you thought about using throttle groups? It'd mean many devices=20
sharing the same limits. This way the interfaces can be unified.  Please=20
read docs/throttle.txt and see if it would be useful for you.

--ybzeb565qdyb44zc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAllot30ACgkQc2J8L2kN
9xAP1w//W0fIc3CkxaeSSVbz22OpRK3Hs4GLLdC3Nzhh/bL1IoMcKL1jsnOZmuok
dpm4fL/8eqKGDCTMu9fb0n8WrNMpaAqwYzLJCVBkDST7Mhl7MEsPbZrRoFRC1QVy
bxxH2+EjXK5kCuiN1lLIQrYaCeWCSrJfzejFc7R56GH3GUkE3fyNci0xA872VLXV
luy9McgdxENCYJ6nFuGdz81qbE/vqWyOMmZCfDwHp1NNvXqdFMfvgJAw1Tfu9/5m
2hJydS7wpn84SdenjBozLpS4oCbDIVZLbTb7uzUOcn3ZqaxNiwqcfvYyzUpm5fgE
TTUnjBRb9MNJXKtsuIZK17v0/y22XNGU9iQZeerjtwXdSKHeYrJrkud6uSIfRg1t
OpXx2TgUEtVXw5H7UZndgEG3KL979qskRlBqQCiG/smQ9YaGjoY/7jj8ilfS3e3/
Cvx9m90aI8r4A3GOccn8U+wgDqV+KUAWVKj/63jxQcP769m4gHiXOFGbYYPri7LZ
sdW7lCpJrhLqkf0Kb6LhDAgWzfNusgrqIFbE5SiBOhGG8tjELz7tYr0gE7xLj8KS
gymi0ikRmgGB+2sNlFuKlaHFcOcmKIceE6DzwzIhjVbU8vLXnPRNMwv2hBV3s/Ad
bJIKunzjYGYNZ4SW3KY6h23X9OqY6KuZsmsD3h498RBPD6GpaGU=
=gdPe
-----END PGP SIGNATURE-----

--ybzeb565qdyb44zc--
