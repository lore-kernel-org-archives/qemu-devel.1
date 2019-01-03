Received: from eggs.gnu.org ([208.118.235.92]:34673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf9Re-0005gB-4r
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:18:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gf9Ra-0005RO-Rz
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:18:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gf9Ra-0005Qe-Ho
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 15:18:18 -0500
References: <1546078551-6109-1-git-send-email-ptsneves@gmail.com>
	<1546078551-6109-2-git-send-email-ptsneves@gmail.com>
	<CAJ+F1C+k6k2KLZWKFQ_4RPxWWeDWhEbLaq6g2iESyhk2kjVLEQ@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a0aaed2-f97c-a2b1-1d7b-b6a0ac29b1af@redhat.com>
Date: Thu, 3 Jan 2019 14:18:15 -0600
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+k6k2KLZWKFQ_4RPxWWeDWhEbLaq6g2iESyhk2kjVLEQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M3v7cSTf3wOv8iv1Bb7NE6lHUUDpviqzZ"
Subject: Re: [Qemu-devel] [PATCH] chardev: Allow for pty path passing.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, Paulo Neves <ptsneves@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M3v7cSTf3wOv8iv1Bb7NE6lHUUDpviqzZ
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 Paulo Neves <ptsneves@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>
Message-ID: <9a0aaed2-f97c-a2b1-1d7b-b6a0ac29b1af@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] chardev: Allow for pty path passing.
References: <1546078551-6109-1-git-send-email-ptsneves@gmail.com>
 <1546078551-6109-2-git-send-email-ptsneves@gmail.com>
 <CAJ+F1C+k6k2KLZWKFQ_4RPxWWeDWhEbLaq6g2iESyhk2kjVLEQ@mail.gmail.com>
In-Reply-To: <CAJ+F1C+k6k2KLZWKFQ_4RPxWWeDWhEbLaq6g2iESyhk2kjVLEQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/2/19 2:23 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Sat, Dec 29, 2018 at 2:34 PM Paulo Neves <ptsneves@gmail.com> wrote:=

>>
>> If a user requires a virtual serial device like provided
>> by the pty char device, the user needs to accept the
>> returned device name. This makes the program need to
>> have smarts to parse or communicate with qemu to get the
>> pty device.
>> With this patch the program can pass the path where
>> a symlink to the pty device will be, removing the
>> need for 2 way communication or smarts.
>=20
> This seems reasonable. Your patch doesn't apply on master, can you reba=
se it?
>=20

>> +++ b/qapi/char.json
>> @@ -224,7 +224,7 @@
>>  ##
>>  # @ChardevHostdev:
>>  #
>> -# Configuration info for device and pipe chardevs.
>> +# Configuration info for device, pty and pipe chardevs.
>>  #
>>  # @device: The name of the special file for the device,
>>  #          i.e. /dev/ttyS0 on Unix or COM1: on Windows
>> @@ -380,7 +380,7 @@
>>                                         'pipe'   : 'ChardevHostdev',
>>                                         'socket' : 'ChardevSocket',
>>                                         'udp'    : 'ChardevUdp',
>> -                                       'pty'    : 'ChardevCommon',
>> +                                       'pty'    : 'ChardevHostdev',
>=20
> Better to create a new ChardevPty instead (ChardevHostdev is for host
> device, here it is not)

A new type with identical member names is indistinguishable in
introspection.  You could even rename s/ChardevHostdev/ChardevDevice/
for use by both 'pipe' and 'pty', since all the more ChardevHostdev did
over ChardevCommon was add a 'device' member (since renaming types is
transparent to introspection).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--M3v7cSTf3wOv8iv1Bb7NE6lHUUDpviqzZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwubgcACgkQ3g5py3or
ov18twf7BsBrvdVdih8pXcI8sfI8uuAtq16udrdHRxckRG78eqUaH5lvwpvnOlnB
lo7p3WeXzoRCO8sBy4TSBzf27FWzemiQAW6r/XUGYiwXPGlS7JokQoaAchtQvC2j
sVBtGbtDwZXw7dt8TWQVRSqlEsXM7mViAWpEC3sbNzNsRXbpBZ6fjJeij9fK5woO
xZWZQ3DjklOTFQasCs8N+mxzjsUIMNM7B03hnwWp69lJhHI1o0TKF0jtWNYnrcd6
XIC52NYdkrENyOnIQFfTZJBjtY7LW7+b2fSZAfOWqLMoP9Wk7DgiUx3s4/PUCM0b
iCm42wbXDoKkDEullZNS3jX2rqIfvA==
=s/F/
-----END PGP SIGNATURE-----

--M3v7cSTf3wOv8iv1Bb7NE6lHUUDpviqzZ--
