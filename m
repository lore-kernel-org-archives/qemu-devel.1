Received: from eggs.gnu.org ([2001:4830:134:3::10]:37737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyixM-0001n7-5h
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:54:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cyixL-0000Dn-9q
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:54:56 -0400
Date: Thu, 13 Apr 2017 19:54:44 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170413175444.GG5095@noname.redhat.com>
References: <1492104214-29994-1-git-send-email-kwolf@redhat.com>
	<1492104214-29994-2-git-send-email-kwolf@redhat.com>
	<a635dc96-283e-3704-59cb-248eb065bf2b@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <a635dc96-283e-3704-59cb-248eb065bf2b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/3] migration: Call
 blk_resume_after_migration() for postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 13.04.2017 um 19:39 hat Eric Blake geschrieben:
> On 04/13/2017 12:23 PM, Kevin Wolf wrote:
> > Commit d35ff5e6 ('block: Ignore guest dev permissions during incoming
> > migration') added blk_resume_after_migration() to the precopy migration
> > path, but neglected to add it to the duplicated code that is used for
> > postcopy migration. This means that the guest device doesn't request the
> > necessary permissions, which ultimately led to failing assertions.
> >=20
> > Add the missing blk_resume_after_migration() to the postcopy path.
> >=20
> > Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> > ---
> >  migration/savevm.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Are we targetting this for 2.9-rc5, or is it 2.10 material?

At this point, I think it's clearly 2.10.

Kevin

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJY77tkAAoJEH8JsnLIjy/WgPsP/ilac6bARcBxL8FhT/MOLBoX
gj36CM7AlIpfHtQy0CRxef6YEkdRGtnCz9h5jyA5StaLkzplblP+xZDumOvN5fcI
BkroKR3IxUIWFXGBoCvyOZNxWajPvOqUx5SfrShPv3YBzk0fHEtvSdI5YWZ3gd25
6BjSplr0itfUC1ICokrYjBKJrwKZxCcBIu40MjPKzfQ3SE593K/Qw16CrpziUVUa
YcwmvLVlzUPTwY4aE2PKWc3SNfm/7tiTwe5pLBEU59U+RrVwYZKGldCwUVvYoa52
eyEuKUVzeX16KdE0hlF3RX6lDcENL13TY/hyGLmWtxYv9tks1YavRHS5hpJk5dHV
Ve0hs1+Wf0TZilKSb/179GEfYYuCLnzcEJGaJpG8L21ejBozpV0FwF0LodX70FpY
w+zgCLvjhfe5kHp9enDJxLdiz6N/YWrJLOqw2x8V78st+JxnTPwSUZkolOMSF//P
PG7sStxIFfv7SGMMbsA/NzrcBEftXCPm79UvGcum46mG7Sh60C/QxUWMez3MupK+
T5o/gUGzpr4NaJqaG01XGLppLeCuOQDodY7YlWqI2inlrDHHfe4uSM9DRhEb7KqA
DtajT2hLj5B7Of6sY0PzARcthYyvGIrp4kPU8S23KQaWe1cC+/9Mu86xTLrf1YXW
E6XCuENZH8VI5gbQn3WI
=9N17
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
