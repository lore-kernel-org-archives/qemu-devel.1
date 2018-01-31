Received: from eggs.gnu.org ([2001:4830:134:3::10]:45603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egv3R-0006kI-Q5
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egv3I-0005xI-DY
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 11:16:09 -0500
References: <20180120154412.9990-1-mreitz@redhat.com>
	<20180120154412.9990-3-mreitz@redhat.com>
	<94fe98ba-1db0-61b2-3df6-7bc9db988885@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <413829fb-06ec-7685-b3d7-90c0e5d687a6@redhat.com>
Date: Wed, 31 Jan 2018 10:14:50 -0600
MIME-Version: 1.0
In-Reply-To: <94fe98ba-1db0-61b2-3df6-7bc9db988885@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NWgwjhDTP6cUY7G8nN4APwTy9aTZB6eFW"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NWgwjhDTP6cUY7G8nN4APwTy9aTZB6eFW
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <413829fb-06ec-7685-b3d7-90c0e5d687a6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: Replace qobject_to_X(o) by
 qobject_to(o, X)
References: <20180120154412.9990-1-mreitz@redhat.com>
 <20180120154412.9990-3-mreitz@redhat.com>
 <94fe98ba-1db0-61b2-3df6-7bc9db988885@redhat.com>
In-Reply-To: <94fe98ba-1db0-61b2-3df6-7bc9db988885@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2018 10:11 AM, Eric Blake wrote:
> On 01/20/2018 09:44 AM, Max Reitz wrote:
>> This patch was generated using the following Coccinelle script:
>>
>> @@
>> expression Obj;
>> @@
>> (
>> - qobject_to_qnum(Obj)
>> + qobject_to(Obj, QNum)
>> |
>> - qobject_to_qstring(Obj)
>> + qobject_to(Obj, QString)
>> |
>> - qobject_to_qdict(Obj)
>> + qobject_to(Obj, QDict)
>> |
>> - qobject_to_qlist(Obj)
>> + qobject_to(Obj, QList)
>> |
>> - qobject_to_qbool(Obj)
>> + qobject_to(Obj, QBool)
>> )
>=20
> Worth adding these to scripts/coccinelle/qobject.cocci?

Answering myself - perhaps not, since 3/6 deletes the functions meaning
they won't reappear as something we need to keep checking for.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NWgwjhDTP6cUY7G8nN4APwTy9aTZB6eFW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpx63oACgkQp6FrSiUn
Q2q+FggAnPTiM7K5GQ+G3CAM0RhR/+WQxpahsiWWn8FmOQ8OaF7v72jcY28HNrgl
Z9lBBelUhL+YuI8S2ny1DqdqcfZoOHbfV+NLx0Ss3Uqo27xctZCM0XNoUnF1C1Ys
C+irsDCKrrDUNYCFm7u1lEvX47uUhrDPEJ4i+TLPG+h8l28T0SJJbrD+CnC8VEgR
agpdUlMA26kpCwSOoPOSv7FknqCQiR0xnm/V5wJtxt7NC1LDDYIEBDzwN/Si345c
l4exQ7eTRQiUHjvJRmMt8wkZldcCZ323gk4NnIz79qaSPodAeG0iWfM93OcUcy5T
Ad74yPY5jqZ1OpsTx7dxjPBAtCBbwQ==
=V/JP
-----END PGP SIGNATURE-----

--NWgwjhDTP6cUY7G8nN4APwTy9aTZB6eFW--
