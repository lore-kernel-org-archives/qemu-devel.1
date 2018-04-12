Received: from eggs.gnu.org ([2001:4830:134:3::10]:40716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6jDO-00022B-Ae
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:53:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6jDJ-0003o9-Qk
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:53:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34090 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f6jDJ-0003na-Kb
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 16:53:01 -0400
References: <20180312183628.394722-9-eblake@redhat.com>
	<20180412175140.GA5406@yuvallap>
From: Eric Blake <eblake@redhat.com>
Message-ID: <db626048-18ff-0a21-c084-aaa79a32b980@redhat.com>
Date: Thu, 12 Apr 2018 15:52:50 -0500
MIME-Version: 1.0
In-Reply-To: <20180412175140.GA5406@yuvallap>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LfHp3sT6mTvfCitZeG3oWSaIJUTJbUMCt"
Subject: Re: [Qemu-devel] [PULL, 08/36] qapi: Remove qobject_to_X() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LfHp3sT6mTvfCitZeG3oWSaIJUTJbUMCt
From: Eric Blake <eblake@redhat.com>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <db626048-18ff-0a21-c084-aaa79a32b980@redhat.com>
Subject: Re: [PULL,08/36] qapi: Remove qobject_to_X() functions
References: <20180312183628.394722-9-eblake@redhat.com>
 <20180412175140.GA5406@yuvallap>
In-Reply-To: <20180412175140.GA5406@yuvallap>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2018 12:51 PM, Yuval Shaia wrote:
> Hi Eric,
>=20
> On Mon, Mar 12, 2018 at 01:35:59PM -0500, Eric Blake wrote:
>> From: Max Reitz <mreitz@redhat.com>
>>
>> They are no longer needed now.
>=20
> I'm doing some off-list development which use these functions.
> Unfortunately i'm not subscribed (yet) to qemu-devel so obviously misse=
d
> this email.
>=20
> Is there any alternative to these functions?

Yes, in the patches right before this one.

>=20
> My code looks something like this:
>=20
> QObject *oid;
> unsigned long id;
>=20
> oid =3D qlist_pop(list);
> id =3D qnum_get_uint(qobject_to_qnum(oid));
>=20

id =3D qnum_get_uint(qobject_to(QNum, oid));

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LfHp3sT6mTvfCitZeG3oWSaIJUTJbUMCt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrPxyIACgkQp6FrSiUn
Q2r1XAf/Z6qJUevhpwxn/wfFfV2RW2R3KIcXHAXwUZESoOH6fjKh3yXZUWn5DQxP
k9TActYzBhoNcRlu/v+galNiMfQ80D+nRrKkDNKbkpEPlTHg14skmmfSx7cVu66V
1NDXAPhIfAlyv1f1zswnl15FMNFdUlblP0/HAYenfQHcnHnDjJrVe03qRt8YzFyi
R/ht05y00pXqjqH7hUTTgEExmkcpEPtaZgAZJXuQalZbg+3+C7Hwjgc97XXft42x
2Twhu5kxZc/PHbVplbstDJzWIWEBEUj3GT1YFBLzkockLdgBsPW4jhHORFfRx99A
mT/0wfsdsu6JjfbtTUge2J76/Eynpw==
=BqIm
-----END PGP SIGNATURE-----

--LfHp3sT6mTvfCitZeG3oWSaIJUTJbUMCt--
