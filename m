Received: from eggs.gnu.org ([2001:4830:134:3::10]:51638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwW5O-0003xJ-Ki
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:18:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dwW5L-00077s-EV
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 12:18:22 -0400
References: <40DEFE92-410B-4FED-B0A5-56C186627134@loffgren.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b99306b2-2e53-7b0f-933c-c549c54b07b7@redhat.com>
Date: Mon, 25 Sep 2017 11:18:14 -0500
MIME-Version: 1.0
In-Reply-To: <40DEFE92-410B-4FED-B0A5-56C186627134@loffgren.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wvWmL0C68swImAXnxxFUpqCnxUH6UENSk"
Subject: Re: [Qemu-devel] [PATCH 1/2] fprintf-fn.h uses GCC_FMT,
 but doesn't include the definition of it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Loffgren <daniel@loffgren.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wvWmL0C68swImAXnxxFUpqCnxUH6UENSk
From: Eric Blake <eblake@redhat.com>
To: Daniel Loffgren <daniel@loffgren.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
Message-ID: <b99306b2-2e53-7b0f-933c-c549c54b07b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] fprintf-fn.h uses GCC_FMT, but doesn't
 include the definition of it
References: <40DEFE92-410B-4FED-B0A5-56C186627134@loffgren.org>
In-Reply-To: <40DEFE92-410B-4FED-B0A5-56C186627134@loffgren.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/24/2017 08:02 PM, Daniel Loffgren wrote:
>=20
> Signed-off-by: Daniel Loffgren <daniel@loffgren.org>

Hmm - you've identified a file with no listed maintainer.  But
qemu-trivial does seem like the right place to include it.

Generally, we like patches to call out the topic that it is touching;
also, the subject line should focus on the what, while the body focuses
on the why.  So a better commit message might be:

maint: Make fprintf-fn.h self-contained

Include the necessary headers so that GCC_FMT_ATTR is defined regardless
of what client files use fprintf-fn.h.


However, after saying that, I think your patch is not needed.  Per
HACKING, _all_ .c files must include osdep.h first, and osdep.h already
includes compiler.h, therefore, any .c file that uses fprintf-fn.h
already has GCC_FMT_ATTR in scope by the time it gets to the
fprintf_function typedef.  If you ran into a situation where you had a
compile failure, please post more details of what failed for you, in
case the problem was you forgetting to use osdep.h.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wvWmL0C68swImAXnxxFUpqCnxUH6UENSk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnJLEYACgkQp6FrSiUn
Q2q2+wf/S6KNmkFI8dcq9rRmQEOiZ6lR0/7korWHe57Rj4KjM+d8UruSNS+lQ16E
pD0rik9zRZjlyInGUi8hHCH+nMBn/PgDJl+GZuudLG6N4hWXrm6NkAjwvlsj1C+S
L0sD671k8CTZPdnXLT7MA3uTvSa+Dro00EsjcEhKTP+fJu9DvDO7PnXYKXWMDQC8
D9jZfq5fGHVV6ex1wvaNmvhzHtvHkiiReGh/I3SXYywUCkURvDL44YjFVTEeHEfM
H5rJq4CB9M2eLg+Udt0Bxhw37VxrRvKeEHSi1w735Z1wHmAWfKrrwxCC1TMwbOY4
Mpv3FZHMD37/0C78mzExG4PdZGOswQ==
=Q3dV
-----END PGP SIGNATURE-----

--wvWmL0C68swImAXnxxFUpqCnxUH6UENSk--
