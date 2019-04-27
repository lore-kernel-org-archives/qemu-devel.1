Received: from eggs.gnu.org ([209.51.188.92]:41304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBZu-0005He-MD
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:52:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hKBYv-000105-BI
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:30 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hKBYv-0000zP-5k
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 20:51:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id y27so1634487pgl.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 17:51:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-179-147.tukw.qwest.net.
	[97.113.179.147]) by smtp.gmail.com with ESMTPSA id
	b20sm5301745pff.118.2019.04.26.17.51.24 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 17:51:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 26 Apr 2019 17:51:22 -0700
Message-Id: <20190427005124.12756-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/alpha: Fix bug 1701835
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Serves me right for really only being interested in system testing.
Anyway, in order to emulate user-only properly, we have to do all
of the crazy things the kernel does, forced on us by the crazy DEC
hardware engineers.


r~


Richard Henderson (2):
  target/alpha: Clean up alpha_cpu_dump_state
  target/alpha: Fix user-only floating-point exceptions

 linux-user/syscall_defs.h |   3 +-
 target/alpha/cpu.h        |  42 +++++++++++++++
 linux-user/syscall.c      | 104 ++++++++++++++++++--------------------
 target/alpha/fpu_helper.c |  21 ++++++--
 target/alpha/helper.c     |  39 ++++++++++----
 5 files changed, 140 insertions(+), 69 deletions(-)

-- 
2.17.1
