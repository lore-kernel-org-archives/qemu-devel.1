Received: from eggs.gnu.org ([2001:4830:134:3::10]:55773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCSk-0000Ip-CM
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCSh-0004ob-9J
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:18 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:37989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1diCSh-0004nh-5j
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 00:31:15 -0400
Received: by mail-qk0-x236.google.com with SMTP id x191so30909715qka.5
	for <qemu-devel@nongnu.org>; Wed, 16 Aug 2017 21:31:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 17 Aug 2017 01:30:54 -0300
Message-Id: <20170817043102.6322-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/8] QOMify MIPS cpu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Hi,

While working with the mips codebase I had to QOMify it.

I then read Igor's series "complete cpu QOMification" [1] and after some IRC
chat I suggested Igor to rebase his series on mine to avoid code moving
forward then back.

Since most of Igor's series is reviewed I'm posting this a week before 2.11.

I'm not sure about the TypeInfo.abstract change so it is RFC.

Also I couldn't test it with KVM.

Regards,

Phil.

[1]: http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg04414.html

Igor Mammedov (2):
  mips: MIPSCPU model subclasses
  mips: replace cpu_mips_init() with cpu_generic_init()

Philippe Mathieu-Daudé (6):
  mips: move hw/mips/cputimer.c to target/mips/
  mips: introduce internal.h and cleanup cpu.h
  mips: split cpu_mips_realize_env() out of cpu_mips_init()
  mips: call cpu_mips_realize_env() from mips_cpu_realizefn()
  mips: now than MIPSCPU is QOMified, mark it abstract
  mips: update mips_cpu_list() to use object_class_get_list()

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
 target/mips/cpu.c                             |  57 +++-
 target/mips/gdbstub.c                         |   1 +
 target/mips/helper.c                          |  47 +++
 target/mips/kvm.c                             |   1 +
 target/mips/machine.c                         |   1 +
 target/mips/msa_helper.c                      |   1 +
 target/mips/op_helper.c                       |   1 +
 target/mips/translate.c                       |  23 +-
 target/mips/translate_init.c                  |  68 +----
 hw/mips/Makefile.objs                         |   2 +-
 target/mips/Makefile.objs                     |   2 +-
 21 files changed, 549 insertions(+), 449 deletions(-)
 create mode 100644 target/mips/internal.h
 rename hw/mips/cputimer.c => target/mips/cp0_timer.c (99%)

-- 
2.14.1
