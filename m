Received: from eggs.gnu.org ([2001:4830:134:3::10]:44915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPq6D-0000g6-W8
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:04:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fPq69-0006lt-2Z
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:04:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1fPq68-0006lF-RG
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:04:36 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 234C2406E966
	for <qemu-devel@nongnu.org>; Mon,  4 Jun 2018 14:04:36 +0000 (UTC)
References: <d714d8ac-6642-f2f3-ad9c-ac7e3bdf30e0@redhat.com>
	<d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <787c23db-430b-dc20-10f7-00fdf119449c@redhat.com>
Date: Mon, 4 Jun 2018 16:04:33 +0200
MIME-Version: 1.0
In-Reply-To: <d453da2c-92fe-5ef8-239c-656c1822b9e0@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="8ZlXBJeJhNbTFHTVXFJdmQXHPJul354Cf"
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
--8ZlXBJeJhNbTFHTVXFJdmQXHPJul354Cf
From: Max Reitz <mreitz@redhat.com>
To: Michal Privoznik <mprivozn@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <787c23db-430b-dc20-10f7-00fdf119449c@redhat.com>
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

I haven't investigated further, but that patch breaks iotest 091 (which
tests migration).  It just stops now after the migration has started, so
it never completes.

Actually, it seems to break all migration iotests (but 203, which
migrates to /dev/null), so I suspect it breaks migration as a whole.

Max


--8ZlXBJeJhNbTFHTVXFJdmQXHPJul354Cf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlsVRvEACgkQ9AfbAGHV
z0D8vAf/QzzULumGTxXwyJIF5Gq3vbHK56K9xk0Gva5nT8S1sJN6DgYh+85KIOJz
24kyFfCM9ISXz+LhTIi0TKU2z29AP+d6aOfE6naYSUEMIl75lVVSLilkK29Z54fZ
T2XznZWV3nhR/zV+MSTXDC1VWU3h0U48hidCF1EzHF35Hc7kKSgiDl03rqE6+QtW
xQi+1bJAkysa5bfT6Ibv993sN2najz1JkUGyuquveu7YWW/5FKS+oj7kfTMitn3m
GIy7kwM/t459eTiS4Zaypdy3CeK3ohsHcPzCTlRd/61Ax1/EpuF/wqDCbYe3Y3hJ
e9ksY4WZ2mvuP63KwawSFD0S2yL5+Q==
=f0Ka
-----END PGP SIGNATURE-----

--8ZlXBJeJhNbTFHTVXFJdmQXHPJul354Cf--
