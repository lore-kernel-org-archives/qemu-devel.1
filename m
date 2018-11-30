Received: from eggs.gnu.org ([2001:4830:134:3::10]:40334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSoMs-0007iX-10
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gSoMm-00082g-Hy
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:25 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:32868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gSoMm-00082Q-3L
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 14:22:20 -0500
Received: by mail-pl1-x644.google.com with SMTP id z23so3275028plo.0
	for <qemu-devel@nongnu.org>; Fri, 30 Nov 2018 11:22:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 30 Nov 2018 11:22:14 -0800
Message-Id: <20181130192216.26987-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH for-4.0 0/2] target/s390x: Implement STCK et al
 for CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cohuck@redhat.com, david@redhat.com, qemu-s390x@nongnu.org

This is a non-privileged instruction that was only implemented
for system mode.  However, the stck instruction is used by glibc,
so this was causing SIGILL for programs run under debian stretch.


r~


Richard Henderson (2):
  target/s390x: Move TOD_UNIX_EPOCH to cpu.h
  target/s390x: Implement STCK et al for CONFIG_USER_ONLY

 include/hw/s390x/tod.h     |  3 ---
 target/s390x/cpu.h         |  3 +++
 target/s390x/helper.h      |  2 +-
 target/s390x/misc_helper.c | 13 ++++++++++++-
 target/s390x/translate.c   |  2 ++
 target/s390x/insn-data.def | 11 ++++++-----
 6 files changed, 24 insertions(+), 10 deletions(-)

-- 
2.17.2
