Received: from eggs.gnu.org ([2001:4830:134:3::10]:58408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQANy-0005zC-Jv
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQANx-0008N3-Q6
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:22 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:54907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQANx-0008MQ-IB
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 07:44:21 -0400
Received: by mail-wm0-x243.google.com with SMTP id o13-v6so4293875wmf.4
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 04:44:21 -0700 (PDT)
Date: Tue, 5 Jun 2018 12:44:18 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180605114418.GF11888@stefanha-x1.localdomain>
References: <1527840629-18648-1-git-send-email-junyan.he@gmx.com>
	<1527840629-18648-4-git-send-email-junyan.he@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zi0sgQQBxRFxMTsj"
Content-Disposition: inline
In-Reply-To: <1527840629-18648-4-git-send-email-junyan.he@gmx.com>
Subject: Re: [Qemu-devel] [PATCH V6 3/7] hostmem-file: add the 'pmem' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: junyan.he@gmx.com
Cc: qemu-devel@nongnu.org, Haozhong Zhang <haozhong.zhang@intel.com>, xiaoguangrong.eric@gmail.com, crosthwaite.peter@gmail.com, mst@redhat.com, dgilbert@redhat.com, ehabkost@redhat.com, quintela@redhat.com, Junyan He <junyan.he@intel.com>, stefanha@redhat.com, pbonzini@redhat.com, imammedo@redhat.com, rth@twiddle.net


--Zi0sgQQBxRFxMTsj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2018 at 04:10:25PM +0800, junyan.he@gmx.com wrote:
> From: Junyan He <junyan.he@intel.com>
>=20
> When QEMU emulates vNVDIMM labels and migrates vNVDIMM devices, it
> needs to know whether the backend storage is a real persistent memory,
> in order to decide whether special operations should be performed to
> ensure the data persistence.
>=20
> This boolean option 'pmem' allows users to specify whether the backend
> storage of memory-backend-file is a real persistent memory. If
> 'pmem=3Don', QEMU will set the flag RAM_PMEM in the RAM block of the
> corresponding memory region.
>=20
> Signed-off-by: Junyan He <junyan.he@intel.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> ---
>  backends/hostmem-file.c | 27 ++++++++++++++++++++++++++-
>  docs/nvdimm.txt         | 14 ++++++++++++++
>  exec.c                  |  9 +++++++++
>  include/exec/memory.h   |  6 ++++++
>  include/exec/ram_addr.h |  3 +++
>  qemu-options.hx         |  7 +++++++
>  6 files changed, 65 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Zi0sgQQBxRFxMTsj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbFneSAAoJEJykq7OBq3PIy+gH/2CKAT/0Vx8LM/s+2qs0zAKu
farSKy1ADTTe12ODSt3hGGFVyQ6gZMnixKZPYZPulIKhPKusvSWL4BsNwOs8X+20
dvbVIYKYCP9rXi3dsKFtiob1rjfwMBA7Lsv3aK4nuRhfYrynyl+TXWJqAo0YBJqo
8W9pOJa4U0DPI1qnIbgE9bZtAFkjJW3AyyTpZoACGVKQiHuuZL2qthO6IOR7CS+c
okZ94Cc+vf65ZATaZI7uEARBf7HUfGebuhbl0YF4y1ueTfGtMUITB7LTLRX0Tv45
+qGrusGeunWGrTJo1nLzVOLtGPhUCdZmTU1h7K/M8gr/O5Wuo5Q0mYnolCLuoHk=
=7fpo
-----END PGP SIGNATURE-----

--Zi0sgQQBxRFxMTsj--
