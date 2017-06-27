Received: from eggs.gnu.org ([2001:4830:134:3::10]:53289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPtm5-0007wO-8X
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dPsIM-0001oB-Ow
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 11:20:52 -0400
References: <20170622121713.27601-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1e102164-43ce-126f-29f3-228c407391a6@redhat.com>
Date: Tue, 27 Jun 2017 10:20:10 -0500
MIME-Version: 1.0
In-Reply-To: <20170622121713.27601-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hfHEQeDObjTjGClIQ8ch6RfNPU79L5O4n"
Subject: Re: [Qemu-devel] [PATCH] docs: add qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, el13635@mail.ntua.gr

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hfHEQeDObjTjGClIQ8ch6RfNPU79L5O4n
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, el13635@mail.ntua.gr
Message-ID: <1e102164-43ce-126f-29f3-228c407391a6@redhat.com>
Subject: Re: [PATCH] docs: add qemu-block-drivers(7) man page
References: <20170622121713.27601-1-stefanha@redhat.com>
In-Reply-To: <20170622121713.27601-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/22/2017 07:17 AM, Stefan Hajnoczi wrote:
> Block driver documentation is available in qemu-doc.html.  It would be
> convenient to have documentation for formats, protocols, and filter
> drivers in a man page.
>=20
> Extract the relevant part of qemu-doc.html into a new file called
> docs/qemu-block-drivers.texi.  This file can also be built as a
> stand-alone document (man, html, etc).
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---

> +
> +@table @option
> +@item raw
> +
> +Raw disk image format. This format has the advantage of
> +being simple and easily exportable to all other emulators. If your
> +file system supports @emph{holes} (for example in ext2 or ext3 on
> +Linux or NTFS on Windows), then only the written sectors will reserve
> +space. Use @code{qemu-img info} to know the real size used by the
> +image or @code{ls -ls} on Unix/Linux.

Worth mentioning the security risk of using raw images under probing
without explicitly calling them out as raw, because then a guest can
impersonate other type of images?

> +
> +Supported options:
> +@table @code
> +@item preallocation
> +Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{f=
ull}).
> +@code{falloc} mode preallocates space for image by calling posix_fallo=
cate().
> +@code{full} mode preallocates space for image by writing zeros to unde=
rlying
> +storage.
> +@end table
> +
> +@item qcow2
> +QEMU image format, the most versatile format. Use it to have smaller
> +images (useful if your filesystem does not supports holes, for example=


s/supports/support/

> +on Windows),

Odd, since you just stated above for raw that Windows DOES support holes
(on NTFS).  Better might be "on FAT filesystems".

> zlib based compression and support of multiple VM
> +snapshots.
> +
> +Supported options:
> +@table @code
> +@item compat
> +Determines the qcow2 version to use. @code{compat=3D0.10} uses the
> +traditional image format that can be read by any QEMU since 0.10.
> +@code{compat=3D1.1} enables image format extensions that only QEMU 1.1=
 and
> +newer understand (this is the default). Amongst others, this includes

I don't have any strong opinion on US vs. UK spelling, but do like to
point out that this is user-facing, if we are trying to consistently
prefer one flavo[u]r of among[st] in our docs.

Then again, much of your patch is just code motion, rather than new
documentation.  So my comments are probably worth separate patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hfHEQeDObjTjGClIQ8ch6RfNPU79L5O4n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZUneqAAoJEKeha0olJ0NqbPIH/R9G2jmQn4xXMib/33FPxspC
6KxSluzJVxyDsxPT9A6qLPcp71xM5yVahoAdM4UUX1h/q/q3mWccGUa7aprbEQNd
KIUyXiIEIA6B8ZiLE4HudLPD9Y0600WZV40JM86jhmCMHVLkO10kNH7VCQsc0ZnV
efTfw/GwScojxGwBGwxlZdTpUbtSz4xuZWBUfl1M+65JZMc/9h9fuIgn2zyGy/3X
j4Q8EcPwV6eJNaI4NrHObZ/otQLx+er40H6cYzE9Vl/fkQLWryy0p5LKaNSCNUkQ
uHdk86xNO0cTaEmYhgBvNzgCSfmO614aI4mf3dDVT+JWRMt+WLFbDu9VJ5yBKjg=
=1d5b
-----END PGP SIGNATURE-----

--hfHEQeDObjTjGClIQ8ch6RfNPU79L5O4n--
