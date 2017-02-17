Received: from eggs.gnu.org ([2001:4830:134:3::10]:44379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cedt9-0002IU-S7
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:27:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skiver.cloud.yzy@gmail.com>) id 1cedt4-0008Gb-V0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:27:35 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:36007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skiver.cloud.yzy@gmail.com>)
	id 1cedt4-0008Fh-Pp
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:27:30 -0500
Received: by mail-pf0-x243.google.com with SMTP id 19so3610824pfo.3
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 00:27:30 -0800 (PST)
From: Ziyue Yang <skiver.cloud.yzy@gmail.com>
Date: Fri, 17 Feb 2017 16:27:02 +0800
Message-Id: <20170217082704.23270-1-skiver.cloud.yzy@gmail.com>
Subject: [Qemu-devel] [PATCH 0/2] fix segfaults caused by accessing CPU in
 empty machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Pavel Butsykin <pbutsykin@virtuozzo.com>, Ziyue Yang <yzylivezh@hotmail.com>

From: Ziyue Yang <yzylivezh@hotmail.com>

Many QEMU monitor commands, like "info lapic", "info tlb" and so on
use mon_get_cpu or related wrappers to access CPU info without checking
whether the CPU exists.
This patch series fix the "info lapic" case, and is the base of the incoming
patch series aiming to eliminate segfaults caused by other QEMU commands
trying to access CPU that doesn't exist.

Ziyue Yang (2):
  monitor.c: make mon_get_cpu return NULL when there is no CPU
  target/i386/monitor.c: check return value of mon_get_cpu before using
    it

 monitor.c             | 10 +++++++---
 target/i386/monitor.c |  7 +++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

--
2.11.0
