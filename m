Received: from eggs.gnu.org ([2001:4830:134:3::10]:45837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqIZ0-0006cx-BG
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:06:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cqIYx-00060P-Il
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:06:58 -0400
Received: from 15.mo5.mail-out.ovh.net ([178.33.107.29]:36871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cqIYx-00060F-9j
	for qemu-devel@nongnu.org; Tue, 21 Mar 2017 08:06:55 -0400
Received: from player695.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id A6D68E0703
	for <qemu-devel@nongnu.org>; Tue, 21 Mar 2017 13:06:53 +0100 (CET)
Date: Tue, 21 Mar 2017 13:06:46 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170321130646.7609eb01@bahia.lan>
In-Reply-To: <d149478f-fb4e-6699-5508-570a5bf27869@huawei.com>
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<a08674d1-0f08-b8fb-aa11-c971042ac58a@redhat.com>
	<d149478f-fb4e-6699-5508-570a5bf27869@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/2F5RyraMvTBLtdB0FaiCmYa";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Eric Blake <eblake@redhat.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

--Sig_/2F5RyraMvTBLtdB0FaiCmYa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Mar 2017 10:44:32 +0100
Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> wrote:

> Hi Eric,
>=20
> Thanks for having a look at the patch. My answers are inline.
>=20
> > On 03/20/2017 08:07 AM, Pradeep Jagadeesh wrote: =20
> >> This patchset enables qmp interfaces for the 9pfs
> >> devices (fsdev).This provides two interfaces one =20
> >
> > Space between English sentences, after '.' =20
> OK
> > =20
> >> for querying all the 9pfs devices info. The second one
> >> to set the IO limits for the required 9pfs device.
> >>
> >> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> >> --- =20
> > =20
> >> +++ b/qapi-schema.json
> >> @@ -81,6 +81,9 @@
> >>  # QAPI block definitions
> >>  { 'include': 'qapi/block.json' }
> >>
> >> +# QAPI 9pfs definitions
> >> +{ 'include': 'qapi/9pfs.json' }
> >> +
> >>  # QAPI event definitions
> >>  { 'include': 'qapi/event.json' }
> >>
> >> diff --git a/qapi/9pfs.json b/qapi/9pfs.json
> >> new file mode 100644
> >> index 0000000..c068474
> >> --- /dev/null
> >> +++ b/qapi/9pfs.json
> >> @@ -0,0 +1,169 @@
> >> +# -*- Mode: Python -*-
> >> +
> >> +##
> >> +# =3D=3D QAPI 9p definitions
> >> +##
> >> +
> >> +# QAPI common definitions
> >> +{ 'include': 'common.json' }
> >> +
> >> +##
> >> +# @fs9p_set_io_throttle:
> >> +#
> >> +# Change I/O limits for a 9p/fsdev device.
> >> +#
> >> +# Since QEMU 2.9, I/0 limits can be enabled on each  fsdev(9pfs) devi=
ce =20
> >
> > This says 2.9... =20
> I meant that, the qemu cli io throttle facility for 9p/fsdev is enabled=20
> in 2.9.But the qmp interfaces are from 2.10.

QMP users don't care about the cli API. The only important thing is:

Since: 2.10

The curious will find out about the background in git log, no need to
mention this in the *code*.

> > =20
> >> +#
> >> +# I/O limits can be disabled by setting all of them to 0.
> >> +#
> >> +# Returns: Nothing on success
> >> +#          If @device is not a valid 9p device, DeviceNotFound
> >> +#
> >> +# Since: 2:10 =20
> >
> > ...but this says 2:10 (typo, should be 2.10).  No need to mention the
> > version twice, especially if one of them is wrong (keep the Since: line=
). =20
> OK, mentioned above.
> > =20
> >> +#
> >> +# Example:
> >> +#
> >> +# -> { "execute": "fs9p_set_io_throttle",
> >> +#      "arguments": { "device": "ide0-1-0",
> >> +#                     "bps": 1000000,
> >> +#                     "bps_rd": 0,
> >> +#                     "bps_wr": 0,
> >> +#                     "iops": 0,
> >> +#                     "iops_rd": 0,
> >> +#                     "iops_wr": 0,
> >> +#                     "bps_max": 8000000,
> >> +#                     "bps_rd_max": 0,
> >> +#                     "bps_wr_max": 0,
> >> +#                     "iops_max": 0,
> >> +#                     "iops_rd_max": 0,
> >> +#                     "iops_wr_max": 0,
> >> +#                     "bps_max_length": 60,
> >> +#                     "iops_size": 0 } }
> >> +# <- { "returns": {} }
> >> +##
> >> +{ 'command': 'fs9p_set_io_throttle', 'boxed': true,
> >> +  'data': 'FS9PIOThrottle' } =20
> >
> > New commands and members should be named with '-' rather than '_' as the
> > word separator, so this should be 'fs9p-set-io-throttle', 'bps-rd', etc=
. =20
> OK, I will change.
>=20
> >> +##
> >> +# @FS9PIOThrottle:
> >> +#
> >> +# A set of parameters describing block
> >> +#
> >> +# @device: Block device name
> >> +#
> >> +# @bps: total throughput limit in bytes per second
> >> +#
> >> +# @bps_rd: read throughput limit in bytes per second
> >> +#
> >> +# @bps_wr: write throughput limit in bytes per second
> >> +#
> >> +# @iops: total I/O operations per second
> >> +#
> >> +# @iops_rd: read I/O operations per second
> >> +#
> >> +# @iops_wr: write I/O operations per second
> >> +#
> >> +# @bps_max: total throughput limit during bursts,
> >> +#                     in bytes (Since 1.7) =20
> >
> > You're introducing this struct in 2.10, so this member is not since 1.7.
> >  Either that, or you're copying-and-pasting when you should be sharing
> > code and reusing an existing struct. =20
> Hmm..copied the block devices code, I will correct it.
> I thought of reusing the code, but the whole struct from block devices=20
> can not be used, as there is one member called "group" that is not used=20
> in case of 9p. Also this needs lot of changes even in case of block=20
> devices. Because I may need to rename the structure as IOThrottle or=20
> something like that.
> Shall I reuse the code and avoid setting the group member in case of 9p?
> What do you think?

The code factoring would affect:
- hmp_9pfs_set_io_throttle() which looks identical to the existing
  hmp_block_set_io_throttle() function
- a bunch of lines to handle the throttle arguments in fsdev_set_io_throttl=
e()
  which are the same as in qmp_block_set_io_throttle(). And BTW, a similar
  refactoring seems doable in the cli API between fsdev_throttle_parse_opts=
()
  and extract_common_blockdev_options().

This being said, I don't know what this would mean with json files.

> >
> > =20
> >> +#
> >> +# Since: 2.10
> >> +##
> >> +{ 'struct': 'FS9PIOThrottle',
> >> +  'data': { '*device': 'str', 'bps': 'int', 'bps_rd': 'int',
> >> +            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_w=
r': 'int',
> >> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> >> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> >> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> >> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> >> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> >> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int=
',
> >> +            '*iops_size': 'int' } } =20
> >
> > If you reuse an existing struct that uses _ instead of -, then that
> > explains your naming.  But in that case, why do you need to declare a
> > new (copied) struct, instead of just reusing the existing one?
> > =20
> Explained in above comment.
> >> +
> >> +##
> >> +# @query-9pfs-io-throttle:
> >> +#
> >> +# Return a list of information about each iothread
> >> +#
> >> +# Returns: @FS9PIOIOThrottle
> >> +#
> >> +# Since: 2.10
> >> +#
> >> +# Example:
> >> +#
> >> +# -> { "Execute": "query-9pfs-io-throttle" }
> >> +# <- { "returns" : [
> >> +#          {
> >> +#             "device": "ide0-hd0",
> >> +#              "bps":1000000,
> >> +#              "bps_rd":0,
> >> +#              "bps_wr":0,
> >> +#              "iops":1000000,
> >> +#              "iops_rd":0,
> >> +#              "iops_wr":0,
> >> +#              "bps_max": 8000000,
> >> +#              "bps_rd_max": 0,
> >> +#              "bps_wr_max": 0, =20
> >
> > You are not consistent on whether to include a space after ':'.  The
> > easiest way to get this right is to paste actual output from pretty qmp
> > mode. =20
> I will fix this.
> > =20
> >> +#              "iops_max": 0,
> >> +#              "iops_rd_max": 0,
> >> +#              "iops_wr_max": 0,
> >> +#              "bps_max_length": 0,
> >> +#              "bps_rd_max_length": 0,
> >> +#              "bps_wr_max_length": 0,
> >> +#              "iops_max_length": 0,
> >> +#              "iops_rd_max_length": 0,
> >> +#              "iops_wr_max_length": 0,
> >> +#              "iops_size": 0,
> >> +#            } =20
> >
> > This is not valid JSON. No trailing commas. =20
> Will fix
> > =20
> >> +#          ]
> >> +#      }
> >> +#
> >> +##
> >> +{ 'command': 'query-9pfs-io-throttle', 'returns': [ 'FS9PIOThrottle' =
] }
> >> +

.git/rebase-apply/patch:631: new blank line at EOF.
+
warning: 1 line adds whitespace errors.

> >> =20
> > =20
>=20


--Sig_/2F5RyraMvTBLtdB0FaiCmYa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAljRF1YACgkQAvw66wEB28LzcwCglrcfwNAqDDFHhZggnM+QagOq
LuMAn1jeLRO0YgV1bUk1cnPfMusnLKkP
=ovLk
-----END PGP SIGNATURE-----

--Sig_/2F5RyraMvTBLtdB0FaiCmYa--
