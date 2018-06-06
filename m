Received: from eggs.gnu.org ([2001:4830:134:3::10]:52912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZeI-0001Ae-Ig
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQZeG-0007AJ-QT
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:42:54 -0400
Date: Wed, 6 Jun 2018 15:42:43 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180606144242.GI2660@work-vm>
References: <20180529064415.GA4756@localhost.localdomain>
	<2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180605092159.GA2544@work-vm>
	<46ef4200-eccf-7e65-d3a0-69e4a7414b51@redhat.com>
	<20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm> <20180606143737.GI3064@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606143737.GI3064@redhat.com>
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
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, armbru@redhat.com, qemu-devel@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Wed, Jun 06, 2018 at 03:31:35PM +0100, Dr. David Alan Gilbert wrote:
> > > Not in this case because it'd still be a flat qcow2 file in a simpl=
e tar
> > > archive.
> > >=20
> > > But you're right if we had a more complex format (like chunks store=
d in
> > > a tar file).
> >=20
> > My only problem with using the tar like that is that all tools
> > everywhere would need to be updated to be able to parse them.
>=20
> I feel it is the opposite actually. By adding named blobs or custom
> strings to qcow2, we've effectively invented a new type of archive
> format, except apps cant use the normal unzip/tar tools/apis they
> already have. Instead they need to use qemu-img to read,add,remove
> blobs from qcow2. It is very compelling to use an existing archive
> format like tar/zip because every language has APIs for dealing
> with them and apps probably already do this for things like OVA.

My thinking was that a qcow2 with this extra data would still work in
all our existing systems.

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
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
