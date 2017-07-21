Received: from eggs.gnu.org ([2001:4830:134:3::10]:33888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSFg-0005DG-Dd
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSFb-0001Yh-GD
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:32 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:56814)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wang.yi59@zte.com.cn>) id 1dYSFb-0001Wj-5X
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 03:21:27 -0400
From: Yi Wang <wang.yi59@zte.com.cn>
Date: Fri, 21 Jul 2017 03:38:54 -0400
Message-Id: <1500622736-20865-1-git-send-email-wang.yi59@zte.com.cn>
Subject: [Qemu-devel]  [PATCH 0/2] hmp: support querying lapic through
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, armbru@redhat.com, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, qemu-devel@nongnu.org
Cc: wang.yi59@zte.com.cn, Liu.Jianjun3@zte.com.cn, liu.yunh@zte.com.cn

This series add support querying local apic through apic-id for 'info
lapic'.
As cpu_index will not be used afterwards, so extend 'info registers'
firstly to get apic-id through monitor commands.

Yi Wang (2):
  hmp: dump ids including socket-id, core-id and so on for 'info registers'
  hmp: allow apic-id for "info lapic"

 hmp-commands-info.hx  |  6 +++---
 include/qom/cpu.h     | 12 ++++++++++++
 monitor.c             |  1 +
 qom/cpu.c             | 10 ++++++++++
 target/i386/cpu.c     |  1 +
 target/i386/cpu.h     | 11 +++++++++++
 target/i386/helper.c  | 29 +++++++++++++++++++++++++++++
 target/i386/monitor.c |  9 ++++++++-
 8 files changed, 75 insertions(+), 4 deletions(-)
