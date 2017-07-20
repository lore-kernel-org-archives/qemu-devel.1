Received: from eggs.gnu.org ([2001:4830:134:3::10]:58212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dYBWV-0006WB-Ri
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:29:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pkrempa@redhat.com>) id 1dYBWU-00006T-NX
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 09:29:47 -0400
Date: Thu, 20 Jul 2017 15:29:40 +0200
From: Peter Krempa <pkrempa@redhat.com>
Message-ID: <20170720132940.GK8266@andariel.pipo.sk>
References: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="W/+CTqSGWdiRg+8j"
Content-Disposition: inline
In-Reply-To: <1500556314-32102-1-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.10 v3] block: Skip implicit nodes in
 query-block/blockstats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, eblake@redhat.com, armbru@redhat.com, nsoffer@redhat.com, el13635@mail.ntua.gr, qemu-devel@nongnu.org, qemu-stable@nongnu.org


--W/+CTqSGWdiRg+8j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 15:11:54 +0200, Kevin Wolf wrote:
> Commits 0db832f and 6cdbceb introduced the automatic insertion of filter
> nodes above the top layer of mirror and commit block jobs. The
> assumption made there was that since libvirt doesn't do node-level
> management of the block layer yet, it shouldn't be affected by added
> nodes.
>=20
> This is true as far as commands issued by libvirt are concerned. It only
> uses BlockBackend names to address nodes, so any operations it performs
> still operate on the root of the tree as intended.
>=20
> However, the assumption breaks down when you consider query commands,
> which return data for the wrong node now. These commands also return
> information on some child nodes (bs->file and/or bs->backing), which
> libvirt does make use of, and which refer to the wrong nodes, too.
>=20
> One of the consequences is that oVirt gets wrong information about the
> image size and stops the VM in response as long as a mirror or commit
> job is running:
>=20
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1470634
>=20
> This patch fixes the problem by hiding the implicit nodes created
> automatically by the mirror and commit block jobs in the output of
> query-block and BlockBackend-based query-blockstats as long as the user
> doesn't indicate that they are aware of those nodes by providing a node
> name for them in the QMP command to start the block job.
>=20
> The node-based commands query-named-block-nodes and query-blockstats
> with query-nodes=3Dtrue still show all nodes, including implicit ones.
> This ensures that users that are capable of node-level management can
> still access the full information; users that only know BlockBackends
> won't use these commands.
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>=20
> v3:
> - Fixed skipping during the recursion for query-block [Peter]
> - Fixed backing_file_depth
> - More thorough test case for mirror, added one for commit
>=20
> v2:
> - Skip implicit nodes not only on the top level, but also during the recu=
rsive
>   calls [Peter]
> - Spelling fix in the commit message [Manos]
>=20
>  block.c                    | 13 -------------
>  block/commit.c             |  3 +++
>  block/mirror.c             |  3 +++
>  block/qapi.c               | 33 +++++++++++++++++++++++++++------
>  include/block/block.h      |  1 -
>  include/block/block_int.h  |  1 +
>  qapi/block-core.json       |  6 ++++--
>  tests/qemu-iotests/040     | 30 +++++++++++++++++++++++++++++-
>  tests/qemu-iotests/040.out |  4 ++--
>  tests/qemu-iotests/041     | 38 +++++++++++++++++++++++++++++++++++++-
>  tests/qemu-iotests/041.out |  4 ++--
>  11 files changed, 108 insertions(+), 28 deletions(-)

Reviewed-by: Peter Krempa <pkrempa@redhat.com>


--W/+CTqSGWdiRg+8j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAllwsEEACgkQHGwCByjY
1GpLIw//WPe1RCPTaJN/RtZwpPDqWGwbq0/+vbmF4dcBCE9mr7Vwyf504EGWq1Xt
jUSg/lM1evDhOfAPHvuNUvMdVCIOV3VuARgM40t/RgwjblKkwkO3u/YKGwNJjU+7
IViBl0EIFctA4tNAo6qFF4wIZsYqZ3+AabOpUGQczHjbGiOg9gwbaHAg2OzkWXGB
VMElqGTIrHPbs6bewo3oW5Uwl6D5MsfLliXmXcMOdMoijPVJQlyB5CITooxYEc4B
uQYdZSyna0MLwOk52ftGT7s7PtBDC1xwaJQSkPrjIZBSn0jtgZRnVedJ2b6xQEtd
JKZIoNtoMwQOH4tEzuZ+iYBnPtZaylMMIe8mXz/qaE3obL6DC/ZgjwKy5mNvNzBm
9oJNskXEq1S4+kamQvvQMeG43tBJq2lyLmMSYPyVGRIRLhAH4KXo2WZWjXj5xBc3
geNh38LokGYNp+2xp6EqX4RHYAocm3xwuhjuz/W3rdtCVF5Vx0VPgSzqGBSWBPhV
Z6hUns8fw9skw3Bq7klqumJS2PFBwYOWPNh7t01kdqyNfaHKztIPhDZnS9npI1p8
94qBc68dwrHrbMJGlf0QwVWHXz8bpKRkPDNPMGec2z/lYBgl0E1yvfvSiue6Sab/
D6Y38vis5IPL9B68OrZMXhGNwCixWOzQg6s2BtXkcKIGVK/lfxY=
=4KSO
-----END PGP SIGNATURE-----

--W/+CTqSGWdiRg+8j--
