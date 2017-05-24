Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDWNf-00024U-Um
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:31:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDWNa-0007dY-Iu
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:31:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDWNa-0007dP-8v
	for qemu-devel@nongnu.org; Wed, 24 May 2017 09:31:10 -0400
References: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5c021e4-86ce-7476-44dc-d386f2349ed0@redhat.com>
Date: Wed, 24 May 2017 08:30:58 -0500
MIME-Version: 1.0
In-Reply-To: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="c6mRPugd6GL9RGdXFNLUNoNNXCd4wLMlj"
Subject: Re: [Qemu-devel] new to qemu with a simple question
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wang Dong <dongdwdw@linux.vnet.ibm.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--c6mRPugd6GL9RGdXFNLUNoNNXCd4wLMlj
From: Eric Blake <eblake@redhat.com>
To: Wang Dong <dongdwdw@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Message-ID: <f5c021e4-86ce-7476-44dc-d386f2349ed0@redhat.com>
Subject: Re: [Qemu-devel] new to qemu with a simple question
References: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
In-Reply-To: <f0b11c2d-9f61-c4c2-4b55-58644b760e31@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/23/2017 09:56 PM, Wang Dong wrote:
>=20
> Hi guys,
>=20
> I am new to qemu. But I need do some job in it right now.
>=20
> When I try read qmp code. I found a interesting part against it.
>=20
> Some C source code is generate from json file.
>=20
> I wonder why this? What is the benefits of this?

Boring and repetitive code that is easy to typo is best written by a
computer, which excels at boring and repetitive tasks.  Writing our
description in a more concise higher language and generating C code from
that lets us focus on the actual design, rather than the mundane
correctness of the code implementing the design.

It's the same reason that people use bison/yacc rather than hand-written
parsers for complex grammars - you isolate the correctness of the code
to the correctness of the generator, and free yourself to now only have
to worry about the bigger picture of the input you feed to the
generator.  And on another level, it's why we write programs in C
instead of assembly.  Abstraction is good.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--c6mRPugd6GL9RGdXFNLUNoNNXCd4wLMlj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJYsSAAoJEKeha0olJ0NqiYEH/iTvJWVT9j+MQSZDDuG20QIQ
M2bJ0kSWSScTqh1z81h8FUBfRNekrl5LqxqbUyFKGF2ie23QI9aBDOVmcpcMmHYw
/oWMmS5UejSf0UL0ADdA64O/kPgqjHJnXo+iEdjYRmeBuppEqy1z9mX32VOdw9cz
bB3DrhHCsvngW2GQrzVoCogEtIWUA+Hu/+wHoVoxII82I1U816RDitB4e8UPz3Cf
328pfWAVjqXY1t443iJ88M9QPVwnsvtVBOaSNCG+Ub0Trst9fziy4SrGeYxNEnfZ
vk89uWnjmz7lXiucYS+PJ17MPOMOkrHFp4aoUkMIuNXGqMBx8fXsY8uA7Dfiho4=
=J6Fj
-----END PGP SIGNATURE-----

--c6mRPugd6GL9RGdXFNLUNoNNXCd4wLMlj--
