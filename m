Received: from eggs.gnu.org ([209.51.188.92]:56480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtOdN-0005yF-GY
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gtOdK-0005eO-ND
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:21:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48126)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gtOdH-0005av-7S
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 22:21:17 -0500
Date: Mon, 11 Feb 2019 22:21:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211222053-mutt-send-email-mst@kernel.org>
References: <20190211165756.GN2627@work-vm>
	<20190211122058-mutt-send-email-mst@kernel.org>
	<FF7FC980937D6342B9D289F5F3C7C2625B7B4E39@SHSMSX103.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <FF7FC980937D6342B9D289F5F3C7C2625B7B4E39@SHSMSX103.ccr.corp.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] virtio-blk io bar size changed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Changpeng" <changpeng.liu@intel.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "stefanha@redhat.com" <stefanha@redhat.com>, "ldoktor@redhat.com" <ldoktor@redhat.com>

On Tue, Feb 12, 2019 at 01:59:38AM +0000, Liu, Changpeng wrote:
>=20
>=20
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Tuesday, February 12, 2019 1:23 AM
> > To: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Cc: qemu-devel@nongnu.org; Liu, Changpeng <changpeng.liu@intel.com>;
> > stefanha@redhat.com; ldoktor@redhat.com
> > Subject: Re: virtio-blk io bar size changed
> >=20
> > On Mon, Feb 11, 2019 at 04:58:19PM +0000, Dr. David Alan Gilbert wrot=
e:
> > > Hi,
> > >   Luk=C3=A1=C5=A1 reported that there's a migration breakage betwee=
n 3.1 and
> > > current head with virtio-blk;   it looks like the io bar changes fr=
om 64
> > > to 128 bytes and my bisect suggests it's:
> > >
> > > commit caa1ee43131c060347b32893abd41fe4865eaa2e (HEAD, refs/bisect/=
bad)
> > > Author: Changpeng Liu <changpeng.liu@intel.com>
> > > Date:   Wed Jan 16 13:19:30 2019 +0800
> > >
> > >     vhost-user-blk: add discard/write zeroes features support
> > >
> > >
> > > How do we fix that?
> > >
> > > Dave
> >=20
> > Quickly :)
> >=20
> > See the logic around virtio_net_set_config_size
> > and static VirtIOFeature feature_sizes - we need to
> > add something similar to virtio blk now.
> Correct, after this commit the BAR config size is changed, I will submi=
t a patch to fix this.

Thanks!

> >=20
> >=20
> > > --
> > > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
