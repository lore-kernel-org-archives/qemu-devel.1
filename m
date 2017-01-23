Received: from eggs.gnu.org ([2001:4830:134:3::10]:47161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVby6-0006Wc-Gn
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:35:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cVby1-0007rM-HE
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:35:22 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:34876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cVby1-0007rE-BM
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 05:35:17 -0500
Received: by mail-wm0-x244.google.com with SMTP id d140so25413300wmd.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 02:35:17 -0800 (PST)
Date: Mon, 23 Jan 2017 10:35:13 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170123103513.GE29186@stefanha-x1.localdomain>
References: <20170113115651.17607-1-haozhong.zhang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5xSkJheCpeK0RUEJ"
Content-Disposition: inline
In-Reply-To: <20170113115651.17607-1-haozhong.zhang@intel.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386: check if nvdimm is enabled before
 plugging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Haozhong Zhang <haozhong.zhang@intel.com>
Cc: qemu-devel@nongnu.org, Xiao Guangrong <guangrong.xiao@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, imammedo@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>


--5xSkJheCpeK0RUEJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 07:56:51PM +0800, Haozhong Zhang wrote:
> The missing of 'nvdimm' in the machine type option '-M' means NVDIMM
> is disabled. QEMU should refuse to plug any NVDIMM device in this case
> and report the misconfiguration.
>=20
> Reported-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Message-Id: 20170112110928.GF4621@stefanha-x1.localdomain
> Message-Id: 20170111093630.2088-1-stefanha@redhat.com
> ---
>  hw/i386/pc.c | 5 +++++
>  1 file changed, 5 insertions(+)

Michael: Please add Haozhong's comment to the commit description when
merging:

"The behavior of NVDIMM on unsupported platform (HW/FW) is vendor
specific. For some vendors, it's undefined and the platform may do
anything. Thus, I think QEMU is free to choose the implementation.
Aborting QEMU (i.e. refusing to boot) is the easiest one."

This way we have a record that the behavior is okay according to the
spec and why we chose this option.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5xSkJheCpeK0RUEJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYhdxhAAoJEJykq7OBq3PIJ+wIAK2FCJ+yF84ddHXYxXOrFhBx
J7PgYn7g2yNiR97B1AZXjDidvWfIYuYtMdi9qSK2xxH5qzyfO+jRR+OdRO98ptmJ
qQMiQ2eBx1d9slaMM93X/nhBqTiZpJx8dLm89K+YuHT1fCanTC2eBDwIC/xiJrz5
HrQvciIkN7qPGR2YK6r4AUm0q74KlVmHNVhw7deibgeQErU2dc06WZKFlZcaKEym
5Pi+dBQXtBW+NC/j/5jx/wGtKO/pqunw//58rNturCFcX5R+V1ivCjN4Ps53e1j+
3ubGOpjqXNIAzes0mvOjQY9a+5bJBzLOxhd7AC6NUTP6qzvR3SigcE4MaK8vKWo=
=2GUP
-----END PGP SIGNATURE-----

--5xSkJheCpeK0RUEJ--
