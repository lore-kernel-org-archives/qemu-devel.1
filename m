Received: from eggs.gnu.org ([209.51.188.92]:57001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1zNq-0006Hv-9k
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1zNp-0001xc-Ji
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:50 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:42250)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1zNp-0001wN-Bf
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 15:12:49 -0500
Received: by mail-pg1-x541.google.com with SMTP id b2so12118850pgl.9
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 12:12:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 12:12:42 -0800
Message-Id: <20190307201244.8971-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] target/arm: gdbstub system registers
 refinement
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This was working toward fixing 

  https://bugs.linaro.org/show_bug.cgi?id=4274

although I don't think I'm entirely successful.  I would argue,
however, that gdb's behaviour in this is odd.  Why are registers
that are clearly marked "system" being added to "general" simply
because they have integer type?

In the meantime, we don't really need to present these registers
to the user for CONFIG_USER_ONLY.


r~


Richard Henderson (2):
  target/arm: Put system registers in "system" group
  target/arm: Don't add system-registers.xml for user-only

 target/arm/gdbstub.c | 2 +-
 target/arm/helper.c  | 4 ++++
 2 files changed, 5 insertions(+), 1 deletion(-)

-- 
2.17.2
