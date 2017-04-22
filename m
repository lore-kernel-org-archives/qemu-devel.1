Received: from eggs.gnu.org ([2001:4830:134:3::10]:34704)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1d24ZI-00019a-0x
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 19:35:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1d24ZD-0004Pj-VA
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 19:35:56 -0400
Received: from mout.gmx.net ([212.227.15.18]:53580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1d24ZD-0004Ox-Jq
	for qemu-devel@nongnu.org; Sat, 22 Apr 2017 19:35:51 -0400
Received: from [192.168.1.4] ([185.58.161.191]) by mail.gmx.com (mrgmx002
	[212.227.17.184]) with ESMTPSA (Nemesis) id 0M6jMS-1c7n4y0MpY-00wYMZ
	for <qemu-devel@nongnu.org>; Sun, 23 Apr 2017 01:35:48 +0200
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
Date: Sun, 23 Apr 2017 01:27:58 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rE8XOLsxqJ9g5TqfVQieWVOKXIDnoMt0X"
Subject: [Qemu-devel] NetBSD maintenance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rE8XOLsxqJ9g5TqfVQieWVOKXIDnoMt0X
From: Kamil Rytarowski <n54@gmx.com>
To: qemu-devel@nongnu.org
Message-ID: <e1b08f20-77e6-83c8-85e6-b73c645c44c1@gmx.com>
Subject: NetBSD maintenance
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,

I noted a call for NetBSD maintainers in the 2.9.0 release notes.

I'm willing to attach a NetBSD machine to CI cluster and volunteer basic
maintenance. I'm mostly interested in NetBSD as host & as guest as this
is my daily and work driver on my desktop and development machines.

If I understand correctly there is currently no infrastructure for CI:
http://wiki.qemu.org/Testing/ContinuousIntegration


I'm familiar with Python buildbot, I run a machine for the LLVM
toolchain with Clang and LLDB. This setup works very well and it's easy
to setup with minimal dependencies:
http://llvm.org/docs/HowToAddABuilder.html

My LLVM machine:
http://lab.llvm.org:8011/builders/lldb-amd64-ninja-netbsd7

Although, I plan to upgrade it pretty soon and rename, so look for
lldb-amd64-ninja-netbsd8.


As of today NetBSD patches for qemu are maintained in pkgsrc. There are
also at least DragonFly and SunOS (SmartOS) diffs available.
https://github.com/NetBSD/pkgsrc/tree/trunk/emulators/qemu/patches


Qemu is one of the core tools in NetBSD development and it's used in our
release engineering infrastructure:

http://releng.netbsd.org/test-results.html


I will start with upstreaming local diffs and move on to running tests.
I'm aware that there are lately issues with ACPI, APIC, SMP and certain
device drivers... but not everything at once.


--rE8XOLsxqJ9g5TqfVQieWVOKXIDnoMt0X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY++cEAAoJEEuzCOmwLnZsm+8QAIeZDOsUlq/0BZYRCo6cWrgO
Hf7P7TWLa0WqzKi/b2/3vWshB1b1nJPGrQsffV+n6bephb8GY70VtiIlqVZaaQLt
VOEqPkUCLY18FRekteRzVqFCzEUSTfIfkO+WhcuXgEDjvs9l6c2UYfKif9fx2/km
KXTysp54tN5tkvo+F6McduUPZManRGAmFTicWmYTDtYPW/T8smNVwZNqdUq8Ihfh
bcTbmDy2GqiJ9lWPeUgXASh3NlehLWRP3M9t/ePdQ7snMEBulix9iuE0TbuJjkh6
sLp8MeHcTh1grEyXnG8GfwydQF2RkNYeYFGqwT86pPnGLF7s6crSJXd0Xomnqa1L
6f38IG94BZ0/UqpTVR5Qqxci0FN+k9O5ZXa+112QpYaKo/8xOwo47ggFrP/dNxzq
+sote2Vnr5pOkrqwRgdhmQx9xKJ79DDbZAFN3ibotk2NVEBrSF/v7qckC3tnMhYV
OLXuwco8cdj3jZniqQiW679JYYI5Vg+Mk6vuuggnzDO0p37Hvdbdy95HsvpCC0FE
Uo3FQyAg32Pf8iHJothVGLvuO2hM7AF0vKgagGkfC0aFXDe1OcRasHE/paYvKtP8
ixyBnJgW++vWi1jbyXBVlgyV7z/AHIn1IS03/PbM7JrHIQEBFF/tmVUMGTE3b2F+
74AJSVPVeLCkCiCLOEKK
=ezBQ
-----END PGP SIGNATURE-----

--rE8XOLsxqJ9g5TqfVQieWVOKXIDnoMt0X--
