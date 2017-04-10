Received: from eggs.gnu.org ([2001:4830:134:3::10]:44498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxW8Q-0005Hh-4y
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:01:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxW8P-0002AA-Ay
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 06:01:22 -0400
Date: Mon, 10 Apr 2017 11:01:15 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410100115.GO2567@stefanha-x1.localdomain>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
	<20170407113312.GN13602@stefanha-x1.localdomain>
	<3565ef7f-97dd-4d7b-fbed-590e032819bf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxIXENaY2CYUgF8u"
Content-Disposition: inline
In-Reply-To: <3565ef7f-97dd-4d7b-fbed-590e032819bf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] migration/block:limit the
 time used for block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 858585 jemmy <jemmy858585@gmail.com>, kwolf@redhat.com, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, quintela@redhat.com, qemu-devel@nongnu.org, dgilbert@redhat.com, Lidong Chen <lidongchen@tencent.com>


--wxIXENaY2CYUgF8u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 08, 2017 at 06:09:16PM +0800, Paolo Bonzini wrote:
> On 07/04/2017 19:33, Stefan Hajnoczi wrote:
> > The migration thread is holding the QEMU global mutex, the AioContext,
> > and the qcow2 s->lock while the L2 table is read from disk.
> >=20
> > The QEMU global mutex is needed for block layer operations that touch
> > the global drives list.  bdrv_is_allocated() can be called without the
> > global mutex.
>=20
> Hi Stefan,
>=20
> only virtio-blk and virtio-scsi take the AioContext lock (because they
> support dataplane).  For block migration to work with devices such as
> IDE, it needs to take the iothread lock too.  I think there's a comment
> about this in migration/block.c.

Good point.  :(

Stefan

--wxIXENaY2CYUgF8u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61frAAoJEJykq7OBq3PIDUQIAIic7IdWT9QnyfpbltSqI5zT
CCIQ/RPFpbHE3l3ZXM7NeA+Q0p2sZSndpM1G7NQgrOpHUEspUGA/wVHPRq1GJdkl
0Z7GhFpQ0xjjyW2/4/kt8AF70QcZBi5gTQRKPkaTzwgPLHTtqZLHpV59Pk+wJC82
OrT7I5Ld/HmRf3xx9M38LFAiDu4ondslhZ5dRhPRPZdnHmoSHfs0U5HwzHiGirmi
gLu3MD3Cb4QPV/UWTiu0nXJbNXYpDA5MJNBIoFNpSQqRIfCHgzdmM4Vr8GOOZbyK
xPkjLbKtll6dt6gW2KpNLdY/+F03Z+K13iblOJpRlrGWNQSwo4uigLxQgyYq+DU=
=Y3nI
-----END PGP SIGNATURE-----

--wxIXENaY2CYUgF8u--
