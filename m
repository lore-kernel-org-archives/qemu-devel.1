Received: from eggs.gnu.org ([2001:4830:134:3::10]:34010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAKyJ-00079i-SM
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:43:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dAKyG-0006rB-Pg
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:43:55 -0400
Received: from 3.mo69.mail-out.ovh.net ([188.165.52.203]:55897)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dAKyG-0006nN-JZ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:43:52 -0400
Received: from player699.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id ABC2F1FA0C
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 20:43:50 +0200 (CEST)
Date: Mon, 15 May 2017 20:43:45 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170515204345.62922829@bahia>
In-Reply-To: <b5fad238-40ac-7deb-e1b6-33e57c0bb117@redhat.com>
References: <149486383099.19357.10170962018755572073.stgit@bahia.lan>
	<b5fad238-40ac-7deb-e1b6-33e57c0bb117@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/mMMwyrVfHuohrNdhUJc+Yl3";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH] 9pfs: local: forbid client access to
 metadata (CVE-2017-7493)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Leo Gaspard <leo@gaspard.io>, Prasad J Pandit <prasad@redhat.com>

--Sig_/mMMwyrVfHuohrNdhUJc+Yl3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 May 2017 12:37:08 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 05/15/2017 11:07 AM, Greg Kurz wrote:
> > When using the mapped-file security mode, we shouldn't let the client m=
ess
> > with the metadata. The current code already tries to hide the metadata =
dir
> > from the client by skipping it in local_readdir(). But the client can s=
till
> > access or modify it through several other operations. This can be used =
to
> > escalate privileges in the guest.
> >=20
> > Affected backend operations are:
> > - local_mknod()
> > - local_mkdir()
> > - local_open2()
> > - local_symlink()
> > - local_link()
> > - local_unlinkat()
> > - local_renameat()
> > - local_rename()
> > - local_name_to_path()
> >=20
> > Other operations are safe because they are only passed a fid path, which
> > is computed internally in local_name_to_path().
> >=20
> > This patch converts all the functions listed above to fail and return
> > EINVAL when being passed the name of the metadata dir. This may look
> > like a poor choice for errno, but there's no such thing as an illegal
> > path name on Linux and I could not think of anything better.
> >=20
> > This fixes CVE-2017-7493.
> >=20
> > Reported-by: Leo Gaspard <leo@gaspard.io>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > --- =20
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Thanks again for your help.

Cheers,

--
Greg

--Sig_/mMMwyrVfHuohrNdhUJc+Yl3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlkZ9uEACgkQAvw66wEB28KaRwCghC5ludwkzelUqTjKGPD+QoT8
gHIAoKfRCDK+KLyb83I590OscMghMM7a
=C6Th
-----END PGP SIGNATURE-----

--Sig_/mMMwyrVfHuohrNdhUJc+Yl3--
