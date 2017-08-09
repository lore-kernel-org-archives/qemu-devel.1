Received: from eggs.gnu.org ([2001:4830:134:3::10]:59576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfTOj-0008No-C8
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:59:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfTOg-0005WG-7T
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:59:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33018)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dfTOf-0005Vt-Ub
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 11:59:50 -0400
References: <150228860899.28168.1415083032613087245.stgit@bahia>
	<d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
	<20170809172233.36e17285@bahia.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c1ae9a24-632b-1dde-631a-b11a3e968ab7@redhat.com>
Date: Wed, 9 Aug 2017 10:59:46 -0500
MIME-Version: 1.0
In-Reply-To: <20170809172233.36e17285@bahia.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="5IMP4jVWfwnuUP3p0dJsEIRQHWAttX1Mk"
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
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, zhiyong.wu@ucloud.cn, Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5IMP4jVWfwnuUP3p0dJsEIRQHWAttX1Mk
From: Eric Blake <eblake@redhat.com>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, zhiyong.wu@ucloud.cn,
 Michael Tokarev <mjt@tls.msk.ru>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
Message-ID: <c1ae9a24-632b-1dde-631a-b11a3e968ab7@redhat.com>
Subject: Re: [for-2.10 PATCH v2] 9pfs: local: fix fchmodat_nofollow()
 limitations
References: <150228860899.28168.1415083032613087245.stgit@bahia>
 <d1343f6c-d524-0174-d1b7-fda2d83a3a44@redhat.com>
 <20170809172233.36e17285@bahia.lan>
In-Reply-To: <20170809172233.36e17285@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/09/2017 10:22 AM, Greg Kurz wrote:

>>>
>>> The solution is to use O_PATH: openat() now succeeds in both cases, a=
nd we
>>> can ensure the path isn't a symlink with fstat(). The associated entr=
y in
>>> "/proc/self/fd" can hence be safely passed to the regular chmod() sys=
call. =20
>>
>> Hey - should we point this out as a viable solution to the glibc folks=
,
>> since their current user-space emulation of AT_SYMLINK_NOFOLLOW is bro=
ken?
>>
>=20
> Probably. What's the best way to do that ?

I've added a comment to
https://sourceware.org/bugzilla/show_bug.cgi?id=3D14578; you'll also want=

to point to the lkml discussion in that bug.  And reading that bug, it
also looks like your hack with /proc/self/fd has been proposed by Rich
Felker since 2013! (although fstat() didn't work until Linux 3.6, even
though O_PATH predates that time) - so there is that one additional
concern of whether we need to cater to the window of kernels where
O_PATH exists but fstat() on that fd can't learn whether we opened a
symlink.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--5IMP4jVWfwnuUP3p0dJsEIRQHWAttX1Mk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmLMXIACgkQp6FrSiUn
Q2oa+Af/TNDYbCKNjByC06lI8iuxv8sQDNvgPL/dQObtgp9nrCIFK5HD+QNZ3ool
b2c4stpIQ6MuGoo+ksweUC/EqYPR4LqzSfHjMP6A+CcZ3/1nMWLWokVnhkM3W1Zq
raOzInjcs/opqssjmMV3afrwtOghJb9yWql+tU26rmro7MojXYLidbGgoEOM8vGA
sEQCZKmLpjNQgpfPbSn0Ez59GlNkcDduwlY+hgKJsR6wEcHjprhYquvNTZLNICBY
iNBw59bVXacLuboMeugmR4uxVgEBZFVf5P1OdDuqGxVkMIPHrR0Cr2pWW5u+3MeR
wmSoqIWxjXqwbTSD4UUPCRIn0plB6Q==
=1TjM
-----END PGP SIGNATURE-----

--5IMP4jVWfwnuUP3p0dJsEIRQHWAttX1Mk--
