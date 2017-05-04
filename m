Received: from eggs.gnu.org ([2001:4830:134:3::10]:48913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d66nc-0005rd-Tc
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:47:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d66nb-0006q1-So
	for qemu-devel@nongnu.org; Wed, 03 May 2017 22:47:24 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-10-eblake@redhat.com>
	<7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
	<c942db16-1bd7-57d5-2553-11c9d31c3b50@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fa232fd-2a86-20a0-3d82-cd046f23e151@redhat.com>
Date: Wed, 3 May 2017 21:47:16 -0500
MIME-Version: 1.0
In-Reply-To: <c942db16-1bd7-57d5-2553-11c9d31c3b50@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8Tx5WhXH6F1xkEpdx2HaWI0NRTwHRcT1t"
Subject: Re: [Qemu-devel] [PATCH v10 09/17] qcow2: Optimize write zero of
 unaligned tail cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8Tx5WhXH6F1xkEpdx2HaWI0NRTwHRcT1t
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <2fa232fd-2a86-20a0-3d82-cd046f23e151@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v10 09/17] qcow2: Optimize write zero of
 unaligned tail cluster
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-10-eblake@redhat.com>
 <7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
 <c942db16-1bd7-57d5-2553-11c9d31c3b50@redhat.com>
In-Reply-To: <c942db16-1bd7-57d5-2553-11c9d31c3b50@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 04:24 PM, Eric Blake wrote:

>>> +echo
>>> +echo =3D=3D unaligned image tail cluster, no allocation needed =3D=3D=

>>> +
>>> +CLUSTER_SIZE=3D1024 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((si=
ze + 1024))
>>
>> Any reason for the CLUSTER_SIZE? It passes with 64 kB as well, and I
>> actually think that would be a better test because as it is, the image=
's
>> "unaligned" tail is exactly one cluster (so it isn't really unaligned)=
=2E
>=20
> Uhhh - copy-and-paste?  You're right, that 1024 is too small for what
> I'm actually doing with it.  :(

Actually, the whole test defaults to 4k clusters except when overridden,
but I did learn while hammering at things that we don't have a nice way
to tell that a backing file slightly shorter than the active file
behaves as though we read all zeros for the difference. I'm thinking of
proposing an RFC patch introducing BDRV_BLOCK_EOF, which gets set any
time bdrv_get_block_status() clamps the returns *pnum because it hit
EOF, to see what optimizations fall out elsewhere in the tree as a
result.  (It may not be worth it in the end, but we'll see).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--8Tx5WhXH6F1xkEpdx2HaWI0NRTwHRcT1t
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZCpY0AAoJEKeha0olJ0Nq78UH/16ixEfbyhbvUJdI8s1FwRgm
QCMciYafFeoTu2zGJyQDcoCQNjvveVOtrucN4k/X+3XB9gY2yD415dzUFS8ZSjh7
ifFJX2Z2BezeGPFgOfx1LNVQTwIAz8o8An3TySM7TOgadPpCPwcO7wa5e0xQChZw
XawM0XNhxTLf7JsHRmeBwxwTb06LpQlz2VarmyEQxwmk7IlCQZxvKp0k8pIPpxys
0ELgqMAph1pLqIWj3Lhu/JwfyHG8cpncy6fgcJaosgOIh/onY47ncXd4aOfw9Xic
9buNBS5Q+SW7QqjAPk4Hiug91Ht2CuvjZiEAirwiPEqTCmtC9NaVudNK4vIer34=
=eHqz
-----END PGP SIGNATURE-----

--8Tx5WhXH6F1xkEpdx2HaWI0NRTwHRcT1t--
