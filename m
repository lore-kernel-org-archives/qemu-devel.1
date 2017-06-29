Received: from eggs.gnu.org ([2001:4830:134:3::10]:50679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQbrp-0007Dq-DI
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:00:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dQbro-000070-8a
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 12:00:29 -0400
References: <20170627224616.18538-1-el13635@mail.ntua.gr>
	<20170627224616.18538-2-el13635@mail.ntua.gr>
	<20170629140521.GC18146@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a195f024-687b-82a7-3e76-7b6c5e18e124@redhat.com>
Date: Thu, 29 Jun 2017 11:00:17 -0500
MIME-Version: 1.0
In-Reply-To: <20170629140521.GC18146@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XQTvGbPWmOMNofthbhCjdbfqojjGo8EPs"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: pass bdrv_*
 methods to bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XQTvGbPWmOMNofthbhCjdbfqojjGo8EPs
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <a195f024-687b-82a7-3e76-7b6c5e18e124@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 1/2] block: pass bdrv_* methods
 to bs->file by default
References: <20170627224616.18538-1-el13635@mail.ntua.gr>
 <20170627224616.18538-2-el13635@mail.ntua.gr>
 <20170629140521.GC18146@stefanha-x1.localdomain>
In-Reply-To: <20170629140521.GC18146@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 09:05 AM, Stefan Hajnoczi wrote:
> On Wed, Jun 28, 2017 at 01:46:15AM +0300, Manos Pitsidianakis wrote:
>> The following functions fail if bs->drv does not implement them:
>>
>> bdrv_probe_blocksizes
>> bdrv_probe_geometry
>> bdrv_truncate
>> bdrv_has_zero_init
>> bdrv_get_info
>> bdrv_media_changed
>> bdrv_eject
>> bdrv_lock_medium
>> bdrv_co_ioctl
>>
>> Instead, the call should be passed to bs->file if it exists, to allow
>> filter drivers to support those methods without implementing them.
>>
>> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
>> ---
>>  block.c    | 45 ++++++++++++++++++++++++++++++++++-----------
>>  block/io.c |  4 ++++
>>  2 files changed, 38 insertions(+), 11 deletions(-)
>=20
> Will you send a block/raw-format.c patch that removes the forwarding
> functions that are no longer needed?

block/raw-format.c does some additional things thanks to its 'offset'
parameter, so I think it will have to still implement things directly
rather than relying on defaults.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XQTvGbPWmOMNofthbhCjdbfqojjGo8EPs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZVSQRAAoJEKeha0olJ0NqXkgH/RvCs4c9vmGq5DVe7YUpCaf+
QytlZg8UuHQIxovWMV9zBtzDZr5Un+4dq+owp94Br8/QmUwUHCb9wqKu4+29/kWI
vgATxBSAumW4WnXP+dWO/jPSb4t8Phc4TEFiK37uPxK53+d3GiFOtgD+F4+yCTzH
VK0hqM1dAzJE+5OtDXL2XTrWqnlF7dbs3tsodwU8RsaYxoxiiQiW+KqSsjLSuBNk
zrT0xJn5KSBb0hxK2t0a6FEdkQ1Jrne380TD7xRe6AR5L1+Gt02DtI0kAEulCfCR
AIpt2tuNkjP8YAZIYAh6fLO7G7rFHX0+70o3kaeSQeSDO1rEBPT6+Wzpp1NlJ9E=
=I10b
-----END PGP SIGNATURE-----

--XQTvGbPWmOMNofthbhCjdbfqojjGo8EPs--
