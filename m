Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQarb-0003FX-Lz
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cQarX-0008P0-9S
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:23:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cQarX-0008Of-3F
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 09:23:51 -0500
References: <148396120962.205.623546213408864755@790289a7ca88>
	<20170109130749.9795-1-rka@sysgo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39273aca-010e-b23f-9ee2-c7adf0582ec6@redhat.com>
Date: Mon, 9 Jan 2017 08:23:47 -0600
MIME-Version: 1.0
In-Reply-To: <20170109130749.9795-1-rka@sysgo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="uxW4ai4A1rHqd51523cUnKa0DGhTO60dO"
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Prevent inifnite loop in
 decrementer auto-reload.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <rka@sysgo.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uxW4ai4A1rHqd51523cUnKa0DGhTO60dO
From: Eric Blake <eblake@redhat.com>
To: Roman Kapl <rka@sysgo.com>, qemu-devel@nongnu.org
Message-ID: <39273aca-010e-b23f-9ee2-c7adf0582ec6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] ppc: Prevent inifnite loop in decrementer
 auto-reload.
References: <148396120962.205.623546213408864755@790289a7ca88>
 <20170109130749.9795-1-rka@sysgo.com>
In-Reply-To: <20170109130749.9795-1-rka@sysgo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/09/2017 07:07 AM, Roman Kapl wrote:

s/inifnite/infinite/ in the subject

> If the DECAR register is set to 0, QEMU tries to reload the decrementer=
 with
> zero in an inifinite loop. According to PPC documentation, the decremen=
ter is

s/inifinite/infinite/

> triggered on 1->0 transition, so avoid reloading the decrementer if if =
is
> already zero.
>=20
> The problem does not manifest under Linux, but it is valid to set DECAR=
 to zero
> (and may make sense as part of decrementer initialization when interrup=
ts are
> disabled).

When sending a v2, it's best to do it as a new top-level thread rather
than in-reply-to v1, as some patch tools overlook deeply nested replies.
 More hints on sending patches:
http://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--uxW4ai4A1rHqd51523cUnKa0DGhTO60dO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYc5z0AAoJEKeha0olJ0NqOB0H/1pV8NAwk2F5lzMjRsMkFZK0
0HjlFo5oF1VFvR5531juP6cSm6DMG1RIw3DNqzt9iMOdc4BhsOqMFAKMmM1MUzx4
VjvjskJKh002mnTuymVfaUNEHfRhwJAjfVKolh53bdIzf0a24HalaRiYww0DuY4O
TM6RpZhI0OoxgGoY9Hd90oruwKW4MBXoENqs1fh4C/QxZLFRNBZ8LG+0vzWQjYD9
5l+RpeuqZgY7XBBnZNCgUVIFTL+LOsDk3y7vXBvWJX61sVdypgkembvW5pEoJC9t
iw5dv1yOxUhNPcTtUe8b+CoJQUzS/H2VwSxxwp0kahre7oXZJJxHOS+J51zifEc=
=3w2/
-----END PGP SIGNATURE-----

--uxW4ai4A1rHqd51523cUnKa0DGhTO60dO--
