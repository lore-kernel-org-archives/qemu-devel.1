Received: from eggs.gnu.org ([2001:4830:134:3::10]:39113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eF1ZD-0003tQ-Jm
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eF1ZA-00013k-Fz
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:14612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eF1ZA-00013C-6a
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 12:33:36 -0500
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
Date: Wed, 15 Nov 2017 11:33:29 -0600
MIME-Version: 1.0
In-Reply-To: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="25ajsLQGF5NePQsue6tiMDX05wpQ8l0SM"
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--25ajsLQGF5NePQsue6tiMDX05wpQ8l0SM
From: Eric Blake <eblake@redhat.com>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>,
 qemu-devel@nongnu.org, libguestfs <libguestfs@redhat.com>
Message-ID: <c2ecae32-f999-9f1e-46a6-37cdab2a62e3@redhat.com>
Subject: Re: [Qemu-devel] [qemu-img] support for XVA
References: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
In-Reply-To: <CAJH6TXiMxUoU2sFEHAoZ8jhDMtg_saEnTHM9f0vJ6Nhqj7099w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[adding libguestfs]

On 11/15/2017 09:52 AM, Gandalf Corvotempesta wrote:
> I'm thinking if support for XVA files could be added to qemu-img
> The file-format is well known (it's just a tar archive) and there are s=
cripts
> that are able to convert an XVA file to a RAW image. (ie:
> https://gist.github.com/miebach/0433947bcf053de23159)
>=20
> Running these script on their own is very time consuming, as you have t=
o
> extract the XVA, convert any disk image from "single chunks" to a raw i=
mage
> and then use qemu-img to convert from raw to qcow.
>=20
> Maybe a native support will be able to skip some steps. (like the
> conversion from
> "single chunks" to raw and raw to qcow2)

Another possibility might be writing an nbdkit plugin that can directly
read XVA, then you can connect qemu to the NBD server provided by
nbdkit, without having to teach qemu proper how to read the file.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--25ajsLQGF5NePQsue6tiMDX05wpQ8l0SM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloMemkACgkQp6FrSiUn
Q2pmsQf+PL3/PZzdwRzLW702Wkku6Fqq9oV1Bpg57tBPWhYeN/PQzAdEExSCK/ST
Zjzlv1ST4yqQYWSXFsLQ1mr6j9a5Iq9UQllWtE4T9DaKXVmfRa1tzrkb2cjwpUCr
9LLF04BUuhxBEuKUJHaQIrbYqUS+qa70TaWMy3fr6LwHOo3dVZumX6RIMAIHwzFR
3IzeJtuEeYvr5m5/evOypuyVOx3+A9PbDLU/Y+8eYWWHxPrAsZYDtgfRbRr5Rx+T
Wa7LnBqu0kDA9elkPn3C2TKkZLS6aSJGQS7loWzVUeGMcPkTfTR/UIinWaxlJcrU
AxZcK7Rl/4ebRQIWyzv6D5DNaSJ4vw==
=BlvX
-----END PGP SIGNATURE-----

--25ajsLQGF5NePQsue6tiMDX05wpQ8l0SM--
