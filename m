Received: from eggs.gnu.org ([2001:4830:134:3::10]:38925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWk9X-0004cU-GF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=87697dac6=Paul.Durrant@citrix.com>)
	id 1gWk9T-0003IS-Ao
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 10:40:55 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Tue, 11 Dec 2018 15:40:30 +0000
Message-ID: <88b1bbdbad294bf5b4013fd144534651@AMSPEX02CL03.citrite.net>
References: <1544525238-3527-1-git-send-email-paul.durrant@citrix.com>
	<1544525238-3527-4-git-send-email-paul.durrant@citrix.com>
	<20181211151636.GQ18875@perard.uk.xensource.com>
In-Reply-To: <20181211151636.GQ18875@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 03/18] xen: introduce 'xen-block',
 'xen-disk' and 'xen-cdrom'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 11 December 2018 15:17
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; qemu-block@nongnu.org; xen-
> devel@lists.xenproject.org; Kevin Wolf <kwolf@redhat.com>; Max Reitz
> <mreitz@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v3 03/18] xen: introduce 'xen-block', 'xen-disk' and
> 'xen-cdrom'
>=20
> On Tue, Dec 11, 2018 at 10:47:03AM +0000, Paul Durrant wrote:
> > This patch adds new XenDevice-s: 'xen-disk' and 'xen-cdrom', both
> derived
> > from a common 'xen-block' parent type. These will eventually replace th=
e
> > 'xen_disk' (note the underscore rather than hyphen) legacy PV backend
> but
> > it is illustrative to build up the implementation incrementally, along
> with
> > the XenBus/XenDevice framework. Subsequent patches will therefore add t=
o
> > these devices' implementation as new features are added to the
> framework.
> >
> > After this patch has been applied it is possible to instantiate new
> > 'xen-disk' or 'xen-cdrom' devices with a single 'vdev' parameter, which
> > accepts values adhering to the Xen VBD naming scheme [1]. For example, =
a
> > command-line instantiation of a xen-disk can be done with an argument
> > similar to the following:
> >
> > -device xen-disk,vdev=3Dhda
> >
> > The implementation of the vdev parameter formulates the appropriate VBD
> > number for use in the PV protocol.
> >
> > [1] https://xenbits.xen.org/docs/unstable/man/xen-vbd-interface.7.html
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> Now we can add a xen-disk with vdev=3Dxvdbgqcv :)

Yep, you can keep going until xenstore explodes :-)

  Paul

>=20
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
>=20
> Thanks,
>=20
> --
> Anthony PERARD
