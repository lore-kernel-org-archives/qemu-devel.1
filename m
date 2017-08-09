Received: from eggs.gnu.org ([2001:4830:134:3::10]:35127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfTV6-000651-GJ
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:06:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dfTV3-0001Jt-7c
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:06:28 -0400
Received: from 20.mo4.mail-out.ovh.net ([46.105.33.73]:51297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dfTV3-0001J2-0w
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 12:06:25 -0400
Received: from player694.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 5CD3889F54
	for <qemu-devel@nongnu.org>; Wed,  9 Aug 2017 18:06:23 +0200 (CEST)
Date: Wed, 9 Aug 2017 18:06:17 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170809180617.1ea5c101@bahia.lan>
In-Reply-To: <c1ae9a24-632b-1dde-631a-b11a3e968ab7@redhat.com>
References: <150228860899.28168.1415083032613087245.stgit@bahia>
	<d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
	<20170809172233.36e17285@bahia.lan>
	<c1ae9a24-632b-1dde-631a-b11a3e968ab7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/QK/HgDxrE=SaShYx+C+e/3r";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [for-2.10 PATCH v2] 9pfs: local: fix
 fchmodat_nofollow() limitations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>

--Sig_/QK/HgDxrE=SaShYx+C+e/3r
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 9 Aug 2017 10:59:46 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 08/09/2017 10:22 AM, Greg Kurz wrote:
>=20
> >>>
> >>> The solution is to use O_PATH: openat() now succeeds in both cases, a=
nd we
> >>> can ensure the path isn't a symlink with fstat(). The associated entr=
y in
> >>> "/proc/self/fd" can hence be safely passed to the regular chmod() sys=
call.   =20
> >>
> >> Hey - should we point this out as a viable solution to the glibc folks,
> >> since their current user-space emulation of AT_SYMLINK_NOFOLLOW is bro=
ken?
> >> =20
> >=20
> > Probably. What's the best way to do that ? =20
>=20
> I've added a comment to
> https://sourceware.org/bugzilla/show_bug.cgi?id=3D14578; you'll also want
> to point to the lkml discussion in that bug.  And reading that bug, it
> also looks like your hack with /proc/self/fd has been proposed by Rich
> Felker since 2013! (although fstat() didn't work until Linux 3.6, even
> though O_PATH predates that time) - so there is that one additional
> concern of whether we need to cater to the window of kernels where
> O_PATH exists but fstat() on that fd can't learn whether we opened a
> symlink.
>=20

BTW, what happens with fstat() and O_PATH before Linux 3.6 ? Does it
fail or does it return something wrong in th stat buf ?

--Sig_/QK/HgDxrE=SaShYx+C+e/3r
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlmLMvkACgkQAvw66wEB28LGaQCfXBxVSnrlJeICr2IR/JS9XEzg
OygAn0tcLOUhw0L28l2BeBu3XajRdmY4
=n3GQ
-----END PGP SIGNATURE-----

--Sig_/QK/HgDxrE=SaShYx+C+e/3r--
