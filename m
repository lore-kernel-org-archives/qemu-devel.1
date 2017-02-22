Received: from eggs.gnu.org ([2001:4830:134:3::10]:42765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgY84-0003LC-At
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cgY83-0000bF-Bs
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 09:42:52 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-26-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <da1d3fc9-afd5-ebd9-ca72-d9ca9f77ebce@redhat.com>
Date: Wed, 22 Feb 2017 15:42:42 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-26-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bQPlXaTLaVJg08bCNv1XopKvFt5fnl1Gi"
Subject: Re: [Qemu-devel] [PATCH 25/54] block: Add error parameter to
 blk_insert_bs()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bQPlXaTLaVJg08bCNv1XopKvFt5fnl1Gi
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <da1d3fc9-afd5-ebd9-ca72-d9ca9f77ebce@redhat.com>
Subject: Re: [PATCH 25/54] block: Add error parameter to blk_insert_bs()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-26-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-26-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Now that blk_insert_bs() requests the BlockBackend permissions for the
> node it attaches to, it can fail. Instead of aborting, pass the errors
> to the callers.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                          |  5 ++++-
>  block/backup.c                   |  5 ++++-
>  block/block-backend.c            | 13 ++++++++-----
>  block/commit.c                   | 38 ++++++++++++++++++++++++++++++--=
------
>  block/mirror.c                   | 15 ++++++++++++---
>  block/qcow2.c                    | 10 ++++++++--
>  blockdev.c                       | 11 +++++++++--
>  blockjob.c                       |  7 ++++++-
>  hmp.c                            |  6 +++++-
>  hw/core/qdev-properties-system.c |  7 ++++++-
>  include/sysemu/block-backend.h   |  2 +-
>  migration/block.c                |  2 +-
>  nbd/server.c                     |  6 +++++-
>  tests/test-blockjob.c            |  2 +-
>  14 files changed, 100 insertions(+), 29 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--bQPlXaTLaVJg08bCNv1XopKvFt5fnl1Gi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlito2ISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AtXEH/2pQ28T/vq2ESfX2VgOWVmPrFUXQ1AsR
ylN//l7nGsF1LwpBo3wbRXwtvYnr454t5LM+dxlko/f/7wOJlLyAu+ogDcqxyFjb
jsaOvLRhY/duHGrP9dj8UC8Uj7JqpayAV+EEBh960tpXQuyQRjlFXi+zu3rBFHn2
sMX3DyamzDRKFsSmmRBj465UMqmmkErTNTwfR+bMCmteJSPPMB/iSBE6uE23aYap
UjE4y/IA458OqOX4k988lZR4bzqRkmJPFGm9a4vtq8moDGSRwzJn7SexfuuXJGcp
ebHkbRMFiwyPfrbloHIoNtXH1rO0FwieucV5jLfc3NIIxSCBqFk6Y3U=
=XhxE
-----END PGP SIGNATURE-----

--bQPlXaTLaVJg08bCNv1XopKvFt5fnl1Gi--
