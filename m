Received: from eggs.gnu.org ([2001:4830:134:3::10]:33330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d35gb-0007Va-C9
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d35gY-0008VI-QE
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:59:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d35gY-0008Uj-Fh
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 14:59:38 -0400
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
	<1491575431-32170-6-git-send-email-amarnath.valluri@intel.com>
	<e8ebc62a-63eb-c4c8-3f80-5e67d10b42ed@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1614e603-2d69-296b-cc31-716e710937e3@redhat.com>
Date: Tue, 25 Apr 2017 13:59:34 -0500
MIME-Version: 1.0
In-Reply-To: <e8ebc62a-63eb-c4c8-3f80-5e67d10b42ed@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XnKGrBt9N16ej1jpKT4mgSIiCpm8rd32k"
Subject: Re: [Qemu-devel] [PATCH v2 5/9] tmp backend: Add new api to read
 backend TpmInfo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>, Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XnKGrBt9N16ej1jpKT4mgSIiCpm8rd32k
From: Eric Blake <eblake@redhat.com>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Amarnath Valluri <amarnath.valluri@intel.com>, qemu-devel@nongnu.org
Cc: patrick.ohly@intel.com, marcandre.lureau@gmail.com
Message-ID: <1614e603-2d69-296b-cc31-716e710937e3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/9] tmp backend: Add new api to read
 backend TpmInfo
References: <1491575431-32170-1-git-send-email-amarnath.valluri@intel.com>
 <1491575431-32170-6-git-send-email-amarnath.valluri@intel.com>
 <e8ebc62a-63eb-c4c8-3f80-5e67d10b42ed@linux.vnet.ibm.com>
In-Reply-To: <e8ebc62a-63eb-c4c8-3f80-5e67d10b42ed@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/25/2017 01:51 PM, Stefan Berger wrote:

>> +++ b/qapi-schema.json
>> @@ -5140,6 +5140,16 @@
>>   { 'command': 'query-tpm-types', 'returns': ['TpmType'] }
>>
>>   ##
>> +# @TPMOptions:
>> +#
>> +# Base type for TPM options
>> +#
>> +# Since: 2.10
>> +##
>> +{ 'struct': 'TPMOptions',
>> +  'data': { } }
>> +
>> +##
>>   # @TPMPassthroughOptions:
>>   #
>>   # Information about the TPM passthrough type
>> @@ -5151,20 +5161,9 @@
>>   #
>>   # Since: 1.5
>>   ##
>> -{ 'struct': 'TPMPassthroughOptions', 'data': { '*path' : 'str',
>> -                                             '*cancel-path' : 'str'} =
}
>> +{ 'struct': 'TPMPassthroughOptions', 'base': 'TPMOptions',
>> +  'data': { '*path' : 'str', '*cancel-path' : 'str'} }
>=20
>=20
> I don't think that you can change it like this anymore since this is
> part of the public interface.

The change is backwards compatible; it doesn't break any existing QMP
usage.  It's weird to have an empty base class, though.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XnKGrBt9N16ej1jpKT4mgSIiCpm8rd32k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/5yWAAoJEKeha0olJ0NqEVQIAIETgcR/GgRqjtbB2uaDN7M4
kN2rsg5rHgvKSaQrevWKhjHT4kAPyfgFUeCaLBkOhQjZDQ7tx3nL4l232efgpohh
d/9OreWED1kLkQGUuA0YZuS7sa37NOycqY/xgj6g6stSHGhpa/vxSPVdETEXLAbt
knHwPT/rlV9aboeYfWpB23d23DZSgCiafjfCBtDdgSH4KazBSwwbOvXhF1RvVa4X
pr1+rmJqeWI79AKi1PUMv4AxOkQF+QMjMcnMG1bElNfxuSwZdkdTjsqnsRtGyGwb
13/wMFFxkXYNCpGw5hsrvAWTj6ye99zHhOq/M4W8XRwLophDQRpN/w4xAUfc9KU=
=5ZTC
-----END PGP SIGNATURE-----

--XnKGrBt9N16ej1jpKT4mgSIiCpm8rd32k--
