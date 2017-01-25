Received: from eggs.gnu.org ([2001:4830:134:3::10]:44358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOj1-00026k-Ii
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:39:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWOiy-0005N0-EU
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:39:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWOiy-0005Mo-4u
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 09:39:00 -0500
Date: Wed, 25 Jan 2017 14:38:57 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125143857.GN10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-7-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hNG1vEeyG8BCaHbQ"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-7-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 6/8] trace: switch to modular code
 generation for sub-directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>


--hNG1vEeyG8BCaHbQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:49AM +0000, Daniel P. Berrange wrote:
> Introduce rules in the top level Makefile that are able to generate
> trace.[ch] files in every subdirectory which has a trace-events file.
>=20
> The top level directory is handled specially, so instead of creating
> trace.h, it creates trace-root.h. This allows sub-directories to
> include the top level trace-root.h file, without ambiguity wrt to
> the trace.g file in the current sub-dir.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  .gitignore                                |  22 +++--
>  Makefile                                  | 156 ++++++++++++++++++++++++=
++----
>  Makefile.objs                             | 102 ++++++++++---------
>  Makefile.target                           |   7 +-
>  aio-posix.c                               |   2 +-
>  balloon.c                                 |   2 +-
>  block.c                                   |   2 +-
>  blockdev-nbd.c                            |   1 -
>  blockdev.c                                |   2 +-
>  blockjob.c                                |   1 -
>  cpu-exec.c                                |   2 +-
>  dma-helpers.c                             |   2 +-
>  exec.c                                    |   2 +-
>  hw/net/fsl_etsec/etsec.c                  |   1 -
>  include/exec/cpu_ldst_template.h          |   2 +-
>  include/exec/cpu_ldst_useronly_template.h |   2 +-
>  include/hw/xen/xen_common.h               |   2 +-
>  include/trace.h                           |   6 --
>  ioport.c                                  |   2 +-
>  kvm-all.c                                 |   2 +-
>  memory.c                                  |   2 +-
>  monitor.c                                 |   2 +-
>  qom/cpu.c                                 |   2 +-
>  scripts/tracetool.py                      |   8 +-
>  scripts/tracetool/backend/dtrace.py       |   7 +-
>  scripts/tracetool/backend/simple.py       |   1 -
>  scripts/tracetool/backend/ust.py          |   7 +-
>  scripts/tracetool/format/c.py             |   7 +-
>  scripts/tracetool/format/tcg_h.py         |   6 +-
>  scripts/tracetool/format/tcg_helper_c.py  |   6 +-
>  scripts/tracetool/format/ust_events_c.py  |   2 +-
>  scripts/tracetool/format/ust_events_h.py  |   7 +-
>  spice-qemu-char.c                         |   2 +-
>  tests/Makefile.include                    |   2 +-
>  thread-pool.c                             |   2 +-
>  trace/Makefile.objs                       |  94 +-----------------
>  trace/control-target.c                    |   2 +-
>  trace/control.c                           |   2 +-
>  trace/ftrace.c                            |   2 +-
>  trace/simple.c                            |   1 -
>  translate-all.c                           |   2 +-
>  vl.c                                      |   2 +-
>  xen-hvm.c                                 |   2 +-
>  xen-mapcache.c                            |   2 +-
>  44 files changed, 283 insertions(+), 209 deletions(-)
>  delete mode 100644 include/trace.h

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--hNG1vEeyG8BCaHbQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiLiBAAoJEJykq7OBq3PIl+kH/0f2cMSfQwIstDJY63k5FC9k
s1LloytcltVK11Q/9ZLWtkbFXeUt2Cy1qUOFXSWum8Ob7anjpZ25+swaVmAkGEL0
9VdMCxo1cP/flPZUMwmlSADYUcxK268j4XnVzLR5GujwuhZCN2YRn2H9AGl4AiOk
tLbW33fNXvNTCKaZJOC8ZN33IT1iJ+AsS+IcOEJG4DyfS2nui/8EreJX/++9puGS
c7HTpq3XzwqTK4kNN1ezVTxBhBb+ShbZ125IXLVrTMG4oIqeUI5o5qV3qdO2Hq80
s2XJKOKu8V/2+3bp9m6bdtqX0dP3PEkgTlpCKB0ZBFqf51MsujPhoZOpUOgq9jY=
=Ovoy
-----END PGP SIGNATURE-----

--hNG1vEeyG8BCaHbQ--
