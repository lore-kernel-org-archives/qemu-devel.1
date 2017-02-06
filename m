Received: from eggs.gnu.org ([2001:4830:134:3::10]:45996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1castB-0001CI-Mj
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cast8-0001RP-KI
	for qemu-devel@nongnu.org; Mon, 06 Feb 2017 18:40:05 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon,  6 Feb 2017 20:39:29 -0300
Message-Id: <20170206233931.14921-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] register: fix incorrect read mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <peter.crosthwaite@xilinx.com>, Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org

Hi,

This serie fix a bug in register_read_memory(). To avoid duplicated code, a new
inlined function register_enabled_mask() is introduced in the first patch.

Philippe Mathieu-Daudé (2):
  register: inline register_enabled_mask
  register: fix incorrect read mask

 hw/core/register.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

-- 
2.11.0
