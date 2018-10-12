Received: from eggs.gnu.org ([2001:4830:134:3::10]:37782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAxZ1-0007x3-6u
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:33:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gAxYy-0004uV-17
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47212)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gAxYx-0004sN-MU
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 09:33:07 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EA47F4D4CB
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 13:33:06 +0000 (UTC)
References: <20181008185013.19371-1-mreitz@redhat.com>
	<20181012124845.yriqk5v46qprcps5@sirius.home.kraxel.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <136ccd2e-7b60-9956-945a-b3643d473ce8@redhat.com>
Date: Fri, 12 Oct 2018 15:33:00 +0200
MIME-Version: 1.0
In-Reply-To: <20181012124845.yriqk5v46qprcps5@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="90uBVOvG42wkbU3QGGFBbL5e6OSazURiJ"
Subject: Re: [Qemu-devel] [PATCH] sdl2: Support all virtio-gpu formats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--90uBVOvG42wkbU3QGGFBbL5e6OSazURiJ
From: Max Reitz <mreitz@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <136ccd2e-7b60-9956-945a-b3643d473ce8@redhat.com>
Subject: Re: [PATCH] sdl2: Support all virtio-gpu formats
References: <20181008185013.19371-1-mreitz@redhat.com>
 <20181012124845.yriqk5v46qprcps5@sirius.home.kraxel.org>
In-Reply-To: <20181012124845.yriqk5v46qprcps5@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.10.18 14:48, Gerd Hoffmann wrote:
> On Mon, Oct 08, 2018 at 08:50:13PM +0200, Max Reitz wrote:
>> There are some 2D resource formats that can be used through virtio-gpu=
,
>> but which are not supported by SDL2 when used for a scanout; these are=

>> all alpha-channel formats and also XBGR (RGBX in non-BE pixman).
>>
>> Add these formats in the switch converting pixman to SDL format
>> constants so a guest cannot crash the VM by triggering the
>> g_assert_not_reached() with an unsupported format.
>=20
> fixed (sdl2_2d_check_format update) & queued.

Thanks!

Max


--90uBVOvG42wkbU3QGGFBbL5e6OSazURiJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvAoowACgkQ9AfbAGHV
z0B/xAf/S5BP+tG2B67k++rTZG1hzbW1HrUM+GXDYb0UFfeDUzh0sAv2AbSyzUpQ
vMPKZVF/9r7IKfoybOTgx50y9TJCOpLY+gKwoMDdjI6o+aB4Nq3XZXwyUFQscRPf
jaQZqg81s9CL8O7M3hXJBaSY76vgk2mwZqTL7L2MAml28MWbJaxGqxVNRWy+rwFu
1LCKGLR6H0n6k9pjLtEFJutotu30OXJfOPPkmX3MkpXhPOcB/sqaOwHfupA4O10t
JCz5IF4AV1UbmwVjy//YhMqgPh5YUDrlnbNiEfNEWikoN5/ZHqbmjnauZOUa4AYx
fVCWs32J6LBoloFI1+hRge5kAHNZpQ==
=5CzK
-----END PGP SIGNATURE-----

--90uBVOvG42wkbU3QGGFBbL5e6OSazURiJ--
