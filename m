Received: from eggs.gnu.org ([209.51.188.92]:33789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMLyT-0003Tl-EO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:22:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <driver1998@foxmail.com>) id 1hMLyS-0001WG-BO
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:22:49 -0400
Received: from smtpbgeu2.qq.com ([18.194.254.142]:50598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <driver1998@foxmail.com>)
	id 1hMLyR-0001T0-Cr
	for qemu-devel@nongnu.org; Thu, 02 May 2019 20:22:48 -0400
From: Cao Jiaxi <driver1998@foxmail.com>
Date: Fri,  3 May 2019 08:22:06 +0800
Message-Id: <20190503002206.9751-1-driver1998@foxmail.com>
Subject: [Qemu-devel] [PATCH v3 0/4] Initial Windows on ARM (AArch64 64-Bit)
 host support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cao Jiaxi <driver1998@foxmail.com>

Initial Windows on ARM (AArch64 64-Bit) host support

This series of patches is for initial support of Windows 10 on ARM as a QEMU host.
Currently only TCG intepreter is working correctly, it crashes when TCG JIT is enabled.

For now we assume it is built using the clang aarch64-w64-mingw32 toolchain,
you can get a prebuilt toolchain at https://github.com/mstorsjo/llvm-mingw.

Cao Jiaxi (4):
  QEMU_PACKED: Remove gcc_struct attribute in Windows non x86 targets
  qga: Fix mingw compilation warnings on enum conversion
  util/cacheinfo: Use uint64_t on LLP64 model to satisfy Windows ARM64
  osdep: Fix mingw compilation regarding stdio formats

 contrib/libvhost-user/libvhost-user.h |  2 +-
 include/qemu/compiler.h               |  2 +-
 include/qemu/osdep.h                  | 10 +++++-----
 qga/commands-win32.c                  |  2 +-
 scripts/cocci-macro-file.h            |  7 ++++++-
 slirp/src/util.h                      |  2 +-
 util/cacheinfo.c                      |  2 +-
 7 files changed, 16 insertions(+), 11 deletions(-)

-- 
2.17.1
