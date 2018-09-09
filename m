Received: from eggs.gnu.org ([2001:4830:134:3::10]:39329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod7-0004JF-N7
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyod1-0001Js-Rq
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:13 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:36713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fyocx-0001Gd-7r
	for qemu-devel@nongnu.org; Sat, 08 Sep 2018 21:35:04 -0400
Received: by mail-wm0-x244.google.com with SMTP id j192-v6so18006788wmj.1
	for <qemu-devel@nongnu.org>; Sat, 08 Sep 2018 18:35:02 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun,  9 Sep 2018 02:34:42 +0100
Message-Id: <20180909013444.18936-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] mips: Allow more 'Chip specific
 instructions' flags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Richard Henderson <rth@twiddle.net>, Fredrik Noring <noring@nocrew.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

Hi,

After noticing Fredrik patch [1] clashes with an ongoing work, I shared my
concerns after the current limitations of CPUMIPSState::insn_flags, having
1 bit left to store more 'Chip specific instructions'.

The first patch drop this restriction,
the second simply add definitions for 2 Toshiba cores.

Regards,

Phil.

[1] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01978.html
[2] http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg00901.html

Philippe Mathieu-Daudé (2):
  target/mips: Increase the 'supported instructions' flags holder size
  target/mips: Add entries for the Toshiba's R3900 and R5900 cores

 target/mips/cpu.h       | 2 +-
 target/mips/internal.h  | 2 +-
 target/mips/mips-defs.h | 2 ++
 target/mips/translate.c | 4 ++--
 4 files changed, 6 insertions(+), 4 deletions(-)

-- 
2.19.0.rc2
