Received: from eggs.gnu.org ([2001:4830:134:3::10]:42312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEX-0001yp-Df
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1clHEW-0002Ty-6i
	for qemu-devel@nongnu.org; Tue, 07 Mar 2017 10:41:05 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  7 Mar 2017 16:40:24 +0100
Message-Id: <1488901251-16214-1-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 00/27] Block layer fixes for 2.9.0-rc0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The following changes since commit ff79d5e939c38677a575e3493eb9b4d36eb218=
65:

  Merge remote-tracking branch 'remotes/xtensa/tags/20170306-xtensa' into=
 staging (2017-03-07 09:57:14 +0000)

are available in the git repository at:


  git://repo.or.cz/qemu/kevin.git tags/for-upstream

for you to fetch changes up to b69f00dde490e88d55f5ee731545e690b2dc61f8:

  commit: Don't use error_abort in commit_start (2017-03-07 14:53:29 +010=
0)

----------------------------------------------------------------
Block layer fixes for 2.9.0-rc0

----------------------------------------------------------------
Fam Zheng (2):
      block: Don't use error_abort in blk_new_open
      commit: Don't use error_abort in commit_start

Kevin Wolf (10):
      commit: Fix error handling
      mirror: Fix permission problem with 'replaces'
      mirror: Fix permissions for removing mirror_top_bs
      mirror: Fix error path for dirty bitmap creation
      block: Fix blockdev-snapshot error handling
      block: Factor out should_update_child()
      block: Factor out bdrv_replace_child_noperm()
      block: Ignore multiple children in bdrv_check_update_perm()
      block: Handle permission errors in change_parent_backing_link()
      block: Fix error handling in bdrv_replace_in_backing_chain()

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

 block.c                   | 182 ++++++++++++-------
 block/block-backend.c     |   7 +-
 block/commit.c            |  18 +-
 block/gluster.c           | 127 ++++++-------
 block/mirror.c            |  35 ++--
 block/sheepdog.c          | 453 +++++++++++++++++++++++++++++++++-------=
------
 blockdev.c                |   6 +-
 include/block/block.h     |   4 +-
 include/block/block_int.h |   6 +-
 qapi-schema.json          |  38 ++++
 qapi/block-core.json      |  73 +++-----
 11 files changed, 623 insertions(+), 326 deletions(-)
