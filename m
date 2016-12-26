Received: from eggs.gnu.org ([2001:4830:134:3::10]:56648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cLWmn-00019b-EG
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 10:02:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cLWmk-0002i2-Dm
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 10:02:01 -0500
Received: from ignoranthack.me ([199.102.79.106]:64608
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cLWmk-0002hb-8t
	for qemu-devel@nongnu.org; Mon, 26 Dec 2016 10:01:58 -0500
Received: from [192.168.0.6] (67-0-254-111.albq.qwest.net [67.0.254.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbruno@ignoranthack.me)
	by mail.ignoranthack.me (Postfix) with ESMTPSA id 89A781928BA
	for <qemu-devel@nongnu.org>; Mon, 26 Dec 2016 15:01:55 +0000 (UTC)
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <0505bf58-21d7-7f77-a0f8-25c5a9586c7f@freebsd.org>
Date: Mon, 26 Dec 2016 08:01:52 -0700
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="8d1IWM91RIuPwNQiBUnVraFnADvpO5bGJ"
Subject: [Qemu-devel] Extra linked objects in qemu-system-aarch64
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
--8d1IWM91RIuPwNQiBUnVraFnADvpO5bGJ
From: Sean Bruno <sbruno@freebsd.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <0505bf58-21d7-7f77-a0f8-25c5a9586c7f@freebsd.org>
Subject: Extra linked objects in qemu-system-aarch64
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

FreeBSD detects undeclared dependencies when building "ports" and I've
been ignoring a bunch of warnings from qemu-system-aarch64 that I'm a
bit puzzled by.  It appears that we're linking qemu-system-aarch64
differently than the other system emulator targets:

https://gist.github.com/seanbruno/dd992cc1e425d708e53dc0fd0f958b92

I would have expected that all the system targets have the same non-qemu
objects linked against it.  Is this something specific to the aarc64
emulator that needs to be there?

sean


--8d1IWM91RIuPwNQiBUnVraFnADvpO5bGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQF8BAEBCgBmBQJYYTDiXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRCQUFENDYzMkU3MTIxREU4RDIwOTk3REQx
MjAxRUZDQTFFNzI3RTY0AAoJEBIB78oecn5kRewH/1O/NDsTZ1VijLt25rFh/xJ8
kKhRaKIyPhGkv1HQpz48rO5kp+lejvIbAhgyNQ57FgClyXemUXa7yUpchHRnb9xo
fSD8iVV4mZVRP8TUIMp5SmhKRB1pA2W/gAfxwaxt8FiygBfwCKB7o1I3GKnRLJcs
C63tqvUC4oo1V+vM/wNG8KpHVpjd7qh3/xY2c//4jNFMSuv6v7b7syDLWAWYd6MB
5w+1kfYg/Kd5whN1tJTEWCGTD4VRUHINcHTVipP87vIGJfWRFfzSHGFXViW8Zzer
evAUjb/s7Wlef13ig0JOyRhOyr+V6zAUHDlr3oC3e0ff7SVwzot7RyAtaR06H6k=
=gJJj
-----END PGP SIGNATURE-----

--8d1IWM91RIuPwNQiBUnVraFnADvpO5bGJ--
