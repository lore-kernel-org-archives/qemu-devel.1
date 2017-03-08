Received: from eggs.gnu.org ([2001:4830:134:3::10]:60434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgOW-0001EX-Fv
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:33:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1clgOV-0008On-BX
	for qemu-devel@nongnu.org; Wed, 08 Mar 2017 13:33:04 -0500
References: <20170308181833.32110-1-mreitz@redhat.com>
	<e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
	<91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cf2a46ae-afd3-58ea-7a1b-2de4e1d89a16@redhat.com>
Date: Wed, 8 Mar 2017 19:32:53 +0100
MIME-Version: 1.0
In-Reply-To: <91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="CtPIfE1bNxcNeoCJSXHEUDFow9ClhWTR5"
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CtPIfE1bNxcNeoCJSXHEUDFow9ClhWTR5
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Chrysostomos Nanakos <chris@include.gr>
Message-ID: <cf2a46ae-afd3-58ea-7a1b-2de4e1d89a16@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9] block/archipelago: Make it compile
References: <20170308181833.32110-1-mreitz@redhat.com>
 <e7e616d7-441f-9cff-d182-cbda19700ec5@redhat.com>
 <91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
In-Reply-To: <91dff396-0e71-cb32-8353-edc4b644d5af@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.03.2017 19:28, Eric Blake wrote:
> On 03/08/2017 12:25 PM, Eric Blake wrote:
>> On 03/08/2017 12:18 PM, Max Reitz wrote:
>>> In order to use error_setg() and similar functions, we need to includ=
e
>>> qapi/error.h.
>>>
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  block/archipelago.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>
>> Does this mean our automated buildbots aren't building archipelago by
>> default?
>>
>=20
> Oh, I meant to add:
>=20
> Should probably mention that it was commit da34e65 that introduced the
> problem (if I'm right?).  Does that mean we have not been compiling
> archipelago.c since Mar 2016?

At least here on my machine it does indeed compile before that commit
and fails afterwards. So, yes, maybe we actually have not. :-)

Max


--CtPIfE1bNxcNeoCJSXHEUDFow9ClhWTR5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljATlUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9aYH/RVbxThJPyWDEZ8GqE9LI+mE1prHxS0z
MFFYgS/pod9w3p5Ff6dy7enKKgzPWlnT1DO660CotidL3r2dR3tqkYUg2zlihjNQ
dN6LnQPqoWOAu2iUZgYygbGb2bF0kGwLP9fRAkPRn4zr3ATr4wC5RHKt29WHQqSx
iYYImQS1Vy/7Ibvtdls+OYAjKm42LXVCSFooHUqiq2zhWz+OvM5Cm6hltFC0VGAJ
UHWyMqE4K+319vzYsdoSLcI2g8ckwA3ak3Fne+pd5mb9Fx0MCrr29tMyJd4r785G
1VgavDrWJGS8Mcb102Tb8bX3fLpSrj70rN6WeNmqyiH3m8YrrYca1oE=
=2m5R
-----END PGP SIGNATURE-----

--CtPIfE1bNxcNeoCJSXHEUDFow9ClhWTR5--
