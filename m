Received: from eggs.gnu.org ([2001:4830:134:3::10]:39484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7vt-0005GU-Ul
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:54:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cS7vq-0001Zm-So
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:54:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34028)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cS7vq-0001ZO-KC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 14:54:38 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCCC1C0467D3
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 19:54:38 +0000 (UTC)
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
	<20170111172956.11255-40-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4ab99440-8b2a-a263-c0f5-f74daf471c84@redhat.com>
Date: Fri, 13 Jan 2017 13:54:36 -0600
MIME-Version: 1.0
In-Reply-To: <20170111172956.11255-40-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="L4DAkeaXlF70Dx4wrK4B0mkqhH3S6Sqdd"
Subject: Re: [Qemu-devel] [PATCH 39/40] char: move parallel chardev in its
 own file
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
--L4DAkeaXlF70Dx4wrK4B0mkqhH3S6Sqdd
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <4ab99440-8b2a-a263-c0f5-f74daf471c84@redhat.com>
Subject: Re: [PATCH 39/40] char: move parallel chardev in its own file
References: <20170111172956.11255-1-marcandre.lureau@redhat.com>
 <20170111172956.11255-40-marcandre.lureau@redhat.com>
In-Reply-To: <20170111172956.11255-40-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 11:29 AM, Marc-Andr=C3=A9 Lureau wrote:
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-parallel.h |   9 ++
>  chardev/char-parallel.c | 293 ++++++++++++++++++++++++++++++++++++++++=
++++++++
>  chardev/char.c          | 288 +---------------------------------------=
-------
>  chardev/Makefile.objs   |   1 +
>  4 files changed, 304 insertions(+), 287 deletions(-)
>  create mode 100644 chardev/char-parallel.h
>  create mode 100644 chardev/char-parallel.c
>=20

> +++ b/chardev/char.c

> @@ -123,7 +109,6 @@ void qemu_chr_be_generic_open(Chardev *s)
>      qemu_chr_be_event(s, CHR_EVENT_OPENED);
>  }
> =20
> -
>  /* Not reporting errors from writing to logfile, as logs are
>   * defined to be "best effort" only */
>  static void qemu_chr_fe_write_log(Chardev *s,

Spurious hunk?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--L4DAkeaXlF70Dx4wrK4B0mkqhH3S6Sqdd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYeTB8AAoJEKeha0olJ0NqZz0IAKhbwRPv0zWz9OlrsNxDRxGQ
POhHUSKQkjM5ToL0LZfZTfBrZTH3tvLNeSapWqyQNDWXQ/xosKO/BzDyFcbMRIsA
LGHOC1qmVK9+vvs2tyn4bI2TmyPtEVhsrbRjNROb5l3rOoiqduB5udyxg2hK2ovs
vB34Uxt/BmYw3CuEm9Bk00D/NrFDLz/C6zRHw9keYcm12ju9HYNhvwdmH9tDE6HF
3aF74WQTtPqoo4rcbrE/Wb5PvVo3ZOgxzFXej5vmq6Ze9bt/jTknvD+tVz7Sb2pS
ihErWt4xs4xAhoMMFjOI1Q8WdyaI1jM2qQvR5TZVCK7LZgp9f+6eyVfEK8Xovbw=
=1/dF
-----END PGP SIGNATURE-----

--L4DAkeaXlF70Dx4wrK4B0mkqhH3S6Sqdd--
