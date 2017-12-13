Received: from eggs.gnu.org ([2001:4830:134:3::10]:45799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4zg-00071z-6A
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:14:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eP4zb-00045L-Jn
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:14:32 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:42009)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eP4zb-000455-B8
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 06:14:27 -0500
Received: by mail-wm0-x243.google.com with SMTP id b199so4281593wme.1
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 03:14:27 -0800 (PST)
Date: Wed, 13 Dec 2017 11:14:24 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20171213111424.GH16782@stefanha-x1.localdomain>
References: <20171211072806.2812-1-haozhong.zhang@intel.com>
	<20171211072806.2812-2-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Content-Disposition: inline
In-Reply-To: <20171211072806.2812-2-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/3] hostmem-file: add "align" option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, ehabkost@redhat.com, Xiao Guangrong <guangrong.xiao@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 03:28:04PM +0800, Haozhong Zhang wrote:
> When mmap(2) the backend files, QEMU uses the host page size
> (getpagesize(2)) by default as the alignment of mapping address.
> However, some backends may require alignments different than the page
> size. For example, mmap a device DAX (e.g., /dev/dax0.0) on Linux
> kernel 4.13 to an address, which is 4K-aligned but not 2M-aligned,
> fails with a kernel message like
>=20
> [617494.969768] dax dax0.0: qemu-system-x86: dax_mmap: fail, unaligned vm=
a (0x7fa37c579000 - 0x7fa43c579000, 0x1fffff)
>=20
> Because there is no common approach to get such alignment requirement,
> we add the 'align' option to 'memory-backend-file', so that users or
> management utils, which have enough knowledge about the backend, can
> specify a proper alignment via this option.
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  backends/hostmem-file.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  docs/nvdimm.txt         | 16 ++++++++++++++++
>  exec.c                  |  8 +++++++-
>  include/exec/memory.h   |  3 +++
>  memory.c                |  2 ++
>  numa.c                  |  2 +-
>  qemu-options.hx         |  9 ++++++++-
>  7 files changed, 77 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaMQuQAAoJEJykq7OBq3PIAD8H/AreGjPgsUijiMN52Jl1eNJ1
Qw7V5qPkfFEGenRq2+AELs9sozS4tz6sNYOP4bZnuqG3+4Ml5hIH7YyeIEKBQ3/8
KVjZR+W1B+BKquhzc+B3eGJ9aJ4yqvPIou7/FJDQCYGqqZ2hMwp/c6q/SvY5AHoi
WKTMLlwrV+GYifLI7ypirD7hkksW8EoQ7C3rzdeGquYMp+AGS/zUDBISftHKyP9C
2mgzwBYTuYh1ZshehxEH/NrYU9KSGeLgbePhcEhti8u/d4OAuvaKcIgtDJgZ2JiI
jSQAcRUL7sx1NCjJbXZ9REYWdzVVCkoQhA8voZH1rCNuBwBNulccVYlX9yULHKs=
=2uKU
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
