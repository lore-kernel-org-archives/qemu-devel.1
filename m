Received: from eggs.gnu.org ([2001:4830:134:3::10]:48398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=345d44fce=Paul.Durrant@citrix.com>)
	id 1dQCSp-00067C-M7
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=345d44fce=Paul.Durrant@citrix.com>)
	id 1dQCSl-0003CH-MN
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:52:59 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Wed, 28 Jun 2017 12:52:52 +0000
Message-ID: <b511055d35bc4e4388e0bf43261e20d4@AMSPEX02CL03.citrite.net>
References: <20170621125249.8805-1-paul.durrant@citrix.com>
	<alpine.DEB.2.10.1706271506420.24648@sstabellini-ThinkPad-X260>
In-Reply-To: <alpine.DEB.2.10.1706271506420.24648@sstabellini-ThinkPad-X260>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v2 0/3] xen-disk: performance
 improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

> -----Original Message-----
> From: Stefano Stabellini [mailto:sstabellini@kernel.org]
> Sent: 27 June 2017 23:07
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: xen-devel@lists.xenproject.org; qemu-devel@nongnu.org; qemu-
> block@nongnu.org
> Subject: Re: [Xen-devel] [PATCH v2 0/3] xen-disk: performance
> improvements
>=20
> On Wed, 21 Jun 2017, Paul Durrant wrote:
> > Paul Durrant (3):
> >   xen-disk: only advertize feature-persistent if grant copy is not
> >     available
> >   xen-disk: add support for multi-page shared rings
> >   xen-disk: use an IOThread per instance
> >
> >  hw/block/trace-events |   7 ++
> >  hw/block/xen_disk.c   | 228
> +++++++++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 188 insertions(+), 47 deletions(-)
>=20
> While waiting for an answer on patch #3, I sent a pull request for the
> first 2 patches

Cool. Thanks. Hopefully we won't have to wait too long for review on patch =
#3.

  Cheers,

    Paul
