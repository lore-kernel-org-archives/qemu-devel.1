Received: from eggs.gnu.org ([2001:4830:134:3::10]:55148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7Ge-0001KV-TB
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:03:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cv7Ga-0006KO-27
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:03:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47458)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cv7GZ-0006Jy-Pu
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:03:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 74DE565CFC
	for <qemu-devel@nongnu.org>; Mon,  3 Apr 2017 19:03:50 +0000 (UTC)
References: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
	<e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
	<59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
	<20170324035537.GA22342@localhost.localdomain>
	<87fui3yx0y.fsf@dusky.pond.sub.org>
	<20170324124213.GC22342@localhost.localdomain>
	<89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
	<20170324141025.GE15423@localhost.localdomain>
	<2c25aa1c-3832-e8a6-4bfa-004a79a10c77@redhat.com>
	<87h92ffeg4.fsf@dusky.pond.sub.org> <20170403112525.GO2768@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2f41b847-cbe1-29c7-d092-6d93ac84fb49@redhat.com>
Date: Mon, 3 Apr 2017 14:03:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170403112525.GO2768@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="x2I0rSgJJsj0WbMBQ8Ci6W0h7kNphGgp8"
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, mreitz@redhat.com, dillaman@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--x2I0rSgJJsj0WbMBQ8Ci6W0h7kNphGgp8
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, mreitz@redhat.com, dillaman@redhat.com
Message-ID: <2f41b847-cbe1-29c7-d092-6d93ac84fb49@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
References: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
 <e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
 <59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
 <20170324035537.GA22342@localhost.localdomain>
 <87fui3yx0y.fsf@dusky.pond.sub.org>
 <20170324124213.GC22342@localhost.localdomain>
 <89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
 <20170324141025.GE15423@localhost.localdomain>
 <2c25aa1c-3832-e8a6-4bfa-004a79a10c77@redhat.com>
 <87h92ffeg4.fsf@dusky.pond.sub.org> <20170403112525.GO2768@redhat.com>
In-Reply-To: <20170403112525.GO2768@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/03/2017 06:25 AM, Daniel P. Berrange wrote:
> On Mon, Mar 27, 2017 at 07:58:51AM +0200, Markus Armbruster wrote:
>> =3D What to do for 2.9 =3D
>>
>> I propose to
>>
>> * drop both "auth_supported" and "password-secret" from the QAPI schem=
a
>>
>> * drop "password-secret" from QemuOpts
>>
>> * hide "keyvalue-pairs" in QemuOpts
>>
>> No existing usage is affected, since all these things are new in 2.9.
>=20
> Maybe I'm mis-understanding what you're suggesting wrt QemuOpts, but
> 'password-secret' with RBD is not new in 2.9.0

We updated things in the respin of this series; the actual committed
version (ending in commit d1c13688) did NOT kill password-secret from
QemuOpts, but merely removed it from QMP (it was the QMP portion that
was attempted to be new in 2.9).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--x2I0rSgJJsj0WbMBQ8Ci6W0h7kNphGgp8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY4pySAAoJEKeha0olJ0Nq1bcH/iSMG/3Ha8uRiccLIdEHLvE4
1jvnzNa948IXcuSxesZa0lwMKWz9vkgYWI4/hmCkUAA1YXmwnM7QBkyACu6NWbH4
hFRN+zq4WYyD1K/EH1E5Tcas9nnlHZrtwGjH/s4h5RfBVgErKVnw4G8O32KGgVuP
MT4t+tZZS0yZycYhX0sFReua8UFHdynmEU0NGQowJ2DpNUaMKIA8JchO28DwMDU1
4MmrG4HTzRlpfY3eqSNemhBkcyNK+AL0gml2Cm2aKyPVUv0CpoLTJGw/k7u1V046
6w7eYcVoHQgzIw8HcyfHVMDzz5qniCjxeAcYp/jSa9i/f9j/sB3lrDGdy2lCFpk=
=smE/
-----END PGP SIGNATURE-----

--x2I0rSgJJsj0WbMBQ8Ci6W0h7kNphGgp8--
