Received: from eggs.gnu.org ([2001:4830:134:3::10]:40609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaO-0006Lx-Q3
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaJ-0002tU-56
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:48 -0500
Received: from mail-qt0-x230.google.com ([2607:f8b0:400d:c0d::230]:32772)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eMGaJ-0002tI-0j
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 12:00:43 -0500
Received: by mail-qt0-x230.google.com with SMTP id e2so2390905qti.0
	for <qemu-devel@nongnu.org>; Tue, 05 Dec 2017 09:00:42 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Tue,  5 Dec 2017 14:00:11 -0300
Message-Id: <20171205170013.22337-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] target/sh4: add missing tcg_temp_free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Vladimir Prus <vladimir.prus@gmail.com>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>

Hi,

After reading Alex commenting on IRC "java --version failing on sh4" I remember
this series staged for 2.12.

This might help for:

  root@6e10336e48ac:/etc/apt# java --version
  qemu-sh4: /home/alex/lsrc/qemu/qemu.git/tcg/tcg.h:703: temp_idx: Assertion `n >= 0 && n < tcg_ctx->nb_temps' failed.
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped

Regards,

Philippe.

Philippe Mathieu-Daudé (2):
  target/sh4: add missing tcg_temp_free() in gen_conditional_jump()
  target/sh4: add missing tcg_temp_free() in _decode_opc()

 target/sh4/translate.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

-- 
2.15.1
