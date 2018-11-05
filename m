Received: from eggs.gnu.org ([2001:4830:134:3::10]:34775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJfnP-0003CB-7V
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:24:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJfnK-0002im-5P
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 09:24:03 -0500
Date: Mon, 5 Nov 2018 15:18:38 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181105141838.GC10880@linux.fritz.box>
References: <20181019164929.18404-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181019164929.18404-1-mreitz@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] Various option help readability
 improvement suggestions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>

Am 19.10.2018 um 18:49 hat Max Reitz geschrieben:
> I noticed that with the (more or less) recent series from Marc-Andr=E9 =
the
> output of qemu-img amend -f qcow2 -o help changed to this:
>=20
> $ ./qemu-img amend -f qcow2 -o help
> Creation options for 'qcow2':
> qcow2-create-opts.backing_file=3Dstr - File name of a base image
> qcow2-create-opts.backing_fmt=3Dstr - Image format of the base image
> qcow2-create-opts.cluster_size=3Dsize - qcow2 cluster size
> qcow2-create-opts.compat=3Dstr - Compatibility level (0.10 or 1.1)
> [...]
>=20
> The types are a nice addition, but I didn't like having the list name
> printed in every single line (in fact, the list name does not make any
> sense here at all, because there already is a caption which reads
> "Creation options for 'qcow2'"), and I did not like the use of '=3D' fo=
r
> types.
>=20
> In general, I don't like the robot-y appearance, which is even worse in
> things like -device virtio-blk,help, which gives you this (among
> other lines):
>=20
> > virtio-blk-pci.iothread=3Dlink<iothread>
>=20
> Sadly, there isn't much we can do about the "link<iothread>", so this
> series doesn't improve on that point.
>=20
> What this series does do, however, is it changes these lists not to
> print the list name on every single line, but only as a caption (and fo=
r
> option lists, this caption is option, because the caller may want to
> print a custom caption that is more expressive -- as is the case for
> qemu-img amend -o help).
>=20
> Consequentially, all list items are indented by two spaces to make clea=
r
> they belong to the caption.  I can already see that some people might
> disagree on having this indentation, but I like it, so I have it in thi=
s
> series.
>=20
> Furthermore, types are now enclosed by angle brackets, and the alignmen=
t
> we originally had for descriptions is restored (although now after 24
> instead of 16 characters, because every option name is now accompanied
> by indentation and a type).
>=20
>=20
> Thus, after this series, the amend output looks like this:
>=20
> $ ./qemu-img amend -f qcow2 -o help
> Creation options for 'qcow2':
>   backing_file=3D<str>     - File name of a base image
>   backing_fmt=3D<str>      - Image format of the base image
>   cluster_size=3D<size>    - qcow2 cluster size
>   compat=3D<str>           - Compatibility level (0.10 or 1.1)
> [...]
>=20
>=20
> virtio-blk's list presents itself like so:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -device virtio-blk,help
> virtio-blk-pci options:
>   iothread=3D<link<iothread>>
>   request-merging=3D<bool> - on/off
>   secs=3D<uint32>
> [...]
>=20
>=20
> And now we even print something when there are no options:
>=20
> $ x86_64-softmmu/qemu-system-x86_64 -object can-bus,help
> There are no options for can-bus.
>=20
> (Before this series, there just is no output.)
>=20
>=20
> As a side effect, patch 1 fixes iotest 082.

Thanks, applied to the block branch.

Kevin
