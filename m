Received: from eggs.gnu.org ([2001:4830:134:3::10]:52778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RCT-0005n8-Id
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f4RCS-0001q9-Oq
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:41 -0400
Received: from mail-pf0-x230.google.com ([2607:f8b0:400e:c00::230]:39191)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f4RCS-0001pv-I9
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 09:14:40 -0400
Received: by mail-pf0-x230.google.com with SMTP id c78so701252pfj.6
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:14:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  6 Apr 2018 23:14:29 +1000
Message-Id: <20180406131430.23432-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL for-2.12 0/1] tcg vector fix
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

Fixes the reported problem w/ ppc64 host (gcc 4.8.5) + aa64 guest.


r~


The following changes since commit 0e87fdc966d05f4e5ad868034fcd8ee2a08ca62d:

  Update version for v2.12.0-rc2 release (2018-04-04 20:37:20 +0100)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-tcg-20180407

for you to fetch changes up to 6cb1d3b8517572031a22675280ec642972cdb395:

  tcg: Fix out-of-line generic vector compares (2018-04-06 23:08:50 +1000)

----------------------------------------------------------------
Fix generic host vector compares.

----------------------------------------------------------------
Richard Henderson (1):
      tcg: Fix out-of-line generic vector compares

 accel/tcg/tcg-runtime-gvec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
