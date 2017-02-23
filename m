Received: from eggs.gnu.org ([2001:4830:134:3::10]:48723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch02s-0007Nm-TM
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:31:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1ch02n-0002Mz-Vx
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:31:22 -0500
Received: from 20.mo6.mail-out.ovh.net ([178.32.124.17]:51165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1ch02n-0002Mt-NN
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 15:31:17 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 55D2CABD08
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 21:31:15 +0100 (CET)
Date: Thu, 23 Feb 2017 21:31:08 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170223213108.070ecd5d@bahia.lan>
In-Reply-To: <CAG48ez1wh--=vP+XqSNigwf32d-pGs_-JoFw5P77Em00YmJ9+g@mail.gmail.com>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760161575.31154.505252736798591155.stgit@bahia.lan>
	<2e9357a4-34ad-9cc1-db39-5ed00bdc015d@redhat.com>
	<CAG48ez1wh--=vP+XqSNigwf32d-pGs_-JoFw5P77Em00YmJ9+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/Po/9loR1WYA+jnbWp06nxRY";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH 07/29] 9pfs: local: introduce
 symlink-attack safe xattr helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jann Horn <jannh@google.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>

--Sig_/Po/9loR1WYA+jnbWp06nxRY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 23 Feb 2017 16:05:02 +0100
Jann Horn <jannh@google.com> wrote:

> On Thu, Feb 23, 2017 at 4:02 PM, Eric Blake <eblake@redhat.com> wrote:
> > On 02/20/2017 08:40 AM, Greg Kurz wrote: =20
> >> All operations dealing with extended attributes are vulnerable to syml=
ink
> >> attacks because they use path-based syscalls which can traverse symbol=
ic
> >> links while walking through the dirname part of the path.
> >>
> >> The solution is to introduce helpers based on opendir_nofollow(). This
> >> calls for "at" versions of the extended attribute syscalls, which don't
> >> exist unfortunately. This patch implement them by simulating the "at"
> >> behavior with fchdir(). Since the current working directory is process
> >> wide, and we don't want to confuse another thread in QEMU, all the work
> >> is done in a separate process. =20
> >
> > Can you emulate *at using /proc/fd/nnn/xyz? =20
>=20
> I don't know much about QEMU internals, but QEMU supports running in a
> chroot using the -chroot option, right? Does that already require procfs =
to be
> mounted inside the chroot?

Calling chroot() requires CAP_SYS_CHROOT and QEMU shouldn't rely on that to
provide a secure and isolated environment to run VMs.

--Sig_/Po/9loR1WYA+jnbWp06nxRY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlivRowACgkQAvw66wEB28I2gQCgpdfN+z5937CgoO4Q7YT8ZdUY
bvcAnAhideyYYEEBOVv3nmzJIqWYS1G6
=E9Ko
-----END PGP SIGNATURE-----

--Sig_/Po/9loR1WYA+jnbWp06nxRY--
