Received: from eggs.gnu.org ([2001:4830:134:3::10]:47027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQZNA-00069T-TU
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQZN9-00071j-NS
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:25:12 -0400
Date: Wed, 6 Jun 2018 15:24:50 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180606142450.GH3064@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
	<20180606141356.0b86d6b4@kitsune.suse.cz>
	<95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
	<20180606154510.24be6ceb@kitsune.suse.cz>
	<20180606135010.GF3064@redhat.com>
	<20180606141432.GS7451@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606141432.GS7451@localhost.localdomain>
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Jun 06, 2018 at 11:14:32AM -0300, Eduardo Habkost wrote:
> On Wed, Jun 06, 2018 at 02:50:10PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Wed, Jun 06, 2018 at 03:45:10PM +0200, Michal Such=C3=A1nek wrote:
> > >=20
> > > I think that *if* we want an 'appliance' format that stores a whole=
 VM
> > > in a single file to ease VM distribution then the logical place to =
look
> > > in qemu is qcow. The reason have been explained at length.
> >=20
> > I rather disagree. This is a common problem beyond just QEMU and ever=
yone
> > just uses an existing archive format (TAR, ZIP) for bundling together
> > one or more disk images, metdata for config, and whatever other resou=
rces
> > are applicable for the vendor.  This works with any disk format (raw,
> > qcow2, vmdk, vpc, etc) so is preferrable to inventing someting that i=
s
> > specific to qcow2 IMHO.
>=20
> Now we have N+1 appliance file formats.  :)
>=20
> (We like it or not, qcow2 is already used as an appliance format
> for single-disk VMs in practice.)
>=20
> But I agree this must not be specific to qcow2.  The same VM
> description format we agree upon should work with other disk
> formats or with multi-disk appliances.
>=20
> If we specify a reasonable VM description format for appliances
> and make it work inside (e.g.) tar files, we will still have the
> option of allowing the description be placed inside qcow2 if we
> really want to.  I don't think we need to finish this qcow2
> bikeshedding exercise right now.

Yes, I think that is sensible, as once we actually try it out in real
world cases, we might then find a tar/zip is sufficient after all and
we don't need to do something extra for qcow2. Also means we can do
experiments without committing to a qcow2 format spec change right
away.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
