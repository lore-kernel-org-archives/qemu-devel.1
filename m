Received: from eggs.gnu.org ([2001:4830:134:3::10]:44508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9fDH-00006w-Ma
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1f9fDD-0000Ye-LX
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:13:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48316 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1f9fDD-0000Xp-H2
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 19:13:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F3F28DC20
	for <qemu-devel@nongnu.org>; Fri, 20 Apr 2018 23:12:59 +0000 (UTC)
From: Laszlo Ersek <lersek@redhat.com>
Date: Sat, 21 Apr 2018 01:12:43 +0200
Message-Id: <20180420231246.23130-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu RFC v3 0/3] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, libvir-list@redhat.com
Cc: "Daniel P. Berrange" <berrange@redhat.com>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>

This version seeks to address the RFCv2 feedback. Changes are noted per
patch.

Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: David Gibson <dgibson@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>

Thanks,
Laszlo

Laszlo Ersek (3):
  qapi: add SysEmuTarget to "common.json"
  qapi: change the type of TargetInfo.arch from string to enum
    SysEmuTarget
  qapi: add "firmware.json"

 Makefile              |   9 +
 Makefile.objs         |   4 +
 qapi/common.json      |  19 ++
 qapi/firmware.json    | 554 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json        |   6 +-
 qapi/qapi-schema.json |   1 +
 arch_init.c           |  18 +-
 qmp.c                 |   5 +
 .gitignore            |   4 +
 9 files changed, 617 insertions(+), 3 deletions(-)
 create mode 100644 qapi/firmware.json

-- 
2.14.1.3.gb7cf6e02401b
