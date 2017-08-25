Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGTy-0001sD-0q
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dlGTu-0006dr-Rb
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:25:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dlGTu-0006cT-KZ
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 11:25:10 -0400
References: <20170825032101.42538-1-aik@ozlabs.ru>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a08c16f0-ed01-e511-52fd-1fcaf655819e@redhat.com>
Date: Fri, 25 Aug 2017 10:25:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170825032101.42538-1-aik@ozlabs.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hf1jXPl9Leoa5w2CeMQxF7acoWT0PBUbu"
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Initialize pci_dev->name before
 use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hf1jXPl9Leoa5w2CeMQxF7acoWT0PBUbu
From: Eric Blake <eblake@redhat.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Message-ID: <a08c16f0-ed01-e511-52fd-1fcaf655819e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH qemu] pci: Initialize pci_dev->name before
 use
References: <20170825032101.42538-1-aik@ozlabs.ru>
In-Reply-To: <20170825032101.42538-1-aik@ozlabs.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/24/2017 10:21 PM, Alexey Kardashevskiy wrote:
> This moves pci_dev->name initialization earlier so
> pci_dev->bus_master_as could get a name instead of empry string.

s/empry/an empty/

>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Hf1jXPl9Leoa5w2CeMQxF7acoWT0PBUbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmgQVMACgkQp6FrSiUn
Q2r7+gf+L8zamrfa/T10m+VphOIPaxnn2OzLt4s0Db+uZcF19WcbrdC4wlL22uyi
IHME4q2HeRTejH3/7i3+MmdT2hTRdwZaHnPipERnB3JTQuvXhQoSukafKI8gt5Zl
Qjp9ZdJZ9kUaJWhtqakq/SpNImZTRoYXLN8/pD8Y+qgcYxncUpQxZo7lSFjGCUA3
e6oLvSsIO1KckVjesQ6naQiqMsEveRU3/aFoWHtRFvIrUlJ4CBVZ8MLXP4pXA0BK
Bud0sZblHJxcZHbJQC9pQ781sVBvE5d4foOLYMlK7jYIO0Mp1vTn9Qj8lyAwpqNF
QtBsWok272FrPGmxm3ijnMP6wgM4Qg==
=jqeT
-----END PGP SIGNATURE-----

--Hf1jXPl9Leoa5w2CeMQxF7acoWT0PBUbu--
