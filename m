Received: from eggs.gnu.org ([2001:4830:134:3::10]:58012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErk-0006cI-Ij
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErj-00088C-IX
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:16 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:36126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ckErj-00087j-Ek
	for qemu-devel@nongnu.org; Sat, 04 Mar 2017 13:57:15 -0500
Received: by mail-qk0-x241.google.com with SMTP id n141so11287560qke.3
	for <qemu-devel@nongnu.org>; Sat, 04 Mar 2017 10:57:15 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat,  4 Mar 2017 15:56:47 -0300
Message-Id: <20170304185652.10675-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] target-mips: fixes,
 start using trace points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

This patchset fixes two easy-to-fix clang warnings and replace few
qemu_log_mask() with trace points.

Philippe Mathieu-Daudé (5):
  target-mips: fix compiler warnings (clang 5)
  target-mips: remove old & unuseful comments
  target-mips: log bad coprocessor0 register accesses with LOG_UNIMP
  target-mips: replace break by goto cp0_unimplemented
  target-mips: replace few LOG_DISAS() with trace points

 Makefile.objs            |   1 +
 target/mips/helper.c     |  16 ++++--
 target/mips/trace-events |   5 ++
 target/mips/translate.c  | 129 ++++++++++++++++++++++-------------------------
 4 files changed, 79 insertions(+), 72 deletions(-)
 create mode 100644 target/mips/trace-events

-- 
2.11.0
