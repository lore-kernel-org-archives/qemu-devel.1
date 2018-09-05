Received: from eggs.gnu.org ([2001:4830:134:3::10]:55431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxYOb-0003U2-Ic
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:03:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxYOU-0007Oy-TF
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 10:03:00 -0400
Date: Wed, 5 Sep 2018 16:02:38 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180905140238.GG3803@andariel.pipo.sk>
References: <20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
	<20180904141730.GC3803@andariel.pipo.sk>
	<w515zzll3xy.fsf@maestria.local.igalia.com>
	<20180904150042.GE3803@andariel.pipo.sk>
	<20180904153436.GC4371@localhost.localdomain>
	<20180905123813.GF3803@andariel.pipo.sk>
	<eff7c4ef-9db7-2b80-b853-e68bf60f4a73@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DWg365Y4B18r8evw"
Content-Disposition: inline
In-Reply-To: <eff7c4ef-9db7-2b80-b853-e68bf60f4a73@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com


--DWg365Y4B18r8evw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 05, 2018 at 08:48:15 -0500, Eric Blake wrote:
> On 09/05/2018 07:38 AM, Peter Krempa wrote:
>=20
> > block-commit is able to reopen the format layers and works as expected.
> >=20
> > Unfortunately though the 'read-only' option is actually useful as the
> > curl-driver does not work without it:
> >=20
> > -blockdev {"driver":"http","url":"http://ftp.sjtu.edu.cn:80/ubuntu-cd/1=
2.04/ubuntu-12.04.5-alternate-amd64.iso","node-name":"libvirt-2-storage","d=
iscard":"unmap"}: curl block device does not support writes
> >=20
> > We obviously can encode that knowledge into libvirt but it will be hard
> > to undo if qemu eventually supports writes in the curl driver.
> >=20
> > Which other protocol drivers don't support writes? in case we have to go
> > this way.
>=20
> When an NBD server exported an image as read-only, the NBD block client
> cannot request write permissions.  But that's a runtime discovery process,
> not a limitation of the block driver itself.

Hmmm, that's unfortunate. Because in some cases we don't know this fact
upfront in libvirt and we also don't know whether an user might attempt
to block-commit at some time.

We probably do need a way to specify that we want
'read-write-if-possible' behaviour.

Peter

--DWg365Y4B18r8evw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluP4fwACgkQHGwCByjY
1GpSLg/+PNRLzGTBaq6cY2nU2lDqNytCvtlnF/Thw4rn+nQuViEpXHWxe1pECRAT
eFtr+TvKhNDuRs1exiPunhBKoZqZNMkxOHLB/Xcsh0JjHW8oWJKC2RBeBaCZvoMy
F1zqKFHcoEdt2W8U/B5dtB7NUSsqhRoZ0eYlDX7iUM5Eo/iBIu4V30VoxBApSG+B
aGGr8iS5nTJiooyC/DUVcwPXfKirZxgryVNMdRMY0Wbyl0POYJnpi0zmOELOVIRb
EbahHwhQX6WkGnWG+x51l/mWI6k8hvSmGfi1eaenDSxoiJ6jq3Xr3leJomK7RX60
Tvr34Dcnx/68ktaOoBAYAlBEr2yc7Bi6ateGiq5gSk1dZMKehAmuwpABZrTkaNTl
gl0FyZaWPHlooAB53JYJLeFwTKdzMHVDatxKVoavUEU811w4ddjbAJT+B8Kea7U3
hqb7AuiQs/2sR/f4TU+/X1VDY7zsQqSoKvbV0SBTHP0g9/blHuIxT6htlbT2TbTk
skrxlPtyJjIk34/UI2dsI3RBy0SpWpjTri4/DgL9j9K5FgwlaVJEfIle80fSNCw9
YhDkQK8mCMEevHaiAbKNP217+MAxRjhCJ/kMDNww8HIbbv+wiNPyrYSMwI0awvUR
9EzwYQo6f+mTiCLXQQMOvqiJo5e9p35jsw0j0FMgYMxxEBsOFzE=
=QM8a
-----END PGP SIGNATURE-----

--DWg365Y4B18r8evw--
