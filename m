Received: from eggs.gnu.org ([2001:4830:134:3::10]:36071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkQ8A-00008x-Dg
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1fkQ87-0008Vw-Bc
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:46 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1fkQ87-0008VJ-4Y
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 04:35:43 -0400
Received: by mail-pg1-x542.google.com with SMTP id p23-v6so8708515pgv.13
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 01:35:42 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Tue, 31 Jul 2018 01:35:21 -0700
Message-Id: <1533026124-6740-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] Add a new migrate_set_max_cpu_throttle qmp
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, crosthwaite.peter@gmail.com, rth@twiddle.net, quintela@redhat.com, dgilbert@redhat.com, eblake@redhat.com, armbru@redhat.com
Cc: liqiang02@corp.netease.com, hzliuyingdong@corp.netease.com, qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

Currently, the default maximum CPU throttle for migration is 
99(CPU_THROTTLE_PCT_MAX). This is too big and can make a remarkable
performance effect for the guest. We see a lot of packets latency 
exceed 500ms when the CPU_THROTTLE_PCT_MAX reached. This patch set
adds a new qmp command to limit the CPU throttle.

Li Qiang (3):
  migrate: replace the cpu throttle percentage max with a variable
  migration: Add qmp command for migrate_set_max_cpu_throttle
  hmp: add hmp for migrate_set_max_cpu_throttle

 cpus.c                |  9 ++++++++-
 hmp-commands.hx       | 14 ++++++++++++++
 hmp.c                 |  6 ++++++
 hmp.h                 |  1 +
 include/qom/cpu.h     |  8 ++++++++
 migration/migration.c | 10 ++++++++++
 qapi/migration.json   | 13 +++++++++++++
 7 files changed, 60 insertions(+), 1 deletion(-)

-- 
2.11.0
