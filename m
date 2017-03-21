Received: from eggs.gnu.org ([2001:4830:134:3::10]:40996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8OH-0003Kj-M5
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq8OD-0006Yf-MM
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:15:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48464)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cq8OD-0006X8-DN
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 21:15:09 -0400
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a08674d1-0f08-b8fb-aa11-c971042ac58a@redhat.com>
Date: Mon, 20 Mar 2017 20:15:06 -0500
MIME-Version: 1.0
In-Reply-To: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="24387KRof5uRkPQ9tBU2Wck58bwObkxvj"
Subject: Re: [Qemu-devel] [PATCH v0] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--24387KRof5uRkPQ9tBU2Wck58bwObkxvj
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 Alberto Garcia <berto@igalia.com>, Jani Kokkonen <jani.kokkonen@huawei.com>,
 qemu-devel@nongnu.org
Message-ID: <a08674d1-0f08-b8fb-aa11-c971042ac58a@redhat.com>
Subject: Re: [PATCH v0] fsdev: QMP interface for throttling
References: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1490015240-49118-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/20/2017 08:07 AM, Pradeep Jagadeesh wrote:
> This patchset enables qmp interfaces for the 9pfs=20
> devices (fsdev).This provides two interfaces one=20

Space between English sentences, after '.'

> for querying all the 9pfs devices info. The second one
> to set the IO limits for the required 9pfs device.
>=20
> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
> ---

> +++ b/qapi-schema.json
> @@ -81,6 +81,9 @@
>  # QAPI block definitions
>  { 'include': 'qapi/block.json' }
> =20
> +# QAPI 9pfs definitions
> +{ 'include': 'qapi/9pfs.json' }
> +
>  # QAPI event definitions
>  { 'include': 'qapi/event.json' }
> =20
> diff --git a/qapi/9pfs.json b/qapi/9pfs.json
> new file mode 100644
> index 0000000..c068474
> --- /dev/null
> +++ b/qapi/9pfs.json
> @@ -0,0 +1,169 @@
> +# -*- Mode: Python -*-
> +
> +##
> +# =3D=3D QAPI 9p definitions
> +##
> +
> +# QAPI common definitions
> +{ 'include': 'common.json' }
> +
> +##
> +# @fs9p_set_io_throttle:
> +#
> +# Change I/O limits for a 9p/fsdev device.
> +#
> +# Since QEMU 2.9, I/0 limits can be enabled on each  fsdev(9pfs) devic=
e

This says 2.9...

> +#
> +# I/O limits can be disabled by setting all of them to 0.
> +#
> +# Returns: Nothing on success
> +#          If @device is not a valid 9p device, DeviceNotFound
> +#
> +# Since: 2:10

=2E..but this says 2:10 (typo, should be 2.10).  No need to mention the
version twice, especially if one of them is wrong (keep the Since: line).=


> +#
> +# Example:
> +#
> +# -> { "execute": "fs9p_set_io_throttle",
> +#      "arguments": { "device": "ide0-1-0",
> +#                     "bps": 1000000,
> +#                     "bps_rd": 0,
> +#                     "bps_wr": 0,
> +#                     "iops": 0,
> +#                     "iops_rd": 0,
> +#                     "iops_wr": 0,
> +#                     "bps_max": 8000000,
> +#                     "bps_rd_max": 0,
> +#                     "bps_wr_max": 0,
> +#                     "iops_max": 0,
> +#                     "iops_rd_max": 0,
> +#                     "iops_wr_max": 0,
> +#                     "bps_max_length": 60,
> +#                     "iops_size": 0 } }
> +# <- { "returns": {} }
> +##
> +{ 'command': 'fs9p_set_io_throttle', 'boxed': true,
> +  'data': 'FS9PIOThrottle' }

New commands and members should be named with '-' rather than '_' as the
word separator, so this should be 'fs9p-set-io-throttle', 'bps-rd', etc.

