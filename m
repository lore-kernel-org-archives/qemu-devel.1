Received: from eggs.gnu.org ([2001:4830:134:3::10]:36438)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8GkT-0004RG-Tc
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f8GkQ-0007XQ-TT
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:38 -0400
Received: from mail-pl0-x242.google.com ([2607:f8b0:400e:c01::242]:42970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f8GkQ-0007V6-MQ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:53:34 -0400
Received: by mail-pl0-x242.google.com with SMTP id t20-v6so11152206ply.9
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 19:53:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 16 Apr 2018 16:53:26 -1000
Message-Id: <20180417025328.25431-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.12 0/2] softfloat fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org

An alternate fix for Bastian's division problem and another
fix for a scalbn problem exposed during SVE testing.  Again,
the SVE issue should be visible with normal NEON insns too.


r~


Richard Henderson (2):
  fpu: Check for inf/x before x/0
  fpu: Bound increment for scalbn

 fpu/softfloat.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.14.3
