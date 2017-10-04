Received: from eggs.gnu.org ([2001:4830:134:3::10]:41800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZlq-0002nH-Gk
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:50:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dzZln-0005d2-B4
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:50:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dzZln-0005ba-55
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 22:50:47 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C77D96E762
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 02:50:45 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Tue,  3 Oct 2017 23:50:41 -0300
Message-Id: <20171004025043.3788-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v4 0/2] vl: Deprecate auto-loading of qemu.conf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This missed v2.9 and v2.10.  Let's try again: we can include this
on v2.11, and remove the default config file in QEMU 2.13 or
2.14.

Changes v3 -> v4:
* Use warn_report() instead of error_report("warning: ...")
  (Eric Blake)
* Document as a deprecated feature in qemu-doc.texi
* Updated Subject line
  (was "vl: Print warning if a non-empty default config file is found")

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
  vl: Deprecate auto-loading of qemu.conf

 block/blkdebug.c   |  1 -
 util/qemu-config.c | 15 +++++++--------
 vl.c               |  6 ++++++
 qemu-doc.texi      |  8 ++++++++
 4 files changed, 21 insertions(+), 9 deletions(-)

-- 
2.13.5
