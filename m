Received: from eggs.gnu.org ([209.51.188.92]:38444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxDFi-0004dZ-32
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:00:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gxDFY-0007tR-SA
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 11:00:38 -0500
References: <20190220145819.30969-1-berrange@redhat.com>
	<20190220145819.30969-2-berrange@redhat.com>
	<1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
	<20190222151655.GD25234@redhat.com>
	<54c5e3ea-c6cc-b705-b247-647d355e6607@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1756083b-7966-4d43-4996-57fe27566d46@redhat.com>
Date: Fri, 22 Feb 2019 17:00:09 +0100
MIME-Version: 1.0
In-Reply-To: <54c5e3ea-c6cc-b705-b247-647d355e6607@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="swDv89NM0Guf6DJ16QcwhcO2vRcmWM750"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] iotests: ensure we print nbd server
 log on error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--swDv89NM0Guf6DJ16QcwhcO2vRcmWM750
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <1756083b-7966-4d43-4996-57fe27566d46@redhat.com>
Subject: Re: [PATCH v2 1/2] iotests: ensure we print nbd server log on error
References: <20190220145819.30969-1-berrange@redhat.com>
 <20190220145819.30969-2-berrange@redhat.com>
 <1b7cca35-0764-c365-169e-f46c033bd2e2@redhat.com>
 <20190222151655.GD25234@redhat.com>
 <54c5e3ea-c6cc-b705-b247-647d355e6607@redhat.com>
In-Reply-To: <54c5e3ea-c6cc-b705-b247-647d355e6607@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.02.19 16:54, Eric Blake wrote:
> On 2/22/19 9:16 AM, Daniel P. Berrang=C3=A9 wrote:
>> On Fri, Feb 22, 2019 at 04:06:32PM +0100, Max Reitz wrote:
>>> On 20.02.19 15:58, Daniel P. Berrang=C3=A9 wrote:
>>>> If we abort the iotest early the server.log file might contain usefu=
l
>>>> information for diagnosing the problem. Ensure its contents are
>>>> displayed in this case.
>>>>
>>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>>>> @@ -120,6 +122,7 @@ $QEMU_IO -f $IMGFMT -r -U -c 'r -P 0x22 1m 1m' "=
$TEST_IMG" | _filter_qemu_io
>>>>  echo
>>>>  echo "=3D=3D final server log =3D=3D"
>>>>  cat "$TEST_DIR/server.log"
>>>> +rm -f $TEST_DIR/server.log
>>>
>>> I'm not sure how well the iotests currently cope with spaced dir name=
s
>>> anyway, but it looks weird to not use quotes here right after a line
>>> that does.
>>
>> Yes, that is a mistake since we tried quoting throughout the file
>=20
> Can fix that while staging through my NBD queue. I'll probably send a P=
R
> on Monday.

That's OK for me.

Max



--swDv89NM0Guf6DJ16QcwhcO2vRcmWM750
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxwHIkACgkQ9AfbAGHV
z0DYhQgAnn2KPtHSEx+kM2RE0FWs5ZHwaUzMCHRJ32tMCk4usoiG+UX8XjTr96k2
4ydB2uqZ3AiwDVOVS9yQIhG2UtkjWe6VIQiHHd7EpzxwGRl/bkUxbF1OsU7rI7U+
C+iw4wphHv+UDqjzCQ8nP2X0QsC0QGc+K5aQkjYND7KxBq6RbEvIM8HkxXmdO3of
gEhU2REh5IZVuiR77r0vIVeWn0nM+SzY/5dBOmsp0qlBp+g4difq3jI+o/COsV+f
Ix8wgirbW7OoXOGVIK+TqP9twRGnoF4N7wcJE341vPEKIVhnhQJS+gIvIhe7L9Lq
rnTCgnJu2chYtUMZeZovhHYbVMekIA==
=mW61
-----END PGP SIGNATURE-----

--swDv89NM0Guf6DJ16QcwhcO2vRcmWM750--
