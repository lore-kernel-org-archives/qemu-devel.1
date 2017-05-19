Received: from eggs.gnu.org ([2001:4830:134:3::10]:59899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBjuP-0007xc-CM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:33:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dBjuM-0005H9-8C
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:33:41 -0400
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:32848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dBjuM-0005Gf-25
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:33:38 -0400
Received: by mail-wr0-x241.google.com with SMTP id w50so3318052wrc.0
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 08:33:37 -0700 (PDT)
Date: Fri, 19 May 2017 16:33:29 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170519153329.GA30573@stefanha-x1.localdomain>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Content-Disposition: inline
In-Reply-To: <d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, marcandre.lureau@gmail.com, mst@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 19, 2017 at 11:10:33AM +0800, Jason Wang wrote:
> On 2017=E5=B9=B405=E6=9C=8818=E6=97=A5 11:03, Wei Wang wrote:
> > On 05/17/2017 02:22 PM, Jason Wang wrote:
> > > On 2017=E5=B9=B405=E6=9C=8817=E6=97=A5 14:16, Jason Wang wrote:
> > > > On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang wrote:
> > > > > > Hi:
> > > > > >=20
> > > > > > Care to post the driver codes too?
> > > > > >=20
> > > > > OK. It may take some time to clean up the driver code before
> > > > > post it out. You can first
> > > > > have a check of the draft at the repo here:
> > > > > https://github.com/wei-w-wang/vhost-pci-driver
> > > > >=20
> > > > > Best,
> > > > > Wei
> > > >=20
> > > > Interesting, looks like there's one copy on tx side. We used to
> > > > have zerocopy support for tun for VM2VM traffic. Could you
> > > > please try to compare it with your vhost-pci-net by:
> > > >=20
> > We can analyze from the whole data path - from VM1's network stack to
> > send packets -> VM2's
> > network stack to receive packets. The number of copies are actually the
> > same for both.
>=20
> That's why I'm asking you to compare the performance. The only reason for
> vhost-pci is performance. You should prove it.

There is another reason for vhost-pci besides maximum performance:

vhost-pci makes it possible for end-users to run networking or storage
appliances in compute clouds.  Cloud providers do not allow end-users to
run custom vhost-user processes on the host so you need vhost-pci.

Stefan

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZHxBJAAoJEJykq7OBq3PIybgH/A59aZA81jllepODn6jaN8bo
hhKm5kzVSzEwMxmw/xpD8iFCBFQdhIllFMt1t+0LiBGlxOpvTSbJkLsOoEXrR50a
iXREgaf9JqTcV8mQ/HLMEJ7V3xs6PYqzS9aB94JbfXvbjxtakHFwMfVrr4BeoHMV
P28jkAZfMM8Hh/cE0LXqj6hTzqEJyGwUxJKaM+zu9jivka6nlUz503/TQPWjGSZ6
Onx5VtQCC33hM6axzInBUJ4mApU+sN1dwI62cgK2vlGiR+MQGVSxMEryqfNECblx
W829xq9zPU66RhA66FMK5Kbs6HsFGdXlpEoy0JP6bbPuCxhwSXgMFrgWmMzIVVY=
=koyD
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
