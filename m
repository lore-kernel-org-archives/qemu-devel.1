Received: from eggs.gnu.org ([2001:4830:134:3::10]:46850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDB4i-0006IT-NT
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:18:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDB4h-0001jg-Ta
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 10:18:32 -0500
References: <20171109203025.27493-1-mreitz@redhat.com>
	<20171109203025.27493-5-mreitz@redhat.com>
	<w51375mv4by.fsf@maestria.local.igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
Date: Fri, 10 Nov 2017 16:18:15 +0100
MIME-Version: 1.0
In-Reply-To: <w51375mv4by.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="alUPvlcKFth3cApOCC3qVpf0ddokGi73X"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less
 flaky
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--alUPvlcKFth3cApOCC3qVpf0ddokGi73X
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <d44fc75f-829c-65cd-fc19-04f32d897f8a@redhat.com>
Subject: Re: [Qemu-block] [PATCH v2 4/5] iotests: Make 083 less flaky
References: <20171109203025.27493-1-mreitz@redhat.com>
 <20171109203025.27493-5-mreitz@redhat.com>
 <w51375mv4by.fsf@maestria.local.igalia.com>
In-Reply-To: <w51375mv4by.fsf@maestria.local.igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-10 11:02, Alberto Garcia wrote:
> On Thu 09 Nov 2017 09:30:24 PM CET, Max Reitz wrote:
>> +        echo > "$TEST_DIR/nbd-fault-injector.out"
>>  	$PYTHON nbd-fault-injector.py $extra_args "$nbd_addr" "$TEST_DIR/nbd=
-fault-injector.conf" >"$TEST_DIR/nbd-fault-injector.out" 2>&1 &
>=20
> It seems that in this patch you're indenting with spaces but this file
> uses tabs.

Yes, but tabs are wrong. :-)

Max


--alUPvlcKFth3cApOCC3qVpf0ddokGi73X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloFwzcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AsS0H/23BwQ58ySu0Stj8fbSFWtn5RorJcqtL
fflzABEwd6Ls/5OgI/eea8csz1wbZvA2DUKlMioPLpfOLDreFAirBNiradlohjQn
h3RZE5fGKrd3ISyZJlQoMuPQzZoKs2uLrg7mXPHPk7tST1EXCL1Y4Sj/7C1zHGbw
sKQ0hoIlUwJ+u07FvyfbjHp6rjzEBF7DzvtnAmjS0MQDbuX4V2BncyPwlL+H+3sS
XG6lil2wdi5NXzgUK3WVRNco2xMYDWf9RgqgyfuLj1yLpWvwh6ofUjvgIg4+/WKn
/lqfumFq+R7I1UBvKB1tWQ8r+YYB1sZS8ODxp51GTOWJP9mMQNEFElY=
=RinL
-----END PGP SIGNATURE-----

--alUPvlcKFth3cApOCC3qVpf0ddokGi73X--
