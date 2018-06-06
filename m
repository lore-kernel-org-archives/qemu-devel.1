Received: from eggs.gnu.org ([2001:4830:134:3::10]:48283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQVmd-0005mO-WA
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:35:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fQVmY-0001Ab-Qh
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:35:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34998 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fQVmY-00019T-KR
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 06:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 03E98D37A6
	for <qemu-devel@nongnu.org>; Wed,  6 Jun 2018 10:35:10 +0000 (UTC)
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
	<d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
	<787c23db-430b-dc20-10f7-00fdf119449c@redhat.com>
	<20180604222433.4d585846@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <19cc576e-5b1c-c45e-034a-95329d1bff62@redhat.com>
Date: Wed, 6 Jun 2018 12:35:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180604222433.4d585846@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1DAdkp7hWbwLxv6VPFiX9p54bbtgH0G1D"
Subject: Re: [Qemu-devel] Preconfig state reachable without --preconfig given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1DAdkp7hWbwLxv6VPFiX9p54bbtgH0G1D
From: Max Reitz <mreitz@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Michal Privoznik <mprivozn@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <19cc576e-5b1c-c45e-034a-95329d1bff62@redhat.com>
Subject: Re: [Qemu-devel] Preconfig state reachable without --preconfig given
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
 <d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
 <787c23db-430b-dc20-10f7-00fdf119449c@redhat.com>
 <20180604222433.4d585846@redhat.com>
In-Reply-To: <20180604222433.4d585846@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-04 22:24, Igor Mammedov wrote:
> On Mon, 4 Jun 2018 16:04:33 +0200
> Max Reitz <mreitz@redhat.com> wrote:
>=20
>> On 2018-06-02 12:46, Michal Privoznik wrote:
>>> On 06/01/2018 03:28 PM, Max Reitz wrote: =20
>>>> Hi,
>>>>
>>>> The @preconfig RunState documentation states:
>>>> =20
>>>>> The state is reachable only if the --preconfig CLI option is used. =
=20
>>>>
>>>> However, this is not true:
>>>>
>>>> $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
>>>> QEMU 2.12.50 monitor - type 'help' for more information
>>>> (qemu)
>>>> HMP not available in preconfig state, use QMP instead =20
>>>
>>> Not sure if this is the same bug, but I've noticed libvirt having
>>> troubles detecting capabilities of qemu and debugging lead to this pa=
tch:
>>>
>>> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html=

>>>
>>> (which by no means I claim is proper solution. It might be viewed as
>>> workaround by expert qemu devels) =20
>>
>> I haven't investigated further, but that patch breaks iotest 091 (whic=
h
>> tests migration).  It just stops now after the migration has started, =
so
>> it never completes.
>>
>> Actually, it seems to break all migration iotests (but 203, which
>> migrates to /dev/null), so I suspect it breaks migration as a whole.
> Manual migration to file and restore from it, was tested manually and
> worked fine, migration-test  from 'make check' is ok as well.
> It's probably due broken to "echo foo | $QEMU"

I highly doubt that, because four of the failing migration iotests are
written in Python and thus use QMP.  (169, 194, 196, 199)

They work on master, but fail after that patch.

Max

> There is another issue with -nodefaults option leading to indefinite
> timeout even if --preconfig wasn't used. I've just posted fix for that
> so that it won't be masked out by Michal/Daniel's fix.
> But I've run iotests  and -nodefaults fix doesn't affect outcome of the=

> tests (the same 4 failures).=20


--1DAdkp7hWbwLxv6VPFiX9p54bbtgH0G1D
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsXuNsACgkQ9AfbAGHV
z0Ccvwf+Nq1nP5t3R6mDOAX9PsX81r6qfxdwJf+9UV8VkDkGSkNAN5c6glxlfoMu
uF+Tr5wXSnGwJ7vjYhvZrtVCjb8t+qjJzF/61Em2ilMzIJDIktS2thm9y/KHejmk
/WScr9VJEc0Kmp+IcH7V9TyNajOqvsOG0g+ad6MYHlLcINNubhisHE5QdkehEZQD
AAg+p5ysPv7m+0rWjkvjw9dMnCo/BWd1UZJa9I947naysp+84IaW5ahKf+9Xqcg5
diMvSCYJw9CufdRc0D2V3c4N1gJK4Br8LNuWgGUmxC94th+jJwwGkhEr7fgaza/G
LLGzGOSOkUW52BG0Fo4h7JT9a7MBkA==
=RFoE
-----END PGP SIGNATURE-----

--1DAdkp7hWbwLxv6VPFiX9p54bbtgH0G1D--
