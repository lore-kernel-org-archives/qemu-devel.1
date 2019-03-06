Received: from eggs.gnu.org ([209.51.188.92]:59807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1h1SXe-00038t-55
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1h1SXP-0000RO-Rs
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:08:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1h1SXP-0000Pv-Kv
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:08:31 -0500
Message-ID: <75658e81160627acaa723ae145bd5ad5106f1118.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 06 Mar 2019 10:08:08 +0100
In-Reply-To: <20190306083032.GZ1252@lpt>
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
	<20190305143801.lq4gpetubspftkda@sirius.home.kraxel.org>
	<81d22ed88833ed22a1c3781c3c0c1eafad99b280.camel@redhat.com>
	<20190306074148.GA9131@angien.pipo.sk> <20190306083032.GZ1252@lpt>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-1?Q?J=E1n?= Tomko <jtomko@redhat.com>, Peter Krempa <pkrempa@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, Amit Shah <amit@kernel.org>, Reitz <mreitz@redhat.com>, Max@angien.pipo.sk, Caio Carrara <ccarrara@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Laine Stump <laine@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>

On Wed, 2019-03-06 at 09:30 +0100, J=C3=A1n Tomko wrote:
> On Wed, Mar 06, 2019 at 08:41:48AM +0100, Peter Krempa wrote:
> > On Tue, Mar 05, 2019 at 16:56:43 +0100, Andrea Bolognani wrote:
> > > So I agree neither scenario is exactly perfect, but I still think
> > > adding non-transitional alias devices would overall be more
> > > user-friendly.
> >=20
> > I don't think it makes sense to add it at the qemu level. From libvir=
t's
> > point of view users should be shielded from any qemu impl detail or
> > inconsistency as libvirt is the 'user friendly'[1] layer. In qemu the
> > devices would be the same and thus does not make sense to do that
> > because it would be more confusing.
> >=20
> > You can argue that we should add the alias at the libvirt level thoug=
h.
>=20
> You can, but please don't.

It would seem nobody except me thinks this is a good idea, so I
guess I'll just drop it now.

--=20
Andrea Bolognani / Red Hat / Virtualization
