Received: from eggs.gnu.org ([208.118.235.92]:54081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfVQK-00020q-2U
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:46:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfVQF-0008Ie-D5
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:46:28 -0500
References: <20190104181208.7809-1-philmd@redhat.com>
	<20190104181208.7809-2-philmd@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8227c1e9-4a27-d01d-b9e4-fd52560b51b3@redhat.com>
Date: Fri, 4 Jan 2019 13:45:59 -0600
MIME-Version: 1.0
In-Reply-To: <20190104181208.7809-2-philmd@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6VHf3FOFsqmXTuVguluWI6monROqnxeoL"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] util/cutils: Move size_to_str()
 from "qemu-common.h" to "cutils.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6VHf3FOFsqmXTuVguluWI6monROqnxeoL
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Richard Henderson <rth@twiddle.net>
Message-ID: <8227c1e9-4a27-d01d-b9e4-fd52560b51b3@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] util/cutils: Move size_to_str() from
 "qemu-common.h" to "cutils.h"
References: <20190104181208.7809-1-philmd@redhat.com>
 <20190104181208.7809-2-philmd@redhat.com>
In-Reply-To: <20190104181208.7809-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 12:12 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> The size_to_str() function doesn't need to be in a generic header.
>=20
> It makes also sens to find this function in the same header than

s/sens/sense/ s/than/as/

> the opposite string to size functions: qemu_strtosz*().
> Note than this function is already implemented in util/cutils.c.

s/than/that/

>=20
> Since we introduce a new function in a header, we document it,
> using the previous comment from the source file.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--6VHf3FOFsqmXTuVguluWI6monROqnxeoL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwvt/cACgkQ3g5py3or
ov3EVgf/TXmVsEb/9wAm7M/SxJRe7BjiEDY/q8GAQ0ST3pV78xqkwf1kZhhC3ScT
dCFvSyFDmpLrSb1V1dkGZDS9WhCLCS327FVvIy346lUmYH5eegEMEDxxVlg2xHQj
LofuIJmWoisr5d8Ff9S37vg4JeN54YAhmXmVwY/EXlPF3lTqRWm4AKnIbQ6m4buu
hW9FkgdYyFefGsmpNcSRYiq0Ous/GJqM/PCN8CMK20k5Xahs2cN6P16g1sEtwMEb
6CaylRw2DdOM0Unw1+ClNt5H8U46rKM4IMhB53mr3pKqAYh5gR5FCtri3eIyhNzp
+WRzkJhGrcdTqbSSnRSA4Xn9jmgQ3A==
=45Vt
-----END PGP SIGNATURE-----

--6VHf3FOFsqmXTuVguluWI6monROqnxeoL--
