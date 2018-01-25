Received: from eggs.gnu.org ([2001:4830:134:3::10]:47676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eeiQ8-0008NU-89
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eeiQ4-0007us-8G
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:22:28 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:33126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eeiQ4-0007ty-1o
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 09:22:24 -0500
Received: by mail-wr0-x244.google.com with SMTP id s5so6530397wra.0
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 06:22:23 -0800 (PST)
Date: Thu, 25 Jan 2018 14:22:20 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180125142220.GD28396@stefanha-x1.localdomain>
References: <20180125040328.22867-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <20180125040328.22867-1-tiwei.bie@intel.com>
Subject: Re: [Qemu-devel] [PATCH v1 0/6] Extend vhost-user to support VFIO
 based accelerators
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, mst@redhat.com, alex.williamson@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, jianfeng.tan@intel.com, cunming.liang@intel.com, xiao.w.wang@intel.com, zhihong.wang@intel.com, dan.daly@intel.com


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 12:03:22PM +0800, Tiwei Bie wrote:
> Why extend vhost-user for vDPA
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>=20
> We have already implemented various virtual switches (e.g. OVS-DPDK)
> based on vhost-user for VMs in the Cloud. They are purely software
> running on CPU cores. When we have accelerators for such NFVi application=
s,
> it's ideal if the applications could keep using the original interface
> (i.e. vhost-user netdev) with QEMU, and infrastructure is able to decide
> when and how to switch between CPU and accelerators within the interface.
> And the switching (i.e. switch between CPU and accelerators) can be done
> flexibly and quickly inside the applications.
>=20
> More details about this can be found from the Cunming's discussions on
> the RFC patch set.
>=20
> The previous links:
> RFC: http://lists.nongnu.org/archive/html/qemu-devel/2017-12/msg04844.html

Is vDPA also useful in the simpler use case where there is no NFVi
application?

In other words, you have virtio-net inside the guest and vhost-net on
the host.  You'd like to accelerate the virtio-net NIC using the
hardware's vDPA support.

DPDK requires dedicated logical cores and hugepages.  Those resources
will not be used (wasted) if you just want to enable vDPA but have no
DPDK packet processing application.

How can this use case be supported without wasting resources?

Stefan

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaaegcAAoJEJykq7OBq3PIChkH/0IUmFUefpDUhBHDkFwBA7n1
7GXnt6jx2rHyrV4gh6tyz2o7ZO0z5+LNM6z76eqdVlkq9xw0vcT/M/kgvs8DE3hF
XBrRrkz7xJBoWP5NEjOo1x6JXYWBo4zYzPMlPze8KFCwvN3aQQDdmcJCCmWxmZVD
c7Rpjw9KssIzF1eblXI+nnwUpkoYj+YCxaSUCluwhkmb+MxX4GrqKn+tYEclJxSP
CzTVs3g7JecKBemQvh0jHqfgFrsYnMRFJHQJo1IYlvDeGGjhOQ/9wSa4wGwvbBgH
EcZrPFM1YAyFwksOErrEqZ3E5ujfXy8uyb9CvP1iAS6bOyeNa+27bwO8whMW9RM=
=0rDt
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
