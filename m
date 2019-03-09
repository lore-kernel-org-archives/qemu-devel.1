Received: from eggs.gnu.org ([209.51.188.92]:51326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2jkE-0003YB-JA
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 16:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2jkD-0003kZ-Su
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 16:43:02 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  9 Mar 2019 22:42:53 +0100
Message-Id: <20190309214255.9952-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] target/ppc: Optimize VSX instructions
 using deposit_i64()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hi David, Richard.

I found these two patches while cleaning dangling branches on my
previous laptop... Original commits date is 2017-07-21 05:24:05...
I simply rebased them.

It doesn't have to be merged for soft freeze, but since I'm doing
housekeeping I rather send it to keep archived by the ML.

Regards,

Phil.

Philippe Mathieu-Daudé (2):
  target/ppc: Optimize xviexpdp() using deposit_i64()
  target/ppc: Optimize x[sv]xsigdp using deposit_i64()

 target/ppc/translate/vsx-impl.inc.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

-- 
2.19.1
