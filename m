Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQYpY-0004iZ-Qp
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:50:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQYpX-0003iX-8q
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 09:50:28 -0400
Date: Wed, 6 Jun 2018 14:50:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180606135010.GF3064@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <2b3eef00-f326-c1e6-0e4b-b7602646eec4@redhat.com>
	<20180606123237.2235ae4a@kitsune.suse.cz>
	<bc97cdc3-85ba-e053-0816-b6bc431064fb@redhat.com>
	<20180606131929.44d0fd6b@kitsune.suse.cz>
	<93233bff-604b-c891-90ce-64fe1eaaaab5@redhat.com>
	<20180606134327.05de9616@kitsune.suse.cz>
	<94cea1d9-d934-85d1-66d4-dbfc82b8dd53@redhat.com>
	<20180606141356.0b86d6b4@kitsune.suse.cz>
	<95f92a95-6592-27a2-a822-d3a047cf8339@redhat.com>
	<20180606154510.24be6ceb@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180606154510.24be6ceb@kitsune.suse.cz>
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
To: Michal =?utf-8?B?U3VjaMOhbmVr?= <msuchanek@suse.de>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, stefanha@redhat.com

On Wed, Jun 06, 2018 at 03:45:10PM +0200, Michal Such=C3=A1nek wrote:
>=20
> I think that *if* we want an 'appliance' format that stores a whole VM
> in a single file to ease VM distribution then the logical place to look
> in qemu is qcow. The reason have been explained at length.

I rather disagree. This is a common problem beyond just QEMU and everyone
just uses an existing archive format (TAR, ZIP) for bundling together
one or more disk images, metdata for config, and whatever other resources
are applicable for the vendor.  This works with any disk format (raw,
qcow2, vmdk, vpc, etc) so is preferrable to inventing someting that is
specific to qcow2 IMHO.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
