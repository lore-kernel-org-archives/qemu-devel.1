Received: from eggs.gnu.org ([2001:4830:134:3::10]:35162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQW3S-0005Nk-Qa
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:48:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dQW3R-00071P-W4
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 05:48:06 -0400
Date: Thu, 29 Jun 2017 11:47:49 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170629094749.GA4618@noname.redhat.com>
References: <20170628184724.21378-1-stefanha@redhat.com>
	<c8f3d355-8b45-3891-3eee-994059b0f045@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <c8f3d355-8b45-3891-3eee-994059b0f045@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] virtio: use ioeventfd in TCG and qtest
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 28.06.2017 um 21:38 hat Eric Blake geschrieben:
> On 06/28/2017 01:47 PM, Stefan Hajnoczi wrote:
> > This patch series fixes qemu-iotests 068.  Since commit
> > ea4f3cebc4e0224605ab9dd9724aa4e7768fe372 ("qemu-iotests: 068: test ioth=
read
> > mode") the test case has attempted to use dataplane without -M accel=3D=
kvm.
> > Although QEMU is capable of running TCG or qtest with emulated ioeventf=
d/irqfd
> > we haven't enabled it yet.
> >=20
> > Unfortunately the virtio test cases fail when ioeventfd is enabled in q=
test
> > mode.  This is because they make assumptions about virtqueue ISR signal=
ling.
> > They assume that a request is completed when ISR becomes 1.  However, t=
he ISR
> > can be set to 1 even though no new request has completed since commit
> > 83d768b5640946b7da55ce8335509df297e2c7cd "virtio: set ISR on dataplane
> > notifications".
> >=20
> > This issue is solved by introducing a proper qvirtqueue_get_buf() API (=
similar
> > to the Linux guest drivers) instead of making assumptions about the ISR=
=2E  Most
> > of the patches update the test cases to use the new API.
> >=20
> > Stefan Hajnoczi (6):
> >   libqos: fix typo in virtio.h QVirtQueue->used comment
> >   libqos: add virtio used ring support
> >   tests: fix virtio-scsi-test ISR dependence
> >   tests: fix virtio-blk-test ISR dependence
> >   tests: fix virtio-net-test ISR dependence
> >   virtio-pci: use ioeventfd even when KVM is disabled
>=20
> I'm less familiar with the code in question, so I'll let others review,
> but it did fix the failure of 068 for me.
>=20
> Tested-by: Eric Blake <eblake@redhat.com>

Also passes the virtio-scsi qtest under valgrind for me now.

Tested-by: Kevin Wolf <kwolf@redhat.com>

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZVMzFAAoJEH8JsnLIjy/WN0UP/jTlac1azdpEXy/kc5D7d7T4
o0FK3+VkqPnfBj4Psd+jxMAA4SwgVemlV/U1ZtiZnBkIOUXFqgGmrsTrOUiAOZNj
KNmjIfgfuU/D5spaGcdi6ZZvUBijjXjbBE7I9GJS6gRmTSVqD4nBlhYU72ymYHvu
nGZjqk8PYUrdKEbpCBkNPuhwJr/pnuImDJmunkIrIXAIN/UN5mk55JqOmoBAXIOn
zFHW3ZgUR9scMhvXPL5XZvry8o2bnPcVW6xIq/fjUgACowUEGbHf8HXT2UnH56y9
4GZXH7B5TA5Quj9DH24sLm5HIoCvxT+rc54SkO0gNACnTuJpB9dyIcvlZ8Tiy5f4
nrfL1VY/ycUZ+rfT4WptmFH6QtEOQnJk3ezyoBEcCZlL9uaqRMU3jAmlR54kVFVZ
tvVAQzxoV0qTNrTHXTtP9c3w4AeMcz6B9FtA/rRIo5CxjrBZnzkgLRWnSc/VBB7K
IeS0UZRpGNMvmTlMUwlEnxsraGaYYHNKPqMqanAURKgbvmjvzfHTVy4/ArXAPae9
Gh/RAyD26ylh1VgHfP1G1jfs73m21gN0eLmkCWXkXGqTn/ZHWVD4R3UX2Fg1Fq34
DmfIGA5axRz38nD/phAU3IdFUqKDFbAshRbJraYW2YObhvW3AMEoanyLgnloTlXc
bV5ls6MwG6buiCIigXPN
=qiaj
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
