Received: from eggs.gnu.org ([2001:4830:134:3::10]:34899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqD8-0004Zt-54
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:05:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebqD4-0000mg-16
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:05:10 -0500
References: <cover.1513342045.git.berto@igalia.com>
	<a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
	<9a8ac19c-6d7c-dee7-174f-ffdee1a1a0d6@redhat.com>
	<w51lggw1p0q.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a17c7fc-d492-a406-8567-278477f733b6@redhat.com>
Date: Wed, 17 Jan 2018 10:04:45 -0600
MIME-Version: 1.0
In-Reply-To: <w51lggw1p0q.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fKM13QgW71sDaMbPuCuM3zSjqyGXaXTni"
Subject: Re: [Qemu-devel] [PATCH v2 13/32] qcow2: Add l2_slice_size field to
 BDRVQcow2State
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fKM13QgW71sDaMbPuCuM3zSjqyGXaXTni
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Denis V . Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Message-ID: <6a17c7fc-d492-a406-8567-278477f733b6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 13/32] qcow2: Add l2_slice_size field to
 BDRVQcow2State
References: <cover.1513342045.git.berto@igalia.com>
 <a000f7552f603b212c85ed76ac5ee4103f04d3a4.1513342045.git.berto@igalia.com>
 <9a8ac19c-6d7c-dee7-174f-ffdee1a1a0d6@redhat.com>
 <w51lggw1p0q.fsf@maestria.local.igalia.com>
In-Reply-To: <w51lggw1p0q.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 09:30 AM, Alberto Garcia wrote:
> On Tue 16 Jan 2018 11:06:21 PM CET, Eric Blake wrote:
>=20
>>>  typedef struct Qcow2ReopenState {
>>>      Qcow2Cache *l2_table_cache;
>>>      Qcow2Cache *refcount_block_cache;
>>> +    int l2_slice_size;
>>
>> Worth a comment?
>> /* Number of entries in a slice of the L2 table */
>=20
> Yeah, why not? I'll add it.

Or see my comments in later patches, that perhaps this is better named
l2_slice_entries.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--fKM13QgW71sDaMbPuCuM3zSjqyGXaXTni
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfdB4ACgkQp6FrSiUn
Q2pHGwgAn/Or63pW7Co4UTEt/G5+gEKxti8BElqjeUZysU0E1cAo3rl6f9bMppmC
kH4fvF7+ujFo3U2Lsvp+sDizmiiM1wTmCOF1Tv0e+mis3WO6dxpl/IQ1OeqnZwGo
5W8Z7T5xGCxsFfONQgZ86vxFTBylWOP3rasv9BhAjRYRJgWhc/fJ6rku1FrkcQc2
lOABTGM3/9FiyBLNq5lV/Y2sifO1JjhUnxzivNUqTZ5hvJYBH655sJqmkCnK1N/R
GflJY9smfxePPTZkRVXSp9y66Ffm1Z9Z5fU1qW0vn226tAXeVQaO8x0ro5DNAIAH
OwjioLFVK/+2XK4wEZ48oV0lV+VJ0Q==
=LF50
-----END PGP SIGNATURE-----

--fKM13QgW71sDaMbPuCuM3zSjqyGXaXTni--
