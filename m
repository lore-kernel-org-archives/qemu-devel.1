Received: from eggs.gnu.org ([2001:4830:134:3::10]:35917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSm88-00009V-9U
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:22:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dSm83-00083t-Bl
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:22:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54074)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dSm83-00083j-4x
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 11:22:11 -0400
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
	<20170621153424.16690-6-vsementsov@virtuozzo.com>
	<41d055f4-1952-fbd8-7cc2-fe377b3c9d7d@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3cd91c92-71d3-2c84-53d9-b6cc9da9d45c@redhat.com>
Date: Wed, 5 Jul 2017 17:21:55 +0200
MIME-Version: 1.0
In-Reply-To: <41d055f4-1952-fbd8-7cc2-fe377b3c9d7d@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rrUHqiCcRfdXxHvf3SsQCXisnIx9IV5SW"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] nbd/client: refactor TRACE of
 NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rrUHqiCcRfdXxHvf3SsQCXisnIx9IV5SW
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, den@openvz.org
Message-ID: <3cd91c92-71d3-2c84-53d9-b6cc9da9d45c@redhat.com>
Subject: Re: [PATCH v2 5/6] nbd/client: refactor TRACE of NBD_MAGIC
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
 <20170621153424.16690-6-vsementsov@virtuozzo.com>
 <41d055f4-1952-fbd8-7cc2-fe377b3c9d7d@redhat.com>
In-Reply-To: <41d055f4-1952-fbd8-7cc2-fe377b3c9d7d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 29/06/2017 21:36, Eric Blake wrote:
>> +    memcpy(&nbd_magic, buf, 8);
>> +    nbd_magic =3D be64_to_cpu(nbd_magic);
> Do we really need to copy the memory around twice?  Can't we just use:
>  magic =3D ldq_be_p(buf);
> and call it good?

Yes.

Paolo


--rrUHqiCcRfdXxHvf3SsQCXisnIx9IV5SW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlldBBcACgkQv/vSX3jH
roOG3gf+LLkjUl6DCEbAX9ez/+Qmus6vVXts4PAgRAhdSGzpVksoSn0evSLDkTBJ
X3xKS1EDjf6Cn7Y8D4Rmza1lHD+JcIRg//ViuBG5aEwuLzkeURNsmwqX8R+l3Tf0
GAOSoouvfalMjpv62dQPbtVvSn+Qr2EduM4uXdl3PKwHgGRHkywMdBS179fCQQEh
FsSqp8X4lWNmQIzkgRMJIfYjF2A4UxPuJ++QE+MC618Q/hz/ynUkFcCJZuAxwtds
4m1SxP/ZfeeHTKhYaXurDU4zlPljE+z8keIH72/PXlR9cQ16n9qWklvU7Dbha3gt
IAPV44xGJ6Fgx5odTf3QiY5iPAo/YA==
=U798
-----END PGP SIGNATURE-----

--rrUHqiCcRfdXxHvf3SsQCXisnIx9IV5SW--
