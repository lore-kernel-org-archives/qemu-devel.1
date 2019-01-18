Received: from eggs.gnu.org ([209.51.188.92]:45731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gkR7c-0003JQ-Tp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:11:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gkR7b-0000UZ-0k
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 05:11:32 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Fri, 18 Jan 2019 10:11:13 +0000
Message-Id: <20190118101114.11759-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4] qemu-io: Add generic function for
 reinitializing optind.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com
Cc: mreitz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, eblake@redhat.com, berrange@redhat.com

v3 was posted here:
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg01536.html

In v4:

 - Detect optreset at ./configure time and use ifdef HAVE_OPTRESET.

 - Adjusted comment style.

 - Checkpatch is now clean.

 - Retested on Linux, FreeBSD 11.2 and OpenBSD 6.4.

Rich.
