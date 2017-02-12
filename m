Received: from eggs.gnu.org ([2001:4830:134:3::10]:34733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cd2yo-00031P-3k
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 17:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cd2yl-00030K-3W
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 17:50:50 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cd2yk-0002zw-Sw
	for qemu-devel@nongnu.org; Sun, 12 Feb 2017 17:50:47 -0500
Received: by mail-wr0-f195.google.com with SMTP id i10so21810699wrb.0
	for <qemu-devel@nongnu.org>; Sun, 12 Feb 2017 14:50:45 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sun, 12 Feb 2017 23:50:33 +0100
Message-Id: <1486939835-3452-1-git-send-email-huth@tuxfamily.org>
Subject: [Qemu-devel] [PATCH 0/2] m68k: Update MCF interrupt controller and
 MAINTAINERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

Here's a patch to QOMify the ColdFire interrupt controller, and
another patch to update MAINTAINERS - I'd like to volunteer to
maintain the two orphan ColdFire machines.

Thomas Huth (2):
  hw/m68k: QOMify the ColdFire interrupt controller
  MAINTAINERS: Add odd fixer the ColdFire boards

 MAINTAINERS        |  7 +++++--
 hw/m68k/mcf_intc.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 49 insertions(+), 6 deletions(-)

-- 
2.7.4
