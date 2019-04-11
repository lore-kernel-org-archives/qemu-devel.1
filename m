Received: from eggs.gnu.org ([209.51.188.92]:54284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgg@mellanox.com>) id 1hEdgg-0005V0-01
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgg@mellanox.com>) id 1hEdge-00046w-3I
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:40:33 -0400
Received: from mail-eopbgr50071.outbound.protection.outlook.com
	([40.107.5.71]:28435
	helo=EUR03-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgg@mellanox.com>) id 1hEdgc-00044b-9F
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:40:31 -0400
From: Jason Gunthorpe <jgg@mellanox.com>
Date: Thu, 11 Apr 2019 17:40:26 +0000
Message-ID: <20190411174022.GA26227@mellanox.com>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411190215.2163572e.cohuck@redhat.com>
	<20190411172402.GA14509@mellanox.com> <20190411173419.GB6259@lap1>
In-Reply-To: <20190411173419.GB6259@lap1>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6242C05B658BD24198CF603E9E63C344@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC 0/3] VirtIO RDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>

On Thu, Apr 11, 2019 at 08:34:20PM +0300, Yuval Shaia wrote:
> On Thu, Apr 11, 2019 at 05:24:08PM +0000, Jason Gunthorpe wrote:
> > On Thu, Apr 11, 2019 at 07:02:15PM +0200, Cornelia Huck wrote:
> > > On Thu, 11 Apr 2019 14:01:54 +0300
> > > Yuval Shaia <yuval.shaia@oracle.com> wrote:
> > >=20
> > > > Data center backends use more and more RDMA or RoCE devices and mor=
e and
> > > > more software runs in virtualized environment.
> > > > There is a need for a standard to enable RDMA/RoCE on Virtual Machi=
nes.
> > > >=20
> > > > Virtio is the optimal solution since is the de-facto para-virtualiz=
aton
> > > > technology and also because the Virtio specification
> > > > allows Hardware Vendors to support Virtio protocol natively in orde=
r to
> > > > achieve bare metal performance.
> > > >=20
> > > > This RFC is an effort to addresses challenges in defining the RDMA/=
RoCE
> > > > Virtio Specification and a look forward on possible implementation
> > > > techniques.
> > > >=20
> > > > Open issues/Todo list:
> > > > List is huge, this is only start point of the project.
> > > > Anyway, here is one example of item in the list:
> > > > - Multi VirtQ: Every QP has two rings and every CQ has one. This me=
ans that
> > > >   in order to support for example 32K QPs we will need 64K VirtQ. N=
ot sure
> > > >   that this is reasonable so one option is to have one for all and
> > > >   multiplex the traffic on it. This is not good approach as by desi=
gn it
> > > >   introducing an optional starvation. Another approach would be mul=
ti
> > > >   queues and round-robin (for example) between them.
> > > >=20
> > > > Expectations from this posting:
> > > > In general, any comment is welcome, starting from hey, drop this as=
 it is a
> > > > very bad idea, to yeah, go ahead, we really want it.
> > > > Idea here is that since it is not a minor effort i first want to kn=
ow if
> > > > there is some sort interest in the community for such device.
> > >=20
> > > My first reaction is: Sounds sensible, but it would be good to have a
> > > spec for this :)
> >=20
> > I'm unclear why you'd want to have a virtio queue for anything other
> > that some kind of command channel.
> >=20
> > I'm not sure a QP or CQ benefits from this??
>=20
> Virtqueue is a standard mechanism to pass data from guest to host. By
> saying that - it really sounds like QP send and recv rings. So my thought
> is to use a standard way for rings. As i've learned this is how it is use=
d
> by other virtio devices ex virtio-net.

I doubt you can use virtio queues from userspace securely? Usually
needs a dedicated page for each user space process

Jason
