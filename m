Received: from eggs.gnu.org ([2001:4830:134:3::10]:49459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcaOQ-0005xE-Ew
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fcaON-0004Cj-C7
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:56:10 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:35186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fcaON-0004CS-4S
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:56:07 -0400
Received: by mail-pf0-x22a.google.com with SMTP id q7-v6so13084480pff.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 10:56:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Jul 2018 10:56:02 -0700
Message-Id: <20180709175603.1320-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for-3.0 0/1] target/sh4: Fix translator.c
 assertion failure for gUSA
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

This patch got lost, and represents a regression from 2.12.

Running check-tcg with all of the docker bells and whistles
will show this up, and is what reminded me.


r~


The following changes since commit ec7eb2ae77cc207064e17ace048f7ec0c4b85d6f:

  translate-all: honour CF_NOCACHE in tb_gen_code (2018-07-09 16:14:36 +0100)

are available in the Git repository at:

  https://github.com/rth7680/qemu.git tags/pull-sh4-20180709

for you to fetch changes up to be0e3d7a1e148180fe1b89c7f93720db0607614e:

  target/sh4: Fix translator.c assertion failure for gUSA (2018-07-09 10:34:04 -0700)

----------------------------------------------------------------
Fix translation for gUSA regions.

----------------------------------------------------------------
Richard Henderson (1):
      target/sh4: Fix translator.c assertion failure for gUSA

 target/sh4/translate.c | 81 +++++++++++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 37 deletions(-)
