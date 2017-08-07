Received: from eggs.gnu.org ([2001:4830:134:3::10]:36472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degDv-0004Dm-HG
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degDq-00070f-It
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:29:27 -0400
References: <20170804140848.880-1-berto@igalia.com>
	<0c382c84-1135-56b6-d90f-1c44e33f1f00@redhat.com>
	<w51y3qvn4y4.fsf@maestria.local.igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <63b22cb5-9753-85cc-283e-1b0b7710bcbf@redhat.com>
Date: Mon, 7 Aug 2017 06:29:09 -0500
MIME-Version: 1.0
In-Reply-To: <w51y3qvn4y4.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kkgaAJNDcPwCGx8Cs4qBCH4ovmOVBhtgV"
Subject: Re: [Qemu-devel] [PATCH for-2.10] quorum: Handle bdrv_getlength()
 failures in quorum_co_flush()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kkgaAJNDcPwCGx8Cs4qBCH4ovmOVBhtgV
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org
Message-ID: <63b22cb5-9753-85cc-283e-1b0b7710bcbf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10] quorum: Handle bdrv_getlength()
 failures in quorum_co_flush()
References: <20170804140848.880-1-berto@igalia.com>
 <0c382c84-1135-56b6-d90f-1c44e33f1f00@redhat.com>
 <w51y3qvn4y4.fsf@maestria.local.igalia.com>
In-Reply-To: <w51y3qvn4y4.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 03:43 AM, Alberto Garcia wrote:
> On Fri 04 Aug 2017 05:44:00 PM CEST, Eric Blake wrote:
>>> --- a/block/quorum.c
>>> +++ b/block/quorum.c
>>> @@ -785,8 +785,9 @@ static coroutine_fn int quorum_co_flush(BlockDriv=
erState *bs)
>>>      for (i =3D 0; i < s->num_children; i++) {
>>>          result =3D bdrv_co_flush(s->children[i]->bs);
>>>          if (result) {
>>> +            int64_t length =3D bdrv_getlength(s->children[i]->bs);
>>>              quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
>>> -                              bdrv_getlength(s->children[i]->bs),
>>> +                              length > 0 ? length : 0,
>>
>> In the fallback case, is always picking 0 good enough?  Then again,
>> this is in the error path, so it is unlikely in practice, and I don't
>> see any better way to handle it.
>=20
> I don't see any better way to handle it either, and I'm not sure that i=
t
> matters much: this is a flush error event, the 'sectors-count' field
> doesn't even mean anything, but we have to put something there.

If that's the case, can we ALWAYS report 0, instead of usually the
length and sometimes 0?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kkgaAJNDcPwCGx8Cs4qBCH4ovmOVBhtgV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmITwUACgkQp6FrSiUn
Q2rT8wf5AcQMaJuOA2i+ZH8l1ALVjKz07eGcThZ5CAUFHkIgi7x4ztIQgizwpPRj
odVsmXmS6Uaepq9aNSdzKKU4MBkfS8vDFqc4JPVtSPDJzDuFUzg7P8s9rzqbgsA5
U8HRsXuC28/Kj0KBQBEE5dldrYVXGpgfE10zCE/1VguOOsvTHBcfHeF5u+uICUh2
mzkPPxO2GSGPlnms+0zHAdh2KbvB3FqRcG5cRbrC/kwmpDgZIaf69WKEYi/UGdUo
XZgZHEJjvN+pI8EPxrg26jFGg7BLeSMHgy1eywCB78fSPEgNQKKllu1BEZMy6b8O
VhCrapJ1vNVnJs+iciCaDpJFCeuaDA==
=7vSY
-----END PGP SIGNATURE-----

--kkgaAJNDcPwCGx8Cs4qBCH4ovmOVBhtgV--
