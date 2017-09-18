Received: from eggs.gnu.org ([2001:4830:134:3::10]:41593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwgC-00075b-0a
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dtwg2-0004yu-KQ
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:05:43 -0400
References: <20170916185123.29255-1-mreitz@redhat.com>
	<20170916185123.29255-2-mreitz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ebce1124-8cbc-8fe4-76f0-52cd76bafc15@redhat.com>
Date: Mon, 18 Sep 2017 09:05:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170916185123.29255-2-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xaOngAFTVxB2U16o3IjLJ79QP7ekn04Gq"
Subject: Re: [Qemu-devel] [PATCH v5 1/6] qapi/qnull: Add own header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xaOngAFTVxB2U16o3IjLJ79QP7ekn04Gq
From: Eric Blake <eblake@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <ebce1124-8cbc-8fe4-76f0-52cd76bafc15@redhat.com>
Subject: Re: [PATCH v5 1/6] qapi/qnull: Add own header
References: <20170916185123.29255-1-mreitz@redhat.com>
 <20170916185123.29255-2-mreitz@redhat.com>
In-Reply-To: <20170916185123.29255-2-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/16/2017 01:51 PM, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  include/qapi/qmp/qdict.h    |  1 +
>  include/qapi/qmp/qnull.h    | 30 ++++++++++++++++++++++++++++++
>  include/qapi/qmp/qobject.h  | 12 ------------
>  include/qapi/qmp/types.h    |  1 +
>  qapi/qapi-clone-visitor.c   |  1 +
>  qapi/string-input-visitor.c |  1 +
>  qobject/qnull.c             |  2 +-
>  tests/check-qnull.c         |  2 +-
>  8 files changed, 36 insertions(+), 14 deletions(-)
>  create mode 100644 include/qapi/qmp/qnull.h
>=20

> +++ b/include/qapi/qmp/qnull.h
> @@ -0,0 +1,30 @@
> +/*
> + * QNull
> + *
> + * Copyright (C) 2015 Red Hat, Inc.

Worth also claiming 2017?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--xaOngAFTVxB2U16o3IjLJ79QP7ekn04Gq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlm/0p4ACgkQp6FrSiUn
Q2rI8wf+PvkmqP24b4pI7VSHM+/gAZ0A86vQPh9iKGtsjJV3oPIwfWlzUqdJ5ooa
tE04YRXKv/t4LcDAU2VpFps+ChE4PpSDeOdxYiCrn6PpvQDL0r//rDWhnzMhr9cg
D8/JqaYl1txkjsPOw85EEYcUWOVwsxw8VP0WB+0Jff9tAre25454vG8rBZvytWtB
0c45URQYFsYy82Ve3sR4BLZEeH98Kd2O6qWyYENKMtOQsHhKP/n81jp4omYIocn2
HUpk3+Ju+GvZxFcT4kFKC4EwQSjYQZJzhgn0oiwh2ZuEpI3klYxQHzRzJ6OtmuoA
uM0tVFNrvRKvLeANKo9ppiWf2hLSXQ==
=ax6N
-----END PGP SIGNATURE-----

--xaOngAFTVxB2U16o3IjLJ79QP7ekn04Gq--
