Received: from eggs.gnu.org ([2001:4830:134:3::10]:41313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSmg-0005xA-7x
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fpSmb-0006ue-6t
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55778 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fpSma-0006uM-WA
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 02:26:21 -0400
References: <20180809141403.11296-1-olaf@aepfle.de>
	<20180809162403.32c53c50.olaf@aepfle.de>
	<30203041-c944-1a12-d983-9735756dc334@redhat.com>
	<20180809163816.092a7c8c.olaf@aepfle.de>
	<a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
	<20180809165549.5c92d5f4.olaf@aepfle.de>
	<dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
	<840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
	<20180810123221.785ae741.olaf@aepfle.de>
	<a08c692b-5e62-9469-db63-b4b439e9afc3@redhat.com>
	<20180813215054.7aaf368b.olaf@aepfle.de>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <62ffe6d1-1df9-7794-f63a-1c4ece0e4231@redhat.com>
Date: Tue, 14 Aug 2018 08:26:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180813215054.7aaf368b.olaf@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dwb8ndONt4OGWDJf2QArDlcVWrYoOkZXS"
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
Cc: Richard Henderson <rth@twiddle.net>, "open list:Overall" <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dwb8ndONt4OGWDJf2QArDlcVWrYoOkZXS
From: Paolo Bonzini <pbonzini@redhat.com>
To: Olaf Hering <olaf@aepfle.de>
Cc: Richard Henderson <rth@twiddle.net>,
 "open list:Overall" <qemu-devel@nongnu.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>
Message-ID: <62ffe6d1-1df9-7794-f63a-1c4ece0e4231@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1] exec: handle NULL pointer in
 flatview_read_continue
References: <20180809141403.11296-1-olaf@aepfle.de>
 <20180809162403.32c53c50.olaf@aepfle.de>
 <30203041-c944-1a12-d983-9735756dc334@redhat.com>
 <20180809163816.092a7c8c.olaf@aepfle.de>
 <a75c67d5-816d-a603-b7bb-12a28f034fb1@redhat.com>
 <20180809165549.5c92d5f4.olaf@aepfle.de>
 <dba2887e-a59c-d05e-1642-b22623199cc5@redhat.com>
 <840c9f90-3299-e2e5-63b6-5d368d15da5c@redhat.com>
 <20180810123221.785ae741.olaf@aepfle.de>
 <a08c692b-5e62-9469-db63-b4b439e9afc3@redhat.com>
 <20180813215054.7aaf368b.olaf@aepfle.de>
In-Reply-To: <20180813215054.7aaf368b.olaf@aepfle.de>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 13/08/2018 22:07, Olaf Hering wrote:
> Since other callers already deal with NULL, that one has to cope as wel=
l.

They don't.

- address_space_map just returns the value that qemu_ram_ptr_length
returned, and none of its callers deal with NULL (there are dozens)

- likewise for address_space_cache_init

There is also memory_region_get_ram_ptr (which via qemu_map_ram_ptr is
also using xen_map_cache), and none of its callers deal with NULL either.=


Paolo


--Dwb8ndONt4OGWDJf2QArDlcVWrYoOkZXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAltydgcACgkQv/vSX3jH
roNLOwf/U7GNuetA4vSksh+fdGeCRbR6eS09hb4VeVtr8FO3Q8iNGGxx6jttcD8E
Dvg3TCbtcRrC+WgL8IJz8d6WqWMOOc+NIYfcrqccUtpLTRRFNBIU1w9eTkUhYfNc
Zq+3b5qSuRpJI4EkEQypGKE/ssUK1G+m0pe+y2ZrF1EScYR3ghShyFsRef0NfA4j
RXnJDjhPo7LW1/j147Av4UjttS7CNOyEC9MtMoVmHWrASLnuH9XBuGTQnHSMDEY4
HleMAyspLWps+r24JK1c6D3I0NdHKknhCzjHUvCb0o7yTxheH6Dg8DRraN2Vql6X
UE4CzP9LdKHBKdtFx9kyTd6vZFLmpg==
=9G24
-----END PGP SIGNATURE-----

--Dwb8ndONt4OGWDJf2QArDlcVWrYoOkZXS--
