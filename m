Received: from eggs.gnu.org ([2001:4830:134:3::10]:34482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDTht-0005DK-3k
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:16:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gDTho-0002Ep-6C
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:16:45 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:33297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gDThn-00029S-RS
	for qemu-devel@nongnu.org; Fri, 19 Oct 2018 08:16:40 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 19 Oct 2018 14:16:20 +0200
Message-Id: <20181019121623.29148-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [2 0/3] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

The following changes since commit 1b7490446bf41f54130c2d495dd4c8768c8e1ce3:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-10-19 11:20:05 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request

for you to fetch changes up to a133367ec1b689410f1e7427921e33bb1b569bd7:

  linux-user: Implement special usbfs ioctls. (2018-10-19 14:05:10 +0200)

----------------------------------------------------------------
A series to enable ioctl usbfs in linux-user

----------------------------------------------------------------

Cortland Tölva (3):
  linux-user: Check for Linux USBFS in configure
  linux-user: Define ordinary usbfs ioctls.
  linux-user: Implement special usbfs ioctls.

 configure                  |  12 ++-
 linux-user/ioctls.h        |  46 ++++++++++
 linux-user/syscall.c       | 180 +++++++++++++++++++++++++++++++++++++
 linux-user/syscall_defs.h  |  28 ++++++
 linux-user/syscall_types.h |  68 ++++++++++++++
 5 files changed, 333 insertions(+), 1 deletion(-)

-- 
2.17.2
