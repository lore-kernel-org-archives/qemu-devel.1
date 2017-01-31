Received: from eggs.gnu.org ([2001:4830:134:3::10]:48502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbLP-0001lI-Pr
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cYbLK-0003Lv-R2
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:31:47 -0500
References: <cover.1485878688.git.berto@igalia.com>
	<79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
Date: Tue, 31 Jan 2017 10:31:32 -0600
MIME-Version: 1.0
In-Reply-To: <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sIAtw1ORQxIQ3Tm1AOQWSx66epnc1PGka"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sIAtw1ORQxIQ3Tm1AOQWSx66epnc1PGka
From: Eric Blake <eblake@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <f9e9efcc-2a59-db47-a048-763eed52d92f@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-io: don't allow I/O operations
 larger than INT_MAX
References: <cover.1485878688.git.berto@igalia.com>
 <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
In-Reply-To: <79f66648c685929a144396bda24d13a207131dcf.1485878688.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/31/2017 10:09 AM, Alberto Garcia wrote:
> Passing a request size larger than INT_MAX to any of the I/O commands
> results in an error. While 'read' and 'write' handle the error
> correctly, 'aio_read' and 'aio_write' hit an assertion:
>=20
> blk_aio_read_entry: Assertion `rwco->qiov->size =3D=3D acb->bytes' fail=
ed.
>=20
> The reason is that the QEMU I/O code cannot handle request sizes
> larger than INT_MAX, so this patch makes qemu-io check that all values
> are within range.

Ideally, it would be nice to fix the block layer to allow larger
requests (since we already have code to auto-fragment down to device
limits, we should be able to rely on that code instead of having to
duplicate artificial constraints everywhere else in the tree).  But
that's a bigger task, and this is a good patch in the interim.

>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  qemu-io-cmds.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sIAtw1ORQxIQ3Tm1AOQWSx66epnc1PGka
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYkLvkAAoJEKeha0olJ0NqL/0H/3LWF1GxBPCNZo4icf3/BHdD
+nIl3itzCTUyUCO+bQ5wiSNTMm6E8VJGGClU/ng1ugOUR1AO+eArz4zg9tq4/wSN
DI08EPeWDILUQ/+ZMRIItPqaJcAuCWS+Agk+IM5BSUxPL4sdEcyXv2jv22hQbOFU
hd3YCf90TYyPUXwwW8nvS+46KcHiq8AjhslS9kZh9jO33k+k07VA88DIV+xHyM6Q
JBi8AR1mkKydwmtWPR3B1lLa2J/yqoTRJ6e0DvWfyzRgVtmkfGDf+SoUywLzyMwK
x9asyS5E7N1tYEKD9R1SHlkDwsOFhWuZOWMZOTrweyvKSby2ucLKMCl5FmQNoLQ=
=Z6h3
-----END PGP SIGNATURE-----

--sIAtw1ORQxIQ3Tm1AOQWSx66epnc1PGka--
