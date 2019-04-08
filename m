Received: from eggs.gnu.org ([209.51.188.92]:37413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDVsp-0005Wq-8Q
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:08:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hDVsn-0000Ft-9D
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 11:08:27 -0400
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
	<471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <19944be5-e9db-3428-5744-79e8301a265f@redhat.com>
Date: Mon, 8 Apr 2019 17:08:07 +0200
MIME-Version: 1.0
In-Reply-To: <471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l"
Subject: Re: [Qemu-devel] Aborts in iotest 169
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Luiz Capitulino <lcapitulino@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Luiz Capitulino <lcapitulino@redhat.com>
Message-ID: <19944be5-e9db-3428-5744-79e8301a265f@redhat.com>
Subject: Re: Aborts in iotest 169
References: <3da8da19-72dc-8f5e-f2e1-820999994cb2@redhat.com>
 <471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
In-Reply-To: <471e5ea1-cafb-c9b6-129e-07e9007122d6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.04.19 16:57, Vladimir Sementsov-Ogievskiy wrote:
> 23.01.2019 18:48, Max Reitz wrote:
>> Hi,
>>
>> When running 169 in parallel (e.g. like so:
>>
>> $ while TEST_DIR=3D/tmp/t0 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 169; do; done
>> $ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 169; do; done
>>
>> in four different shells), I get aborts:
>>
>> (Often I get segfaults, but that's because of
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-12/msg05579.html =
--
>> feel free to apply the attached patch to make them go away)
>=20
> Hi,
>=20
> Didn't you send it in separate? iotests still fails sometimes with segf=
ault
> in chardev code...

I didn=E2=80=99t, because I don=E2=80=99t believe that patch is entirely =
correct.
That=E2=80=99s why its commit title starts with =E2=80=9CHack=E2=80=9D.

Max


--h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlyrY9cACgkQ9AfbAGHV
z0BJqAf/VefmNCznndrHt97Th6yDgQekVyVPOP83tJzuBQxqElhrR3ghn7ubejJP
X/QP/uFlUaBYq5/fM9w+bFXOSOEuS22JtCSuLgiD9eGGJWuw+eLEgZU/tGE+zuBe
HuCJ4Jaotk0xcfts7KRB0JbpIuHYc/aC9CvI/+9qJaqV+QYtktlkvQMBkAcPVxpe
TmhTOsfHwkcWhX+lX86W0VzG1frDZIVzd5QwR9GOrhZkQgtL9LO/dlnnVkgF13CE
dX1n9bd3EtQXDsxucXFFkxZ3D0HqPckd9ypXu0zJ14yvPSh0yxrW/3FTomp3vJfy
QlSxfVyKza0GRLnDk+9gU7EkSRsoaQ==
=pOLE
-----END PGP SIGNATURE-----

--h2YikPECzZM9p9XUv3bXuNRhtiLpqOo9l--
