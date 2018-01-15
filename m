Received: from eggs.gnu.org ([2001:4830:134:3::10]:59393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5FU-0006wt-5B
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eb5FQ-0008KN-7N
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51310)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eb5FQ-0008If-0u
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:56:24 -0500
Date: Mon, 15 Jan 2018 13:56:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180115135620.GG13238@stefanha-x1.localdomain>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xjyYRNSh/RebjC6o"
Content-Disposition: inline
In-Reply-To: <a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: wei.w.wang@intel.com, qemu-devel@nongnu.org


--xjyYRNSh/RebjC6o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2018 at 02:56:31PM +0800, Jason Wang wrote:
> On 2018=E5=B9=B401=E6=9C=8812=E6=97=A5 18:18, Stefan Hajnoczi wrote:
> > > And what's more important, according to the kvm 2016 slides of vhost-=
pci,
> > > the motivation of vhost-pci is not building SDN but a chain of VNFs. =
So
> > > bypassing the central vswitch through a private VM2VM path does make =
sense.
> > > (Though whether or not vhost-pci is the best choice is still question=
able).
> > This is probably my fault.  Maybe my networking terminology is wrong.  I
> > consider "virtual network functions" to be part of "software-defined
> > networking" use cases.  I'm not implying there must be a central virtual
> > switch.
> >=20
> > To rephrase: vhost-pci enables exitless VM2VM communication.
>=20
> The problem is, exitless is not what vhost-pci invents, it could be achie=
ved
> now when both sides are doing busypolling.

The only way I'm aware of is ivshmem.  But ivshmem lacks a family of
standard device types that allows different implementations to
interoperate.  We already have the virtio family of device types, so it
makes sense to work on a virtio-based solution.

Perhaps I've missed a different approach for exitless VM2VM
communication.  Please explain how VM1 and VM2 can do exitless network
communication today?

Also, how can VM1 provide SCSI I/O services to VM2 today?

Stefan

--xjyYRNSh/RebjC6o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaXLMEAAoJEJykq7OBq3PI9ooIALplKMZ1Lfking1jcIf30mX/
VZA2VVeuLk4BA48WFl0ATVKTK15rXffhdh7ozDEHXLBnm/o0gZrfTfWfwlknaZfP
sXZrF0QU06Zgru+kFGUbUXuhdOI6Sn3Xq3kfgLHdVYBdF0tD0OsQ60ZdeEgI3S9+
k0AZ9zc6Nq7fd1OMo3ws2WL/zP1cZ9CvfzhDMFWc2rXDRFtn/Vsr2im9Al2FPGg/
aVLrSIh6iwp7BYTuDnsqeOaxRFdUNaq+zIiG+stm1HG/HDCw4jGo8rywMqsy17tb
kKZ3pBRfKuSFIYnq5IXOpW7U928O6YLNLz3iRWviJ2V4tTGbPQGWFbokgKtnkNM=
=bT53
-----END PGP SIGNATURE-----

--xjyYRNSh/RebjC6o--
