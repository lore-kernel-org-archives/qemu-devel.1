Received: from eggs.gnu.org ([2001:4830:134:3::10]:46217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUZnA-000434-Kb
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:12:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUZn9-0004yF-Af
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:12:52 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 5 Dec 2018 16:12:30 +0000
Message-ID: <ceb50d9d9889439e98614ce0f00bacd5@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-7-paul.durrant@citrix.com>
	<20181203154556.GL14786@perard.uk.xensource.com>
In-Reply-To: <20181203154556.GL14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 06/18] xen: add grant table interface for
 XenDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 03 December 2018 15:46
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 06/18] xen: add grant table interface for XenDevice-s
>=20
> On Wed, Nov 21, 2018 at 03:11:59PM +0000, Paul Durrant wrote:
> > The legacy PV backend infrastructure provides functions to map, unmap
> and
> > copy pages granted by frontends. Similar functionality will be required
> > by XenDevice implementations so this patch adds the necessary support.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
> > +typedef struct XenDeviceGrantCopySegment {
> > +    union {
> > +        void *virt;
> > +        struct {
> > +            uint32_t ref;
> > +            off_t offset;
> > +        } foreign;
> > +    } source, dest;
>=20
> Why is there a union between `source` and `dest`, I don't see any way
> (another field) to distinguish which is which. Can't we have a
> segment without `source`/`dest`?

How? I think introducing two separate segment definitions depending on whet=
her it is a copy-to-guest or copy-from-guest is a little ugly.

> It mimic the
> xengnttab_grant_copy_segment_t but that doesn't seems very useful as it
> doesn't really prevent mistake.

It mimics that struct apart from the field static which direction the trans=
fer is because, to maintain compatibility, the entire copy goes only one wa=
y or the other.

>=20
> > +    size_t len;
> > +} XenDeviceGrantCopySegment;
>=20
> Anyway, it's not very important:
>=20
> Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks.

  Paul

>=20
> Thanks,
>=20
> --
> Anthony PERARD
