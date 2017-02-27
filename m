Received: from eggs.gnu.org ([2001:4830:134:3::10]:47287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOKZ-0003PN-4O
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ciOKW-0001g6-0u
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:39:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ciOKV-0001fx-OF
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 11:39:19 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E149AC0567B2
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 16:39:19 +0000 (UTC)
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
	<1488145424-14974-6-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aaa9af8f-0025-f2d5-7b01-51e280e0b81a@redhat.com>
Date: Mon, 27 Feb 2017 10:39:17 -0600
MIME-Version: 1.0
In-Reply-To: <1488145424-14974-6-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9uOXBQPEvrtvfdSP5mejchAkKiIbpHSQ4"
Subject: Re: [Qemu-devel] [PATCH v2 05/26] qmp: Clean up how we enforce
 capability negotiation
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
--9uOXBQPEvrtvfdSP5mejchAkKiIbpHSQ4
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <aaa9af8f-0025-f2d5-7b01-51e280e0b81a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 05/26] qmp: Clean up how we enforce
 capability negotiation
References: <1488145424-14974-1-git-send-email-armbru@redhat.com>
 <1488145424-14974-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1488145424-14974-6-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/26/2017 03:43 PM, Markus Armbruster wrote:
> To enforce capability negotiation before normal operation,
> handle_qmp_command() inspects every command before it's handed off to
> qmp_dispatch().  This is a bit of a layering violation, and results in
> duplicated code.
>=20
> Before capability negotiation (!cur_mon->in_command_mode), we fail
> commands other than "qmp_capabilities".  This is what enforces
> capability negotiation.
>=20
> Afterwards, we fail command "qmp_capabilities".
>=20
> Clean this up as follows.
>=20
> The obvious place to fail a command is the command itself, so move the
> "afterwards" check to qmp_qmp_capabilities().
>=20
> We do the "before" check in every other command, but that would be
> bothersome.  Instead, start without all the other commands, by
> registering only qmp_qmp_capabilities().  Register the others in
> qmp_qmp_capabilities().
>=20
> Additionally, replace the generic human-readable error message for
> CommandNotFound by one that reminds the user to run qmp_capabilities.
> Without that, we'd regress commit 2d5a834.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  monitor.c | 70 ++++++++++++++++++++++++++++++++++++-------------------=
--------
>  1 file changed, 40 insertions(+), 30 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--9uOXBQPEvrtvfdSP5mejchAkKiIbpHSQ4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtFY1AAoJEKeha0olJ0Nq8C0H/36N7V+TmJUu3s77jQxxI2M+
D3o42ERSEwYq/igScvW+CgnvslqCUzKZSbR4JUZoqcphVytuxnh+fAx3xpO0Ybe3
AhHNdrCYobqMlbwjpNWqAAXziICYeT7miat0nL0vdMtmEDLiVtJGmOeWKr4f3RCp
nMaRDajI/xHox4JyAv2w+jKG9G30bNLGDwib/LiGmV+LpAQ0cuT1+uBi7ZO3xbj9
wO43I0wJjMkgbKhy3CW/KcRUFdqnTatPi1vPq346iWPlzoYaZwb5SvlZzCyBlKI/
n9AqwBpChiTjws/IFjpGdXbYkH5bJZL7LN5wCVb2GduUPCljy4WRB1nDFaCdT+A=
=gy3O
-----END PGP SIGNATURE-----

--9uOXBQPEvrtvfdSP5mejchAkKiIbpHSQ4--
