Received: from eggs.gnu.org ([2001:4830:134:3::10]:57591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYXQ9-0000qB-Dn
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dYXQ6-0000a8-Bp
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dYXQ6-0000Zf-63
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:52:38 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6BF34E33A
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:52:36 +0000 (UTC)
Received: from vader.redhat.com (ovpn-116-236.ams2.redhat.com [10.36.116.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1FFA38B316
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 12:52:35 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri, 21 Jul 2017 14:52:29 +0200
Message-Id: <20170721125235.11939-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCH v3 0/6] seccomp: feature refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

v3:
    * Style problems fixed

v2:
    * The semantics of the options "allow/deny" instead of booleans "on/off" remains. 
    * Added option 'children' to elevateprivileges
    * Added documentation to docs/

v1:
    * First version based on the discussion
      https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03348.html

Eduardo Otubo (6):
  seccomp: changing from whitelist to blacklist
  seccomp: add obsolete argument to command line
  seccomp: add elevateprivileges argument to command line
  seccomp: add spawn argument to command line
  seccomp: add resourcecontrol argument to command line
  seccomp: adding documentation to new seccomp model

 docs/seccomp.txt         |  31 ++++
 include/sysemu/seccomp.h |   7 +-
 qemu-options.hx          |  19 ++-
 qemu-seccomp.c           | 364 ++++++++++++++++++-----------------------------
 vl.c                     |  61 +++++++-
 5 files changed, 248 insertions(+), 234 deletions(-)
 create mode 100644 docs/seccomp.txt

-- 
2.13.3
