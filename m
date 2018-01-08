Received: from eggs.gnu.org ([2001:4830:134:3::10]:51746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYZzT-0007Wt-VD
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eYZzP-0000cQ-HO
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:09:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eYZzP-0000bp-8G
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 11:09:31 -0500
Date: Mon, 8 Jan 2018 16:09:21 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180108160921.GC11758@stefanha-x1.localdomain>
References: <20171219162151.GA10889@stefanha-x1.localdomain>
	<1512291492.2209478.1513854089861.JavaMail.zimbra@redhat.com>
	<20180104104744.GC10106@stefanha-x1.localdomain>
	<5A4E0CDA.4060409@intel.com>
	<20180105154914.GH28322@stefanha-x1.localdomain>
	<5A53547D.2090602@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4ZLFUWh1odzi/v6L"
Content-Disposition: inline
In-Reply-To: <5A53547D.2090602@intel.com>
Subject: Re: [Qemu-devel] vhost-user graceful connect/disconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, mukawa@igel.co.jp, "Michael S. Tsirkin" <mst@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, n nikolaev <n.nikolaev@virtualopensystems.com>


--4ZLFUWh1odzi/v6L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08, 2018 at 07:22:37PM +0800, Wei Wang wrote:
> On 01/05/2018 11:49 PM, Stefan Hajnoczi wrote:
> > On Thu, Jan 04, 2018 at 07:15:38PM +0800, Wei Wang wrote:
> > > On 01/04/2018 06:47 PM, Stefan Hajnoczi wrote:
> > > > On Thu, Dec 21, 2017 at 06:01:29AM -0500, Marc-Andr=E9 Lureau wrote:
> > > >=20
> > > > I'm not going to prototype this yet, I'm working on virtio-vhost-us=
er
> > > > first, but eventually I might get back to -object vhost-user(-backe=
nd).
> > > >=20
> > > Hi Stefan, are you implementing the guest slave and vhost-pci driver =
(we've
> > > posted to the dpdk mailinglist) as well? and do you have an estimatio=
n when
> > > would the prototype be ready?
> > I'm implementing the "[RFC virtio-dev] vhost-user-slave: add vhost-user
> > slave device type" device in QEMU and DPDK in order to show how the
> > ideas we've discussed work.
> >=20
> > Here is the VIRTIO spec link again:
> > https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007
>=20
> There are four virtqueues documented in the spec, would two suffice? Requ=
est
> and Response can be distinguished by VHOST_USER_REPLY_MASK.

That's a good idea and I'll do it for the master-to-slave virtqueue.

Unfortunately virtqueues are asymmetric so a single virtqueue cannot
support the slave-to-master message flow (VHOST_USER_SET_SLAVE_REQ_FD):
1. Master puts an empty buffer onto vq.
2. Slave takes buffer and fills in a request.  The buffer is now used.
3. Master pops the used buffer but there is no way to reply back to the
   slave!

We still need 2 virtqueues for the slave-to-master message flow.

> I think the key issue is that we have a different viewpoint of protocol
> gating and protocol relaying. It is a high-level direction we need to ali=
gn
> first before we could get into more details. Hope your upcoming code can =
get
> us a decision. Please also remember to reuse the dpdk code that my cowork=
er
> posted to the dpdk mailinglist wherever possible, it may save your time to
> debug.

Thanks!

Stefan

--4ZLFUWh1odzi/v6L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaU5exAAoJEJykq7OBq3PINBIH/2q0L25DVSrymvfiMvs9OlaM
0UwYbbpHa8go9b/NKVlWFRVHpakayGEHfS1fi4ui2dyMKAFk+NBmuBeFyvMyqbVE
0FvFMvLAzBXk7nCH90vZWMOrmmxT0A2D6cr85QLxScJiNXuqBfVt6yWIWhPsuv43
bWRUbsvD1+iW8kifizdVTi9r9sKkui87tUV/OUB7UvHUbMDWEr/WUh0NjzcCnrOb
xwM50MgGl1r3Gjdtb2fg5wk0ptoLL3NE1lzTKx/eYVlARKMNJn6gfpFXDVCFt7v8
jLEWewMbxrOyZ6cZ0rMzGgiL+iZ0xGieL8istc5dESAd6EgPVLGqcF9OeS6Jzoo=
=4o42
-----END PGP SIGNATURE-----

--4ZLFUWh1odzi/v6L--
