Received: from eggs.gnu.org ([2001:4830:134:3::10]:52647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daJx2-0005l4-KJ
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daJwy-0001Hb-3M
	for Qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:54:00 -0400
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
Date: Wed, 26 Jul 2017 05:53:52 -0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Itxg8KmBVwW4nc4jpcXuMJ8DEI7MAR9P7"
Subject: [Qemu-devel] RFC: unified --help information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Itxg8KmBVwW4nc4jpcXuMJ8DEI7MAR9P7
From: Eric Blake <eblake@redhat.com>
To: "Qemu-devel@nongnu.org" <Qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <f3b1276a-92e3-54f3-c6a0-5f8e16124014@redhat.com>
Subject: RFC: unified --help information
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I noticed that some utilities provide a handy link to the website (which
in turn connects the users to bug database, mailing list, online docs,
=2E..); for example, look at 'ls --help | tail -n3':

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Full documentation at: <http://www.gnu.org/software/coreutils/ls>
or available locally via: info '(coreutils) ls invocation'

or 'm4 --help | tail -n3':
Report bugs to: bug-m4@gnu.org
GNU M4 home page: <http://www.gnu.org/software/m4/>
General help using GNU software: <http://www.gnu.org/gethelp/>

In our executables, we are rather inconsistent with --help

qemu-nbd mentions: Report bugs to <qemu-devel@nongnu.org>
qemu-ga mentions: Report bugs to <mdroth@linux.vnet.ibm.com>

while qemu-system-*, qemu-img, and qemu-io mention nothing at all.  Is
it worth unifying these to all mention qemu-devel@nongnu.org as the
primary bug-report site, and/or to add mention of <http://qemu.org> as a
site for further information?

Likewise, with --version, qemu-io and qemu-ga lack the git suffix
present in qemu-system-* and just added in qemu-nbd.

I can submit patches to make things consistent, and think it is 2.10
material, but first want to get consensus on what the behavior should be.=


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Itxg8KmBVwW4nc4jpcXuMJ8DEI7MAR9P7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4dMAACgkQp6FrSiUn
Q2rBEAgAgpdNjiAH8trwQwsuHC+EB/KWzWpYj4Xkx/CwoptqFSwXtsH4k6OpfPl4
4rj3o0PQ6JLV+7aQSJIlH6kHMbY9GiFhqsE8Gx5jsn3nLJOpHp0MPlEZAIl6mHmu
IBdtyLf4TVWiMTEF9MD2yBK3PI29BNMtNSKwHS+YyS/VfsTOapgpsZeRgr+UYBuP
iR5Q9lO91xIp+VCs5W2gcdJHrHN56Vz0WfG42FA9S0vqBWDSGLgbJ4bK/J/mSgpF
EXRnzkSaDCIWpSchaQWzHAuN1JDrFpxl018x3XiAcVkB4XV/GFHOUHqjZNgQPsFl
RTtHr7trfOPb0zE6m7ji7CIOaF3RHg==
=OzER
-----END PGP SIGNATURE-----

--Itxg8KmBVwW4nc4jpcXuMJ8DEI7MAR9P7--
