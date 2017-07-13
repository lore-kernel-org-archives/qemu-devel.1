Received: from eggs.gnu.org ([2001:4830:134:3::10]:48518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVeyr-000521-0A
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVeyl-000766-Tn
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:36 -0400
Received: from mail-wr0-f179.google.com ([209.85.128.179]:34622)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVeyl-00075J-Mb
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:31 -0400
Received: by mail-wr0-f179.google.com with SMTP id 77so54062813wrb.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:20:31 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 13 Jul 2017 15:19:22 +0100
Message-Id: <20170713141928.25419-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/6] arm: fixes for eret,
 isb and DISAS_UPDATE handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Peter,

All reviews are now in and I've tested against AArch64 OPTEE xtest
suite and it fixes the hang. Apart from review tags there was one
minor tweak to gen_goto_tb so it always sets s->is_jmp =
DISAS_TB_JUMP;

I reckon these are ready to be taken into the ARM tree now.

Regards,

Alex Bennée (6):
  include/exec/exec-all: document common exit conditions
  target/arm/translate: make DISAS_UPDATE match declared semantics
  target/arm/translate.h: expand comment on DISAS_EXIT
  target/arm/translate: ensure gen_goto_tb sets exit flags
  target/arm: use gen_goto_tb for ISB handling
  target/arm: use DISAS_EXIT for eret handling

 include/exec/exec-all.h    | 29 ++++++++++++++++++++++++++---
 target/arm/translate-a64.c | 19 ++++++++++---------
 target/arm/translate.c     | 21 +++++++++++++--------
 target/arm/translate.h     |  5 ++++-
 4 files changed, 53 insertions(+), 21 deletions(-)

-- 
2.13.0
