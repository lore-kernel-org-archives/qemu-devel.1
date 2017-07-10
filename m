Received: from eggs.gnu.org ([2001:4830:134:3::10]:36627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZiS-0000J6-NI
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUZiR-00075k-Ml
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 10:31:12 -0400
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
	<1498733831-15254-2-git-send-email-pl@kamp.de>
	<20170710125857.GD5772@noname.redhat.com>
	<11427303-a0cd-ee7b-edb4-1cdf9b90c0af@kamp.de>
	<20170710135021.GJ5772@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c435ac9c-6076-aed0-feb9-2eca465df1de@redhat.com>
Date: Mon, 10 Jul 2017 09:31:02 -0500
MIME-Version: 1.0
In-Reply-To: <20170710135021.GJ5772@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3MT77N7fMUFW8CKWU7OmwRpCNkiLCa4Uf"
Subject: Re: [Qemu-devel] [PATCH V2 1/8] docs: add compress format extension
 to qcow2 spec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3MT77N7fMUFW8CKWU7OmwRpCNkiLCa4Uf
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, lersek@redhat.com,
 den@openvz.org, mreitz@redhat.com, berrange@redhat.com
Message-ID: <c435ac9c-6076-aed0-feb9-2eca465df1de@redhat.com>
Subject: Re: [PATCH V2 1/8] docs: add compress format extension to qcow2 spec
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
 <1498733831-15254-2-git-send-email-pl@kamp.de>
 <20170710125857.GD5772@noname.redhat.com>
 <11427303-a0cd-ee7b-edb4-1cdf9b90c0af@kamp.de>
 <20170710135021.GJ5772@noname.redhat.com>
In-Reply-To: <20170710135021.GJ5772@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 08:50 AM, Kevin Wolf wrote:

> We have regretted enough things that were defined a bit sloppily just
> for convenience that I'd rather not make this mistake again when we can=

> avoid it.

Agreed.  Another consideration: defining redundant information is
trickier to maintain because correct implementations have to check that
both points are consistent with one another.

>=20
>>>> +         17 - 19:  Reserved for future use, must be zero.
>>> We don't need this for now because byte 16 will be the final one in t=
his
>>> struct.
>>>
>>>> +         20 - 23:  extra_data_size
>>>> +                   Size of compress format specific extra data.
>>>> +                   For now, as no format specifies extra data,
>>>> +                   extra_data_size is reserved and should be zero.
>>>> +
>>>> +        variable:  extra_data
>>>> +                   Extra data with additional parameters for the co=
mpress
>>>> +                   format, occupying extra_data_size bytes.
>>> extra_data_size isn't necessary because we already have the length of=

>>> the header extension, so we know how long the whole thing is.
>>> extra_data isn't necessary because we'll just add new fields at the e=
nd
>>> if we want to add something.
>>
>> I was asked to add it altough it is redundant.
>=20
> Who asked this, and did they have a good reason for it?

May have been me, or may have been implied by my comments, but I agree
that the overall extension header covers this, so we don't need a
redundant form.  So as long as the overall extension header length is
good enough, I'm okay avoiding redundancies.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3MT77N7fMUFW8CKWU7OmwRpCNkiLCa4Uf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY4+mAAoJEKeha0olJ0NqmmIIAJur4GIASmYIInu8cUGIX7cZ
Btdj3lkakTcgGPf2RGrMVlclRu/32KlYWoRjDlQ7R+SiSgii8mMGBpXZwZwHEq9P
Ah4hrN9WlSEKyc4Bx7J0Iuz6RoPdyCE3tQ7jB2ZOGKxx7mMt95DB0IJOIbpDdhPR
EHvR4vaI8PbYFEobgZxg7suubrCoaalsN4mg4mF9whgStiJbfh5wAABEUcuHY2iL
0yqIA+b2n7TQkI24H8g9aaRDCla5j4wPYUe5x2N226Z7e3phKYk/C3FuMLb9+5WU
VCUY0za1YROyazBlZRwyOZjrm99Qt4HT36fRV5kx5VWkZSCt6BtFkLR+ofLBlYs=
=LIFh
-----END PGP SIGNATURE-----

--3MT77N7fMUFW8CKWU7OmwRpCNkiLCa4Uf--
