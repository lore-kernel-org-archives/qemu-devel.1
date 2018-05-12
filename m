Received: from eggs.gnu.org ([2001:4830:134:3::10]:46941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYly-0005x2-3X
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fHYlt-0002sX-8w
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:34 -0400
Received: from mail-pf0-x233.google.com ([2607:f8b0:400e:c00::233]:34091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fHYlt-0002rC-2A
	for qemu-devel@nongnu.org; Sat, 12 May 2018 13:57:29 -0400
Received: by mail-pf0-x233.google.com with SMTP id a14-v6so4154743pfi.1
	for <qemu-devel@nongnu.org>; Sat, 12 May 2018 10:57:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 12 May 2018 10:57:20 -0700
Message-Id: <20180512175724.5923-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/xtensa: Convert to TranslatorOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcmvbkbc@gmail.com

I have one xtensa image against which to test this.
There are enough options going on here in the xtensa
frontend that this probably needs a better work-out.


r~


Richard Henderson (4):
  target/xtensa: Replace DISAS_UPDATE with DISAS_NORETURN
  target/xtensa: Convert to DisasContextBase
  target/xtensa: Change gen_intermediate_code dc to pointer
  target/xtensa: Convert to TranslatorOps

 target/xtensa/translate.c | 345 +++++++++++++++++++-------------------
 1 file changed, 177 insertions(+), 168 deletions(-)

-- 
2.17.0
