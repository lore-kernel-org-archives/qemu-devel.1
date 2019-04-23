Received: from eggs.gnu.org ([209.51.188.92]:46844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYj-0003ZX-Q7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1hIsYg-0005si-P3
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 06:21:51 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 23 Apr 2019 12:21:43 +0200
Message-Id: <20190423102145.14812-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] tcg: more tcg_gen_abs() uses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-ppc@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hi Richard, 2 patches to complete your series.

Based on Richard's "tcg vector improvements" series:
https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg03430.html

Regards,

Phil.

Based-on: <20190420073442.7488-1-richard.henderson@linaro.org>

Philippe Mathieu-Daudé (2):
  target/ppc: Use tcg_gen_abs_i32
  target/tricore: Use tcg_gen_abs_tl

 target/ppc/translate/spe-impl.inc.c | 14 +-------------
 target/tricore/translate.c          | 27 +++++----------------------
 2 files changed, 6 insertions(+), 35 deletions(-)

-- 
2.19.1
