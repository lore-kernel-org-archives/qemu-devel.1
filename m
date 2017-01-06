Received: from eggs.gnu.org ([2001:4830:134:3::10]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcIB-0006oy-Bn
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:43:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcI6-0004Bz-Hc
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:43:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPcI6-0004Bk-8d
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:43:14 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B5864E048
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 21:43:14 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-12-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d12f836d-c3fd-72f2-1ac4-8176f37986ed@redhat.com>
Date: Fri, 6 Jan 2017 15:43:11 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-12-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="n2Uhx4ugCKvpu7nL8rFtFsbPxi4utTndA"
Subject: Re: [Qemu-devel] [PATCH 11/20] char: allocate CharDriverState as a
 single object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--n2Uhx4ugCKvpu7nL8rFtFsbPxi4utTndA
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <d12f836d-c3fd-72f2-1ac4-8176f37986ed@redhat.com>
Subject: Re: [PATCH 11/20] char: allocate CharDriverState as a single object
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-12-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> Use a single allocation for CharDriverState, this avoids extra
> allocations & pointers, and is a step towards more object-oriented
> CharDriver.
>=20
> Gtk console is a bit peculiar, gd_vc_chr_set_echo() used to have a
> temporary VirtualConsole to save the echo bit. Instead now, we consider=

> whether vcd->console is set or not, and restore the echo bit saved in
> VCDriverState when calling gd_vc_vte_init().
>=20
> The casts added are temporary, they are replaced with QOM type-safe
> macros in a later patch in this series.

Thanks; that commit message addition helps.

>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>

R-b stands.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--n2Uhx4ugCKvpu7nL8rFtFsbPxi4utTndA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYcA9vAAoJEKeha0olJ0Nqa1gH/0Zy33+xAbTtKWzpZcCEmPC+
EQdPrlfWOR2F09CfqOOuFQGhHOHR0roIr6UZCJFaFWGnOxwON8DlO000j6LzPuEc
XDgZWGGBk4oysR38DZwbOQA1JkYImz0dA0UOnpoDCKOGfA0wySfgivvbW0EWwV2q
xlmfxmLJne5hJdBSPvLTkC2PKrsz0UVFhV5quE6ffK0Q0LG3unDk3Qsgyl0exLwo
0Id2xoKZFYzVUiUb3ZpbwWJkW/sWflF01QHWtRAfByY5UAcxc4uJ2TaUPvnoRz7y
CmMxh+SeRaQ2Rhh1ayO0aR34xlso3b7W/JbSygnoxu1aAGS52VZ8B6HqZYnulG4=
=lJ48
-----END PGP SIGNATURE-----

--n2Uhx4ugCKvpu7nL8rFtFsbPxi4utTndA--
