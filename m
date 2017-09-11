Received: from eggs.gnu.org ([2001:4830:134:3::10]:44599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKt-00010c-Vx
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKq-0006hq-Qy
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:44 -0400
Received: from mail-qt0-x22a.google.com ([2607:f8b0:400d:c0d::22a]:34269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1drWKq-0006hE-Lp
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 17:33:40 -0400
Received: by mail-qt0-x22a.google.com with SMTP id m35so22011706qte.1
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 14:33:40 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 11 Sep 2017 18:33:23 -0300
Message-Id: <20170911213328.9701-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 0/5] move user-exec, tcg-runtime,
 atomic_template.h to accel/tcg/
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

As suggested by Paolo:

  That part of tcg/tcg-runtime.c probably should be moved to user-exec.c,
  and user-exec.c should in turn be in accel/tcg.

in http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg03657.html

also update MAINTAINERS accordingly.

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  tcg: move user-exec
  tcg: move tcg-runtime to accel/tcg/
  tcg: move atomic_template.h to accel/tcg/
  tcg: restrict i386 regs definitions

Thomas Huth (1):
  tcg: Move softmmu_template.h to the accel/tcg/ folder

 Makefile.target                                    |  6 +++---
 atomic_template.h => accel/tcg/atomic_template.h   |  0
 softmmu_template.h => accel/tcg/softmmu_template.h |  0
 {tcg => accel/tcg}/tcg-runtime.h                   |  0
 {tcg => accel/tcg}/tcg-runtime.c                   |  0
 user-exec-stub.c => accel/tcg/user-exec-stub.c     |  0
 user-exec.c => accel/tcg/user-exec.c               | 18 +++++++++---------
 MAINTAINERS                                        |  4 +---
 accel/tcg/Makefile.objs                            |  4 ++++
 9 files changed, 17 insertions(+), 15 deletions(-)
 rename atomic_template.h => accel/tcg/atomic_template.h (100%)
 rename softmmu_template.h => accel/tcg/softmmu_template.h (100%)
 rename {tcg => accel/tcg}/tcg-runtime.h (100%)
 rename {tcg => accel/tcg}/tcg-runtime.c (100%)
 rename user-exec-stub.c => accel/tcg/user-exec-stub.c (100%)
 rename user-exec.c => accel/tcg/user-exec.c (100%)

Based-on: 20170911204936.5020-1-f4bug@amsat.org

-- 
2.14.1
