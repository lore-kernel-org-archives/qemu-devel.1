Received: from eggs.gnu.org ([2001:4830:134:3::10]:51733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiKY-000078-FJ
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:34:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fOiKV-0006NX-BC
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:34:50 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:40130)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fOiKV-0006Mp-0t
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 07:34:47 -0400
Received: by mail-wm0-x243.google.com with SMTP id x2-v6so2058228wmh.5
	for <qemu-devel@nongnu.org>; Fri, 01 Jun 2018 04:34:46 -0700 (PDT)
Date: Fri, 1 Jun 2018 12:34:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180601113444.GG8687@stefanha-x1.localdomain>
References: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="z9ECzHErBrwFF8sy"
Content-Disposition: inline
In-Reply-To: <40602400-cae4-e175-e7ce-10ac70ba52f5@riseup.net>
Subject: Re: [Qemu-devel] Virtio-net drivers immune to Nethammer?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: procmem <procmem@riseup.net>
Cc: qemu-devel@nongnu.org, whonix-devel@whonix.org, "Michael S. Tsirkin" <mst@redhat.com>, jasowang@redhat.com


--z9ECzHErBrwFF8sy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 21, 2018 at 11:24:43PM +0000, procmem wrote:
> Hi I'm a privacy distro maintainer investigating the implications of the
> newly published nethammer attack [0] on KVM guests particularly the
> virtio-net drivers. The summary of the paper is that rowhammer can be
> remotely triggered by feeding susceptible* network driver crafted
> traffic. This attack can do all kinds of nasty things such as modifying
> SSL certs on the victim system.
>=20
> * Susceptible drivers are those relying on Intel CAT, uncached memory or
> the clflush instruction.
>=20
> My question is, do virtio-net drivers do any of these things?

I have CCed Michael Tsirkin and Jason Wang, the virtio maintainers.

> ***
>=20
> [0] https://arxiv.org/abs/1805.04956
>=20
>=20
>=20

--z9ECzHErBrwFF8sy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbES9UAAoJEJykq7OBq3PIf6gH/2T+xieSUDx8GEqiQSY5fGKx
BbJi0frKvt1i47aV+MUOj9cTCeKbSNn66LbwBDormdstP4rA+ss+0VZdIJaNcPCL
sJUXTRlq/CgmnXsPmQki0ew9c533G6CQ99krkNxTdKGIvtVPRWV6pEIs3fzN/ug9
mLuFHh4zRzxvh+OgyKyZaaJgkE0DJ1QYDLDxRNHgXnsVdc7+Z6ACLuddjKZePUCl
4W2grS7ipsz+zsf/335e9A7hkW78gb01xDzeDLISpE59CZf1L9x+G8NsXeaacpj/
IY3q3yPamzKqlMPnob7L5tROeHnodrO0nqvTEc4oDNn1KZYXpsbM1jS2J+9wT04=
=Y7fH
-----END PGP SIGNATURE-----

--z9ECzHErBrwFF8sy--
