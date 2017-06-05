Received: from eggs.gnu.org ([2001:4830:134:3::10]:39651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHr8t-0005fU-N9
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:29:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dHr8q-0007SW-OV
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:29:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dHr8q-0007Rg-Gy
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 08:29:52 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C46DC049D5B
	for <qemu-devel@nongnu.org>; Mon,  5 Jun 2017 12:29:51 +0000 (UTC)
References: <20170605104216.22429-1-stefanha@redhat.com>
	<20170605104216.22429-2-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d009c38e-4fd2-352b-a8d5-dea56b7db82d@redhat.com>
Date: Mon, 5 Jun 2017 07:29:48 -0500
MIME-Version: 1.0
In-Reply-To: <20170605104216.22429-2-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3D9QjPQxSQkWmXPNANeJimGi3RXhAQ2ub"
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor: add handle_hmp_command trace
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3D9QjPQxSQkWmXPNANeJimGi3RXhAQ2ub
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <d009c38e-4fd2-352b-a8d5-dea56b7db82d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] monitor: add handle_hmp_command trace
 event
References: <20170605104216.22429-1-stefanha@redhat.com>
 <20170605104216.22429-2-stefanha@redhat.com>
In-Reply-To: <20170605104216.22429-2-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/05/2017 05:42 AM, Stefan Hajnoczi wrote:
> It is often useful to correlate QEMU-internal events with monitor
> commands that caused them.  Trace the full HMP command being executed.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  monitor.c    | 2 ++
>  trace-events | 1 +
>  2 files changed, 3 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3D9QjPQxSQkWmXPNANeJimGi3RXhAQ2ub
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZNU68AAoJEKeha0olJ0Nq4N0IAJRCbcOICWjtdoLxibrFFy5E
4Uc9ruqddBu8KW7FV2GZovtrr2VeUMB1dGq7xE7fyg475imCuJSnPGVirw7qVfv/
ny/FVk9zMyQMZwSv890vr4l03VdI9U2p0z4C+RZ0fg+FVf1LG9+AeoOj6Q5S6r+c
7jrlE8DlV92tSQQAYRQPiOpi6p/UFSgpvkBP0F+tyxq0AlclIZxXGlAHMln2AB+q
wmHP4SklV/dZL4bfWXC0vKSTI0wBBEnE3DhQfbJXHzsOdwuogbf9NtUuf/4JdToy
YJQ1Q5aPc+2TRnI3dfin9iAxMA7llD0+EMokVum1L6+rCkKzYybxzf+GbYDI9ik=
=VYe2
-----END PGP SIGNATURE-----

--3D9QjPQxSQkWmXPNANeJimGi3RXhAQ2ub--
