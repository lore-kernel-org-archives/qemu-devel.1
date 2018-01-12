Received: from eggs.gnu.org ([2001:4830:134:3::10]:52163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZwiW-00059Q-1U
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eZwiR-0007UE-B5
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:37:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36670)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eZwiR-0007Sa-2E
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 05:37:39 -0500
Date: Fri, 12 Jan 2018 10:37:36 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180112103736.GF7356@stefanha-x1.localdomain>
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<5A5704B4.5090502@intel.com>
	<CAJSP0QWyaE8qUGMgcpzB460Y=kpX4VDfqFWm-CWmmX4X3nmRMQ@mail.gmail.com>
	<5A585930.1030009@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wtjvnLv0o8UUzur2"
Content-Disposition: inline
In-Reply-To: <5A585930.1030009@intel.com>
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>


--wtjvnLv0o8UUzur2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2018 at 02:44:00PM +0800, Wei Wang wrote:
> On 01/11/2018 05:56 PM, Stefan Hajnoczi wrote:
> > On Thu, Jan 11, 2018 at 6:31 AM, Wei Wang <wei.w.wang@intel.com> wrote:
> > > On 01/11/2018 12:14 AM, Stefan Hajnoczi wrote:
> > > Without above two, the solution already works well, so I'm not sure w=
hy would we need the above two from functionality point of view.
> > The "[PATCH v3 0/7] Vhost-pci for inter-VM communication" series is
> > incomplete.  It is a subset of vhost-user-net and it works only for
> > poll-mode drivers.  It's the requirements that haven't been covered by
> > the vhost-pci patch series yet that make me prefer the
> > virtio-vhost-user approach.
> >=20
> > The virtio device design needs to be capable of supporting the rest of
> > vhost-user functionality in the future.  Once the code is merged in
> > QEMU and DPDK it will be very difficult to make changes to the virtio
> > device.
>=20
> This is how virtio works. A new feature with a new feature bit.

Although it is possible to add a feature bit that radically changes the
virtio device's interface, the existing driver software would need to be
largely rewritten - all the way up to the net, scsi, blk, etc devices.

We cannot easily migrate between the vhost-pci to virtio-vhost-user
approaches later.

> Now, we let
> the guest driver join the vhost-user negotiation (including feature
> negotiation), the default device/driver feature negotiation is free to us=
e.
> I'm thinking if it is worthwhile to do some kind of mediated passthrough,
> which passes the selected messages only. Because many messages are not
> necessary to be passed down (e.g. VHOST_USER_SEND_RARP is not needed for
> simple VM-to-VM communication), though might be safe to do. I plan to see
> your full passthrough code first, and see if changing to mediated
> passthrough would be simpler.

I expect vhost-pci to require fewer code changes.  If you judge
"simpler" just by the patch count or size, then vhost-pci will win.

The reason for that is virtio-vhost-user integrates with librte_vhost.
This requires refactoring librte_vhost to support multiple transports.

I think the virtio-vhost-user end result is worth it though: vhost
devices like examples/vhost/ and examples/vhost/scsi/ will work with
both AF_UNIX and virtio-vhost-user.  This makes it simpler for users and
vhost device developers - you only have one implementation of net, scsi,
blk, etc devices.

Stefan

--wtjvnLv0o8UUzur2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaWI/vAAoJEJykq7OBq3PIgygIAJK0guRRsM3ZOMSw/JHZtOtQ
cUwGJ1EoNvcQ64AR2IYFaVNq7zlLd0fUG2XPIUBBq1UPt0V4/Qk5X2bV5xnlwt/l
LDUxAoUwDz507Ssckn+t6JboGV+9VXEu4zWpRrkgE/m15ubIvSD9OZ7mAeAMn77g
43j632qtJrDCD4XjOYL1/asO5up0mtXw7UsDJfwcrM8O45agssgSFZzVxtFzqCT2
7+t0i+jG4Z9k9ZP0uzJICNNGZgj6y13xzfCMtVZQS1BMjMXkGQqUVMPwgeyHx8Tn
Cn2dUZ9U+5rMgyCr0NfQ+KOKQ/a4vPOI3Y7D2pphX35wsooroQoN/KqyxIXlIrY=
=apRc
-----END PGP SIGNATURE-----

--wtjvnLv0o8UUzur2--
