Received: from eggs.gnu.org ([2001:4830:134:3::10]:52889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlFDz-0005ny-C6
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:04:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dlFDv-0003uZ-Ci
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:04:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dlFDv-0003uN-2v
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 10:04:35 -0400
References: <20170824123006.GK5379@umbus.fritz.box>
	<20170825083123.47432-1-aik@ozlabs.ru>
	<4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
	<CAFEAcA_Z3wWv3_x0kCqD0tEwP=GTV-uoCLmUr5YpWjdD1GyMew@mail.gmail.com>
	<0e7817c4-4189-c620-e71c-d935076286ad@redhat.com>
	<20170825131956.GK2772@umbus.fritz.box>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b7dff81a-d194-5ac0-7884-3902d7ffb7e3@redhat.com>
Date: Fri, 25 Aug 2017 16:04:27 +0200
MIME-Version: 1.0
In-Reply-To: <20170825131956.GK2772@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XmDTQTfl7ELoXXm0qq3oqtiXBQaAkRvcW"
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XmDTQTfl7ELoXXm0qq3oqtiXBQaAkRvcW
From: Paolo Bonzini <pbonzini@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <b7dff81a-d194-5ac0-7884-3902d7ffb7e3@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH qemu] exec: Destroy dispatch immediately
References: <20170824123006.GK5379@umbus.fritz.box>
 <20170825083123.47432-1-aik@ozlabs.ru>
 <4608a2c1-5c74-efea-d901-3b5cfa0519e6@redhat.com>
 <CAFEAcA_Z3wWv3_x0kCqD0tEwP=GTV-uoCLmUr5YpWjdD1GyMew@mail.gmail.com>
 <0e7817c4-4189-c620-e71c-d935076286ad@redhat.com>
 <20170825131956.GK2772@umbus.fritz.box>
In-Reply-To: <20170825131956.GK2772@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 25/08/2017 15:19, David Gibson wrote:
> On Fri, Aug 25, 2017 at 11:57:26AM +0200, Paolo Bonzini wrote:
>> On 25/08/2017 11:22, Peter Maydell wrote:
>>> On 25 August 2017 at 09:53, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
>>>> The solution is to: 1) share the FlatView structures if they refer t=
o
>>>> the same root memory region; 2) have one AddressSpaceDispatch per
>>>> FlatView instead of one per AddressSpace, so that FlatView reference=

>>>> counting takes care of clearing the AddressSpaceDispatch too.  Neith=
er
>>>> is particularly hard.
>>> If we did this we could get rid of address_space_init_shareable(),
>>> right? (It's a bit of a cheesy hack aimed at avoiding having duplicat=
e
>>> address space structures for the same root memory region, but if
>>> the underlying code is better at not duplicating all the data
>>> structures unless necessary then the benefit of having the
>>> separate API goes away I think.)
>>
>> Yes, indeed.
>=20
> Hm.  Why do we need to construct full ASes for virtio-blk, rather than
> just MRs?

It's an artifact of how virtio_address_space_read and
virtio_address_space_write are implemented.

Paolo


--XmDTQTfl7ELoXXm0qq3oqtiXBQaAkRvcW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmgLmsACgkQv/vSX3jH
roM0Rgf/X1oenMjMZYUrRRWnUUH6t5OKUOiB71JTApH49QthUaU18PUWZ7DfuLaR
VHxAvi+ShM6Sn4hkDhBOEnndQNNfiR7vie/D3xhAEsri7Fvbg+9m+BXYxc3H6A7Q
oab28e1HdCZdPsznygcyxFtMlf9fXbR5N6PcCDL9UhWonHZ0X2MSx4+UnMcIapgr
mbNBuWiR4etCZsV7lT5vJM+0burMA4hwzHldRF8KnhheOriI9uicB8FG63w/rLn6
dhf1/zWtWFj6blK3Ql2xMRVRTH9kyHiZiCNVQQBX8x+RfSLlq3W2ha2z1uTyN+/V
0Ovu0UwTANdnFUmi9XbzPOaU29PAOA==
=tvCE
-----END PGP SIGNATURE-----

--XmDTQTfl7ELoXXm0qq3oqtiXBQaAkRvcW--
