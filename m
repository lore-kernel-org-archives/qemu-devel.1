Received: from eggs.gnu.org ([2001:4830:134:3::10]:38054)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0Zm-0005m9-Co
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS0Zg-0004jc-TN
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 08:35:38 -0400
References: <20170703122505.32017-1-mreitz@redhat.com>
	<20170703122505.32017-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aed2cf9b-1360-1bb7-0489-40f5ed3b7843@redhat.com>
Date: Mon, 3 Jul 2017 07:35:25 -0500
MIME-Version: 1.0
In-Reply-To: <20170703122505.32017-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KixMPMLC9V65QD2GJMEltfOFiApRVm8c2"
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qapi/qnull: Add own header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KixMPMLC9V65QD2GJMEltfOFiApRVm8c2
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org
Message-ID: <aed2cf9b-1360-1bb7-0489-40f5ed3b7843@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/5] qapi/qnull: Add own header
References: <20170703122505.32017-1-mreitz@redhat.com>
 <20170703122505.32017-2-mreitz@redhat.com>
In-Reply-To: <20170703122505.32017-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/03/2017 07:25 AM, Max Reitz wrote:
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qnull.h   | 26 ++++++++++++++++++++++++++
>  include/qapi/qmp/qobject.h |  8 --------
>  include/qapi/qmp/types.h   |  1 +
>  qobject/qnull.c            |  2 +-
>  tests/check-qnull.c        |  2 +-
>  5 files changed, 29 insertions(+), 10 deletions(-)
>  create mode 100644 include/qapi/qmp/qnull.h
>=20
> diff --git a/include/qapi/qmp/qnull.h b/include/qapi/qmp/qnull.h
> new file mode 100644
> index 0000000..48edad4
> --- /dev/null
> +++ b/include/qapi/qmp/qnull.h
> @@ -0,0 +1,26 @@
> +/*
> + * QNull
> + *
> + * Copyright (C) 2015 Red Hat, Inc.

The date makes sense based on when the bulk of the content for this file
was first introduced elsewhere, but I'm okay if you also want to add 2017=
=2E

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--KixMPMLC9V65QD2GJMEltfOFiApRVm8c2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWjoNAAoJEKeha0olJ0NqbNMIAJXoIC7K83bcIxSYjhNmyllX
tHGXeIjrxqpi5VHN5cCviVeAjzgwuZSg63gCZsmFXpG5KYZo5D3V7dYdocFuxOxk
tOV+oU1TMFVSCMiwM5Qnr7Hgof/A/G7OmWbNG5P5FSzO7gWd18p3+aVc2BgKoWbg
TWX6dmgoXArHbHrlqA2yrIYM04DDlk638ovceD/O187+xqWW+91gCI4xKrFdQRoh
clszzRe0AO5z/yA1sWumVWAmvprEqaz/KNCsCoWTimR2jMMEU7KqGZ+aGMGhYaiJ
VJpTZsH3B9i4MmCJ7WrgtvqVPcpCKtBN0zWIIViVDNmmCuV9E74mLRQ0w7UB5fM=
=ZnK/
-----END PGP SIGNATURE-----

--KixMPMLC9V65QD2GJMEltfOFiApRVm8c2--
