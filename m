Received: from eggs.gnu.org ([2001:4830:134:3::10]:49772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr0PL-0006rm-5N
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cr0PH-0005iq-Sc
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:55:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cr0PH-0005iI-N4
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 06:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7CB25C04B927
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 10:55:51 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 23 Mar 2017 11:55:43 +0100
Message-Id: <1490266548-22500-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 0/5] rbd: Clean up API and code
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

These API cleanups need to go into 2.9.

Markus Armbruster (5):
  rbd: Clean up runtime_opts
  rbd: Clean up qemu_rbd_create()'s detour through QemuOpts
  rbd: Rewrite the code to extract list-valued options
  rbd: Peel off redundant RbdAuthMethod wrapper struct
  rbd: Reject options server.*.{numeric,to,ipv4,ipv6}

 block/rbd.c          | 198 +++++++++++++++++----------------------------------
 qapi-schema.json     |  21 ++++--
 qapi/block-core.json |  17 +----
 3 files changed, 82 insertions(+), 154 deletions(-)

-- 
2.7.4
