Received: from eggs.gnu.org ([209.51.188.92]:46108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQi2-0004HG-5y
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:34:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtQel-00075j-6t
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:30:56 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45272)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtQek-00068w-HT
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 00:30:54 -0500
Received: by mail-pf1-x442.google.com with SMTP id j3so718255pfi.12
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 21:30:47 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 11 Feb 2019 21:30:42 -0800
Message-Id: <20190212053044.29015-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 0/2] target/s390x: Implement STCK et al for
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
Cc: qemu-s390x@nongnu.org, cohuck@redhat.com

Changes since v2:
  * Fix botched subject line, include r-b tags.

Changes since v1:
  * Move more of hw/s390x/tod.h to a new header.
  * Use time2tod.


r~


Richard Henderson (2):
  target/s390x: Split out s390-tod.h
  target/s390x: Implement STCK et al for CONFIG_USER_ONLY

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
