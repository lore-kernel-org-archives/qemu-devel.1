Received: from eggs.gnu.org ([2001:4830:134:3::10]:47079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTzz-0004Fp-5u
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:05:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSTzy-0007y9-71
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 17:05:11 -0400
References: <20180611205203.2624-1-mreitz@redhat.com>
	<20180611205203.2624-5-mreitz@redhat.com>
	<b47ba7b8-9771-ab66-591e-2c73451f709d@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d841d1e8-441c-412c-a693-fa79ab2e08d5@redhat.com>
Date: Mon, 11 Jun 2018 23:05:01 +0200
MIME-Version: 1.0
In-Reply-To: <b47ba7b8-9771-ab66-591e-2c73451f709d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="u0KsNzA89L1cKQY6DBmoPfVTMBdbOlfcT"
Subject: Re: [Qemu-devel] [PATCH v2 04/10] qapi: Formalize qcow2 encryption
 probing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u0KsNzA89L1cKQY6DBmoPfVTMBdbOlfcT
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <d841d1e8-441c-412c-a693-fa79ab2e08d5@redhat.com>
Subject: Re: [PATCH v2 04/10] qapi: Formalize qcow2 encryption probing
References: <20180611205203.2624-1-mreitz@redhat.com>
 <20180611205203.2624-5-mreitz@redhat.com>
 <b47ba7b8-9771-ab66-591e-2c73451f709d@redhat.com>
In-Reply-To: <b47ba7b8-9771-ab66-591e-2c73451f709d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-11 23:02, Eric Blake wrote:
> On 06/11/2018 03:51 PM, Max Reitz wrote:
>> Currently, you can give no encryption format for a qcow2 file while
>> still passing a key-secret.=C2=A0 That does not conform to the schema,=
 so
>> this patch changes the schema to allow it.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>> =C2=A0 qapi/block-core.json | 44 +++++++++++++++++++++++++++++++++++++=
+++----
>> =C2=A0 block/qcow2.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 3 +++
>> =C2=A0 2 files changed, 43 insertions(+), 4 deletions(-)
>=20
>> +##
>> +# @ImageInfoSpecificQCow2EncryptionNoInfo:
>> +#
>> +# Only used for the qcow2 encryption format "auto" in which the actua=
l
>> +# encryption format is determined from the image header.=C2=A0 Theref=
ore,
>> +# this encryption format will never be reported in
>> +# ImageInfoSpecificQCow2Encryption.
>> +#
>> +# Since: 3.0
>> +##
>> +{ 'struct': 'ImageInfoSpecificQCow2EncryptionNoInfo',
>> +=C2=A0 'data': { } }
>=20
> Do we actually need this type, given Anton's work on making omitted
> branches automatically use an empty struct?
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06836.html

Looks like no, we don't.  Great! :-)

I think I'll still keep part of the comment and move it down into the
description of ImageInfoSpecificQCow2Encryption so that anyone who's
wondering knows that this value won't appear.

Thanks for reviewing and pointing me at it,

Max


--u0KsNzA89L1cKQY6DBmoPfVTMBdbOlfcT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlse4/0ACgkQ9AfbAGHV
z0BWxAf+M99EJyJcK9adUJxUsb1xOTs/+mPI70ASSnhZI+GNy5eY5uqWSQY6P5j3
7BmggaKxNA6pJfhenR4RT6d2/+l6be+QnDncxIh+JgtKo6+UaabDWPKjq5BlEizw
HsM8lQddVny3fdxPGSIhfAEr4+CPJFmH9nuIjzSLLkEjcfhBnjymbI/Q1clVVQyG
4/6P05gxubrhgpNnYnPjyh/p/yABKmuTiOdL6ut1G99mAtrIFvVZ4QpPhX8hHQyW
rt2z4ghgnT5hqR44EGo7SA9+pivRz2S+qO6/2/bRJF2TCz146/sCojVn5bFsMMLo
QNckMsjZKq7zDJDstIK7tcbBIctY5w==
=EqXO
-----END PGP SIGNATURE-----

--u0KsNzA89L1cKQY6DBmoPfVTMBdbOlfcT--
