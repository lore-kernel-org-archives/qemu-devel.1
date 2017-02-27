Received: from eggs.gnu.org ([2001:4830:134:3::10]:60129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciKQ3-0002Wc-Uu
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:28:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciKQ3-00044B-8Q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:28:47 -0500
Date: Mon, 27 Feb 2017 13:28:42 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170227122842.GC6356@noname.redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-16-git-send-email-kwolf@redhat.com>
	<90ef56d8-0415-bf7d-28b0-9b80adb4622c@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <90ef56d8-0415-bf7d-28b0-9b80adb4622c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 15/54] block: Involve block drivers in
 permission granting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 22.02.2017 um 15:04 hat Max Reitz geschrieben:
> > @@ -1390,6 +1565,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverStat=
e *child_bs,
> > =20
> >      ret =3D bdrv_check_update_perm(child_bs, perm, shared_perm, NULL, =
errp);
> >      if (ret < 0) {
> > +        bdrv_abort_perm_update(child_bs);
> >          return NULL;
> >      }
> > =20
>=20
> This function doesn't call bdrv_set_perm(). Intentional?

Yes, intentional. It calls it indirectly via bdrv_replace_child(). I'll
add a comment.

Kevin

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYtBt6AAoJEH8JsnLIjy/WCNIQAKmfekS63XsjP4XbmL5ojqTF
UgqLwGkO8Kuj2n3zWuwoS8DIzsb5wLGsen6pgR1kNvlUpJkDFT3LhN9D6VoWJqNZ
aR4VgrKVH5wBpGEJs+pSAQ1LFd6x2qZlYhXq+RvskzW07hlN9U+HaowO3vedseo6
ac/+TchW/yq4bRfYbWeSXjJR18/cLrIM3o2EgPkds/2x/LaYwzWBYMujdcQ+Dcmj
v8wcE75XooeGHdsmwiUAUqiu9rgHW4AU7pQNxLycrzZLdwwTS6gwfEWsouEYEr+O
UEut/+kfbAEB/V5xwYBY14tR1uD+5IeXe7rThlC85E/rFc/eiVKtqZ3iQ+ai3yOf
4qhfdLmEfd2wy0qzP+0nn2E0ZKgi2gqjE3EnYjs2d4egphgvBvRxKPkJqxl6Ak6f
IrCODGQbqK2I2cTQVzfrJMM2/6GyolCJTscuaVHYdSXEhYZ6r5Qt/dE/snte6PGv
49vTS1gbDOCAfI/M/FXsjNLk4TRXvVlNC5ziy46H8NgmIFlC9IFNLQUTVPLK93It
fZAAbly5EgY8zb7O5DeCgc4HLU9BJr2wCviwsI4EKvq69G6lucgIwrfLsSRvYgbZ
58DZjoUP/XHVaWu9/mjH4F+h+i/SLi0TabLGWe4k2f33v3UNWgbuxJ08zMS6vFtT
D7hXsa4G/9JCmB4ErJ3S
=9V8p
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
