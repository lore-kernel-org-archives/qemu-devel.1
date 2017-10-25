Received: from eggs.gnu.org ([2001:4830:134:3::10]:52039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e7LP1-0004Yb-Dn
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1e7LOs-00017B-1Y
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 09:07:23 -0400
References: <BC29A004BA570342A4CC0044A3845572CFCE4DB9@H3CMLB12-EX.srv.huawei-3com.com>
	<93ce91e1-d1cf-5781-c995-a2d82f5d515a@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <13fb8c1d-b0fd-b6a6-b983-049450af6bde@redhat.com>
Date: Wed, 25 Oct 2017 15:06:57 +0200
MIME-Version: 1.0
In-Reply-To: <93ce91e1-d1cf-5781-c995-a2d82f5d515a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fcqgJANWQnnSdO6GqmBs0fabsMq4LwT0J"
Subject: Re: [Qemu-devel] qemu-img crash when resize a qcow2 file created
 with preallocation=full/falloc .
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Changlimin <changlimin@h3c.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fcqgJANWQnnSdO6GqmBs0fabsMq4LwT0J
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Changlimin <changlimin@h3c.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Qemu-block <qemu-block@nongnu.org>
Message-ID: <13fb8c1d-b0fd-b6a6-b983-049450af6bde@redhat.com>
Subject: Re: [Qemu-devel] qemu-img crash when resize a qcow2 file created with
 preallocation=full/falloc .
References: <BC29A004BA570342A4CC0044A3845572CFCE4DB9@H3CMLB12-EX.srv.huawei-3com.com>
 <93ce91e1-d1cf-5781-c995-a2d82f5d515a@redhat.com>
In-Reply-To: <93ce91e1-d1cf-5781-c995-a2d82f5d515a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-10-25 09:22, Thomas Huth wrote:
> On 24.10.2017 05:28, Changlimin wrote:
>> Hi,
>> I am glad to see that qcow2 file created with preallocation=3Dfull/fal=
loc can be resized. But when I test it, qemu-img crashs.
>> qemu-img: block/qcow2-refcount.c:530: qcow2_refcount_area: Assertion `=
!(start_offset % s->cluster_size)' failed.
>>
>> These are commands:
>> qemu-img create -f qcow2 -o preallocation=3Dfull full.img 1G
>> qemu-img resize --preallocation=3Dfull full.img +1G

Hi,

This should be fixed in my block branch
(https://github.com/XanClic/qemu/commits/block)
-- but unfortunately I haven't been able to send a pull request yet.


Thanks for the report!

Max


--fcqgJANWQnnSdO6GqmBs0fabsMq4LwT0J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlnwjHISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AgnEH+gLbFcs2S7BKe1Y+HBRk3lfoZwrNYfXy
1sQrHu+gtrDGf11Z3rwKjMlDOOJYllMSs3sqGSgwJXgm1pUKrHiAcJkj0yBqcciY
+owlUpx3SIjmiC8v01XSnaxrtSRbwG+/JAyH5tNe1jdDeZLn4gdSZMRBMdRAbHSm
MxYLcLHb9UmTBhOUjRyO+ypYJyo2IQrpLoZP50CRc3kP5m0zyEbePL1yPZVL9Rzn
8yfyshcvk2CTDa8PW3Mdha5R6fA+0khtlGivMS/VFYL9JAA36UIqr+GvnKtRGfTg
MQU3qTUPgqwpQiCOSl6QI74r+FV5LP5nUdEN8RM5tX76Peenfy4vh8k=
=HLKp
-----END PGP SIGNATURE-----

--fcqgJANWQnnSdO6GqmBs0fabsMq4LwT0J--
