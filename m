Received: from eggs.gnu.org ([2001:4830:134:3::10]:58890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNrW-0002Ll-Jm
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWNrV-0005a3-Pj
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32928)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWNrV-0005Zo-JV
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 08:43:45 -0500
Date: Wed, 25 Jan 2017 13:43:42 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170125134342.GK10664@stefanha-x1.localdomain>
References: <20170124110151.937-1-berrange@redhat.com>
	<20170124110151.937-4-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NhBACjNc9vV+/oop"
Content-Disposition: inline
In-Reply-To: <20170124110151.937-4-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 3/8] trace: move hw/xen events to
 correct subdir
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


--NhBACjNc9vV+/oop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2017 at 11:01:46AM +0000, Daniel P. Berrange wrote:
> The trace-events for a given source file should generally
> always live in the same directory as the source file.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  Makefile.objs       |  1 +
>  hw/xen/trace-events | 13 +++++++++++++
>  trace-events        | 10 ----------
>  3 files changed, 14 insertions(+), 10 deletions(-)
>  create mode 100644 hw/xen/trace-events

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NhBACjNc9vV+/oop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYiKuOAAoJEJykq7OBq3PIMD0IAMgpPSDEg0u5FdytNtjnkT1E
JS3bodNQkC5Tr8PFTcr7CXFtk7e3mxIrtE59mtvzhg2UVLqWIMjOy4PRf552JYhO
PUauDzLMp/o3IGvfDoVXl9qv4grzEU4+Cd1/aq5DvNO2mOjSGxvWWU8q9loxL4OF
U+fL0g7JSLOgxufy3WdakKVbyJ+zDRPq+hf/p6dZMviHlkfMMJgMloK86vdTf0pK
jkXhRNAVAcPqg3liKw1ihb58TDlh9awqzDpPdzrU7RmAoFC01sRJ3jtLcgDI0qXv
EpU3VSeWXXOcXNYtzf96pQW7UerAehtwiJtk3CNwt1k5TPb9WSHlKLivorBM7Og=
=Y/gl
-----END PGP SIGNATURE-----

--NhBACjNc9vV+/oop--
