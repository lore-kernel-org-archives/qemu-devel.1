Received: from eggs.gnu.org ([2001:4830:134:3::10]:52306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnmTo-0006pW-3T
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:04:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fnmTj-0000em-Je
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:04:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39868 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fnmTj-0000ea-Cf
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 11:03:55 -0400
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
	<a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
	<20180809165549.5c92d5f4.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
Date: Thu, 9 Aug 2018 17:03:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180809165549.5c92d5f4.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L9AVf8P6VKB2FPUZiN9kFJpY2XfpI9UUc"
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
--L9AVf8P6VKB2FPUZiN9kFJpY2XfpI9UUc
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>,
 Richard Henderson <rth@twiddle.net>,
 "open list:Overall" <qemu-devel@nongnu.org>
Message-ID: <dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
Subject: Re: [PATCH v1] exec: handle NULL pointer in flatview_read_continue
References: <20180809141403.11296-1-olaf@aepfle.de>
 <20180809162403.32c53c50.olaf@aepfle.de>
 <30203041-c944-1a12-d983-9735756dc334@redhat.com>
 <20180809163816.092a7c8c.olaf@aepfle.de>
 <a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
 <20180809165549.5c92d5f4.olaf@aepfle.de>
In-Reply-To: <20180809165549.5c92d5f4.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 09/08/2018 16:55, Olaf Hering wrote:
>=20
>> I think the simplest fix is for the map
>> cache to set aside a zero page and return it whenever it is asked for =
a
>> ballooned page.
> Can qemu actually know if it ran into a ballooned page? I think no.

Well, xen_map_cache knows that it has run into *something like* a
ballooned page when it returns NULL. :)

Paolo


--L9AVf8P6VKB2FPUZiN9kFJpY2XfpI9UUc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAltsV9gACgkQv/vSX3jH
roNSrAf/ZsouqMs1YrjLAAhHw9IIrHpjAjYOsfVY771mdla6km3f2L5m4Zj6F+Nn
/v0Wrtcb5HD+d6DudhF5ssc6NJ6b3A6LnYDX/0nqzqEYkcEy9cO3ZjLFRcia6539
mpR3XwVV/ejEtfUvLb8T0kiQB3bag/WY1W6rQKqWod9CH9UlvLJlh5mmVyFU0sWV
vXYDNgAi1lRcUMHq5Il8Hao5qzsOYJfINmzDPJhNyYwk7Jk3jzR+URNq8gQ+1gOI
37e3C2+qbLnaCCxjO5Poh4E42Dad6I0M8xbEBKKw3J6wURSfJH5WnR8ramCBF7X6
4yD5DZKvlDaWpTlnH4mLx5CM6/uH4w==
=ynIp
-----END PGP SIGNATURE-----

--L9AVf8P6VKB2FPUZiN9kFJpY2XfpI9UUc--
