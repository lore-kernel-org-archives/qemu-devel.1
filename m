Received: from eggs.gnu.org ([2001:4830:134:3::10]:42628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirY-0003KD-08
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirT-0007Uq-E2
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:31 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36863)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dtirT-0007Ua-8W
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 19:20:27 -0400
Received: by mail-qt0-x242.google.com with SMTP id t46so4695497qtj.3
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 16:20:27 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sun, 17 Sep 2017 20:20:04 -0300
Message-Id: <20170917232010.14183-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/6] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>

Hi,

This series is based on Igor's "complete cpu QOMification" [1] but only modify
the MIPS part. Igor posted an updated series [2].

Yongbok: this series is now ready to apply to your MIPS tree :)

Regards,

Phil.

[1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04414.html
[2]: http://lists.nongnu.org/archive/html/qemu-devel/2017-08/msg03364.html

v3:
- added Eduardo Habkost Acked-by and Reviewed-by
- put Eduardo patch 4 review comment in commit message
- address Eduardo's patch 5 review (use correct type, unnecessary null check)
- drop patch 7 in favor of a "generic mechanism to list CPU models using the
  QOM hierarchy"

v2: 
- added Igor and James Tested-by
- squashed "!fixup mips: now than MIPSCPU is QOMified, mark it abstract"

PS: code movement somehow triggers a "binary vs unary operators" confusion
    in checkpatch: "ERROR: space prohibited after that '&' (ctx:WxW)"

Igor Mammedov (2):
  mips: MIPSCPU model subclasses
  mips: replace cpu_mips_init() with cpu_generic_init()

Philippe Mathieu-Daudé (4):
  mips: move hw/mips/cputimer.c to target/mips/
  mips: introduce internal.h and cleanup cpu.h
  mips: split cpu_mips_realize_env() out of cpu_mips_init()
  mips: call cpu_mips_realize_env() from mips_cpu_realizefn()

 target/mips/cpu-qom.h                         |   1 +
 target/mips/cpu.h                             | 357 +---------------------
 target/mips/internal.h                        | 422 ++++++++++++++++++++++++++
 hw/mips/cps.c                                 |   2 +-
 hw/mips/mips_fulong2e.c                       |   2 +-
 hw/mips/mips_jazz.c                           |   2 +-
 hw/mips/mips_malta.c                          |   2 +-
 hw/mips/mips_mipssim.c                        |   2 +-
 hw/mips/mips_r4k.c                            |   2 +-
 hw/mips/cputimer.c => target/mips/cp0_timer.c |   2 +-
 target/mips/cpu.c                             |  54 +++-
 target/mips/gdbstub.c                         |   1 +
 target/mips/helper.c                          |   1 +
 target/mips/kvm.c                             |   1 +
 target/mips/machine.c                         |   1 +
 target/mips/msa_helper.c                      |   1 +
 target/mips/op_helper.c                       |   1 +
 target/mips/translate.c                       |  23 +-
 target/mips/translate_init.c                  |  58 +---
 hw/mips/Makefile.objs                         |   2 +-
 target/mips/Makefile.objs                     |   2 +-
 21 files changed, 500 insertions(+), 439 deletions(-)
 create mode 100644 target/mips/internal.h
 rename hw/mips/cputimer.c => target/mips/cp0_timer.c (99%)

-- 
2.14.1
