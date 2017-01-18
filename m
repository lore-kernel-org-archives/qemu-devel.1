Received: from eggs.gnu.org ([2001:4830:134:3::10]:34453)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTqj4-0006H7-CO
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cTqj0-000894-C6
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cTqj0-00088h-6D
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:56:30 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1680A7B9C1
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 13:56:30 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 18 Jan 2017 11:56:22 -0200
Message-Id: <20170118135624.17368-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 0/2] vl: Print warning if a non-empty default
 config-file is found
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

We plan to remove support for /etc/qemu/qemu.conf in the near
future. Make QEMU print a warning in case there a non-empty
/etc/qemu/qemu.conf is loaded, so users have time to adapt.

This series is based on my machine-next branch, at:
  https://github.com/ehabkost/qemu.git machine-next

Eduardo Habkost (2):
  config: qemu_config_parse() return number of config groups
  vl: Print warning when a default config file is loaded

 util/qemu-config.c | 15 +++++++--------
 vl.c               |  6 ++++++
 2 files changed, 13 insertions(+), 8 deletions(-)

-- 
2.11.0.259.g40922b1
