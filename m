Received: from eggs.gnu.org ([2001:4830:134:3::10]:53778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdlq-0006qh-IL
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dAdlp-00032V-Rc
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:48:18 -0400
Date: Tue, 16 May 2017 15:47:52 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170516144752.GJ8498@stefanha-x1.localdomain>
References: <20170511144208.24075-1-pbonzini@redhat.com>
	<20170511144208.24075-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
In-Reply-To: <20170511144208.24075-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/18] util: add stats64 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 04:42:00PM +0200, Paolo Bonzini wrote:
> This module provides fast paths for 64-bit atomic operations on machines
> that only have 32-bit atomic access.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>         v1->v2: use CONFIG_ATOMIC64 [Paolo]
>                 fix compilation on 32-bit machines [patchew]
>                 simplify "fast" version of stat64_min/stat64_max [Paolo]
>                 fix typo [Roman]
>                 use cpu_relax [Fam]
>=20
>  include/qemu/stats64.h | 193 +++++++++++++++++++++++++++++++++++++++++++=
++++++
>  util/Makefile.objs     |   1 +
>  util/stats64.c         | 136 ++++++++++++++++++++++++++++++++++
>  3 files changed, 330 insertions(+)
>  create mode 100644 include/qemu/stats64.h
>  create mode 100644 util/stats64.c

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGxEYAAoJEJykq7OBq3PIhwwH/1rqvmIYG+FLQdj+wEm0RtXq
DeDsTeDdWK8Cl8ZxZekHORB/UgvApQH6ZfFA337B81LbYjW2uxVYTwy4/woRafF3
5Kf4pWMp0W3pN/B0YKMvIhhUoyNIqqgYJQP70jLC3FG9v2E9OhQgxilNVsfySxKP
qDjOLNZgh2rDs8fZNM8Pp2kDlJ2c5OuCk5PHT3PbGMBOTW1bPiiNOuoMBcUu8DuH
JVQLrd/RxKnxFOyNjx/odGL13FiBqB4SDmwT+AdvBGAOIi9rOyvgW9xhyvYhy4yo
6xXcGAiN7UI/Ssartwn5D9LNkVoDpk84ojdFNaSBu4e9xUAxWYjaAQ9HmxLKgVY=
=Wxe2
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
