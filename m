Received: from eggs.gnu.org ([2001:4830:134:3::10]:39862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvJ-0000Br-Pv
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csmvI-0008Mg-Lp
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:56:17 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Mar 2017 10:55:58 +0200
Message-Id: <1490691368-32099-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v4 for-2.9 00/10] rbd: Clean up API and code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

I really, really want to correct a few issues in external interfaces
before while I can.  Bonus: several minor bug fixes.

Thanks to Jeff Cody for testing this series.

v4:
* PATCH 01,04-06 unchanged
* PATCH 02 commit message fixed up [Jeff]
* PATCH 03 commit message tweak [Jeff]
* PATCH 07 fixed to use qdict_get_try_str() [Max]
* PATCH 08 commit message amended [Eric]
* PATCH 09 fixed to revert the code change, too [Jeff]
* old PATCH 10 dropped, PATCH 11 trivially rebased [Eric]

v3:
* PATCH 01-07 unchanged except for a doc tweak in PATCH 06
* PATCH 08-10 replace PATCH 9
* PATCH 8 becomes PATCH 11, rebased on top of 08-10, commit message
  updated, R-by dropped

Markus Armbruster (10):
  rbd: Reject -blockdev server.*.{numeric,to,ipv4,ipv6}
  rbd: Fix to cleanly reject -drive without pool or image
  rbd: Don't limit length of parameter values
  rbd: Clean up after the previous commit
  rbd: Don't accept -drive driver=rbd,keyvalue-pairs=...
  rbd: Clean up runtime_opts, fix -drive to reject filename
  rbd: Clean up qemu_rbd_create()'s detour through QemuOpts
  rbd: Revert -blockdev and -drive parameter auth-supported
  rbd: Revert -blockdev parameter password-secret
  rbd: Fix bugs around -drive parameter "server"

 block/rbd.c          | 319 ++++++++++++++-------------------------------------
 qapi-schema.json     |  21 ++--
 qapi/block-core.json |  30 +----
 3 files changed, 100 insertions(+), 270 deletions(-)

-- 
2.7.4
