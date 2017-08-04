Received: from eggs.gnu.org ([2001:4830:134:3::10]:51389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddcZF-0000hR-2W
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:24:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ddc37-0007sk-2e
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 08:50:59 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 04 Aug 2017 14:48:03 +0200
Message-ID: <8760e3ijng.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] Is the use of bdrv_getlength() in quorum_co_flush()
 kosher?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

Have a look at quorum_co_flush():

            quorum_report_bad(QUORUM_OP_TYPE_FLUSH, 0,
                              bdrv_getlength(s->children[i]->bs),
                              s->children[i]->bs->node_name, result);

bdrv_getlength() can fail.  Does it do the right thing then?
