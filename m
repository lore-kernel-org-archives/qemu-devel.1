Received: from eggs.gnu.org ([2001:4830:134:3::10]:46777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQXZ8-0001Rn-U4
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:29:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fQXZ7-0006wp-IG
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:29:26 -0400
Date: Wed, 6 Jun 2018 13:29:13 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180606122913.GI1455@redhat.com>
References: <20180528183833.GJ4580@localhost.localdomain>
	<20180528212054.GH2209@redhat.com>
	<20180528212510.GC4660@redhat.com>
	<20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm> <20180606114228.GH1455@redhat.com>
	<20180606114817.GC3064@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606114817.GC3064@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Wed, Jun 06, 2018 at 12:48:17PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jun 06, 2018 at 12:42:28PM +0100, Richard W.M. Jones wrote:
> > On Wed, Jun 06, 2018 at 12:14:07PM +0100, Dr. David Alan Gilbert wrot=
e:
> > > The problem with having a separate file is that you either have to =
copy
> > > it around with the image or have an archive.  If you have an archiv=
e
> > > you have to have an unpacking step which then copies, potentially a=
 lot
> > > of data taking some reasonable amount of time.  Storing a simple bi=
t
> > > of data with the image avoids that.
> >=20
> > This isn't really true.  For OVA (ie. tar) we don't unpack them.
> > Adding file.offset and file.size in qemu's raw driver was crucial to
> > that optimization.
>=20
> Though that assumes you're only using the qcow2 file in read-only mode.
> As soon as you need write access you need to unpack from the OVA so tha=
t
> the qcow2 file can grow its length when new sectors are allocated.

Sure but you cannot write to an OVA anyway because it contains
embedded checksums.

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
