Received: from eggs.gnu.org ([2001:4830:134:3::10]:52940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgZ-0000i2-8B
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eduardo.otubo@profitbricks.com>) id 1cnkgW-00082w-HQ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:15 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:36295)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <eduardo.otubo@profitbricks.com>)
	id 1cnkgW-0007zM-9R
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:32:12 -0400
Received: by mail-wr0-x234.google.com with SMTP id u108so121818224wrb.3
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 04:32:11 -0700 (PDT)
From: Eduardo Otubo <eduardo.otubo@profitbricks.com>
Date: Tue, 14 Mar 2017 12:32:04 +0100
Message-Id: <20170314113209.12025-1-eduardo.otubo@profitbricks.com>
Subject: [Qemu-devel] [PATCH 0/5] seccomp: feature refactoring
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com

Hi all,

This is first attempt of refactoring the seccomp feature, following Daniel's ideas:
https://lists.gnu.org/archive/html/qemu-devel/2017-02/msg03348.html

Best regards,

Eduardo Otubo (5):
  seccomp: changing from whitelist to blacklist
  seccomp: add obsolete argument to command line
  seccomp: add elevateprivileges argument to command line
  seccomp: add spawn argument to command line
  seccomp: add resourcecontrol argument to command line

 include/sysemu/seccomp.h |   7 +-
 qemu-options.hx          |  19 ++-
 qemu-seccomp.c           | 375 ++++++++++++++++++-----------------------------
 vl.c                     |  49 ++++++-
 4 files changed, 217 insertions(+), 233 deletions(-)

-- 
2.11.0
