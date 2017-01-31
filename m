Received: from eggs.gnu.org ([2001:4830:134:3::10]:42188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYaxn-00045P-BE
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:07:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYaxh-0005hd-A9
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:07:23 -0500
References: <1485878172-15463-1-git-send-email-pl@kamp.de>
	<1485878172-15463-3-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e77b239c-6c6e-821e-07c2-2009d3cc7163@redhat.com>
Date: Tue, 31 Jan 2017 10:07:04 -0600
MIME-Version: 1.0
In-Reply-To: <1485878172-15463-3-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5flVMmkOWUQdmmgLXaA2Pu47ONPgP6i1g"
Subject: Re: [Qemu-devel] [PATCH V2 2/2] block/nfs: fix naming of runtime
 opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com, jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5flVMmkOWUQdmmgLXaA2Pu47ONPgP6i1g
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, ashijeetacharya@gmail.com,
 jcody@redhat.com, mreitz@redhat.com, armbru@redhat.com,
 qemu-stable@nongnu.org
Message-ID: <e77b239c-6c6e-821e-07c2-2009d3cc7163@redhat.com>
Subject: Re: [PATCH V2 2/2] block/nfs: fix naming of runtime opts
References: <1485878172-15463-1-git-send-email-pl@kamp.de>
 <1485878172-15463-3-git-send-email-pl@kamp.de>
In-Reply-To: <1485878172-15463-3-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 09:56 AM, Peter Lieven wrote:
> commit 94d6a7a accidently left the naming of runtime opts and QAPI
> scheme inconsistent. As one consequence passing of parameters in the
> URI is broken. Sync the naming of the runtime opts to the QAPI
> scheme.
>=20
> Please note that this is technically backwards incompatible with the 2.=
8
> release, but the 2.8 release is the only version that had the wrong nam=
ing.
> Furthermore release 2.8 suffered from a NULL pointer deference during

s/deference/dereference/

> URI parsing.
>=20
> Fixes: 94d6a7a76e9df9919629428f6c598e2b97d9426c
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Lieven <pl@kamp.de>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Maintainer can touch that up, my review stands.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--5flVMmkOWUQdmmgLXaA2Pu47ONPgP6i1g
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkLYoAAoJEKeha0olJ0NqQ8wH/0Dy46Yh4yW3LWWqw1JIRal2
znI2VXmk08WqgN983619Hhe3xQ71r2bo/DvCNuEPB4Z2vbYqX6sj0yWIN5aL14yF
rWw8ZUaEoGjRHRDO0DHgsirvO3RhI8WvWQiUF+Fmvp0SOKIkAYX43FqxenFd2crS
PHfedtSH3DAK9PYQl0ItRuT9BKhDDcPthvkAva44lZQxU/etWLQQGI0IlklJMArm
DP/Q5O8VJHAW3oZPBroM2xNdaF41dAk+2Hf7pAo+kcNvwM7SI1McGAjv3gMJUC1f
OHOUNiQ40L7yV24H0RSx3hQE0QGC+zOSw4p9Wxdgh1Wz3/gjiUmhbt/kXbRVFEE=
=Khwg
-----END PGP SIGNATURE-----

--5flVMmkOWUQdmmgLXaA2Pu47ONPgP6i1g--
