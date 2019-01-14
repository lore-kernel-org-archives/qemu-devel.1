Received: from eggs.gnu.org ([209.51.188.92]:39629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj5V4-0001Jq-Rq
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:54:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gj5V2-0003Th-LZ
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:54:10 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:56241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gj5V2-0003TP-AP
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:54:08 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so257104wmc.5
	for <qemu-devel@nongnu.org>; Mon, 14 Jan 2019 08:54:08 -0800 (PST)
References: <20190111201330.14473-1-eblake@redhat.com>
	<05f29d1e-11f0-62e0-af82-02a989e1c7b7@redhat.com>
	<aae54881-da9b-f49f-24e3-86378adbf71f@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <a46d8da7-afbe-d68f-4ca7-ddf00dbff4e5@redhat.com>
Date: Mon, 14 Jan 2019 17:54:05 +0100
MIME-Version: 1.0
In-Reply-To: <aae54881-da9b-f49f-24e3-86378adbf71f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2ih3T7SVXqaw9pzPFe7IEBGpCsDIQwyaj"
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
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ih3T7SVXqaw9pzPFe7IEBGpCsDIQwyaj
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Message-ID: <a46d8da7-afbe-d68f-4ca7-ddf00dbff4e5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] qemu.py: Fix error message when qemu dies
 from signal
References: <20190111201330.14473-1-eblake@redhat.com>
 <05f29d1e-11f0-62e0-af82-02a989e1c7b7@redhat.com>
 <aae54881-da9b-f49f-24e3-86378adbf71f@redhat.com>
In-Reply-To: <aae54881-da9b-f49f-24e3-86378adbf71f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/14/19 4:36 PM, Eric Blake wrote:
> On 1/14/19 5:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi Eric,
>>
>> On 1/11/19 9:13 PM, Eric Blake wrote:
>>> When qemu dies from a signal, the python code gets a negative
>>> value for exitcode; but signal numbers are positive.  Copy the
>>> pattern used in qemu-iotests/iotests.py for reporting a positive
>>> value.
>>>
>>> CC: qemu-trivial@nongnu.org
>>> Signed-off-by: Eric Blake <eblake@redhat.com>
>>> ---
>>>  scripts/qemu.py | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/qemu.py b/scripts/qemu.py
>>> index 6e3b0e67719..0a5e02eb56e 100644
>>> --- a/scripts/qemu.py
>>> +++ b/scripts/qemu.py
>>> @@ -351,7 +351,7 @@ class QEMUMachine(object):
>>>                  command =3D ' '.join(self._qemu_full_args)
>>>              else:
>>>                  command =3D ''
>>> -            LOG.warn(msg, exitcode, command)
>>> +            LOG.warn(msg, -exitcode, command)
>>
>> What about displaying signal name directly?
>=20
> If you want to do that, it should be a separate patch, and fix
> iotests.py at the same time.

Fair enough :)


--2ih3T7SVXqaw9pzPFe7IEBGpCsDIQwyaj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAlw8vq0ACgkQoqP9bt6t
wN536g/+Pyrzp3WsjqqairKzUNp7qeye90tTSeiHvhu+3UuaDnffQ0mSou34ktzv
4UDg8kOXKq1fIQjL3MLDy0je2PmUalBQDv9qLNhyqmlNprjOOj5pfzxJuXjkY5Fj
VUK4CERRO7rsxyWeSb9GVGsOo88Lz8q+X/exvkQBxZROIUuDchKisE2r6EZF1ERj
YC8G0kj+V3zOa/fkbYHX5zPBWu9Of/OniejVqif8Ic2XePIpte8x1SRb6Fnz4tu/
XVJ2HxO0WjmmBP6+xNplfQU7DZrQppEKpE0dbcRJhW3PlJcR+Wto8P0ku0I9Wj0/
pCTDn1LsnVHHNxYJ9vgTicSGPMWdvNPbA0G5MIJBq1p2RS0CPt3oqxL0FWvTegDb
4xtMt42bCdnh1aYK7JWd0SJ/d/c2rX4NAq+or/ShY5lIODE5Tyzeq2ENIUsDUU9w
MxL7IFTTXiE7BGefsTWv2LuMF1eJYoz7k/PgrC2eTh+dtU1XADvGQc7ii+M6NUFX
sugrKDXZs4xHH/9KAhGV5J/vSO2EJctnLxuDWdplCPN3MtHx9TbfoXCnuVjkYw3n
Tp3BNEYmHmQjRmVbGfUZ9F4g2f55q4YnEIZyyl4l6Ppuiaf1vj4/x6S4PDkLkjm7
I4g750U2OkaTZARjscJSWauW4Af/v+v4kTH2A0QgJOJJjFP8gHQ=
=osd6
-----END PGP SIGNATURE-----

--2ih3T7SVXqaw9pzPFe7IEBGpCsDIQwyaj--
