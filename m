Received: from eggs.gnu.org ([2001:4830:134:3::10]:33389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcA5G-0003J3-DS
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:46:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcA5B-0003TF-U7
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:46:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcA5B-0003Se-K6
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 08:46:01 -0400
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
	<20170729131159.24949-2-vsementsov@virtuozzo.com>
	<20170731091908.GB11830@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34710b90-c98b-2400-6983-213f8a095329@redhat.com>
Date: Mon, 31 Jul 2017 07:45:52 -0500
MIME-Version: 1.0
In-Reply-To: <20170731091908.GB11830@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gmvEtt3uJusVc9fh8ujDDMWeIScQofufI"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] coding_style: add point about 0x in
 trace-events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com, jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gmvEtt3uJusVc9fh8ujDDMWeIScQofufI
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, mreitz@redhat.com,
 jsnow@redhat.com, den@openvz.org, peter.maydell@linaro.org,
 berrange@redhat.com
Message-ID: <34710b90-c98b-2400-6983-213f8a095329@redhat.com>
Subject: Re: [PATCH v2 1/4] coding_style: add point about 0x in trace-events
References: <20170729131159.24949-1-vsementsov@virtuozzo.com>
 <20170729131159.24949-2-vsementsov@virtuozzo.com>
 <20170731091908.GB11830@stefanha-x1.localdomain>
In-Reply-To: <20170731091908.GB11830@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/31/2017 04:19 AM, Stefan Hajnoczi wrote:
> On Sat, Jul 29, 2017 at 04:11:56PM +0300, Vladimir Sementsov-Ogievskiy =
wrote:
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> ---
>>  CODING_STYLE | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/CODING_STYLE b/CODING_STYLE
>> index 2fa0c0b65b..2e6a0507be 100644
>> --- a/CODING_STYLE
>> +++ b/CODING_STYLE
>> @@ -123,3 +123,26 @@ We use traditional C-style /* */ comments and avo=
id // comments.
>> =20
>>  Rationale: The // form is valid in C99, so this is purely a matter of=

>>  consistency of style. The checkpatch script will warn you about this.=

>> +
>> +8. trace-events style
>> +
>> +In trace-events files use '0x' prefix to specify hex numbers, as in:
>=20
> s/use '0x' prefix/use a '0x' prefix/

Also s/files/files,/

>=20
>> +
>> +some_trace(unsigned x, uint64_t y) "x 0x%x y 0x" PRIx64
>> +
>> +The exclusion is a group of numbers, separated by symbols '.', '/', '=
:', ' ':
>=20
> A little bit more background helps make this exception clearer:
>=20
> "An exception is made for groups of numbers that are hexadecimal by
> convention and separated by the symbols '.', '/', ':', or ' ' (such as
> PCI bus addresses):"
>=20
>> +
>> +some_other_trace(unsigned a, unsigned b, unsigned c) "num %x.%x.%x"
>> +
>> +However, you can use '0x' for such groups if you want. Anyway, be sur=
e that
>> +it is obvious that numbers are in hex, ex.:
>> +
>> +data_dump(uint8_t c1, uint8_t c2, uint8_t c3) "bytes (in hex): %02x %=
02x %02x"
>> +
>> +For consistency do not use printf flag '#', like '%#x'.
>> +
>> +Rationale: hex numbers are hard to read in logs when there no 0x pref=
ix,

The position of the rationale makes it sound like it applies to the last
paragraph (about avoiding %#x) rather than the section; but %#x provides
a 0x prefix (most of the time).  Better might be to have the rationale
on hex numbers being hard to read first, then the paragraph on avoiding
%#x, with a second rationale that %#x omits the 0x for the value 0 which
makes output inconsistent; or keep a single rationale paragraph, but add
a sentence to it explaining why %#x is not as nice.

>=20
> s/there no/there is no/
>=20
>> +especially when (occasionally) the representation doesn't contain any=
 letters
>> +and especially in one line with other decimal numbers. Number groups =
are
>> +allowed to not use '0x' because for some things notations like %x.%x.=
%x are
>> +used not only in Qemu. Also dumping raw data bytes with '0x' is less =
readable.
>> --=20
>> 2.11.1
>>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gmvEtt3uJusVc9fh8ujDDMWeIScQofufI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll/JoAACgkQp6FrSiUn
Q2qPmwf/Yhwb0THvUJcvN2c6Ax2WqYJfDHQI0AUcxDMRg4X8caqzET5Fijb+min8
CO/SXF639IKudsryE8+4rZl3ri6EUeevEh1P2OTjPfYNrkVUl51qjR7F0+c22PSI
cS4btM47BCMvanYNvJaRmtUZnaHtgwEE+joEvjeUvEzl8QbiclbnH+06ByhrREGe
wZVS+PQFd5lvIinmeut/LnekEhob4a2KygeJguarRWx1tXKT1sxZduE+1MpIPQ6X
XuPQBnJlzF2CMPEgNOMxXvBoi8dqzNlwlcPQIbM/ZLN4mK8MtxRFEnnkk5IHkBKL
Z3OU5SPc0/FnFMubfFchk8NfYgZxYA==
=djzx
-----END PGP SIGNATURE-----

--gmvEtt3uJusVc9fh8ujDDMWeIScQofufI--
