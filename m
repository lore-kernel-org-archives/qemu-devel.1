Received: from eggs.gnu.org ([2001:4830:134:3::10]:44495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGQuL-0001fn-4m
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:44:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cGQuH-0006qX-0H
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:44:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cGQuG-0006qK-Qe
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:44:40 -0500
Date: Mon, 12 Dec 2016 13:44:38 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20161212134438.GC4074@stefanha-x1.localdomain>
References: <20161212111857.23399-1-pbonzini@redhat.com>
	<20161212111857.23399-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pAwQNkOnpTn9IO2O"
Content-Disposition: inline
In-Reply-To: <20161212111857.23399-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/11] exec: introduce memory_ldst.inc.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, mst@redhat.com, borntraeger@de.ibm.com


--pAwQNkOnpTn9IO2O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 12, 2016 at 12:18:48PM +0100, Paolo Bonzini wrote:
> Templatize the address_space_* and *_phys functions, so that we can add
> similar functions in the next patch that work with a lightweight version
> of address_space_map/unmap.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  exec.c                    | 681 +---------------------------------------=
----
>  include/exec/cpu-common.h |  15 -
>  include/exec/memory.h     |  15 +
>  memory_ldst.inc.c         | 709 ++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 734 insertions(+), 686 deletions(-)
>  create mode 100644 memory_ldst.inc.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--pAwQNkOnpTn9IO2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYTqnFAAoJEJykq7OBq3PIJ18IAKtC7hoT2nQMqCpgZWxGI09A
V+0/dFV+bj3RAENmdurMXEXXqkz7TtXo6D6baMlBHuZcVvneJ9wVRKzwbe/bmBRA
RhhdJbUkPr6PjhEQo7fYzYHpsgoNxynDywUxjzGcOayNK5AlMNJp/iN7v7gWkU5n
wY6glilz4aLmU6nhIve7D0/jX061/OLJ7HMsfUaZF/6UP5Tl2BfoJ3TYUMwaM7WY
BTq0qS2CJvC76HDesIwUcrbqDY/17VHLJK7JCUPM39de+dGZmm+GSDv7tkXiMmSi
tEpuXW83rPphGpfXZOcKnz7ktvg+mNn+xvhzCvB5u07ctYO9ssGVeFgSFFOwMAg=
=UIVs
-----END PGP SIGNATURE-----

--pAwQNkOnpTn9IO2O--
