Received: from eggs.gnu.org ([2001:4830:134:3::10]:46145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dqyMp-0004El-9i
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 05:17:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dqyMl-0006qv-Ad
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 05:17:27 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:33500)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1dqyMl-0006pL-15
	for qemu-devel@nongnu.org; Sun, 10 Sep 2017 05:17:23 -0400
Received: by mail-pg0-x244.google.com with SMTP id i130so1288703pgc.0
	for <qemu-devel@nongnu.org>; Sun, 10 Sep 2017 02:17:21 -0700 (PDT)
References: <20170907092010.3605-1-aik@ozlabs.ru>
	<20170907092010.3605-3-aik@ozlabs.ru>
	<20170909071846.GU2735@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <fe582ba6-ac4f-e592-651d-e178ee99d508@ozlabs.ru>
Date: Sun, 10 Sep 2017 19:17:13 +1000
MIME-Version: 1.0
In-Reply-To: <20170909071846.GU2735@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="40Eg9JV9PgJVIMRVBCQrh155abaUlCwBm"
Subject: Re: [Qemu-devel] [RFC PATCH qemu 2/4] memory: Prepare for shared
 flat views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--40Eg9JV9PgJVIMRVBCQrh155abaUlCwBm
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Message-ID: <fe582ba6-ac4f-e592-651d-e178ee99d508@ozlabs.ru>
Subject: Re: [RFC PATCH qemu 2/4] memory: Prepare for shared flat views
References: <20170907092010.3605-1-aik@ozlabs.ru>
 <20170907092010.3605-3-aik@ozlabs.ru> <20170909071846.GU2735@umbus.fritz.box>
In-Reply-To: <20170909071846.GU2735@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/09/17 17:18, David Gibson wrote:
> On Thu, Sep 07, 2017 at 07:20:08PM +1000, Alexey Kardashevskiy wrote:
>> We are going to share flat views and dispatch trees between address
>> spaces. This moves bits around but no change in behaviour is expected
>> here. The following patch will implement sharing.
>>
>> This switches from AddressSpace to AddressSpaceDispatch as in many
>> places this is what is used actually. Also, since multiple address
>> spaces will be sharing a flat view, MemoryRegionSection cannot store
>> the address space pointer, this changes it to AddressSpaceDispatch
>> as well. As a not very obvious result, IOMMUTLBEntry also switched
>> from AddressSpace to AddressSpaceDispatch to make
>> address_space_get_iotlb_entry() work.
>=20
> So, mostly this seems to be exposing AddressSpaceDispatch in more
> places.  It's not obvious to me why that's useful.


It is mostly for IOMMUs - since dispatch tree and flat view is shared amo=
ng
address spaces, I cannot use address spaces in iommu_ops::translate - too=

ambiguous - "use any attached to this flatview/dispatch" is just  confusi=
ng.


--=20
Alexey


--40Eg9JV9PgJVIMRVBCQrh155abaUlCwBm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZtQMZDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5RIEP/0h/
HHf4vZ+LJXh39ygxElbrkLczJoREVw8y9BFzwWTajjEk5hRyCZfVa4lXoRhgWuem
S6ihEUXSYd3m+aLGyzcl5OqwhDAI+ANGSbF7g6Nj36++VXYcsNQOc6izgQAIZXeS
Sl2cP1hNQbBh+Ib8rVEOv0BsSsIPrkAZQk+nEEIcD5Gmk14v3EV0GEDbPNSC0ZzP
QsskAbfv5opusV96i8ECvNz6g2yZhhnrkXM8AwfXVNMwELU9T8/lbeyBu4fss0am
Lqqfwr8+EwVZ7KcKgHxkglSxGeGKaVKQlCPWikdxhej0mkGpFano0BBLwrzUQJZy
7TMiseYkPMBoyk5JrG+TIUBffLvL6pjsUx5wxJgK39FElN4tw+FYGwqzCYH6jpQ9
NJrtfsA/Lb0C+nEzZ6W9GB+IT940JKBE7C6uiGJkeNHGh21dzCA0K0O4gJlEhgD7
MT/0I0vuaZ7h5ESJGwchnAT52SO7o1FK0L0cWo0sQvd7XAzO9Tdy3O9UquQ57B8a
ej8eKXJN/sRCIRAfIsuvONAZq5xQqhts9Czq66oZzkGX+Ttsw+Rjja9uVhcHtrDs
2UIkphTQIlh4Zw+xhwiNaW4oI5psMiWuhAKBKn2coxTpt+bjAwLVMdIkIaXprDjv
xCLfdcnD+fKGHQTraV8MZl6eVIk7K/WaYlKHJntt
=+WHW
-----END PGP SIGNATURE-----

--40Eg9JV9PgJVIMRVBCQrh155abaUlCwBm--
