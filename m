Received: from eggs.gnu.org ([2001:4830:134:3::10]:52364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBM-00010I-68
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dBaBJ-0005hg-2V
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:39329)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dBaBI-0005ha-Pa
	for qemu-devel@nongnu.org; Fri, 19 May 2017 01:10:28 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Fri, 19 May 2017 13:09:39 +0800
Message-Id: <1495170583-30905-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v0 0/4] split the tcg code and separate tcg
 files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eblake@redhat.com
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com, Yang Zhong <yang.zhong@intel.com>

In order to disable tcg, the first phase is to split some
tcg code and separate those tcg relative files into one 
directory. The next phase will disable tcg more easily.

In the first phase, there are three serial patchsets to
deal with split code and separate the files.
1) split the tcg exec code.
   a)split the tcg accelerators from accel.c file.
   b)create one accel directory, which will include kvm,
     tcg and general exec files.
   c)move tcg exec files into ./accel/tcg directory.
2) move tcg relative files into ./tcg directory
   those files include translate-all.c, translate-common.c
   and etc.
3) move kvm exec and exec.c file.
   a)move kvm relative exec files into ./accel/kvm directory.
   b)move exec.c in ./accel directory. 

The below patchset are the first serial patchset, the other two 
serial patchsets will be sent out soon.

Yang Zhong (4):
  accel: split the tcg accelerator from accel.c file
  move cputlb.c
  move cpu-exec.c
  move cpu-exec-common.c

 Makefile.objs                                    |  2 +-
 Makefile.target                                  |  6 +--
 accel/Makefile.objs                              |  2 +
 accel.c => accel/accel.c                         | 27 -----------
 accel/tcg/Makefile.objs                          |  3 ++
 cpu-exec-common.c => accel/tcg/cpu-exec-common.c |  0
 cpu-exec.c => accel/tcg/cpu-exec.c               |  5 +-
 cputlb.c => accel/tcg/cputlb.c                   |  0
 accel/tcg/tcg-all.c                              | 61 ++++++++++++++++++++++++
 accel/tcg/trace-events                           |  7 +++
 trace-events                                     |  5 --
 11 files changed, 80 insertions(+), 38 deletions(-)
 create mode 100644 accel/Makefile.objs
 rename accel.c => accel/accel.c (87%)
 create mode 100644 accel/tcg/Makefile.objs
 rename cpu-exec-common.c => accel/tcg/cpu-exec-common.c (100%)
 rename cpu-exec.c => accel/tcg/cpu-exec.c (99%)
 rename cputlb.c => accel/tcg/cputlb.c (100%)
 create mode 100644 accel/tcg/tcg-all.c
 create mode 100644 accel/tcg/trace-events

-- 
1.9.1
