Received: from eggs.gnu.org ([2001:4830:134:3::10]:41368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4k-00041M-0g
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fYh4g-0006ba-Ro
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:45 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34642)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fYh4g-0006aK-Fo
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 20:15:42 -0400
Received: by mail-pg0-x244.google.com with SMTP id y1-v6so3173911pgv.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 17:15:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 28 Jun 2018 17:15:32 -0700
Message-Id: <20180629001538.11415-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/6] target/arm SVE updates
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

Patch 1 fixes the SIGFPE that Alex found with --test-sve=3.
Patch 2 fixes a problem pointed out by Laurent, presumably
via inspection.
  
The rest begin enabling cpu features for -cpu max.
I'm still working on SVE itself, but these are standalone
and perhaps worth merging before softfreeze. 
  
 
r~
 

Richard Henderson (6):
  target/arm: Fix SVE signed division vs x86 overflow exception
  target/arm: Fix SVE system register access checks
  target/arm: Prune a57 features from max
  target/arm: Prune a15 features from max
  target/arm: Add ID_ISAR6
  target/arm: Set ISAR bits for -cpu max

 target/arm/cpu.h           |  1 +
 target/arm/cpu.c           | 31 +++++++++++++++++--------
 target/arm/cpu64.c         | 47 ++++++++++++++++++++++++--------------
 target/arm/helper.c        | 13 +++++------
 target/arm/sve_helper.c    | 16 +++++++++----
 target/arm/translate-a64.c |  5 ++--
 6 files changed, 71 insertions(+), 42 deletions(-)

-- 
2.17.1
