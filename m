Received: from eggs.gnu.org ([2001:4830:134:3::10]:42858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFj4P-0007YX-9v
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dFj4K-00049J-NG
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:28:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dFj4K-00049C-DN
	for qemu-devel@nongnu.org; Tue, 30 May 2017 11:28:24 -0400
References: <20170511191843.13784-1-ehabkost@redhat.com>
	<20170511191843.13784-3-ehabkost@redhat.com>
	<CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
	<20170530140103.GI32274@thinpad.lan.raisama.net>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5f082e0c-6b89-188f-19d5-dfe476c140fc@redhat.com>
Date: Tue, 30 May 2017 10:28:21 -0500
MIME-Version: 1.0
In-Reply-To: <20170530140103.GI32274@thinpad.lan.raisama.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NjmLpmVMAw6GoMLuv1ubXpwU82v6xQOmW"
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NjmLpmVMAw6GoMLuv1ubXpwU82v6xQOmW
From: Eric Blake <eblake@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, He Chen <he.chen@linux.intel.com>
Message-ID: <5f082e0c-6b89-188f-19d5-dfe476c140fc@redhat.com>
Subject: Re: [Qemu-devel] [PULL 02/29] numa: Allow setting NUMA distance for
 different NUMA nodes
References: <20170511191843.13784-1-ehabkost@redhat.com>
 <20170511191843.13784-3-ehabkost@redhat.com>
 <CAFEAcA-jdbDL1uuhM5W=b4qisPsvpJz7aciR8WQebVy43QuBKQ@mail.gmail.com>
 <20170530140103.GI32274@thinpad.lan.raisama.net>
In-Reply-To: <20170530140103.GI32274@thinpad.lan.raisama.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/30/2017 09:01 AM, Eduardo Habkost wrote:

>> The OSX compiler is pickier about format strings than gcc,
>> and neither "MAX_NODES" nor "MAX(anything)" are uint16_t type.
>=20
> src and dst are both uint16_t, so MAX(src, dst) is also uint16_t,
> isn't it?  It looks like MAX_NODES is the problem.

No. MAX() invokes arithmetic (both ?: and > operators), and arithmetic
involves default promotion (anything shorter than int becomes 'int').

> +++ b/numa.c
> @@ -232,7 +232,7 @@ static void parse_numa_distance(NumaDistOptions *di=
st, Error **errp)
>      if (src >=3D MAX_NODES || dst >=3D MAX_NODES) {
>          error_setg(errp,
>                     "Invalid node %" PRIu16
> -                   ", max possible could be %" PRIu16,
> +                   ", max possible could be %d",

Don't you want %u to match PRIu16, rather than %d?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--NjmLpmVMAw6GoMLuv1ubXpwU82v6xQOmW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZLY+VAAoJEKeha0olJ0Nq99oH/i7FnPpGV9PzwhUUURLt0J9D
Nx/nG8/WqDIViGEbNrOUb8Iis33ZXFOAZGd2Z3XAYhqH/H2OyAsFyn4rfWsb7+9C
cHqOSus5is/dXbqRTT/DabmJ1s1PpnKOC1TWVyCQTgd9M5nmZWQ2Np0/iXPQCi9a
YO6cOSkpzd+pINLK4+d/ywRL2mRW6LqD6/YUqVe2arN/oKvXoTOrcWZJK5SFqnyr
6p8N/k1rYSBvbuBgaK+A7az4j7wYNqvTYR7VphOjwiDlcOPKVg2MHyXfLD9e1t1D
/LpPuKqGHTcC0te6+Zi30FKG8v9kEzt2rSgo1V4dMNGzT+enjinko0YG4m805NY=
=e2O7
-----END PGP SIGNATURE-----

--NjmLpmVMAw6GoMLuv1ubXpwU82v6xQOmW--
