Received: from eggs.gnu.org ([2001:4830:134:3::10]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ef8fz-0002Uh-AR
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:24:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ef8fv-00048B-Vp
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:24:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ef8fv-00047G-N4
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 13:24:31 -0500
Date: Fri, 26 Jan 2018 14:44:29 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180126144429.GD17788@stefanha-x1.localdomain>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<5A65C652.6080307@intel.com>
	<20180123111238.GC6565@stefanha-x1.localdomain>
	<5A673369.6050408@intel.com>
	<20180124114055.GC17193@stefanha-x1.localdomain>
	<5A69AF21.5000209@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Content-Disposition: inline
In-Reply-To: <5A69AF21.5000209@intel.com>
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, jasowang@redhat.com


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2018 at 06:19:13PM +0800, Wei Wang wrote:
> On 01/24/2018 07:40 PM, Stefan Hajnoczi wrote:
> > On Tue, Jan 23, 2018 at 09:06:49PM +0800, Wei Wang wrote:
> > > On 01/23/2018 07:12 PM, Stefan Hajnoczi wrote:
> > > > On Mon, Jan 22, 2018 at 07:09:06PM +0800, Wei Wang wrote:
> > > > > On 01/19/2018 09:06 PM, Stefan Hajnoczi wrote:
> > > > >=20
> > > > >=20
> > > > >    - Suppose in the future there is also a kernel virtio-vhost-us=
er driver as
> > > > > other PCI devices, can we unbind the kernel driver first, and the=
n bind the
> > > > > device to the dpdk driver? A normal PCI device should be able to =
smoothly
> > > > > switch between the kernel driver and dpdk driver.
> > > > It depends what you mean by "smoothly switch".
> > > >=20
> > > > If you mean whether it's possible to go from a kernel driver to
> > > > vfio-pci, then the answer is yes.
> > > >=20
> > > > But if the kernel driver has an established vhost-user connection t=
hen
> > > > it will be closed.  This is the same as reconnecting with AF_UNIX
> > > > vhost-user.
> > > >=20
> > > Actually not only the case of switching to testpmd after kernel estab=
lishes
> > > the connection, but also for several runs of testpmd. That is, if we =
run
> > > testpmd, then exit testpmd. I think the second run of testpmd won't w=
ork.
> > The vhost-user master must reconnect and initialize again (SET_FEATURES,
> > SET_MEM_TABLE, etc).  Is your master reconnecting after the AF_UNIX
> > connection is closed?
>=20
> Is this an explicit qmp operation to make the master re-connect?

I haven't tested it myself but I'm aware of two modes of operation:

1. -chardev socket,id=3Dchardev0,...,server
   -netdev vhost-user,chardev=3Dchardev0

   When the vhost-user socket is disconnected the peer needs to
   reconnect.  In this case no special commands are necessary.

   Here we're relying on DPDK librte_vhost's reconnection behavior.

Or

2. -chardev socket,id=3Dchardev0,...,reconnect=3D3
   -netdev vhost-user,chardev=3Dchardev0

   When the vhost-user socket is disconnected a new connection attempt
   will be made after 3 seconds.

In both cases vhost-user negotiation will resume when the new connection
is established.

Stefan

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaaz7NAAoJEJykq7OBq3PIAZoH/3ObKRSNBBAss6QtTpG5KA9t
LqssFsz5CtCZYcnG43T+ylE7cYVSK3T10MQNKQ1aDI/jqN6gQN2eWDm7uHAeirR6
cqgU5pS+qakCxort4R4hEIEBIsVOzp95mcY5FmH1BN4GaLHCuQlOiBojeOdh6Dko
s1u/iRabjQqVW5nVW4Pv5MPJ5ffBh/QQ/vyEZj+INX3SSoFxqbXXutRKgrTvtY4g
4sIr9vAUsIvWxy52T5FBlSAVE0ugcD0EQzewwfZ5VK4nJ7J/Gsq+mkrGMXWJJ+vX
loYcl/uEmky9kAFTi9vLbnVZp8JuK12FjFhcAq+mKR681q/Kc5YxeB7neSHqsCc=
=pnRo
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
