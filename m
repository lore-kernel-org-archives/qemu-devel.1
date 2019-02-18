Received: from eggs.gnu.org ([209.51.188.92]:54415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvqli-0001Vd-AK
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gvqlh-000801-OW
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:48:06 -0500
From: John Snow <jsnow@redhat.com>
Date: Mon, 18 Feb 2019 16:42:50 -0500
Message-Id: <20190218214251.8969-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/1] blockdev: acquire aio_context for
 bitmap add/remove
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>

See patch for details.

V4: Embarrassingly, fix a missing semicolon;
V3: Add signed-off-by. My script went a bit haywire,
    so this one's for posterity.

John Snow (1):
  blockdev: acquire aio_context for bitmap add/remove

 blockdev.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.17.2
