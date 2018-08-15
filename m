Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1fpvyU-0001P6-Vq
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1fpvyM-0000Mr-9F
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:36:34 -0400
Received: from mout.gmx.net ([212.227.15.18]:32783)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1fpvy7-0007tY-OJ
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 09:36:23 -0400
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
	<d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
	<8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
	<80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
	<d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
	<1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <327f3e04-dd5b-06bd-f672-5f180521db32@gmx.com>
Date: Wed, 15 Aug 2018 15:37:02 +0200
MIME-Version: 1.0
In-Reply-To: <1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hcAy0uoPFjNpd5P7Wz75qxk2HuvQ7uWc1"
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Rebecca Cran <rebecca@bluestop.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hcAy0uoPFjNpd5P7Wz75qxk2HuvQ7uWc1
From: Kamil Rytarowski <n54@gmx.com>
To: Thomas Huth <thuth@redhat.com>, Rebecca Cran <rebecca@bluestop.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yuval Shaia <yuval.shaia@oracle.com>, Brad Smith <brad@comstyle.com>
Message-ID: <327f3e04-dd5b-06bd-f672-5f180521db32@gmx.com>
Subject: Re: [Qemu-devel] RDMA wrongly detected as being supported on FreeBSD
References: <0c215752-5cd2-3b7c-bc3c-f435f1dbbfed@bluestop.org>
 <d6acc012-fb6c-9f9d-9cbe-8dd92727c64b@redhat.com>
 <8bf07395-4872-ce74-c201-9fca232edd01@gmail.com>
 <80532e46-ffbf-9c87-5296-741bbb6f83ac@redhat.com>
 <d5ad3096-86b1-29e4-47bd-1ca71b8e7879@bluestop.org>
 <1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
In-Reply-To: <1feb3cc1-86ee-f708-6dc7-b9e20a7588ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06.08.2018 10:51, Thomas Huth wrote:
> On 07/28/2018 05:50 AM, Rebecca Cran wrote:
>> On 7/25/18 5:14 AM, Thomas Huth wrote:
>>
>>>
>>> Note that the error has been reported to happen on FreeBSD - so I dou=
bt
>>> that this <linux/types.h> header should be here.
>>>
>>> Anyway, our include/standard-headers/linux/types.h is also empty ... =
so
>>> could you try whether it compiles if you simply remove this #include
>>> line, Rebecca?
>>
>>
>> Sorry for the delay, I'm just getting back to this. Removing the inclu=
de
>> causes it to fail later on, with:
>>
>> /home/bcran/workspace/qemu/hw/rdma/vmw/pvrdma_cmd.c:60:17: warning:
>> implicit declaration of function 'mremap' is invalid in C99
>> [-Wimplicit-function-declaration]
>> =C2=A0=C2=A0=C2=A0 host_virt =3D mremap(curr_page, 0, length, MREMAP_M=
AYMOVE);
>=20
> OK, thanks for checking. According to
>=20
>  https://www.freebsd.org/cgi/man.cgi?query=3Dmremap&manpath=3DNetBSD+5.=
0
>=20
> that syscall should also be available on FreeBSD. So could you please d=
o
> one more test and see whether it works when you add the following line
> somewhere at the beginning of the file:
>=20
>   #include <sys/mman.h>
>=20
>  Thanks,
>   Thomas
>=20

I'm a little bit disoriented. The linked page is from NetBSD in a very
old version 5.x. We have 8.0 out now.

The thread is about FreeBSD. If there are any questions regarding
NetBSD, please let me know.


--hcAy0uoPFjNpd5P7Wz75qxk2HuvQ7uWc1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlt0LH4MHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZs2K0P/3sSNQ+dzoTiiEZcSbXPqhypEPqdSPw1lJB4GhQl
oYfp/WD4lr0WT9WDIU5OmKtSW6aPNj4+kuHqWN1zKKjAOoa2IetaL0aBv5LR7EIr
nzNhDx4w1bJ93XIi+jJjWisGxfI2j850K8gvPK7ZgKvkYY3rJk4OkvGsULVpEoZ+
AOavsbYzYkfrMqV8jrfGu035FhWg8RZA9HZ3YzNUVt/eT9lEyL2/4RNSC6rRpbah
L+FU+wN2HgdMwYODGLpKKDc4P0ni2IVp/4Rtu51Mdbw6DFksXnAOthnCcYZliU29
Y8D5VFsJGAD3UpyZMiaJh/2C1WTB7DeCNGyDtHJq7GZR20u9R8PiZKY5YkQ7cI/a
vHueqEIcmsW/rDzy0YIIEN7LJMbGex9W+pBJj4w3IsTtcnTw9WBEIxioUvW5Lj7A
Q5u/IyjEE2B0gx9vZzRsWblTzkiDOOIruGvtuqeinaWgRbOWH3NoJWBJxi9y0Zlm
5dNiUf02QOlYvcfLTl3SE21RHfwdr41WwMTYnDkdv89QQ4H9Nk3cjE8sC2cnR5lE
l2Cx2pVCCgfbtPYIx4eDB8nSY58lX55Yaguvc/S4IIpPXCZmB/QgtbPP3Go/TqaA
nDZzgqhyhU8bojJ2+CcWBrW7XuQwf3UkpFmAElFtJqdHBK02T4wO2C6ooFAJPkP+
WClS
=SsDO
-----END PGP SIGNATURE-----

--hcAy0uoPFjNpd5P7Wz75qxk2HuvQ7uWc1--
