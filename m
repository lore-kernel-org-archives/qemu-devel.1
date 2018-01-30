Received: from eggs.gnu.org ([2001:4830:134:3::10]:55349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZDV-0005zI-8R
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:57:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egZDQ-0007j8-No
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:57:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egZDQ-0007iI-9r
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 11:57:00 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8806B5A6E
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 16:56:59 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-8-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <62197e41-e58e-bb1a-7af1-3fb52c26c7ee@redhat.com>
Date: Tue, 30 Jan 2018 10:56:57 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-8-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0OwniajCjansMLrt9B3FCkWrGXkNaImbL"
Subject: Re: [Qemu-devel] [PATCH 07/18] Eliminate qapi/qmp/types.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0OwniajCjansMLrt9B3FCkWrGXkNaImbL
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <62197e41-e58e-bb1a-7af1-3fb52c26c7ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/18] Eliminate qapi/qmp/types.h
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-8-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:21 AM, Markus Armbruster wrote:
> qapi/qmp/types.h is a convenience header to include a number of
> qapi/qmp/ headers.  Since we rarely need all of the headers
> qapi/qmp/types.h includes, we bypass it most of the time.  Most of the
> places that use it don't need all the headers, either.
>=20
> Include the necessary headers directly, and drop qapi/qmp/types.h.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/qapi.c                        |  3 ++-
>  block/qcow2.c                       |  3 ++-
>  blockdev.c                          |  2 +-
>  hw/pci/pcie_aer.c                   |  1 -
>  hw/watchdog/watchdog.c              |  1 -
>  include/qapi/qmp/types.h            | 24 ------------------------

Goodbye!  Glad to be rid of you!

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0OwniajCjansMLrt9B3FCkWrGXkNaImbL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwo9kACgkQp6FrSiUn
Q2rIRQgAihWBO1hnp+5e+NGwdbUhrXpCqOy2APXcThYP3vhmxw1SRM1YZH/Gwb3a
zJ+MHDld3YCeN7Av+6j0y4Wy0CLdTbZRnNYsFMGsGA08Y4LeQ8D5Zip4C57KYGTm
r7D/pEeNJVpEw38OSqPBeEr7gjGrtNKFdEpWuupD/kE85RyeTcr5Ukw3dsrfZkdJ
GsKsLsB8e/a0eeyJptTtyPbXv+upa0vzwIC6/6MWXwEugLQh8yApCyZQJL2AMsBQ
6CmZDd4B3GD5s9CR67TvqhI+zvpsSN9Loj4/8m26A2301AEb4yE154YBjXpTAzER
FMvO+5BDNQxxPPx8MCk7qbHbiQxLPw==
=U1fc
-----END PGP SIGNATURE-----

--0OwniajCjansMLrt9B3FCkWrGXkNaImbL--
