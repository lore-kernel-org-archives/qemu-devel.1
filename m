Received: from eggs.gnu.org ([2001:4830:134:3::10]:44392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1err9m-0005KK-In
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:19:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1err9j-0005K8-FD
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:19:54 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42906 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1err9j-0005Jo-AO
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 15:19:51 -0500
Date: Fri, 2 Mar 2018 22:19:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302221831-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
	<c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
	<7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] virtio-net: add linkspeed and duplex
 settings to virtio-net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

On Fri, Mar 02, 2018 at 03:14:01PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B403=E6=9C=8802=E6=97=A5 11:46, Jason Baron wrote:
> > Although linkspeed and duplex can be set in a linux guest via 'ethtoo=
l -s',
> > this requires custom ethtool commands for virtio-net by default.
> >=20
> > Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> > the hypervisor to export a linkspeed and duplex setting. The user can
> > subsequently overwrite it later if desired via: 'ethtool -s'.
> >=20
> > Linkspeed and duplex settings can be set as:
> > '-device virtio-net,speed=3D10000,duplex=3Dfull'
>=20
> I was thinking whether or not it's better to decide the duplex by the t=
ype
> of backends.
>=20
> E.g userspace and vhost-kernel implement a in fact half duplex. But dpd=
k
> implement a full duplex.
>=20
> Thanks

OTOH it's a priority for some people to be able to support migration
between different backend types. Breaking that won't be nice.

> >=20
> > where speed is [0...INT_MAX], and duplex is ["half"|"full"].
> >=20
> > Signed-off-by: Jason Baron<jbaron@akamai.com>
> > Cc: "Michael S. Tsirkin"<mst@redhat.com>
> > Cc: Jason Wang<jasowang@redhat.com>
> > Cc:virtio-dev@lists.oasis-open.org
> > ---
