Received: from eggs.gnu.org ([2001:4830:134:3::10]:48990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnmIg-0000E0-7S
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnmIc-0002wb-2x
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:52:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34232 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fnmIb-0002vp-Rr
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 10:52:26 -0400
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
Date: Thu, 9 Aug 2018 16:52:22 +0200
MIME-Version: 1.0
In-Reply-To: <20180809163816.092a7c8c.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uUin2DNDCNPJjygDHFCDYWpREju9e8wh6"
Subject: Re: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olaf Hering <olaf@aepfle.de>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uUin2DNDCNPJjygDHFCDYWpREju9e8wh6
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "open list:Overall" <qemu-devel@nongnu.org>
Message-ID: <a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
Subject: Re: [PATCH v1] exec: handle NULL pointer in flatview_read_continue
References: <20180809141403.11296-1-olaf@aepfle.de>
 <20180809162403.32c53c50.olaf@aepfle.de>
 <30203041-c944-1a12-d983-9735756dc334@redhat.com>
 <20180809163816.092a7c8c.olaf@aepfle.de>
In-Reply-To: <20180809163816.092a7c8c.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/08/2018 16:38, Olaf Hering wrote:
> Am Thu, 9 Aug 2018 16:37:05 +0200
> schrieb Paolo Bonzini <pbonzini@redhat.com>:
>=20
>> If no RAM is allocated (i.e. xen_map_cache will return NULL), however,=

>> the memory should not be registered as RAM with the memory API.  So I
>> think the bug is in Xen code.
>=20
> Someone familiar with that code has to figure that out. A ballooned pag=
e will trigger that bug.

I guess that's the answer.  I think the simplest fix is for the map
cache to set aside a zero page and return it whenever it is asked for a
ballooned page.

Paolo


--uUin2DNDCNPJjygDHFCDYWpREju9e8wh6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAltsVSYACgkQv/vSX3jH
roNi6gf+KqmHG09FBM2PMbs775ikMyQhTdvmFb4oMuLo3ELo6GYtE6nlH/15X/ux
5UWLv0CVisYRJivBPOWAJXGWww58psXL/8VDEWEibdnfcmxF0src3oE4Duj1UlKW
lWBsWKCkL06ARWMHTpESoE2F5+Yuw2vw6C18DpgexAN7zlVbGYeQGRSTExl9eMFU
WqrW/F8X5mpM/Oqxbouclfo8rK5KHuUmDvNIeekhI/Gtika6/4ExQoBo121zKDMQ
ZSkKa+vEYlol7ISIwtHYYkY+hns6w1wvxDQ2wAXBZTsvad3xJW6JEbpfiWHPU9Na
CJ0l5pLe3pMp3kRa8SW/tnG9/R7P2g==
=Tcw4
-----END PGP SIGNATURE-----

--uUin2DNDCNPJjygDHFCDYWpREju9e8wh6--
