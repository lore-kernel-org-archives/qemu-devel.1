Received: from eggs.gnu.org ([2001:4830:134:3::10]:56053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edx8B-0003U3-3K
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:52:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edx88-00038e-16
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:52:47 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edx87-000384-OI
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:52:43 -0500
Date: Tue, 23 Jan 2018 11:52:40 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180123115240.GD6565@stefanha-x1.localdomain>
References: <20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<20180115135620.GG13238@stefanha-x1.localdomain>
	<9fad276a-d17b-6a45-6cd6-50899934b7a1@redhat.com>
	<20180118105103.GC19831@stefanha-x1.localdomain>
	<78448708-8d53-70ca-d079-424caabc3a35@redhat.com>
	<20180119172049.GA29973@stefanha-x1.localdomain>
	<9c05c203-7d1f-dbea-5577-4d85c42e82ee@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x4pBfXISqBoDm8sr"
Content-Disposition: inline
In-Reply-To: <9c05c203-7d1f-dbea-5577-4d85c42e82ee@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, wei.w.wang@intel.com, qemu-devel@nongnu.org


--x4pBfXISqBoDm8sr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 11:54:41AM +0800, Jason Wang wrote:
> On 2018=E5=B9=B401=E6=9C=8820=E6=97=A5 01:20, Stefan Hajnoczi wrote:
> > > I don't propose any new idea. I just want to know what's the advantag=
e of
> > > vhost-pci over zerocopy. Both needs one time of copy, the difference =
is the
> > > vhost-pci did it inside a guest but zerocopy did in on host.
> > Exitless VM2VM communication is desirable if you cannot run software on
> > the host or if both endpoints are already in VMs.  In that case running
> > one thing in a VM and another on the host doesn't make sense.
>=20
> Well, I must have missed anything, I don't see why we can not run virtio-=
net
> backend on host. Especially it only does L2 stuffs, higher level of servi=
ce
> could be provided by another VM for sure. So it looks to me
> virtio-vhost-user is just a split device implementation which is irrevere=
nt
> to the service it could provide.
>=20
> Maybe you can provide a concrete examples of virtio-vhost-user and its
> advantages?
[...]
> >=20
> > The obvious environment where this applies is in the cloud where
> > everything is a VM.
>=20
> So a typical setup makes the VMs can already talk to each other through
> ethernet(virtio-net). Virtio-vhost-user looks much less flexible than exi=
st
> stuffs. The only possible advantage of virtio-vhost-user is its performan=
ce
> or security which still need to be proved.

I look forward to performance results but in the meantime consider
existing vhost-user use cases.  Those applications could just use
network communication too (e.g. iSCSI instead of vhost-user-scsi).  They
choose vhost-user mainly because it's faster (zerocopy, no vmexits, and
no network protocol overhead).

There are other advantages too.  In the iSCSI case, guests need
configuration details to establish the iSCSI connection.  In the
virtio-scsi case the guests only need the virtio-scsi driver and no
configuration to access the LUNs.  It's simpler on the guest side!

So the reasons for virtio-vhost-user are the same as vhost-user PLUS
some users choose to deploy everything in VMs and cannot run host
userspace process.

Stefan

--x4pBfXISqBoDm8sr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaZyIIAAoJEJykq7OBq3PIpacH/14CjfVSfAOh5q+xSqCt4TLi
PMxuF30FwPrV+h7okvZYNBUCHBMf4JWhyuGHBW6tnvvU4nzJ1N2IJAV2aLejWLED
98vLnd6ZUZdtVfydumz1QFmPmqhYMAZRVha/+1aLi/rvxLbMlwKAFfIwVyjeb3Za
g3ft7bH8jhLP8ROAhFdGR3cS54OZGtySxNjhIIeHlWIdrZzEbhKTgftONbEyf/gL
1tiTkORakGdSHiAvRHnsKXetJCoWl4UpjiTv3yMpuixon2Y6eo6gW/76Z0YJwdsb
aYM65l+tu8cicEQOBxg7Icqx7v7hxkjTwPREZ9Iknf9ifUpozKbPkP7I+ORoRQU=
=1IAE
-----END PGP SIGNATURE-----

--x4pBfXISqBoDm8sr--
