Received: from eggs.gnu.org ([209.51.188.92]:56515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gio@debian.org>) id 1gri8u-0004aw-KV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:46:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gio@debian.org>) id 1gri8t-0005oY-Tq
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:46:56 -0500
Received: from pietrobattiston.it ([2001:4b98:dc0:41:216:3eff:feb1:1135]:58268
	helo=jauntuale.pietrobattiston.it)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gio@debian.org>) id 1gri8t-0005lK-J2
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 06:46:55 -0500
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
	<20190207114913.2c5f2c5b.cohuck@redhat.com>
	<6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
	<ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
From: Giovanni Mascellani <gio@debian.org>
Message-ID: <1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
Date: Thu, 7 Feb 2019 12:46:50 +0100
MIME-Version: 1.0
In-Reply-To: <ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="wWOqIGUfPlyAty9g7PUv1Z7IAh7LPIXGH"
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wWOqIGUfPlyAty9g7PUv1Z7IAh7LPIXGH
From: Giovanni Mascellani <gio@debian.org>
To: Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 David Hildenbrand <david@redhat.com>
Cc: Bug 1815024 <1815024@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <1a3f847e-a371-eacb-8be6-678bb3c20b05@debian.org>
Subject: Re: [Qemu-devel] [Bug 1815024] [NEW] SIGILL on instruction "stck"
 under qemu-s390x in user mode
References: <154953276796.22523.967637403683519556.malonedeb@chaenomeles.canonical.com>
 <20190207114913.2c5f2c5b.cohuck@redhat.com>
 <6c5ac94e-065f-e66a-2df2-5d8ac81c76e1@debian.org>
 <ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
In-Reply-To: <ffb48b9f-fc99-0766-925c-4f79c692cba7@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

Il 07/02/19 12:26, Thomas Huth ha scritto:
> The problem is rather that the STCK instruction is fenced with
> "#ifndef CONFIG_USER_ONLY" ... quick-n-dirty hack to allow it:

Thanks for the patch. Unfortunately on my system it failes with:

  LINK    s390x-linux-user/qemu-s390x
/usr/bin/ld: ../libqemuutil.a(cpu-get-icount.o):(.bss+0x0): multiple
definition of `use_icount'; exec.o:(.bss+0x58): first defined here
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:207: qemu-s390x] Error 1
make: *** [Makefile:432: subdir-s390x-linux-user] Error 2

The error does not appear when compiling from current master.

I am compiling with

 $ git clean -fdx
 $ ./configure --target-list=3Ds390x-linux-user
 $ make -j16

Giovanni.
--=20
Giovanni Mascellani <g.mascellani@gmail.com>
Postdoc researcher - Universit=C3=A9 Libre de Bruxelles


--wWOqIGUfPlyAty9g7PUv1Z7IAh7LPIXGH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSiBF6hBvCQNcghJEaNr8EMz954SQUCXFwaqgAKCRCNr8EMz954
SSQIAQC8Qkofr0+YCXRPUwF+os+Bhnn5U2tbSn9zrner8OH17gD/QCAZXbX0mVZ5
eOEPUmpX+7OFQroR5WKsFy1nCl9l+QE=
=5LX1
-----END PGP SIGNATURE-----

--wWOqIGUfPlyAty9g7PUv1Z7IAh7LPIXGH--
