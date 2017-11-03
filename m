Received: from eggs.gnu.org ([2001:4830:134:3::10]:49164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYD-0001X2-Db
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eAiYC-0000bG-JH
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 16:26:49 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  3 Nov 2017 21:26:20 +0100
Message-Id: <20171103202624.5956-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PATCH 0/4] softfloat: fix some helper definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org, Laurent Vivier <laurent@vivier.eu>

This series fixes some errors found by
enabling USE_SOFTFLOAT_STRUCT_TYPES.

Most of them are helpers using int types
instead of float types.
This also requires the use of floatXX_val()
and make_floatXX().

Laurent Vivier (4):
  arm: fix float64 helper definitions
  openrisc: fix float32 and float64 helper definitions
  tricore: use make_float32() and float32_val()
  softfloat: use floatXX_val() in XX_minmax()

 fpu/softfloat.c              |  8 +++----
 target/arm/helper-a64.h      |  6 ++---
 target/openrisc/fpu_helper.c | 52 ++++++++++++++++++++++----------------------
 target/openrisc/helper.h     | 20 ++++++++---------
 target/tricore/fpu_helper.c  | 34 ++++++++++++++---------------
 5 files changed, 60 insertions(+), 60 deletions(-)

-- 
2.13.6
