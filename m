Received: from eggs.gnu.org ([2001:4830:134:3::10]:33514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90Q9-0004BX-Nb
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90Q6-00078w-Id
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:25 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:44262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e90Q6-00078f-EI
	for qemu-devel@nongnu.org; Sun, 29 Oct 2017 23:07:22 -0400
Received: by mail-qk0-x244.google.com with SMTP id r64so14533996qkc.1
	for <qemu-devel@nongnu.org>; Sun, 29 Oct 2017 20:07:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 30 Oct 2017 00:05:48 -0300
Message-Id: <20171030030553.21259-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] build fixes for --disable-tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

This series add missing stubs (as suggested by Eduardo in [1]) to build
the i386/s390x targets with --disable-tcg (the only targets building without
TCG so far).

For git workflow ease, I split by offending commit (so one can branch from
this particular commit and cherry-pick the corresponding fix[es]).

Regards,

Phil.

[1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-10/msg06094.html

Philippe Mathieu-Daudé (5):
  accel/tcg: add missing target-independent stubs
  target/i386: tcg stubs
  target/s390x: tcg stubs
  accel/tcg: add a stub for tcg_region_init()
  accel/tcg: add a stub for tcg_register_thread()

 accel/stubs/tcg-stub.c     | 27 +++++++++++++++++++++++++++
 target/i386/tcg-stub.c     | 13 +++++++++++++
 target/s390x/tcg-stub.c    | 13 +++++++++++++
 target/i386/Makefile.objs  |  1 +
 target/s390x/Makefile.objs |  1 +
 5 files changed, 55 insertions(+)
 create mode 100644 target/i386/tcg-stub.c
 create mode 100644 target/s390x/tcg-stub.c

-- 
2.15.0.rc2
