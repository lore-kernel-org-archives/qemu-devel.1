Received: from eggs.gnu.org ([2001:4830:134:3::10]:45077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOI-0006QT-T3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOF-0006CB-Rl
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:50 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56032)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1daFOF-0006B6-GB
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:01:47 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Wed, 26 Jul 2017 02:18:35 -0400
Message-Id: <1501049917-4701-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel] [PATCH v2 0/2] hmp: support querying lapic through
 apic-id for 'info lapic'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, imammedo@redhat.com, qemu-devel@nongnu.org
Cc: wang.yi59@zte.com.cn, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

This series add support querying local apic through apic-id for 'info
lapic'.
As cpu_index will not be used afterwards, so extend 'info registers'
firstly to get apic-id through monitor commands.

v1 -> v2:
 * PATCH 01: Make the code simpler [Igor]
 * PATCH 02: use cpu_by_arch_id() to obtain CPU [Eduardo]

Yi Wang (2):
  hmp: dump ids including socket-id, core-id and so on for 'info registers'
  hmp: allow apic-id for "info lapic"

 hmp-commands-info.hx  |  7 ++++---
 include/qom/cpu.h     | 10 ++++++++++
 qom/cpu.c             | 11 ++++++++---
 target/i386/helper.c  |  8 ++++++++
 target/i386/monitor.c | 10 +++++++++-
 5 files changed, 39 insertions(+), 7 deletions(-)
