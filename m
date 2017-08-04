Received: from eggs.gnu.org ([2001:4830:134:3::10]:51983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddcW0-0000uh-MA
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddc5a-0004Mi-C0
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:53:19 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 04 Aug 2017 14:49:42 +0200
Message-ID: <871sorijkp.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Is the use of bdrv_getlength() in vhdx*.c kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

bdrv_getlength() can fail.  There are several calls in vhdx*.c that
don't seem to check.  Bug or not?
