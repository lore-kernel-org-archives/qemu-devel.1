Received: from eggs.gnu.org ([2001:4830:134:3::10]:55052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpLK-00075K-JC
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:33:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dCpLH-0002Ln-Es
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:33:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18773)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dCpLH-0002LX-5q
	for qemu-devel@nongnu.org; Mon, 22 May 2017 11:33:55 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2DECE80C0F
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 15:33:54 +0000 (UTC)
References: <20170519180342.19618-1-berrange@redhat.com>
	<20170519180342.19618-5-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <95bf69d6-8352-0808-6ee5-7cbb1b26c2d7@redhat.com>
Date: Mon, 22 May 2017 10:33:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170519180342.19618-5-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3ol3L0QsSx10oGGTk48AuGKdpo2X5fCgx"
Subject: Re: [Qemu-devel] [PATCH v2 4/5] io: preserve ipv4/ipv6 flags when
 resolving InetSocketAddress
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3ol3L0QsSx10oGGTk48AuGKdpo2X5fCgx
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <95bf69d6-8352-0808-6ee5-7cbb1b26c2d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/5] io: preserve ipv4/ipv6 flags when
 resolving InetSocketAddress
References: <20170519180342.19618-1-berrange@redhat.com>
 <20170519180342.19618-5-berrange@redhat.com>
In-Reply-To: <20170519180342.19618-5-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/19/2017 01:03 PM, Daniel P. Berrange wrote:
> The original InetSocketAddress struct may have has_ipv4 and
> has_ipv6 fields set, which will control both the ai_family
> used during DNS resolution, and later use of the V6ONLY
> flag.
>=20
> Currently the standalone DNS resolver code drops the
> has_ipv4 & has_ipv6 flags after resolving, which means
> the later bind() code won't correctly set V6ONLY.
>=20
> This fixes the following scenarios
>=20
>   -vnc :0,ipv4=3Doff
>   -vnc :0,ipv6=3Don
>   -vnc :::0,ipv4=3Doff
>   -vnc :::0,ipv6=3Don
>=20
> which all mistakenly accepted IPv4 clients
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/dns-resolver.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3ol3L0QsSx10oGGTk48AuGKdpo2X5fCgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZIwTdAAoJEKeha0olJ0NqOBMH+wYTkeSnEePQJBq/78LCyFUD
+U3NL3vwhsZ8KX0z+hPmI+ICk/bmEtyCysPQBHXAkd8QyaPJLiZzUZPb3CVeudTM
StcwW5eng3Ebf8V5s5sWHcoqx1V65bz/AXEzHJAXv8xG0zQyRkmJR/KYMrYeYzoW
m67cHg3lIzqtEKibrQjGAE0iBVB8y6fIEQGaKStBI5APRktVf81sof8zLHqNIsTc
qMoPPavxUZGhlr9GnU8KMYuZJXIjyhYEb9HcMIGBXKqgj6qE1V8S9KQ6P9hFoQx9
QqPRjvbad8KzRPbAOAxCSR3BHOezzQ5WpCYLtoyTKwVbkjgjHnhyDuVLvD0HnOI=
=zeSJ
-----END PGP SIGNATURE-----

--3ol3L0QsSx10oGGTk48AuGKdpo2X5fCgx--
