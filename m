Received: from eggs.gnu.org ([2001:4830:134:3::10]:41484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAMtY-00055Q-V6
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dAMtU-0002Gu-Te
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:47:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dAMtU-0002Gb-Mg
	for qemu-devel@nongnu.org; Mon, 15 May 2017 16:47:04 -0400
References: <149488067280.492.4602018300691259542@c05f1edc8ed1>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9f93308-fcd1-620a-e0fd-e1e1b7dfd8d0@redhat.com>
Date: Mon, 15 May 2017 15:46:59 -0500
MIME-Version: 1.0
In-Reply-To: <149488067280.492.4602018300691259542@c05f1edc8ed1>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tenWauKR166JNk5uTUUTCfMBQEaCrgvB8"
Subject: Re: [Qemu-devel] [PATCH v8 0/5] event: Add source information to
 SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, armbru@redhat.com, alistair.francis@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tenWauKR166JNk5uTUUTCfMBQEaCrgvB8
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, armbru@redhat.com, alistair.francis@xilinx.com
Message-ID: <f9f93308-fcd1-620a-e0fd-e1e1b7dfd8d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 0/5] event: Add source information to
 SHUTDOWN
References: <149488067280.492.4602018300691259542@c05f1edc8ed1>
In-Reply-To: <149488067280.492.4602018300691259542@c05f1edc8ed1>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/15/2017 03:37 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series seems to have some coding style problems. See output below =
for
> more information:
>=20

> Checking PATCH 5/5: shutdown: Expose bool cause in SHUTDOWN and RESET e=
vents...
> ERROR: open brace '{' following function declarations go on the next li=
ne
> #61: FILE: include/sysemu/sysemu.h:52:
> +static inline bool shutdown_caused_by_guest(ShutdownCause cause) {
>=20

Oh fine (I have a hook to run checkpatch locally on every commit; wonder
why it didn't gripe at me). I also missed a FIXME that should have been
TODO in 2/5.   v9 coming up.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--tenWauKR166JNk5uTUUTCfMBQEaCrgvB8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZGhPDAAoJEKeha0olJ0NqAQYH/iM3lyzAlQ7DjwVLDaLgsj3q
DcqsDgdob10iOruEb/2ahBfxaSpQI2zkLRA8E2R8d6S+6XBJckE008GPe0UZ80Ec
ySIj6nj4GA57vJxMAyDVoNzhG4i7YlulRKsZfELKc4CvOKoGMw5H2qhEFKTZx6Kh
zcNZIFw4aU2zahyqyWJgcBpjma19oZ584vP4wyikq3kei4G8gHBfo0jXSQTdBpZt
gxR9AjjyH6pls+Va16A1mGVCcTbZIb6TeTvyAAEKRVO9SO1X1jndl+/+rpbi/IUp
fzcW3E5V7Vlmrixj9FQ/jKDIWkM5PjI+MqgFdJs7+VQ/2ZN4VtDJk1k30Gl7uGw=
=VctN
-----END PGP SIGNATURE-----

--tenWauKR166JNk5uTUUTCfMBQEaCrgvB8--
