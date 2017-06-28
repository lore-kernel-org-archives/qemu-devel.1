Received: from eggs.gnu.org ([2001:4830:134:3::10]:45690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQFQh-0005FT-T9
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQFQg-0005Pf-Mq
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 12:02:59 -0400
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
	<20170623124700.1389-6-el13635@mail.ntua.gr>
	<20170628155042.GJ5378@noname.redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61521682-b70e-0690-0005-4e05cce821fd@redhat.com>
Date: Wed, 28 Jun 2017 11:02:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170628155042.GJ5378@noname.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gbj460WrdXEb7SiRUbJgKWmnpxpkFw2qa"
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Gbj460WrdXEb7SiRUbJgKWmnpxpkFw2qa
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Message-ID: <61521682-b70e-0690-0005-4e05cce821fd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 5/8] block: add
 BlockDevOptionsThrottle to QAPI
References: <20170623124700.1389-1-el13635@mail.ntua.gr>
 <20170623124700.1389-6-el13635@mail.ntua.gr>
 <20170628155042.GJ5378@noname.redhat.com>
In-Reply-To: <20170628155042.GJ5378@noname.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 10:50 AM, Kevin Wolf wrote:
> Am 23.06.2017 um 14:46 hat Manos Pitsidianakis geschrieben:
>> This is needed to configure throttle filter driver nodes with QAPI.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  qapi/block-core.json | 19 ++++++++++++++++++-
>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index f85c2235c7..1d4afafe8c 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -2119,7 +2119,7 @@
>>              'host_device', 'http', 'https', 'iscsi', 'luks', 'nbd', '=
nfs',
>>              'null-aio', 'null-co', 'parallels', 'qcow', 'qcow2', 'qed=
',
>>              'quorum', 'raw', 'rbd', 'replication', 'sheepdog', 'ssh',=

>> -            'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs' ] }
>> +            'throttle', 'vdi', 'vhdx', 'vmdk', 'vpc', 'vvfat', 'vxhs'=
 ] }
>> =20
>>  ##
>>  # @BlockdevOptionsFile:
>> @@ -2984,6 +2984,7 @@
>>        'replication':'BlockdevOptionsReplication',
>>        'sheepdog':   'BlockdevOptionsSheepdog',
>>        'ssh':        'BlockdevOptionsSsh',
>> +      'throttle':   'BlockdevOptionsThrottle',
>>        'vdi':        'BlockdevOptionsGenericFormat',
>>        'vhdx':       'BlockdevOptionsGenericFormat',
>>        'vmdk':       'BlockdevOptionsGenericCOWFormat',
>> @@ -3723,3 +3724,19 @@
>>    'data' : { 'parent': 'str',
>>               '*child': 'str',
>>               '*node': 'str' } }
>> +
>> +##
>> +# @BlockdevOptionsThrottle:
>> +#
>> +# Driver specific block device options for Throttle
>> +#
>> +# @throttling-group: the name of the throttling group to use
>> +#
>> +# @options:        BlockIOThrottle options
>=20
> Missing #optional marker.

The marker is now auto-generated based solely on the '*options' below,
so we don't need a redundant thing here.

>=20
>> +# Since: 2.9
>> +##
>> +{ 'struct': 'BlockdevOptionsThrottle',
>> +  'data': { 'throttling-group': 'str',
>> +            'file' : 'BlockdevRef',
>> +            '*options' : 'BlockIOThrottle'
>> +             } }
>=20
> Didn't we intend to make 'throttling-group' optional, too?
>=20
> If we don't, then the question of anonymous ThrottleGroup objects is
> kind of moot (not completely because -drive isn't bound to the schema,
> but in that case we should just error out there too if it's missing).
>=20
> Kevin
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Gbj460WrdXEb7SiRUbJgKWmnpxpkFw2qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZU9MlAAoJEKeha0olJ0NqF8kH/0Zt8oHTmb/1Y561UXwmjzyW
exgU4zlSlP9r/VYkih4x2Y2gbowiFQUhQ1a7IzTiCwffVBuOgPIUgbN9UkG27W2K
fVqsdju/L8GO5a+u/6YIVihb7Trn5G084baVIPmMxuvz3K+ZCvOXcEPHn3T4Q7SZ
28mBhPwAPi9AuPs5tYbuT4WusMvbxavOid7Ufq2ddDD6WJn39ORVskx7Y2iePBZc
WhRGR+CMat/OlU26UhkEX3LC+/VHpSShB0ejfppUkwxH1SW9jmfTsbm+3A1tPHdN
EyF1cTirBXuN+bbNdIxq1U4a6kWXe1JMHHD7PwCmjMijQrNxB0Ut1R9cXydFAuc=
=xAUu
-----END PGP SIGNATURE-----

--Gbj460WrdXEb7SiRUbJgKWmnpxpkFw2qa--
