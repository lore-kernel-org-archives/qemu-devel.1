Received: from eggs.gnu.org ([2001:4830:134:3::10]:59250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cMFoL-0007gA-Sd
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:06:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cMFoH-0002OP-O0
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:06:37 -0500
Received: from ignoranthack.me ([199.102.79.106]:54662
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cMFoH-0002O8-J6
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 10:06:33 -0500
Received: from [192.168.0.6] (67-0-254-111.albq.qwest.net [67.0.254.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbruno@ignoranthack.me)
	by mail.ignoranthack.me (Postfix) with ESMTPSA id 997EC1928BA
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 15:06:29 +0000 (UTC)
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <098092bd-b92b-4fb8-5061-f77f9f75e392@freebsd.org>
Date: Wed, 28 Dec 2016 08:06:26 -0700
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="UnsI568FKQ8AMbMlGdeAlUI64hP4Haf3m"
Subject: [Qemu-devel] Looking for a linux-user mode test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UnsI568FKQ8AMbMlGdeAlUI64hP4Haf3m
From: Sean Bruno <sbruno@freebsd.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <098092bd-b92b-4fb8-5061-f77f9f75e392@freebsd.org>
Subject: Looking for a linux-user mode test
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

After some recent-ish changes to how user mode executes things/stuff,
I'm running into issues with the out of tree bsd-user mode code that
FreeBSD has been maintaining.  It looks like the host_signal_handler()
is never executed or registered correctly in our code.  I'm curious if
the linux-user code can handle this bit of configure script from m4.

https://people.freebsd.org/~sbruno/stack.c

If someone has the time/inclination, can this code be compiled for ARMv6
and executed in a linux chroot with the -strace argument applied?  I see
the following, which after much debugging seems to indicate that the
host_signal_handler() code is never executed as this code is requesting
that SIGSEGV be masked to its own handler.

https://people.freebsd.org/~sbruno/qemu-bsd-user-arm.txt

Prior to 7e6c57e2957c7d868f74bd0d53b5e861b495e1c7 this DTRT for our
ARMv6 targets.

sean


--UnsI568FKQ8AMbMlGdeAlUI64hP4Haf3m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGTBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhj1PJfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmTBXAf+KiOhuLGdk1q8meJhh6+XtXRUmIa39lpF5G6np1TJtODCbFzHlbu9YKB3
PBXRSuNt2a4gtlvQjP0OUqpaolmKt4b+3S8Mui82vnXrJJWmySIz9bojuCHGpFoT
pJpIUXWE9RbrDWfORSeNVV5K3iQdbah50R4zkEp1tqmnyAab9YxgJ1MuTGAJko8+
YIkIVl5Pbq5t8HSRgAoYvgH84AlHc9cJ7H/KUHco7DTsJK49VzyyfNaTPKwZ+QR4
y8uAtqP9MpDHzdeOhDNsR3PaEfnNEmNO/c8jIXJ78RH8gB9mQMZPI+OrpOHGqjeb
tYcNTf+s/YMbVf0RF4vuIyBt/wy5tw==
=QxHJ
-----END PGP SIGNATURE-----

--UnsI568FKQ8AMbMlGdeAlUI64hP4Haf3m--
