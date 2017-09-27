Received: from eggs.gnu.org ([2001:4830:134:3::10]:59967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ9X-0000m1-7b
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxJ9T-0004B1-9I
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxJ9T-0004AX-3G
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 16:41:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1AF3737907D
	for <qemu-devel@nongnu.org>; Wed, 27 Sep 2017 20:41:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 17:41:46 -0300
Message-Id: <20170927204148.2311-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/2] vl: Print warning if a non-empty
 default config file is found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

This missed v2.9 and v2.10.  Let's try again: we can include this
on v2.11, and remove the default config file in QEMU 2.12 or
2.13.

Changes v2 -> v3:
* Rebase to latest qemu.git master

Changes v1 -> v2:
* Remove unnecessary translation of qemu_config_parse()
  erros to -EINVAL at block/blkdebug.c:read_config()
  * Suggsted-by: Markus Armbruster <armbru@redhat.com>

We plan to remove support for /etc/qemu/qemu.conf in the near
future. Make QEMU print a warning in case there a non-empty
/etc/qemu/qemu.conf is loaded, so users have time to adapt.

Eduardo Habkost (2):
  config: qemu_config_parse() return number of config groups
  vl: Print warning when a default config file is loaded

 block/blkdebug.c   |  1 -
 util/qemu-config.c | 15 +++++++--------
 vl.c               |  6 ++++++
 3 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.13.5
