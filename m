Received: from eggs.gnu.org ([209.51.188.92]:50168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ghDp9-00038L-Kl
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1ghDp8-0000pf-PM
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 08:23:11 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Wed,  9 Jan 2019 13:23:01 +0000
Message-Id: <20190109132302.22634-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

How about this one?  Add a generic osdep function for reinitializing
optind, which does optreset on FreeBSD (but is identical on all other
OSes).  Use it from qemu-io and qemu-img.

I have tested this on Linux, FreeBSD and OpenBSD.

checkpatch complains:

WARNING: Block comments use a leading /* on a separate line
#69: FILE: include/qemu/osdep.h:591:
+/**

WARNING: architecture specific defines should be avoided
#78: FILE: include/qemu/osdep.h:600:
+#ifdef __FreeBSD__

total: 0 errors, 2 warnings, 44 lines checked

but as far as I'm aware I've followed the correct formatting and
guidelines.

Rich.
