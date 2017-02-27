Received: from eggs.gnu.org ([2001:4830:134:3::10]:36471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQVd-0005Aj-NZ
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:58:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciQVc-0003CV-Pr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 13:58:57 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 27 Feb 2017 13:58:43 -0500
Message-Id: <cover.1488220970.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v2 0/5] RBD: blockdev-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, berrange@redhat.com, eblake@redhat.com


This series adds blockdev-add for rbd.

Changes from v1:

Overall:

* QAPI interface does not allow arbitrary key/value pairs
  in v2 (Thanks Daniel)

* QAPI interface adds 'mon_host' and 'auth_supported' options (Thanks Daniel)

* Use 'user' instead of 'rbd-id' (Thanks Daniel)


By patch:

Patch 1:
 * Fixed some indentation in patch 1 (Thanks Markus)

Patch 2:
 * 'rbd-id' becomes 'user', and the commit message is fixed. (Thanks Daniel)

Patch 3:
 * Ripple-through from changes in patch 2
 * Removed the string unescape from qemu_rbd_set_keypairs(), because the
   strings have already been unescaped by the time they hit this function.

Patch 4:
 * 'rbd-id' becomes 'user'
 * drop the 'keyvalue-pairs' from the QAPI  (both, thanks Daniel)

Patch 5:
 * new patch
 * Adds the 'server' (mon_host) and 'auth_supported' options to the
   QAPI (Thanks Daniel)


Jeff Cody (5):
  block/rbd: don't copy strings in qemu_rbd_next_tok()
  block/rbd: add all the currently supported runtime_opts
  block/rbd: parse all options via bdrv_parse_filename
  block/rbd: add blockdev-add support
  block/rbd: add support for 'mon_host', 'auth_supported' via QAPI

 block/rbd.c          | 464 ++++++++++++++++++++++++++++++---------------------
 qapi/block-core.json |  42 ++++-
 2 files changed, 316 insertions(+), 190 deletions(-)

-- 
2.9.3v
