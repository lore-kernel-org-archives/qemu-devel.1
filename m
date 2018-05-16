Received: from eggs.gnu.org ([2001:4830:134:3::10]:44995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIxWf-0000sg-Oj
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=66789f4f5=Paul.Durrant@citrix.com>)
	id 1fIxWe-0004Jm-V2
	for qemu-devel@nongnu.org; Wed, 16 May 2018 10:35:33 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 16 May 2018 14:34:18 +0000
Message-ID: <e329750eb00e48b7882aeb8a30b78412@AMSPEX02CL03.citrite.net>
References: <1525461967-32174-1-git-send-email-paul.durrant@citrix.com>
	<1525461967-32174-5-git-send-email-paul.durrant@citrix.com>
	<20180516143032.GI2057@perard.uk.xensource.com>
In-Reply-To: <20180516143032.GI2057@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3 4/8] xen_backend: add an emulation of
 grant copy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefano Stabellini <sstabellini@kernel.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 16 May 2018 15:31
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-block@nongnu.org; qemu-
> devel@nongnu.org; Stefano Stabellini <sstabellini@kernel.org>
> Subject: Re: [PATCH v3 4/8] xen_backend: add an emulation of grant copy
>=20
> On Fri, May 04, 2018 at 08:26:03PM +0100, Paul Durrant wrote:
> > Not all Xen environments support the xengnttab_grant_copy() operation.
> > E.g. where the OS is FreeBSD or Xen is older than 4.8.0.
> >
> > This patch introduces an emulation of that operation using
> > xengnttab_map_domain_grant_refs() and memcpy() for those
> environments.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
> > ---
>=20
> The patch looks ok, but since patch 1 is going to be change, this one is
> going to need to be change as well.
>=20

Sure. Thanks for the review.

  Paul

> --
> Anthony PERARD
