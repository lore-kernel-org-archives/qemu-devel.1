Received: from eggs.gnu.org ([2001:4830:134:3::10]:45092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5irX-0005gR-IT
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:18:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1f5irW-0003WM-Fd
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:18:23 -0400
Received: from mail-lf0-x233.google.com ([2a00:1450:4010:c07::233]:40613)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1f5irW-0003Vw-70
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 22:18:22 -0400
Received: by mail-lf0-x233.google.com with SMTP id e5-v6so9361345lfb.7
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 19:18:22 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon,  9 Apr 2018 19:17:44 -0700
Message-Id: <20180410021745.32378-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/1] linux-user: fix file offset for
 preadv/pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

Hi Peter,

please pull the following linux-user fix for QEMU-2.12.

The following changes since commit 9abfc88af3ffd3b33c7fab4471da86462ee71d95:

  Merge remote-tracking branch 'remotes/xtensa/tags/20180402-xtensa' into staging (2018-04-03 19:02:46 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180409-xtensa

for you to fetch changes up to 9ac225171c9d6b2a1cba35a94ae7eeaa0106cf7d:

  linux-user: fix preadv/pwritev offsets (2018-04-09 18:57:49 -0700)

----------------------------------------------------------------
Fix file offset for preadv/pwritev linux-user syscalls.

----------------------------------------------------------------
Max Filippov (1):
      linux-user: fix preadv/pwritev offsets

 linux-user/syscall.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

-- 
Thanks.
-- Max
