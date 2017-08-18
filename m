Received: from eggs.gnu.org ([2001:4830:134:3::10]:60735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dimMY-0004ea-M4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1dimMV-0002iW-L4
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:51:18 -0400
Received: from mail-by2nam01on0041.outbound.protection.outlook.com
	([104.47.34.41]:49312
	helo=NAM01-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1dimMV-0002i4-Az
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 14:51:15 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 18 Aug 2017 11:47:30 -0700
Message-ID: <cover.1503077821.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v1 0/2] Remove libqemustub.a in order to
 improve error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, armbru@redhat.com
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, pbonzini@redhat.com

As discussed with Paolo and Markus let's combine libqemustub.a into
libqemuutil.a to avoid circular dependencies.

Alistair Francis (2):
  Makefile: Remove libqemustub.a
  Convert remaining single line fprintf() to warn_report()

 Makefile                    |  7 +++----
 Makefile.target             |  2 +-
 docs/devel/build-system.txt | 14 +++++---------
 tests/Makefile.include      |  8 ++++----
 util/cutils.c               |  3 ++-
 5 files changed, 15 insertions(+), 19 deletions(-)

-- 
2.11.0
