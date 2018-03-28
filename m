Received: from eggs.gnu.org ([2001:4830:134:3::10]:39564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1C0K-0004Xk-MA
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1f1C0H-000338-FL
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:24:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1f1C0H-00032q-Ad
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 10:24:41 -0400
Date: Wed, 28 Mar 2018 17:24:33 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180328172057-mutt-send-email-mst@kernel.org>
References: <1516308132-10272-1-git-send-email-mst@redhat.com>
	<1516308132-10272-3-git-send-email-mst@redhat.com>
	<d7c049af-8da0-a8a1-a4b1-5484c682fd10@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d7c049af-8da0-a8a1-a4b1-5484c682fd10@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v4 02/29] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, Changpeng Liu <changpeng.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>

On Wed, Mar 28, 2018 at 12:03:36PM +0200, Maxime Coquelin wrote:
> Hi,
>=20
> On 01/18/2018 09:44 PM, Michael S. Tsirkin wrote:
> > From: Changpeng Liu <changpeng.liu@intel.com>
> >=20
> > Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
> > used for live migration of vhost user devices, also vhost user device=
s
> > can benefit from the messages to get/set virtio config space from/to =
the
> > I/O target. For the purpose to support virtio config space change,
> > VHOST_USER_SLAVE_CONFIG_CHANGE_MSG message is added as the event noti=
fier
> > in case virtio config space change in the slave I/O target.
> >=20
> > Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
> > Reviewed-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >   docs/interop/vhost-user.txt       |  55 ++++++++++++++++++
> >   include/hw/virtio/vhost-backend.h |  12 ++++
> >   include/hw/virtio/vhost.h         |  15 +++++
> >   hw/virtio/vhost-user.c            | 118 +++++++++++++++++++++++++++=
+++++++++++
> >   hw/virtio/vhost.c                 |  32 +++++++++++
> >   5 files changed, 232 insertions(+)
> >=20
>=20
> As discussed with Changpeng on DPDK ML, we need a vhost-user protocol
> feature bit to back these new requests, else QEMU cannot whether the
> user backend implement these.
>=20
> With current and older DPDK version, if an unknown request is received,
> the socket connection is closed.
>=20
> Do we still have time before QEMU v2.12 is out?
>=20
> Thanks,
> Maxime

We certainly do, and I agree it's a concern as we get maintain
protocol extensions forever.

It's my bad that I forgot to check that there's a feature bit, but I
think we should act before the release.

There is probably time enough to add it - but if no one
can spare then time it would be better to disable the new messages in
QEMU for now than ship 2.12 without a feature bit.

I wonder what's Changpeng Liu's take on this.

--=20
MST
