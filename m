Received: from eggs.gnu.org ([2001:4830:134:3::10]:43056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gZBVy-0003Rj-QS
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gZBVv-000629-CM
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:18:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gZBVv-0005wq-13
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 04:18:07 -0500
Date: Tue, 18 Dec 2018 09:18:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181218091802.GA18767@stefanha-x1.localdomain>
References: <cover.1545120100.git.yi.z.zhang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Content-Disposition: inline
In-Reply-To: <cover.1545120100.git.yi.z.zhang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH V7 0/6] nvdimm: support MAP_SYNC for
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Yi <yi.z.zhang@linux.intel.com>
Cc: mst@redhat.com, peter.maydell@linaro.org, yu.c.zhang@linux.intel.com, ehabkost@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org, pbonzini@redhat.com, crosthwaite.peter@gmail.com, richard.henderson@linaro.org, xiaoguangrong.eric@gmail.com


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 04:16:44PM +0800, Zhang Yi wrote:
> Linux 4.15 introduces a new mmap flag MAP_SYNC, which can be used to
> guarantee the write persistence to mmap'ed files supporting DAX (e.g.,
> files on ext4/xfs file system mounted with '-o dax').
>=20
> A description of MAP_SYNC and MAP_SHARED_VALIDATE can be found at
>     https://patchwork.kernel.org/patch/10028151/
>=20
> In order to make sure that the file metadata is in sync after a fault=20
> while we are writing a shared DAX supporting backend files, this
> patch-set enables QEMU to use MAP_SYNC flag for memory-backend-dax-file.
>=20
> As the DAX vs DMA truncated issue was solved, we refined the code and
> send out this feature for the v5 version.
>=20
> A new auto on/off option 'sync' is added to memory-backend-file:
>  - on:  try to pass MAP_SYNC to mmap(2); if MAP_SYNC is not supported or
>         'share=3Doff' or 'pmem=3Doff', QEMU will abort
>  - off: never pass MAP_SYNC to mmap(2)
>  - auto (default): if MAP_SYNC is supported and 'share=3Don' 'pmem=3Don',=
 work as if
>         'sync=3Don'; otherwise, work as if 'sync=3Doff'

I took a quick look and didn't see human-readable errors when pmem=3Doff.
Is it possible to report it instead of aborting?

Thanks,
Stefan

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcGLtKAAoJEJykq7OBq3PI088IAK+ILwTazc64At/psAhMPZcW
O8iTp9q1UPg/pDNaO6cvi1y5mgu7ZzPCH6SkRSb8D56dg/K1t9xtuPW9VE/lpxyF
5pLeZKLlTqDon3CLCUV4MwXLN93TVjs9CX6aUZAA8vYGfzNc7h+yOJEsKbQL/bYs
DslpYszDDSqx6H/SiIgMh1yyxG+6X0ju4f6mvagBzrf3rzqWMfmfolnHaH50t8yr
oMOzwUSKEXpGIezseH66EhN1H8HJ2bOS/Mf0DxR0XO4SZKSiqYPVA2mUVlEEDizw
VAVe9396DzQg3cQOTSqUw5s2NRCSmtbiwjZKlFoqB5ADM2qTBuMhO/rl7CD/kqk=
=pmYM
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
