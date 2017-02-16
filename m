Received: from eggs.gnu.org ([2001:4830:134:3::10]:54019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1ceOx0-0002js-Jb
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chadjoan@gmail.com>) id 1ceOwz-0005c5-Ng
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:30:34 -0500
MIME-Version: 1.0
From: Chad Joan <chadjoan@gmail.com>
Date: Thu, 16 Feb 2017 11:30:10 -0500
Message-ID: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
Content-Type: multipart/mixed; boundary=94eb2c05a196e29f560548a8509d
Subject: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

--94eb2c05a196e29f560548a8509d
Content-Type: text/plain; charset=UTF-8

Hello,

This is a one-line patch to the configure script that will allow QEMU to be
built on musl-libc based Linux systems.  This problem is only noticeable
when QEMU is built with --enable-curses.

Detailed reading material if you want to know where this came from:
https://bugs.gentoo.org/show_bug.cgi?id=609364

Hope that helps!
- Chad

--94eb2c05a196e29f560548a8509d
Content-Type: application/octet-stream; name="qemu-2.8.0-musl-ncurses.patch"
Content-Disposition: attachment; filename="qemu-2.8.0-musl-ncurses.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iz8lj9c50

ZGlmZiAtLWdpdCBjb25maWd1cmUgY29uZmlndXJlCmluZGV4IDFjOTY1NWUuLjlmODMxNzYgMTAw
NzU1Ci0tLSBjb25maWd1cmUKKysrIGNvbmZpZ3VyZQpAQCAtNjgyLDYgKzY4Miw3IEBAIEhhaWt1
KQogICB2aG9zdF9uZXQ9InllcyIKICAgdmhvc3Rfc2NzaT0ieWVzIgogICB2aG9zdF92c29jaz0i
eWVzIgorICBRRU1VX0NGTEFHUz0iLURfWE9QRU5fU09VUkNFPTUwMCAkUUVNVV9DRkxBR1MiCiAg
IFFFTVVfSU5DTFVERVM9Ii1JXCQoU1JDX1BBVEgpL2xpbnV4LWhlYWRlcnMgLUkkKHB3ZCkvbGlu
dXgtaGVhZGVycyAkUUVNVV9JTkNMVURFUyIKIDs7CiBlc2FjCg==
--94eb2c05a196e29f560548a8509d--
