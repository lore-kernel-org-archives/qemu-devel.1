Received: from eggs.gnu.org ([2001:4830:134:3::10]:44147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPm47-00049z-5b
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:46:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPm44-0002Z6-3H
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:46:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fPm43-0002Wi-Tq
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:46:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D8AF818F024
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 09:46:10 +0000 (UTC)
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
	<d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <24719f30-25c9-a80e-0db9-ae2f7f318c68@redhat.com>
Date: Mon, 4 Jun 2018 11:46:06 +0200
MIME-Version: 1.0
In-Reply-To: <d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4YRfFjbJ5eShEPHO4jrYSdp5jzE9AcuE0"
Subject: Re: [Qemu-devel] Preconfig state reachable without --preconfig given
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michal Privoznik <mprivozn@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4YRfFjbJ5eShEPHO4jrYSdp5jzE9AcuE0
From: Max Reitz <mreitz@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <24719f30-25c9-a80e-0db9-ae2f7f318c68@redhat.com>
Subject: Re: [Qemu-devel] Preconfig state reachable without --preconfig given
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
 <d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
In-Reply-To: <d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-06-02 12:46, Michal Privoznik wrote:
> On 06/01/2018 03:28 PM, Max Reitz wrote:
>> Hi,
>>
>> The @preconfig RunState documentation states:
>>
>>> The state is reachable only if the --preconfig CLI option is used.
>>
>> However, this is not true:
>>
>> $ echo | x86_64-softmmu/qemu-system-x86_64 -monitor stdio
>> QEMU 2.12.50 monitor - type 'help' for more information
>> (qemu)
>> HMP not available in preconfig state, use QMP instead
>=20
> Not sure if this is the same bug, but I've noticed libvirt having
> troubles detecting capabilities of qemu and debugging lead to this patc=
h:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg00367.html
>=20
> (which by no means I claim is proper solution. It might be viewed as
> workaround by expert qemu devels)

Well, it'd fix both of my issues, so it has that going for it. :-)

>> On IRC, Daniel proposed doing the runstate transition immediately afte=
r
>> the command line has been read and no --preconfig option has been foun=
d.
>>  Doing that indeed fixes the issue for me (but I don't know whether
>> that's the best solution).
>=20
> Oh has he? I can't find it anywhere.

That was in #qemu on OFTC:

[Friday, June 1 2018] [15:21:26 CEST] <danpb> if we've not passed
--preconfig though, we should not be in PRECONFIG state in the first
place IMHO
[Friday, June 1 2018] [15:22:27 CEST] <danpb> eg  vl.c should set the
state to RUN_STATE_PRELAUNCH  immediately after parsing CLI args if
--preconfig wasn't given

Max


--4YRfFjbJ5eShEPHO4jrYSdp5jzE9AcuE0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsVCl4ACgkQ9AfbAGHV
z0Cj5gf+K9g89X11rcX8J4jVE8BINC/D07Y/IRG/zEdrJKvyee+RKaD/C0QQquRM
iW5CuGFIlKJcp/sUhloqsDB4S84bxDrWBFfR4IbVEQyJQ97VAh46vI138LTGdW3/
oD0cEYGprgwLVXkUrFTwCb/lYO00Kg47kKOPCk3p00sMGdXWj+gUwevwWnH1dfnj
CWsSohvpc1RExT15AsfIALoMmoSmoGlW0P0OYJ4N9YruG2L7cTZp85kTrN5siVrO
094u7cF5BTHIOB8zXYnxlWZfoXs7opQ1qvp6iJfzMKWGxJDQ11XvT3mVdNzQCXRz
v1PafCoi0SxbweMkcXkPPGV8sEJeKw==
=W3dF
-----END PGP SIGNATURE-----

--4YRfFjbJ5eShEPHO4jrYSdp5jzE9AcuE0--
