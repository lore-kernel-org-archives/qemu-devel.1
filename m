Received: from eggs.gnu.org ([209.51.188.92]:39289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsMBB-0000S1-OX
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsMBA-0007JS-U3
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:31:57 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsMBA-0007IS-Mt
	for qemu-devel@nongnu.org; Sat, 09 Feb 2019 01:31:56 -0500
Received: by mail-pg1-x544.google.com with SMTP id d72so2536690pga.9
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 22:31:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  8 Feb 2019 22:31:50 -0800
Message-Id: <20190209063152.9490-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 0/2] target/s390x: Implement STCK et al for
 CONFIG_USER_ONLY
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, thuth@redhat.com

Changes since v1:
  * Move more of hw/s390x/tod.h to a new header.
  * Use time2tod.


r~


Richard Henderson (2):
  target/s390x: Split out s390-tod.h
  This is a non-privileged instruction that was only implemented for
    system mode.  However, the stck instruction is used by glibc, so
    this was causing SIGILL for programs run under debian stretch.

 include/hw/s390x/tod.h     | 16 +---------------
 target/s390x/helper.h      |  2 +-
 target/s390x/s390-tod.h    | 29 +++++++++++++++++++++++++++++
 target/s390x/misc_helper.c | 34 ++++++++++++++++++++++------------
 target/s390x/translate.c   |  2 ++
 target/s390x/insn-data.def | 11 ++++++-----
 6 files changed, 61 insertions(+), 33 deletions(-)
 create mode 100644 target/s390x/s390-tod.h

-- 
2.17.2
