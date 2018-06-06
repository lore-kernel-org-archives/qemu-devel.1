Received: from eggs.gnu.org ([2001:4830:134:3::10]:38890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQXAS-0003a5-Sf
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQXAR-0002X3-Mm
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 08:03:56 -0400
Date: Wed, 6 Jun 2018 13:03:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606120346.GC2661@work-vm>
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
Cc: "Richard W.M. Jones" <rjones@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
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

And the person creating the OVA has to do that taring rather than just
take the qcow2 they've just used in the VM.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
