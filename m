Received: from eggs.gnu.org ([2001:4830:134:3::10]:47630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUZr7-000768-M4
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:16:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUZr5-0001pG-2v
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 11:16:56 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 5 Dec 2018 16:16:41 +0000
Message-ID: <1d11969268384be0b8c988911da69e23@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-8-paul.durrant@citrix.com>
	<20181203162424.GM14786@perard.uk.xensource.com>
	<20181204142459.GV14786@perard.uk.xensource.com>
In-Reply-To: <20181204142459.GV14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 07/18] xen: add event channel interface for
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
> Sent: 04 December 2018 14:25
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH 07/18] xen: add event channel interface for XenDevice=
-
> s
>=20
> On Mon, Dec 03, 2018 at 04:24:24PM +0000, Anthony PERARD wrote:
> > On Wed, Nov 21, 2018 at 03:12:00PM +0000, Paul Durrant wrote:
> > > +static void xen_device_event(void *opaque)
> > > +{
> > > +    XenDevice *xendev =3D opaque;
> > > +    unsigned long port =3D xenevtchn_pending(xendev->xeh);
> > > +
> > > +    notifier_list_notify(&xendev->event_notifiers, (void *)port);
> >
> > I wonder if a Notifier is a good fit for XenDevice, like here for the
> > events or the xenstore watches in previous patches, as NotifierLists ar=
e
> > normaly used when every Notifiers want to do something, but here there
> > is only one that is going to do something. But I guess it might not be
> > much better to write a loop in here rather than use the one in
> > notifier_list_notify.
>=20
> I've seen that you use GHashTable in a following patch, wouldn't that be
> useful to use for xenstore watches and evtchn events as well?
>=20

There's precedent for using Notifier lists for this kind of thing. A hash t=
able may be an optimization but I'd rather stick with the lists for now... =
I know they work :-)

  Paul

>=20
> --
> Anthony PERARD
