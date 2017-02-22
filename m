Received: from eggs.gnu.org ([2001:4830:134:3::10]:54423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYm1-00012u-7a
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:24:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cgYly-0006vK-4Y
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:24:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41524)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cgYlx-0006v3-S9
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 10:24:06 -0500
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<8760k3zteg.fsf@dusky.pond.sub.org>
	<3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com>
	<87fuj7r61e.fsf@dusky.pond.sub.org>
	<f72d07f6-e00d-8a9c-0e15-e2bab5b83ee2@redhat.com>
	<868d3cc4-8788-8731-ea7a-4e1336863f45@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <739b5892-fb96-0dfa-802d-51bd7ddea2e9@redhat.com>
Date: Wed, 22 Feb 2017 09:23:57 -0600
MIME-Version: 1.0
In-Reply-To: <868d3cc4-8788-8731-ea7a-4e1336863f45@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xRP3ckWlBpAisVoPMNbAqMwdoVLTgHLMx"
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Markus Armbruster <armbru@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>, "eddie . dong" <eddie.dong@intel.com>, qemu devel <qemu-devel@nongnu.org>, Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xRP3ckWlBpAisVoPMNbAqMwdoVLTgHLMx
From: Eric Blake <eblake@redhat.com>
To: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 "eddie . dong" <eddie.dong@intel.com>, qemu devel <qemu-devel@nongnu.org>,
 Wen Congyang <wencongyang@gmail.com>, bian naimeng <biannm@cn.fujitsu.com>
Message-ID: <739b5892-fb96-0dfa-802d-51bd7ddea2e9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V7 2/2] Add a new qmp command to do
 checkpoint, query xen replication status
References: <1486531462-13882-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <1486531462-13882-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
 <8760k3zteg.fsf@dusky.pond.sub.org>
 <3f2d885b-f4c3-e26c-348b-b3996ad5410e@cn.fujitsu.com>
 <87fuj7r61e.fsf@dusky.pond.sub.org>
 <f72d07f6-e00d-8a9c-0e15-e2bab5b83ee2@redhat.com>
 <868d3cc4-8788-8731-ea7a-4e1336863f45@cn.fujitsu.com>
In-Reply-To: <868d3cc4-8788-8731-ea7a-4e1336863f45@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/22/2017 01:54 AM, Zhang Chen wrote:

>> if (err) {
>>    result->status =3D REPLICATION_STATUS_ERROR;
>>    result->has_desc =3D true;
>>    result->desc =3D ...extract string from err
>> } else {
>>    result->status =3D REPLICATION_STATUS_NORMAL;
>> }
>>
>> by modifying the JSON [1]
>=20
> I got your point, but I don't understand this:
>=20
> result->desc =3D ...extract string from err
>=20
> Where we can get the string from err?
> Can you give me a example?

See qmp_query_migrate (migration/migration.c) for similar code that
populates an optional description member when an error is present:

    case MIGRATION_STATUS_FAILED:
        info->has_status =3D true;
        if (s->error) {
            info->has_error_desc =3D true;
            info->error_desc =3D g_strdup(error_get_pretty(s->error));
        }
        break;


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xRP3ckWlBpAisVoPMNbAqMwdoVLTgHLMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYra0NAAoJEKeha0olJ0NqoUcIAJD7fxQQkMeJoJ+HV/CysXXA
xzSYrweYh/L1Qo9E7twbY4bwSXTc+OBWTWrpFhVNySToM5SFcCM0yspVKkwdRFgc
0K0wTvYPEM8ZGePgmf0Yrmm+et+Ly4CJvK4w4F72amtBmDtBwKgfIfh5MLuD5N7v
LkhKWMpOApWJcfnY2jQj9qmUj5t9Lz8uBiN8MRH74T16l+EMYPyS/HbbevR3jxyh
4emTY6A4qRpUPFl1Uis3N2nQyu/85aCpWsYa14VgU3NXkBcDKFfHP+vN9olmEUFe
5xSiLTRjtBwesLkaDr0G5nKSxmewi0cRyDbKsgQrFJz/clld8pC9EhbbNWCwMDw=
=ywKN
-----END PGP SIGNATURE-----

--xRP3ckWlBpAisVoPMNbAqMwdoVLTgHLMx--
