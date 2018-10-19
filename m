Received: from eggs.gnu.org ([2001:4830:134:3::10]:42101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRaH-00081j-AR
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:00:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gDRaF-0005df-VC
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 06:00:45 -0400
References: <20181015172817.19796-1-mreitz@redhat.com>
	<20181015172817.19796-2-mreitz@redhat.com>
	<20181016121204.GE5620@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7f3ca9eb-7e01-f107-07ba-f53e6de127b4@redhat.com>
Date: Fri, 19 Oct 2018 12:00:22 +0200
MIME-Version: 1.0
In-Reply-To: <20181016121204.GE5620@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nc6CIj5yhdZYjEVaicOQ8Ar9TRAvN8dBB"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/5] option: Make option help
 nicer to read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nc6CIj5yhdZYjEVaicOQ8Ar9TRAvN8dBB
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Message-ID: <7f3ca9eb-7e01-f107-07ba-f53e6de127b4@redhat.com>
Subject: Re: [Qemu-block] [PATCH 1/5] option: Make option help nicer to read
References: <20181015172817.19796-1-mreitz@redhat.com>
 <20181015172817.19796-2-mreitz@redhat.com>
 <20181016121204.GE5620@dhcp-200-186.str.redhat.com>
In-Reply-To: <20181016121204.GE5620@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 16.10.18 14:12, Kevin Wolf wrote:
> Am 15.10.2018 um 19:28 hat Max Reitz geschrieben:
>> This adds some whitespace into the option help (including indentation)=

>> and replaces '=3D' by ': ' (not least because '=3D' should be used for=

>> values, not types).  Furthermore, the list name is no longer printed a=
s
>> part of every line, but only once in advance, and only if the caller d=
id
>> not print a caption already.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>=20
> If this isn't a bike shedding series, then what is? So...

Sure it is.

>> --- a/tests/qemu-iotests/082.out
>> +++ b/tests/qemu-iotests/082.out
>> @@ -44,171 +44,171 @@ cluster_size: 8192
>> =20
>>  Testing: create -f qcow2 -o help TEST_DIR/t.qcow2 128M
>>  Supported options:
>> -size             Virtual disk size
>> -compat           Compatibility level (0.10 or 1.1)
>> -backing_file     File name of a base image
>> -backing_fmt      Image format of the base image
>> -encryption       Encrypt the image with format 'aes'. (Deprecated in =
favor of encrypt.format=3Daes)
>> -encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
>> -encrypt.key-secret ID of secret providing qcow AES key or LUKS passph=
rase
>> -encrypt.cipher-alg Name of encryption cipher algorithm
>> -encrypt.cipher-mode Name of encryption cipher mode
>> -encrypt.ivgen-alg Name of IV generator algorithm
>> -encrypt.ivgen-hash-alg Name of IV generator hash algorithm
>> -encrypt.hash-alg Name of encryption hash algorithm
>> -encrypt.iter-time Time to spend in PBKDF in milliseconds
>> -cluster_size     qcow2 cluster size
>> -preallocation    Preallocation mode (allowed values: off, metadata, f=
alloc, full)
>> -lazy_refcounts   Postpone refcount updates
>> -refcount_bits    Width of a reference count entry in bits
>> -nocow            Turn off copy-on-write (valid only on btrfs)
>> +  backing_file: str - File name of a base image
>> +  backing_fmt: str - Image format of the base image
>> +  cluster_size: size - qcow2 cluster size
>> +  compat: str - Compatibility level (0.10 or 1.1)
>> +  encrypt.cipher-alg: str - Name of encryption cipher algorithm
>> +  encrypt.cipher-mode: str - Name of encryption cipher mode
>> +  encrypt.format: str - Encrypt the image, format choices: 'aes', 'lu=
ks'
>> +  encrypt.hash-alg: str - Name of encryption hash algorithm
>> +  encrypt.iter-time: num - Time to spend in PBKDF in milliseconds
>> +  encrypt.ivgen-alg: str - Name of IV generator algorithm
>> +  encrypt.ivgen-hash-alg: str - Name of IV generator hash algorithm
>> +  encrypt.key-secret: str - ID of secret providing qcow AES key or LU=
KS passphrase
>> +  encryption: bool (on/off) - Encrypt the image with format 'aes'. (D=
eprecated in favor of encrypt.format=3Daes)
>> +  lazy_refcounts: bool (on/off) - Postpone refcount updates
>> +  nocow: bool (on/off) - Turn off copy-on-write (valid only on btrfs)=

>> +  preallocation: str - Preallocation mode (allowed values: off, metad=
ata, falloc, full)
>> +  refcount_bits: num - Width of a reference count entry in bits
>> +  size: size - Virtual disk size
>=20
> I like the result of this series better than what we have in current
> master. Looking at this patch, however, I must also say that I like the=

> original state better than both.

I don't disagree.  But having the types is indeed a worthy improvement.

> How about aligning the description to the same column again to combine
> the best of both worlds?

That sounds good to me.

Max


--nc6CIj5yhdZYjEVaicOQ8Ar9TRAvN8dBB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvJqzYACgkQ9AfbAGHV
z0CuCAf/Qfmq4oA+a16TYfs/fIYR/FFJh7CDIX3grkHPCEwEV0rBzds3yTWJkhw+
QnbU7hW7xGcTZ1AFKWI94Z9hYPPJPPlRWMKTHYk8GTaSgauEduhPrjYorTAymn4r
df9ucDPNeqf9hgi1FwnWmEnFDRFPTInxOpVTJEhdIJtovYbszT9EuoE38izZjZXG
VCGvwKcKGTtYZbp0uv9nyfovKjWSujkxVQipdW7wfv3a0K/o7w1s5dUgCq+ZDJXl
6Eb3YezOiNtseZxxznQ+f4E4vUg7k2rKbUQAi6bAFdpMea467SuBpxOt5+ix1w1D
9Iky8byFbMDFfZcbcwMmA707sZfFzQ==
=fkMd
-----END PGP SIGNATURE-----

--nc6CIj5yhdZYjEVaicOQ8Ar9TRAvN8dBB--
