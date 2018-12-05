Received: from eggs.gnu.org ([2001:4830:134:3::10]:46042)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUazO-0005d9-4i
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:29:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=870045bc7=Paul.Durrant@citrix.com>)
	id 1gUazN-00089y-4n
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 12:29:33 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 5 Dec 2018 17:28:54 +0000
Message-ID: <492a875458194132b54ddbe4a690b26b@AMSPEX02CL03.citrite.net>
References: <20181121151211.15997-1-paul.durrant@citrix.com>
	<20181121151211.15997-14-paul.durrant@citrix.com>
	<20181204121041.GT14786@perard.uk.xensource.com>
In-Reply-To: <20181204121041.GT14786@perard.uk.xensource.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 13/18] xen: purge 'blk' and 'ioreq' from
 function names in dataplane/xen-qdisk.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Perard <anthony.perard@citrix.com>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 04 December 2018 12:11
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-block@nongnu.org; qemu-devel@nongnu.org; xen-
> devel@lists.xenproject.org; Stefano Stabellini <sstabellini@kernel.org>;
> Stefan Hajnoczi <stefanha@redhat.com>; Kevin Wolf <kwolf@redhat.com>; Max
> Reitz <mreitz@redhat.com>
> Subject: Re: [PATCH 13/18] xen: purge 'blk' and 'ioreq' from function
> names in dataplane/xen-qdisk.c
>=20
> On Wed, Nov 21, 2018 at 03:12:06PM +0000, Paul Durrant wrote:
> > This is a purely cosmetic patch that purges remaining use of 'blk' and
> > 'ioreq' in local function names.
> >
> > No functional change.
> >
> > Signed-off-by: Paul Durrant <paul.durrant@citrix.com>
>=20
> I don't think it's a good idee to use function names that could be use
> elsewhere, don't have a namespace. It makes it more difficult to figure
> out which function is called by just searching for the function name.
>=20
> Could you had a prefix?
> Maybe xendisk_ or xen_disk or xen_qdisk or xen_block or ..., so we can
> have xendisk_start_request, or xendisk_request_start. I don't have a
> preference beside staying away from generic names.
>=20

I'll add a xen_block_ prefix.

  Paul

> Thanks,
>=20
> --
> Anthony PERARD
