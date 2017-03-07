Received: from eggs.gnu.org ([2001:4830:134:3::10]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clEIi-0007xo-9O
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clEIg-0003i1-SO
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 07:33:11 -0500
Date: Tue, 7 Mar 2017 13:32:59 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170307123259.GI5871@noname.str.redhat.com>
References: <1488817322-11397-1-git-send-email-kwolf@redhat.com>
	<1488817322-11397-6-git-send-email-kwolf@redhat.com>
	<803f7526-e205-a555-e77a-687aa5410ae0@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <803f7526-e205-a555-e77a-687aa5410ae0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 05/10] block: Fix blockdev-snapshot error
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 06.03.2017 um 21:23 hat Eric Blake geschrieben:
> On 03/06/2017 10:21 AM, Kevin Wolf wrote:
> > For blockdev-snapshot, external_snapshot_prepare() accepts an arbitrary
> > node reference at first and only checks later whether it already has a
> > backing file. Between those places, other errors can occur.
> >=20
> > Therefore checking in external_snapshot_abort() whether state->new_bs
> > has a backing file is not sufficient to tell whether bdrv_append() was
> > already completed or not. Trying to undo the bdrv_append() when it
> > wasn't even executed is wrong.
> >=20
> > Introduce a new boolean flag in the state to fix this.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  blockdev.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >=20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> By the way, how are you finding all these spots? Is it existing qemu-io
> tests that are failing? And if so, would mentioning which test exposed
> the problem being fixed be worth adding in the commit messages?  If not,
> are there some qemu-io tests to be added?

Most of the fixes here are based on qemu-iotests failures that only
appeared after fixing the error path in change_parent_backing_link(),
which is now later in this series. So there is no commit at which
qemu-iotests cases are actually failing, even though they helped me spot
some problems.

Kevin

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYvqh6AAoJEH8JsnLIjy/WpxEP/1VYiPsMgxIo5zAjTg6vO+Z9
qgkQ5KsjBL5GAKQNAYzaMr7lh2/u1mALuQBtE8Y5+XJyrfipbwhXaZGWB//W3klV
hekkTxfDPML4XL3B/dIrqF4AqJL/iHcjI6784YKxJbhTEmT0AX+vtBZ6RFCAff8F
ruiC9xb0uMsFQYRC3bQba+YfM8rc9ZoFLfyxl/BX4Xv9VoCk/SKpV/FDcnm7rZX5
1fe0czPHOad4IaxfoLdnIcEX8fvUs7pa/3LVur4PJwBukYzGIdpYh470IdHgGFxR
DslicpWbmZEj4F9c8N5k51vpV4shgEN1Oj+XbK3KUEFigte4erKi5aA8lryD8Hq3
XNeqo7g0TAbFIABSsH/RQQ5MqM4vEZPAa8MtfJhnH5P4lFWpiDqNiHW7dNhpEuF/
FQb7agIkbzbAv/he6yziP+0v18GGgWOpjt5i+t7AEJBzUbfQHCDPZ+pAgX3qHBCl
omqIn7UhKjBHLKKM8PANlAQMEDI+EvoEXlTfYk09IWruCl4se6zbw426NNtOrpvB
IJ3sdqc8sBTUrKgcxvpGgvGeV8cwLJBu2wuNISS8r5kg3GYve3eayBLRSMiUw2dh
x1ycGdqA6RJmjtFlGMCvYDV2RRRBbS8iM+PmThkilAtcEdy2A9mvpb7b6zTKR98w
cHir3vWs+kgidVT/yz3q
=Gkb8
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
