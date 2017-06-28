Received: from eggs.gnu.org ([2001:4830:134:3::10]:53016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQInP-0004Sc-OX
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:38:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQInO-0000cI-UP
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 15:38:39 -0400
References: <20170628184724.21378-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8f3d355-8b45-3891-3eee-994059b0f045@redhat.com>
Date: Wed, 28 Jun 2017 14:38:26 -0500
MIME-Version: 1.0
In-Reply-To: <20170628184724.21378-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kuEuVxbf4hbfW494gkkSD2Kvjfm7GxSp9"
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
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kuEuVxbf4hbfW494gkkSD2Kvjfm7GxSp9
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <c8f3d355-8b45-3891-3eee-994059b0f045@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/6] virtio: use ioeventfd in TCG and qtest
 mode
References: <20170628184724.21378-1-stefanha@redhat.com>
In-Reply-To: <20170628184724.21378-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/28/2017 01:47 PM, Stefan Hajnoczi wrote:
> This patch series fixes qemu-iotests 068.  Since commit
> ea4f3cebc4e0224605ab9dd9724aa4e7768fe372 ("qemu-iotests: 068: test ioth=
read
> mode") the test case has attempted to use dataplane without -M accel=3D=
kvm.
> Although QEMU is capable of running TCG or qtest with emulated ioeventf=
d/irqfd
> we haven't enabled it yet.
>=20
> Unfortunately the virtio test cases fail when ioeventfd is enabled in q=
test
> mode.  This is because they make assumptions about virtqueue ISR signal=
ling.
> They assume that a request is completed when ISR becomes 1.  However, t=
he ISR
> can be set to 1 even though no new request has completed since commit
> 83d768b5640946b7da55ce8335509df297e2c7cd "virtio: set ISR on dataplane
> notifications".
>=20
> This issue is solved by introducing a proper qvirtqueue_get_buf() API (=
similar
> to the Linux guest drivers) instead of making assumptions about the ISR=
=2E  Most
> of the patches update the test cases to use the new API.
>=20
> Stefan Hajnoczi (6):
>   libqos: fix typo in virtio.h QVirtQueue->used comment
>   libqos: add virtio used ring support
>   tests: fix virtio-scsi-test ISR dependence
>   tests: fix virtio-blk-test ISR dependence
>   tests: fix virtio-net-test ISR dependence
>   virtio-pci: use ioeventfd even when KVM is disabled

I'm less familiar with the code in question, so I'll let others review,
but it did fix the failure of 068 for me.

Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kuEuVxbf4hbfW494gkkSD2Kvjfm7GxSp9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVAWyAAoJEKeha0olJ0Nq9lcH/0vXKnuBMMaZwU2H7OIEI7QW
DmZeiYGIAg1lMI6E9zflQR2O25D+kZQ9wQOfdcVwkCm8Mc1yU92gjAbYPqM7SYxH
gzW9eqLHKhQYAmcKCnAjOH4mK8jFtKPWmbEMRKyMk2iNGIIX4UfRi44/FOrJbJJC
wrd5JfxDQojHwlaD7flxUqz8r51FiwGTv4DwrXSef1epZxvNrYkwxlXE4do3BS5E
idCFvalPwlchWNHk0OuQzAQH8d/7WQTzAMECR2PYZ3Hl39oq+NCbsbOwgvdMXkWi
RNTKH+R30H9zFbJjq3cxA8YPB5lEgyjnQurdQeXxlthUm7Q6fgCaKKPEyiL6zWE=
=KjjL
-----END PGP SIGNATURE-----

--kuEuVxbf4hbfW494gkkSD2Kvjfm7GxSp9--
