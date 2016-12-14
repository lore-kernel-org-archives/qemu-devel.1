Received: from eggs.gnu.org ([2001:4830:134:3::10]:57232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHCtF-00035A-Oy
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:58:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHCtA-00051M-N3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:58:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cHCtA-00050m-Ep
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:58:44 -0500
References: <20161214150840.10899-1-alex@alex.org.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bf93346f-a875-8d09-0e20-431c7a379c3b@redhat.com>
Date: Wed, 14 Dec 2016 10:58:41 -0600
MIME-Version: 1.0
In-Reply-To: <20161214150840.10899-1-alex@alex.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mN5MM9MMFd8uG3isPDrNfIltOlv3McTKd"
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>, nbd-general@lists.sourceforge.net
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>, stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mN5MM9MMFd8uG3isPDrNfIltOlv3McTKd
From: Eric Blake <eblake@redhat.com>
To: Alex Bligh <alex@alex.org.uk>, Wouter Verheist <w@uter.be>,
 nbd-general@lists.sourceforge.net
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, Pavel Borzenkov <pborzenkov@virtuozzo.com>,
 stefanha@redhat.com, "Denis V . Lunev" <den@openvz.org>,
 Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <bf93346f-a875-8d09-0e20-431c7a379c3b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] Further tidy-up on block status
References: <20161214150840.10899-1-alex@alex.org.uk>
In-Reply-To: <20161214150840.10899-1-alex@alex.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/14/2016 09:08 AM, Alex Bligh wrote:
> (NB: I've already applied this and pushed it)
>=20
> * Change NBD_OPT_LIST_METADATA etc. to explicitly send a list of querie=
s
>   and add a count of queries so we can extend the command later (rather=
 than
>   rely on the length of option)
>=20
> * For NBD_OPT_LIST_METADATA make absence of any query (as opposed to ze=
ro
>   length query) list all contexts, as absence of any query is now simpl=
e.
>=20
> * Move definition of namespaces in the document to somewhere more appop=
riate.
>=20
> * Various other minor changes as discussed on the mailing list
>=20

> +Metadata contexts are identified by their names. The name MUST
> +consist of a namespace, followed by a colon, followed by a leaf-name.
> +The namespace and the leaf-name must each consist entirely of
> +printable non-whitespace UTF-8 characters other than colons,
> +and be non-empty. The entire name (namespace, colon and leaf-name)
> +MUST NOT exceed 255 bytes (and therefore botht he namespace and

s/botht he/both the/


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--mN5MM9MMFd8uG3isPDrNfIltOlv3McTKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYUXpBAAoJEKeha0olJ0Nq/o0IAKhbWAElJPVH0GWnZdwx/b+W
w2OvKSwQZsMwMdhC1sdQ2hW4YYga3nBi87J7J9bYiNicBemvaSpmComxGjI3OjLc
DvfhJBA1tXugHbSrp0wQ1cQ/EUiMGjiX4MzZF3ViPLeuU5KqEheer7awqzO1UZRw
BmR9x/ADz8M/2V2+iunWq10VPGBzIQEFqEsEAK9QPNIziqZRuDPDPa1X5Os2ZxD4
43Sz0AV+9Rmt6DbGR6KQrXR3f8djeS8LBQJ9/sNiJ3dFib0GW7DP05j7Li7WfvrR
lDfFmRJqq6gw2TQOiQrsbHOoIjuqTPFw5rUA+HeEe0vjAwL6FNQEirnGuYREgJ0=
=zzkB
-----END PGP SIGNATURE-----

--mN5MM9MMFd8uG3isPDrNfIltOlv3McTKd--
