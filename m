Received: from eggs.gnu.org ([2001:4830:134:3::10]:54187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk7-0001s4-Rt
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1cfEk4-0007C4-Oy
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33531)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1cfEk4-0007Bs-IT
	for qemu-devel@nongnu.org; Sat, 18 Feb 2017 18:48:40 -0500
Received: by mail-wm0-f68.google.com with SMTP id v77so8434246wmv.0
	for <qemu-devel@nongnu.org>; Sat, 18 Feb 2017 15:48:40 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
Date: Sun, 19 Feb 2017 00:48:30 +0100
Message-Id: <1487461713-23092-1-git-send-email-huth@tuxfamily.org>
Subject: [Qemu-devel] [PULL 0/3] ColdFire patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

The following changes since commit ad584d37f2a86b392c25f3f00cc1f1532676c2d1:

  Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into staging (2017-02-16 17:46:52 +0000)

are available in the git repository at:

  https://github.com/huth/qemu.git tags/coldfire-20170219

for you to fetch changes up to 5baf2741b4920c3227c14734986893c66b6b2eed:

  MAINTAINERS: Add odd fixer for the ColdFire boards (2017-02-18 22:23:31 +0100)

----------------------------------------------------------------
Updates for the m68k ColdFire machines:
- Remove the obsolete dummy machine
- QOMify the ColdFire interrupt controller
- Volunteer for maintaining the orphan ColdFire boards

----------------------------------------------------------------
Thomas Huth (3):
      hw/m68k: Remove dummy machine
      hw/m68k: QOMify the ColdFire interrupt controller
      MAINTAINERS: Add odd fixer for the ColdFire boards

 MAINTAINERS           | 11 +++----
 hw/m68k/Makefile.objs |  2 --
 hw/m68k/dummy_m68k.c  | 84 ---------------------------------------------------
 hw/m68k/mcf_intc.c    | 48 ++++++++++++++++++++++++++---
 4 files changed, 49 insertions(+), 96 deletions(-)
 delete mode 100644 hw/m68k/dummy_m68k.c
