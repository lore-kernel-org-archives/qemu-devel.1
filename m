Received: from eggs.gnu.org ([2001:4830:134:3::10]:37884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHLeM-0002Qq-5u
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gHLeJ-0001gV-0s
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:41250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gHLeI-0001fn-P3
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 00:29:02 -0400
Received: by mail-pg1-x541.google.com with SMTP id 23-v6so4969539pgc.8
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 21:29:02 -0700 (PDT)
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 29 Oct 2018 21:28:50 -0700
Message-Id: <1540873732-3503-1-git-send-email-liq3ea@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/2] test: fw_cfg: add reboot-timeout test
 case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, thuth@redhat.com, lvivier@redhat.com, philmd@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

This patchset is the test case for the following patch:

https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg05254.html

v2:
Change qfw_cfg_get_file per Philippe's review:
https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg06340.html

Li Qiang (2):
  tests: fw_cfg: add a function to get the fw_cfg file entry
  tests: fw_cfg: add reboot_timeout test case

 tests/fw_cfg-test.c   | 10 ++++++++++
 tests/libqos/fw_cfg.c | 33 +++++++++++++++++++++++++++++++++
 tests/libqos/fw_cfg.h |  2 ++
 3 files changed, 45 insertions(+)

-- 
2.11.0
