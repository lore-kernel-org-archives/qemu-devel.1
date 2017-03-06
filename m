Received: from eggs.gnu.org ([2001:4830:134:3::10]:39471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cko1V-0001LN-DO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1cko1S-0006Iy-9I
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:41 -0500
Received: from 1.mo1.mail-out.ovh.net ([178.32.127.22]:46867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1cko1S-00069k-31
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:29:38 -0500
Received: from player756.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo1.mail-out.ovh.net (Postfix) with ESMTP id AE8EE5C3AC
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 09:29:27 +0100 (CET)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 06 Mar 2017 09:29:15 +0100
Message-ID: <148878895545.4635.12311472774377490920.stgit@bahia>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 0/2] 9pfs: fix vulnerability and build break
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Greg Kurz <groug@kaod.org>

The "9pfs: fix vulnerability in openat_dir() and local_unlinkat_common()"
was sent to add the missing O_NOFOLLOW flag and drop O_PATH, which causes
build breaks with older versions of glibc.

Eric Blake pointed out during review that O_PATH could be kept:

https://lists.nongnu.org/archive/html/qemu-devel/2017-03/msg00923.html

This v2 does that in a separate patch, to address the build break with
older glibc.

---

Greg Kurz (2):
      9pfs: fix O_PATH build break with older glibc versions
      9pfs: fix vulnerability in openat_dir() and local_unlinkat_common()


 hw/9pfs/9p-local.c |    2 +-
 hw/9pfs/9p-util.h  |    8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

--
Greg
