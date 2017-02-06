Received: from eggs.gnu.org ([2001:4830:134:3::10]:53092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capK3-00031P-TJ
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1capK0-0005sj-Nn
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:51:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51058)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1capK0-0005sJ-FF
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 14:51:32 -0500
References: <165854135.894789.1486069129896.JavaMail.zimbra@research.iiit.ac.in>
	<20170203152407.GH642@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <028cef8c-2f84-b98a-b914-ed9f5c98acfc@redhat.com>
Date: Mon, 6 Feb 2017 13:51:29 -0600
MIME-Version: 1.0
In-Reply-To: <20170203152407.GH642@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0kXfIa2FMkbSLmlPAj6PD13OPJ6ChCfKE"
Subject: Re: [Qemu-devel] regarding codebase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Shubham Kumar <kumar.shubham@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0kXfIa2FMkbSLmlPAj6PD13OPJ6ChCfKE
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Shubham Kumar <kumar.shubham@research.iiit.ac.in>
Cc: qemu-devel@nongnu.org
Message-ID: <028cef8c-2f84-b98a-b914-ed9f5c98acfc@redhat.com>
Subject: Re: [Qemu-devel] regarding codebase
References: <165854135.894789.1486069129896.JavaMail.zimbra@research.iiit.ac.in>
 <20170203152407.GH642@stefanha-x1.localdomain>
In-Reply-To: <20170203152407.GH642@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/03/2017 09:24 AM, Stefan Hajnoczi wrote:
> On Fri, Feb 03, 2017 at 02:28:49AM +0530, Shubham Kumar wrote:
>> I'm having difficulty in understanding the codebase of QEMU .There see=
m to have hundreds of code files and header files in the directory and I'=
m unable to figure out the functionality of each file.Is there any way to=
 understand the function of each file ??
>=20
> vl.c is the main() function for the qemu-system-* family of programs
> (the "system emulators").  You could start exploring the source code
> from there.  That's what I did when I first started hacking on QEMU.
>=20
> Be prepared to read code.  QEMU isn't an educational codebase and the
> code reflects the requirements of many contributors over the years.
> Most of their requirements may not be relevant to you.  You will learn
> to skip the stuff that doesn't affect you and to see the big picture.

In fact, I seriously doubt ANYONE knows the entire code base.  Rather,
various people are experts in a subset of the code base; the MAINTAINERS
file is a good mapping of where to direct questions about a particular
file.  It's also a good jumping off point if you see a category that
interests you for knowing what files to inspect related to that category.=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--0kXfIa2FMkbSLmlPAj6PD13OPJ6ChCfKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYmNPBAAoJEKeha0olJ0Nqd+YIAK8Nczctk84rmvFlQPdRq4f7
/DetYivcc8navNdT5IbFFRC5pTn5BKa3BVLRkfb9Nch8rc/CCg0AKzj5RgYaDRDW
Xrtu7QAcz5C9NbV1fhQyOk9swtUm9DdFjCdDOp/h08s9DOo5F91nnSlhCS6MpaBI
cRvP/bWoJmCtsHf5NpLoRdRo87v1U1gLvVF4O3sChNS1K8dAAdc9HoYexX6JCzYI
pTHDS5HfQpzeABM9TagJnlj3Bw4fTUrPTOB8noOM4x+IWq5R4DZcj1j33TQ+F21L
FKmLlenXLwFfAb10Z+j8gskh3PQht+LxwUDddprv/Tw/oOxuJX/rH8efXVygzVI=
=uJcB
-----END PGP SIGNATURE-----

--0kXfIa2FMkbSLmlPAj6PD13OPJ6ChCfKE--
