Received: from eggs.gnu.org ([209.51.188.92]:43845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj4He-0003gX-SS
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj4He-0006aC-1W
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 10:36:14 -0500
References: <20190111201330.14473-1-eblake@redhat.com>
	<05f29d1e-11f0-62e0-af82-02a989e1c7b7@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aae54881-da9b-f49f-24e3-86378adbf71f@redhat.com>
Date: Mon, 14 Jan 2019 09:36:11 -0600
MIME-Version: 1.0
In-Reply-To: <05f29d1e-11f0-62e0-af82-02a989e1c7b7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jpu1IhMnRFdBHAopUPclphQpENspu1O5P"
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Fix error message when qemu dies
 from signal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jpu1IhMnRFdBHAopUPclphQpENspu1O5P
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <aae54881-da9b-f49f-24e3-86378adbf71f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Fix error message when qemu dies
 from signal
References: <20190111201330.14473-1-eblake@redhat.com>
 <05f29d1e-11f0-62e0-af82-02a989e1c7b7@redhat.com>
In-Reply-To: <05f29d1e-11f0-62e0-af82-02a989e1c7b7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 5:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 1/11/19 9:13 PM, Eric Blake wrote:
>> When qemu dies from a signal, the python code gets a negative
>> value for exitcode; but signal numbers are positive.  Copy the
>> pattern used in qemu-iotests/iotests.py for reporting a positive
>> value.
>>
>> CC: qemu-trivial@nongnu.org
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  scripts/qemu.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>> index 6e3b0e67719..0a5e02eb56e 100644
>> --- a/scripts/qemu.py
>> +++ b/scripts/qemu.py
>> @@ -351,7 +351,7 @@ class QEMUMachine(object):
>>                  command =3D ' '.join(self._qemu_full_args)
>>              else:
>>                  command =3D ''
>> -            LOG.warn(msg, exitcode, command)
>> +            LOG.warn(msg, -exitcode, command)
>=20
> What about displaying signal name directly?

If you want to do that, it should be a separate patch, and fix
iotests.py at the same time.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--jpu1IhMnRFdBHAopUPclphQpENspu1O5P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw8rGsACgkQp6FrSiUn
Q2qRaAf/U9ASWZBV4TMfY0PWTNCB3ZPFiuExQydNYI2UEJfNyBjNsYMrS7CV4oDP
U185saTPSVIzViJJOixh5NrUK/V0XTl4IiaikTwui7RaPEHgStErDggezyZmbJ8M
ZDmG/+Ys22Zifvqi+aikEW7NRcOdFnzLyIht3OSRfgLEndhr88U3ZhT/GGwuy7/I
E24jT/ImaLTXq7N2d2fQatDBJXQ86RuIIIu/amt6bizoLfWiqsUpWEVMmOpBJWQT
yaSW/fA8U1E09V7syrC1ybLhG0j82MNrpKQNDTbi9Hlkl4wehj48EY1dy2u17SYh
hNI5zy6RmRMWp7+7tprSUuBe5kROBg==
=Nh7L
-----END PGP SIGNATURE-----

--jpu1IhMnRFdBHAopUPclphQpENspu1O5P--
