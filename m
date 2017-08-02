Received: from eggs.gnu.org ([2001:4830:134:3::10]:48768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcsqU-0007XQ-Nz
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:33:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcsqR-0006Wv-JE
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:33:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57974)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcsqR-0006Wl-AG
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 08:33:47 -0400
References: <CAK6XCv6oYSL=gQKhv6N5e7y620szz5Wc5g13OOMd=C54Lc=O7w@mail.gmail.com>
	<20170802121856.GG4098@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6da76618-0d93-dc45-1768-4598cf07a95f@redhat.com>
Date: Wed, 2 Aug 2017 07:33:44 -0500
MIME-Version: 1.0
In-Reply-To: <20170802121856.GG4098@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0UijUVKjqeQalPAqeT8I0QsrU5TXIuqqu"
Subject: Re: [Qemu-devel] Where is the VM live migration code?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, Aditya Bhardwaj <adityaform@gmail.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0UijUVKjqeQalPAqeT8I0QsrU5TXIuqqu
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>,
 Aditya Bhardwaj <adityaform@gmail.com>
Cc: qemu-devel@nongnu.org
Message-ID: <6da76618-0d93-dc45-1768-4598cf07a95f@redhat.com>
Subject: Re: [Qemu-devel] Where is the VM live migration code?
References: <CAK6XCv6oYSL=gQKhv6N5e7y620szz5Wc5g13OOMd=C54Lc=O7w@mail.gmail.com>
 <20170802121856.GG4098@redhat.com>
In-Reply-To: <20170802121856.GG4098@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/02/2017 07:18 AM, Daniel P. Berrange wrote:
> On Wed, Aug 02, 2017 at 04:25:08PM +0530, Aditya Bhardwaj wrote:
>> My lab setup is: 3 HP Servers each of 4 GB RAM. Server 1 and Server 2:=

>> installed with Virtualization using KVM on Redhat 6.5 System. On top o=
f
>> this I am using libvirtd for managing virtual machines. NFS server is
>> installed on Server 3 for shared disk image. VM migration is working
>> correctly. Now i need to do some changes in "migration.c" but did not =
find
>> any source code of KVM-QEMU migration.
>>
>> Where I can find the migration source code for KVM-QEMU. All are reque=
sted
>> to help me for this issue.
>=20
> QEMU source code is in GIT
>=20
>   https://git.qemu.org/gitweb.cgi?p=3Dqemu.git;a=3Dsummary
>=20
> in the 'migration' directory.
>=20
> If you're new writing code for QEMU then see this page too
>=20
> https://wiki.qemu.org/index.php/Documentation/GettingStartedDevelopers

I've also got a patch pending to make the various qemu executables
provide a link to qemu.org as part of their --help output (which will in
turn make it easier to find links to the source code):

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg09049.html

It needs some review if it's going to be part of 2.10.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0UijUVKjqeQalPAqeT8I0QsrU5TXIuqqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmBxqkACgkQp6FrSiUn
Q2pCuAf/Sqkxj1KVR1ect9ah7mnZ7nyntbRUx1lfnhecGeBiUwJhGJkohAkTZrB5
1EvC5lF22KkObUWll2Qgd3iJBBornRyYaoDAJCGTkq2Ka6vzgiLZ9fxWqZxmWneW
F+SyVrjqsHy46n55MrrwxxuyO2Io50DFXiXMpaW6tdy+uUna7DYJodA57x7Pz75H
qsUNlfmWp4dcpzu9tAsIKQfWqy+klQBjG/nBImYehvY+UQfFYYIdukbofG0ZRU8N
QQ3MSnIwDni6ibYGFJfUozWAcObEJLKupgZMIdUKyNBDI4viOlzH8f3/mObPnifk
U3hLLW0rH6MhUVVIxpmsvdc6+bsquA==
=dtLq
-----END PGP SIGNATURE-----

--0UijUVKjqeQalPAqeT8I0QsrU5TXIuqqu--
