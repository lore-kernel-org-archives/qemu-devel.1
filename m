Received: from eggs.gnu.org ([2001:4830:134:3::10]:44141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQZDU-0007Dp-M3
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fQZDT-0002co-TA
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 10:15:12 -0400
Date: Wed, 6 Jun 2018 11:14:32 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180606141432.GS7451@localhost.localdomain>
References: <20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
	<20180606141356.0b86d6b4@kitsune.suse.cz>
	<95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
	<20180606154510.24be6ceb@kitsune.suse.cz>
	<20180606135010.GF3064@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180606135010.GF3064@redhat.com>
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
Cc: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Jun 06, 2018 at 02:50:10PM +0100, Daniel P. Berrang=E9 wrote:
> On Wed, Jun 06, 2018 at 03:45:10PM +0200, Michal Such=E1nek wrote:
> >=20
> > I think that *if* we want an 'appliance' format that stores a whole V=
M
> > in a single file to ease VM distribution then the logical place to lo=
ok
> > in qemu is qcow. The reason have been explained at length.
>=20
> I rather disagree. This is a common problem beyond just QEMU and everyo=
ne
> just uses an existing archive format (TAR, ZIP) for bundling together
> one or more disk images, metdata for config, and whatever other resourc=
es
> are applicable for the vendor.  This works with any disk format (raw,
> qcow2, vmdk, vpc, etc) so is preferrable to inventing someting that is
> specific to qcow2 IMHO.

Now we have N+1 appliance file formats.  :)

(We like it or not, qcow2 is already used as an appliance format
for single-disk VMs in practice.)

But I agree this must not be specific to qcow2.  The same VM
description format we agree upon should work with other disk
formats or with multi-disk appliances.

If we specify a reasonable VM description format for appliances
and make it work inside (e.g.) tar files, we will still have the
option of allowing the description be placed inside qcow2 if we
really want to.  I don't think we need to finish this qcow2
bikeshedding exercise right now.

--=20
Eduardo
