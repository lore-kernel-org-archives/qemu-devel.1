Received: from eggs.gnu.org ([209.51.188.92]:46954)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQD-0003LD-OU
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQD-00019M-32
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:33 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1h2mQC-00017C-QQ
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 19:34:33 -0500
Received: by mail-wr1-x443.google.com with SMTP id g12so1268908wrm.5
	for <qemu-devel@nongnu.org>; Sat, 09 Mar 2019 16:34:32 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 10 Mar 2019 01:34:22 +0100
Message-Id: <20190310003428.11723-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/6] target/m68k: Optimize few instructions
 using deposit/extraxt_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Hi Laurent, Richard.

I found these patches while cleaning dangling branches on my
previous laptop... Original commits date is 2017-07-21 09:31:32...
I simply had to rebase them.

It doesn't have to be merged for soft freeze, but since I'm doing
housekeeping I rather send it to keep archived by the ML.

Regards,

Phil.

Philippe Mathieu-Daudé (6):
  target/m68k: Reduce the l1 TCGLabel scope
  target/m68k: Optimize the partset instruction using deposit_i32()
  target/m68k: Fix a tcg_temp leak
  target/m68k: Optimize get_sr() using deposit_i32()
  target/m68k: Optimize rotate_x() using extract_i32()
  target/m68k: Reduce the scope of the 'zero' tcg_temp

 target/m68k/translate.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

-- 
2.19.1
