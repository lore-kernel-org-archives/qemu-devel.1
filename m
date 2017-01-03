Received: from eggs.gnu.org ([2001:4830:134:3::10]:44507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cORnZ-0008HK-8j
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:18:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sbruno@freebsd.org>) id 1cORnU-00032R-Br
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:18:53 -0500
Received: from ignoranthack.me ([199.102.79.106]:54953
	helo=mail.ignoranthack.me)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sbruno@freebsd.org>) id 1cORnU-00032J-6I
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 11:18:48 -0500
Received: from [192.168.0.6] (67-0-226-66.albq.qwest.net [67.0.226.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: sbruno@ignoranthack.me)
	by mail.ignoranthack.me (Postfix) with ESMTPSA id 703BA1928BA
	for <qemu-devel@nongnu.org>; Tue,  3 Jan 2017 16:18:44 +0000 (UTC)
From: Sean Bruno <sbruno@freebsd.org>
Message-ID: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Date: Tue, 3 Jan 2017 09:18:43 -0700
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="qneIfi2SEqiOsqL0j9RAGja48KhhXTN7h"
Subject: [Qemu-devel] New Year's starting over ... bsd-user
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
--qneIfi2SEqiOsqL0j9RAGja48KhhXTN7h
From: Sean Bruno <sbruno@freebsd.org>
To: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <5dd3d27a-e630-4e92-43fa-13c131e9f880@freebsd.org>
Subject: New Year's starting over ... bsd-user
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


I'm pondering where to start with getting FreeBSD's bsd-user code into
shape so it could actually be reviewed and accepted now that its sort of
working again (signal handling fixed finally).

I almost feel like the existing code should be purged, except that it
gives a good history (and this seems lazy to me).

As a first pass, I guess, I'd like to at least make i386 user run on
x86_64.  What would you folks like to see in a first pass?

sean

ref: https://github.com/seanbruno/qemu-bsd-user/tree/bsd-user


--qneIfi2SEqiOsqL0j9RAGja48KhhXTN7h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGSBAEBCgB9FiEEuq1GMucSHejSCZfdEgHvyh5yfmQFAlhrzuNfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJB
QUQ0NjMyRTcxMjFERThEMjA5OTdERDEyMDFFRkNBMUU3MjdFNjQACgkQEgHvyh5y
fmTYJQf4gZqDSMiHTGI9a3g6RMtJGEhyucpeIDIn9ok+3rj/V4osNomGkQaNwsfO
Ki/nepVbVQNXYD1kan/CAtUWe/chdJSLrve7+yqawRLdcX/PkFMlFr4SibZZVYoD
NpZlKQNHCnmQccv3cDFpWVN8PhySiAYcQCCr6xwXbDiapRdVmM+iQ4hNzA7cxH9k
zbnWpi9CHgXcQ+sWk7hSKb2SiB+1ithSbcrDCBzBEEt8NetjipqoinoZNEG/7Xsp
iSvCUu0nqSf9hlhy3yWuqMNseZB60rFvo97av5TZAMJ+4opIBc61E4wU3HxN3DvN
VuI5NmPSehRB+2vMhvua9UI713Ss
=c5cZ
-----END PGP SIGNATURE-----

--qneIfi2SEqiOsqL0j9RAGja48KhhXTN7h--
