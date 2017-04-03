Received: from eggs.gnu.org ([2001:4830:134:3::10]:39178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7ti-0005Gq-W0
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cv7tf-00039R-Qn
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:19 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cv7tf-000391-Hw
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 15:44:15 -0400
Received: by mail-wr0-x243.google.com with SMTP id p52so36448310wrc.2
	for <qemu-devel@nongnu.org>; Mon, 03 Apr 2017 12:44:15 -0700 (PDT)
Received: from donizetti.lan (94-39-184-28.adsl-ull.clienti.tiscali.it.
	[94.39.184.28]) by smtp.gmail.com with ESMTPSA id
	18sm19436935wrt.52.2017.04.03.12.44.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 03 Apr 2017 12:44:12 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  3 Apr 2017 21:44:03 +0200
Message-Id: <20170403194409.21276-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/6] Misc patches for QEMU 2.9.0-rc3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The following changes since commit 95b31d709ba343ad237c3630047ee7438bac4065:

  Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20170331.0' into staging (2017-03-31 18:06:13 +0100)

are available in the git repository at:


  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to ecbddbb106114f90008024b4e6c3ba1c38d7ca0e:

  main-loop: Acquire main_context lock around os_host_main_loop_wait. (2017-04-03 19:13:12 +0200)

----------------------------------------------------------------
* MemoryRegionCache revert
* glib optimization workaround
* fix "info lapic" segfault on isapc
* fix QIOChannel memory leak

----------------------------------------------------------------
Corey Minyard (1):
      ipmi: Fix macro issues

Paolo Bonzini (1):
      exec: revert MemoryRegionCache

Richard W.M. Jones (1):
      main-loop: Acquire main_context lock around os_host_main_loop_wait.

Stefan Hajnoczi (1):
      iscsi: drop unused IscsiAIOCB.qiov field

Tejaswini Poluri (1):
      target-i386: fix "info lapic" segfault on isapc

yaolujing (1):
      nbd: fix memory leak on socket_connect failed

 block/iscsi.c         |  1 -
 block/nbd.c           |  1 +
 exec.c                | 64 +++++++++------------------------------------------
 hw/ipmi/isa_ipmi_bt.c | 34 ++++++++++-----------------
 include/exec/memory.h | 10 ++++----
 target/i386/helper.c  |  4 ++++
 util/main-loop.c      | 11 +++++++++
 7 files changed, 43 insertions(+), 82 deletions(-)
-- 
1.8.3.1
