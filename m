Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJFb9-00054O-PS
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gJFKk-0007Ag-Q1
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:08:47 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:36172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gJFKg-00074o-9R
	for qemu-devel@nongnu.org; Sun, 04 Nov 2018 05:08:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id a8-v6so5292807wmf.1
	for <qemu-devel@nongnu.org>; Sun, 04 Nov 2018 02:08:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  4 Nov 2018 10:08:25 +0000
Message-Id: <20181104100826.15143-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/1] softfloat: Don't execute divdeu without
 power7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The following changes since commit 7d56239f159afc2e7bd42623947e56ba48f37836:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20181102' into staging (2018-11-02 17:17:12 +0000)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-softfloat-20181104

for you to fetch changes up to 7370981bd1ef58b3c20ba8b83cc342d1c61bc773:

  softfloat: Don't execute divdeu without power7 (2018-11-04 10:04:40 +0000)

----------------------------------------------------------------
Only use divdeu insn with Power7 and later.

----------------------------------------------------------------
Richard Henderson (1):
      softfloat: Don't execute divdeu without power7

 include/fpu/softfloat-macros.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
