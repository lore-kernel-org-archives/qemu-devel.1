Received: from eggs.gnu.org ([2001:4830:134:3::10]:53380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxC9M-0005pc-Fe
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:17:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1fxC9J-0003Nx-Qz
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 10:17:48 -0400
Date: Tue, 4 Sep 2018 16:17:30 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20180904141730.GC3803@andariel.pipo.sk>
References: <20180810162658.6562-1-kwolf@redhat.com>
	<20180810162658.6562-2-kwolf@redhat.com>
	<20180828142626.GM122225@angien.pipo.sk>
	<20180903150311.GC14463@dhcp-200-186.str.redhat.com>
	<w51bm9dl81j.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xo44VMWPx7vlQ2+2"
Content-Disposition: inline
In-Reply-To: <w51bm9dl81j.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] commit: Add top-node/base-node options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com


--xo44VMWPx7vlQ2+2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 04, 2018 at 15:13:44 +0200, Alberto Garcia wrote:
> On Mon 03 Sep 2018 05:03:11 PM CEST, Kevin Wolf wrote:
> >> libvirt-3-format is read-write and all other node names are readonly in
> >> the above example.
> >>=20
> >> The same also happens when using filenames:
> >>=20
> >> {"execute":"block-commit",
> >>  "arguments" : {"device":"libvirt-3-format",
> >>                 "job-id":"libvirt-3-format",
> >>                 "top":"/var/lib/libvirt/images/rhel7.3.1483615252",
> >>                 "base":"/var/lib/libvirt/images/rhel7.3.1483605924",
> >>                 "auto-finalize":true,
> >>                 "auto-dismiss":false},
> >>  "id":"libvirt-13"}
> >>=20
> >> {"id":"libvirt-13","error":{"class":"GenericError","desc":"Block node =
is read-only"}}
> >
> > I see what's happening here. So we have a graph like this:
> >
> >      guest device
> >           |
> >           v
> >     overlay-format -------> backing-format
> >     [read-only=3Doff]         [read-only=3Don]
> >           |                        |
> >           v                        v
> >     overlay-proto           backing-proto
> >     [read-only=3Doff]         [read-only=3Don]
> >
> > The difference between your -blockdev use and -drive is that you
> > explicitly specify the read-only option for backing-proto (and you use
> > a separate -blockdev option anyway), so it doesn't just inherit it
> > from backing-format.
>=20
> Are these format and protocol block devices opened with four separate
> -blockdev parameters? Is that how libvirt does it?

Yes. This goes along with the fact that for 'blockdev-create' you need
to blockdev-add the file which you want to format, but the formatted
file is not automatically added.

If we'd use the approach where the protocol layer is opened as part of
the format layer it would complicate the snapshot code where we need to
add a file and then format it to qcow2. It would mean that we'd have to
blockdev-add a file, format it via blockdev-create, then blockdev-del it
and open it together with the format layer. Otherwise the disk
hot-unplug code would be plain crazy.

--xo44VMWPx7vlQ2+2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAluOk/QACgkQHGwCByjY
1Gqc+A/+J8hzRwqagBtT5jrhFhnLVaXJW8k6HzXTuFfVd8ZKpSLJVG+8GB2fiXs4
aQLDSRuZHIyvb1zA9ukL5UxP2rD7ReKrVQkSMJtZVd51kOYRK8dXmvzRu7fxwlZc
41vd1WrIlFOgxGQl0VxsAhsHKeGV3gztpnmii2TZFx6kyjmtTxryldC3XRY5rlgi
kEKPwrihEbkNdIaXLkn3tmKTtwCA/MG1Qhd44P+K5qP970/NhqZK84GiQBNgnzj7
6sKKmlYMKGrxx8acGCh5fAI3o3157fJFV6SwVLSvI1NQ1P+NNNo+0sKuxgoYKPer
7t6jpfSPbtvBURDm/MIATW7001rvzgV5KMSp7WKyNiesQTb+OQzDQbFmUM2wMpJq
lycNZ2ND33aGw1PVbRWPu/rO4gZbEkdovU+2XN75pw6Qn/RMKj6L1E56Cziygdrm
//4YwYCHLxXR7Rz/SISGLocbHYmWELp450uToDKNYm9Znv1/LjGPNBo2PfmHBzKo
DaTONY9F88mH9wULlb7K+gnCJ4loWENbdzQh/SL0/kcPxA9NoRZ1Q1EirkBM0lUp
YnK5Zz3+LJB1tiG8xSA+27+RjLAWV5B1qda1eIhdhWmWYZ86fvQcDeS9X8iH8gDX
+1oVWDbNyZEsDy22F/N/dHqZLHoC/zF3qDmHMBjvjuY6cc1catI=
=6/Tb
-----END PGP SIGNATURE-----

--xo44VMWPx7vlQ2+2--