> +##
> +# @FS9PIOThrottle:
> +#
> +# A set of parameters describing block
> +#
> +# @device: Block device name
> +#
> +# @bps: total throughput limit in bytes per second
> +#
> +# @bps_rd: read throughput limit in bytes per second
> +#
> +# @bps_wr: write throughput limit in bytes per second
> +#
> +# @iops: total I/O operations per second
> +#
> +# @iops_rd: read I/O operations per second
> +#
> +# @iops_wr: write I/O operations per second
> +#
> +# @bps_max: total throughput limit during bursts,
> +#                     in bytes (Since 1.7)

You're introducing this struct in 2.10, so this member is not since 1.7.
 Either that, or you're copying-and-pasting when you should be sharing
code and reusing an existing struct.


> +#
> +# Since: 2.10
> +##
> +{ 'struct': 'FS9PIOThrottle',
> +  'data': { '*device': 'str', 'bps': 'int', 'bps_rd': 'int',
> +            'bps_wr': 'int', 'iops': 'int', 'iops_rd': 'int', 'iops_wr=
': 'int',
> +            '*bps_max': 'int', '*bps_rd_max': 'int',
> +            '*bps_wr_max': 'int', '*iops_max': 'int',
> +            '*iops_rd_max': 'int', '*iops_wr_max': 'int',
> +            '*bps_max_length': 'int', '*bps_rd_max_length': 'int',
> +            '*bps_wr_max_length': 'int', '*iops_max_length': 'int',
> +            '*iops_rd_max_length': 'int', '*iops_wr_max_length': 'int'=
,
> +            '*iops_size': 'int' } }

If you reuse an existing struct that uses _ instead of -, then that
explains your naming.  But in that case, why do you need to declare a
new (copied) struct, instead of just reusing the existing one?

> +
> +##
> +# @query-9pfs-io-throttle:
> +#
> +# Return a list of information about each iothread
> +#
> +# Returns: @FS9PIOIOThrottle
> +#
> +# Since: 2.10
> +#
> +# Example:
> +#
> +# -> { "Execute": "query-9pfs-io-throttle" }
> +# <- { "returns" : [
> +#          {
> +#             "device": "ide0-hd0",
> +#              "bps":1000000,
> +#              "bps_rd":0,
> +#              "bps_wr":0,
> +#              "iops":1000000,
> +#              "iops_rd":0,
> +#              "iops_wr":0,
> +#              "bps_max": 8000000,
> +#              "bps_rd_max": 0,
> +#              "bps_wr_max": 0,

You are not consistent on whether to include a space after ':'.  The
easiest way to get this right is to paste actual output from pretty qmp
mode.

> +#              "iops_max": 0,
> +#              "iops_rd_max": 0,
> +#              "iops_wr_max": 0,
> +#              "bps_max_length": 0,
> +#              "bps_rd_max_length": 0,
> +#              "bps_wr_max_length": 0,
> +#              "iops_max_length": 0,
> +#              "iops_rd_max_length": 0,
> +#              "iops_wr_max_length": 0,
> +#              "iops_size": 0,
> +#            }

This is not valid JSON. No trailing commas.

> +#          ]
> +#      }
> +#
> +##
> +{ 'command': 'query-9pfs-io-throttle', 'returns': [ 'FS9PIOThrottle' ]=
 }
> +
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--24387KRof5uRkPQ9tBU2Wck58bwObkxvj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0H6aAAoJEKeha0olJ0NqVNgIAImG5/0pfOgPfVApkzngMN+l
eYc1qaRgrtoj0MZgqfCyCXHCjOs7Yg54KfevC/gw4N+Jw7L+VOKBAoWa1TXmbPEX
L0NMy+v0/lZm4dwJxiw5L1YG6UtEmNQrhmgca0xZi5Fj66phG3DQq6VAZbEKjGJy
uvadbQziTBMMOUUqpulX152acSQfTSYW4SxeWqObF57Oile51nqVnpB1dU2ZuDOD
X3Ewl7JWOAkESmnePlu7cNJ2JMm5X7xVM58fc1Dn//+eszRaqeWywTZcNMAF9koq
XiA4NgjBAj8A+/Rn8Vm606b58Y25bmMnbji+Tt+3zrzrsophNvbSnCCJQUQUb9o=
=g+X/
-----END PGP SIGNATURE-----

--24387KRof5uRkPQ9tBU2Wck58bwObkxvj--
