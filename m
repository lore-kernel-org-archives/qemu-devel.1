Received: from eggs.gnu.org ([2001:4830:134:3::10]:52206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXT0e-00071q-AM
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:34:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gXT0a-0006Co-B9
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:34:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gXT0a-0006CP-3Q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 10:34:40 -0500
Date: Thu, 13 Dec 2018 15:34:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181213153434.GL23318@stefanha-x1.localdomain>
References: <5C10DAE9.3010605@huawei.com>
	<20181212081902-mutt-send-email-mst@kernel.org>
	<5C11D19C.4010007@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1X+6QtwRodzgDPAC"
Content-Disposition: inline
In-Reply-To: <5C11D19C.4010007@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] vhost-vsock: support parse mergeable
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jiangyiwen <jiangyiwen@huawei.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org


--1X+6QtwRodzgDPAC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2018 at 11:27:24AM +0800, jiangyiwen wrote:
> On 2018/12/12 21:19, Michael S. Tsirkin wrote:
> > On Wed, Dec 12, 2018 at 05:54:49PM +0800, jiangyiwen wrote:
> >> Currently vhost-vsock doesn't have any feature bits, so it
> >> don't support parse mergeable rx buffer feature. And the
> >> feature is support in another series of patches named
> >> "VSOCK: support mergeable rx buffer in vhost-vsock".
> >>
> >> So we neet to support parse mergeable feature in vhost-vsock
> >> if above patches are merged.
> >>
> >> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
> >=20
> > OK but what does it do? this just defines the feature bit ...
> > Also pls copy virtio-dev whenever you change the host/guest
> > interface.
> >=20
> > Thanks!
> >=20
>=20
> Hi Michael,
>=20
> In my opinion, for vhost device, device feature bits need to be
> intersected between vhost and qemu, so I add mergeable rx buffer feature
> into vdev->host_features, and then intersected with vhost_dev features.
>=20
> Later if someone want to add new feature, it can use virtio_add_feature()
> in vhost_vsock_get_features().

Hi Yiwen,
I think Michael's comment is about documenting the behavior of the new
feature bit.

Each change to a VIRTIO device host<->guest interface needs to be
discussed in the VIRTIO community <virtio-dev@lists.oasis-open.org> and
described in a patch to the VIRTIO specification
(https://github.com/oasis-tcs/virtio-spec/).

Stefan

--1X+6QtwRodzgDPAC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEnwKAAoJEJykq7OBq3PIL5AH/3ACv1WfSyJU38p+hnlWyP5I
+Uk83FvKmBYGgcCmA2xpJKwyHiKC4QjBP+kJtlCKzXdMu0LwQNohqkGuX9fJqexG
vJzye8CmCrzfYxQUQjwN23/nm4rNpG4lEwdC91E+33elTTmpYrk65htbm5WRDwCq
xECVtsPTifVWrwJWxN0IoY3EsUaTFaovM/CYr6UnVpYAX0euotqUvX7ytylThbzI
+DpuBHnHlgE5GstOpHJYlIu7dgR+ABfwjW2pMn8Vcq3UZslBquwRNK0sA/DOi2gU
ezfSFLOe8j+QHc5LRLJLdZ99BvbSsPvf/EBx4G4alG7anNuuE7VCxnMzw9H9lT4=
=+9yy
-----END PGP SIGNATURE-----

--1X+6QtwRodzgDPAC--
