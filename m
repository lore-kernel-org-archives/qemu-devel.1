Received: from eggs.gnu.org ([2001:4830:134:3::10]:35074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWF-0005Vk-Rs
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cjYWE-0002ph-7x
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 16:44:15 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Thu,  2 Mar 2017 22:43:51 +0100
Message-Id: <1488491046-2549-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 00/15] block: A bunch of fixes for Sheepdog and
 Gluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com

Bad error handling, memory leaks, and lack of blockdev-add support.

Markus Armbruster (15):
  sheepdog: Defuse time bomb in sd_open() error handling
  sheepdog: Fix error handling in sd_snapshot_delete()
  sheepdog: Fix error handling sd_create()
  sheepdog: Mark sd_snapshot_delete() lossage FIXME
  sheepdog: Fix snapshot ID parsing in _open(), _create, _goto()
  sheepdog: Don't truncate long VDI name in _open(), _create()
  sheepdog: Report errors in pseudo-filename more usefully
  sheepdog: Use SocketAddress and socket_connect()
  sheepdog: Implement bdrv_parse_filename()
  gluster: Drop assumptions on SocketTransport names
  gluster: Don't duplicate qapi-util.c's qapi_enum_parse()
  gluster: Plug memory leaks in qemu_gluster_parse_json()
  qapi-schema: Rename GlusterServer to SocketAddressFlat
  qapi-schema: Rename SocketAddressFlat's variant tcp to inet
  sheepdog: Support blockdev-add

 block/gluster.c      | 127 +++++++--------
 block/sheepdog.c     | 436 +++++++++++++++++++++++++++++++++++++--------------
 qapi-schema.json     |  38 +++++
 qapi/block-core.json |  73 +++------
 4 files changed, 443 insertions(+), 231 deletions(-)

-- 
2.7.4
