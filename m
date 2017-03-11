Received: from eggs.gnu.org ([2001:4830:134:3::10]:60446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmXvg-0001Zi-U8
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cmXvd-00047e-Hb
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:42:52 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:33445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cmXvd-00046f-Cu
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 22:42:49 -0500
Received: by mail-qk0-x241.google.com with SMTP id j127so31374098qke.0
	for <qemu-devel@nongnu.org>; Fri, 10 Mar 2017 19:42:47 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sat, 11 Mar 2017 13:42:29 +1000
Message-Id: <20170311034232.14213-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH 0/3] Fixes for hppa-linux-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, deller@gmx.de

The primary motivator here is in the third patch, allowing any
threads to be created.  Previously I had written off crashes
using threads as lack of MTTCG support without really digging
into it deeper.  Ho hum.

But in the process of looking for the root cause, Helge found
two other things that are incorrect for hppa.

For the purposes of 2.10, I believe the first patch is the way
forward.  However, if desired, in the interest of stage1-ness,
I'm willing to rewrite the first patch to use ifdef TARGET_HPPA,
and so not affect other targets.


r~


Helge Deller (1):
  linux-user: Fix TARGET_SA_* defines for HPPA

Richard Henderson (2):
  linux-user: Restrict usage of sa_restorer
  target/hppa: Fix cpu_clone_regs

 linux-user/hppa/target_cpu.h |  4 ++++
 linux-user/signal.c          |  4 ++--
 linux-user/syscall_defs.h    | 21 +++++++++++++++++++++
 3 files changed, 27 insertions(+), 2 deletions(-)

-- 
2.9.3
