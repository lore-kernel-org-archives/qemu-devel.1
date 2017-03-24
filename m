Received: from eggs.gnu.org ([2001:4830:134:3::10]:36584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGa-0006sW-VJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1crTGX-0001gs-PC
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1crTGX-0001gT-J6
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 13:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56A467F6A4
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 17:44:45 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 24 Mar 2017 18:44:33 +0100
Message-Id: <1490377482-13337-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 0/9] rbd: Clean up API and code
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

This is RFC because it needs more testing and an additional patch to
clean up around RbdAuthMethod.  I'm sending it out now in the hope of
getting some review.

Markus Armbruster (9):
  rbd: Reject -blockdev server.*.{numeric,to,ipv4,ipv6}
  rbd: Fix to cleanly reject -drive without pool or image
  rbd: Don't limit length of parameter values
  rbd: Clean up after the previous commit
  rbd: Don't accept -drive driver=rbd,keyvalue-pairs=...
  rbd: Clean up runtime_opts, fix -drive to reject filename
  rbd: Clean up qemu_rbd_create()'s detour through QemuOpts
  rbd: Rewrite the code to extract list-valued options
  rbd: Reject invalid authentication methods

 block/rbd.c          | 333 ++++++++++++++++++---------------------------------
 qapi-schema.json     |  21 ++--
 qapi/block-core.json |   2 +-
 3 files changed, 131 insertions(+), 225 deletions(-)

-- 
2.7.4
