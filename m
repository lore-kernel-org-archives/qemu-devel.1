Received: from eggs.gnu.org ([2001:4830:134:3::10]:60256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfU-00026m-DJ
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1csUfO-0006NZ-CN
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1csUfO-0006NE-5L
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 09:26:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3B46FD9988
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 13:26:37 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 27 Mar 2017 15:26:24 +0200
Message-Id: <1490621195-2228-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v3 for-2.9 00/11] rbd: Clean up API and code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jdurgin@redhat.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com

This is RFC because it needs more testing.  I'm sending it out now in
the hope of getting some review while we test.

v3:
* PATCH 01-07 unchanged except for a doc tweak in PATCH 06
* PATCH 08-10 replace PATCH 9
* PATCH 8 becomes PATCH 11, rebased on top of 08-10, commit message
  updated, R-by dropped

Markus Armbruster (11):
  rbd: Reject -blockdev server.*.{numeric,to,ipv4,ipv6}
  rbd: Fix to cleanly reject -drive without pool or image
  rbd: Don't limit length of parameter values
  rbd: Clean up after the previous commit
  rbd: Don't accept -drive driver=rbd,keyvalue-pairs=...
  rbd: Clean up runtime_opts, fix -drive to reject filename
  rbd: Clean up qemu_rbd_create()'s detour through QemuOpts
  rbd: Revert -blockdev and -drive parameter auth-supported
  rbd: Revert -blockdev parameter password-secret
  Revert "rbd: add support for getting password from QCryptoSecret
    object"
  rbd: Fix bugs around -drive parameter "server"

 block/rbd.c          | 356 ++++++++++++---------------------------------------
 qapi-schema.json     |  21 ++-
 qapi/block-core.json |  29 +----
 3 files changed, 95 insertions(+), 311 deletions(-)

-- 
2.7.4
