Received: from eggs.gnu.org ([2001:4830:134:3::10]:35908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSuL-000165-MK
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 19:38:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gJSiE-0002Vh-Ox
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 19:25:51 -0500
References: <20181019164929.18404-1-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4f706491-2583-d74a-14e8-6d55bffd6b94@redhat.com>
Date: Mon, 5 Nov 2018 01:25:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181019164929.18404-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vmSE3lASOvoktWUQ1y3zi4RiNufGR2jLk"
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
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vmSE3lASOvoktWUQ1y3zi4RiNufGR2jLk
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <4f706491-2583-d74a-14e8-6d55bffd6b94@redhat.com>
Subject: Re: [PATCH v2 0/5] Various option help readability improvement
 suggestions
References: <20181019164929.18404-1-mreitz@redhat.com>
In-Reply-To: <20181019164929.18404-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ping.  I don't quite want the help output to change in 3.1 only to
change it to something else in 3.2.

(And at some point into freeze we have to consider just merging one of
the many simple 082 reference output "fixes", which I really don't want,
because I still consider the test "broken for a reason"(tm).)

Max


On 19.10.18 18:49, Max Reitz wrote:
> I noticed that with the (more or less) recent series from Marc-Andr=C3=A9=
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
> In general, I don't like the robot-y appearance, which is even worse in=

> things like -device virtio-blk,help, which gives you this (among
> other lines):
>=20
>> virtio-blk-pci.iothread=3Dlink<iothread>
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
>=20
>=20
> v2:
> - Patch 1:
>   - Abandon the "$name: $type" formatting in favor of "$name=3D<$type>"=

>     [Marc-Andr=C3=A9, at least the "abandon" part]
>   - Restore description alignment [Kevin]
>   - Do the alignment when generating each line's GString instead of whe=
n
>     printing them.  This results in less lines modified and allows the
>     compiler to optimize the printf("%s\n", x) to puts(x).
> - Patch 3:
>   - Same changes as above, with the addition of also separating the
>     description with " - " instead of enclosing it in parentheses (to
>     match the other places)
>   - Also, we never did align the descriptions here, so this is not
>     "restore" but "introduce description alignment".
> - Patch 4:
>   - Same as patch 1, but again with the catch of s/restore/introduce/.
>=20
>=20
> git-backport-diff against v1:
>=20
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream p=
atch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences, resp=
ectively
>=20
> 001/5:[0963] [FC] 'option: Make option help nicer to read'
> 002/5:[----] [--] 'chardev: Indent list of chardevs'
> 003/5:[0008] [FC] 'qdev-monitor: Make device options help nicer'
> 004/5:[0007] [FC] 'object: Make option help nicer to read'
> 005/5:[----] [--] 'fw_cfg: Drop newline in @file description'
>=20
>=20
> Max Reitz (5):
>   option: Make option help nicer to read
>   chardev: Indent list of chardevs
>   qdev-monitor: Make device options help nicer
>   object: Make option help nicer to read
>   fw_cfg: Drop newline in @file description
>=20
>  include/qemu/option.h      |   2 +-
>  chardev/char.c             |   2 +-
>  qdev-monitor.c             |  13 +-
>  qemu-img.c                 |   4 +-
>  util/qemu-option.c         |  32 +-
>  vl.c                       |  15 +-
>  tests/qemu-iotests/082.out | 956 ++++++++++++++++++-------------------=

>  7 files changed, 530 insertions(+), 494 deletions(-)
>=20



--vmSE3lASOvoktWUQ1y3zi4RiNufGR2jLk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlvfjgMACgkQ9AfbAGHV
z0DXFwf+IjDh0fnnDv5KBkqiy6Q9MpPfZLI96Mwj8Yo99OkjqjYi3ZScXjpunr7i
NHWtw1pQOYruwAfvDq+xTEoGIpubwoYkmYZN+eY8xu07gZy4inuRhZifONLhV7Oh
4Hp1H8RZCdrdxh+8NRQYVFtJcuWIZPXobC1+6hQZ5gj2Wr1a2Fu0WAFb42zp5jUO
TX/6leO65NZsHSwIqgxuJtAgYh1zAGvM+63kkIi/6WoOXMtKyJC3ZwgF3c2tIaeT
ATZskhrr7nDpUhihAL4UQMoO3QqK//pTeqVZWiKReAB2yeKo9fbFrec+WCFxEQHt
1fnsXca7JsvJPFBhCVvapfZHayYozw==
=a139
-----END PGP SIGNATURE-----

--vmSE3lASOvoktWUQ1y3zi4RiNufGR2jLk--
