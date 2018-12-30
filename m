Received: from eggs.gnu.org ([208.118.235.92]:44443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gdfWi-0004oi-Qz
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 13:09:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gdfWi-00014N-7f
	for qemu-devel@nongnu.org; Sun, 30 Dec 2018 13:09:28 -0500
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Sun, 30 Dec 2018 18:09:11 +0000
Message-Id: <20181230180912.14614-1-rjones@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] qemu-io: Reinitialize optind correctly before
 parsing inner command.
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

checkpatch says:

  WARNING: architecture specific defines should be avoided
  #60: FILE: qemu-io-cmds.c:117:
  +#ifdef __GNU_LIBRARY__

However I don't know a better way to fix this.

Rich.
