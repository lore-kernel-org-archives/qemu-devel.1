Received: from eggs.gnu.org ([209.51.188.92]:33302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu0cp-0003ZX-S9
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gu0cp-00061F-8L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 14:55:19 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Feb 2019 14:55:00 -0500
Message-Id: <20190213195501.7790-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/1] blockdev: acquire aio_context for
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
Cc: Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, vsementsov@virtuozzo.com, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, pbonzini@redhat.com, John Snow <jsnow@redhat.com>

See patch for details.

V3: Add signed-off-by. My script went a bit haywire,
    so this one's for posterity.

John Snow (1):
  blockdev: acquire aio_context for bitmap add/remove

 blockdev.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.17.2
