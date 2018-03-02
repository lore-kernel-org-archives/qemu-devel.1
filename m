Received: from eggs.gnu.org ([2001:4830:134:3::10]:53368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erpr5-0002Cm-3h
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1erpr2-0003Yg-Hb
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:31 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:43181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1erpr2-0003YE-9h
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:28 -0500
Received: by mail-pl0-x243.google.com with SMTP id f23-v6so6195855plr.10
	for <qemu-devel@nongnu.org>; Fri, 02 Mar 2018 10:56:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  2 Mar 2018 10:56:19 -0800
Message-Id: <20180302185622.27780-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] tcg queued patches
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

Only three outstanding patches for now.


r~


Richard Henderson (3):
  tcg: Improve tcg_gen_muli_i32/i64
  tcg/i386: Support INDEX_op_dup2_vec for -m32
  tcg: Add choose_vector_size

 tcg/i386/tcg-target.inc.c |   9 +
 tcg/tcg-op-gvec.c         | 438 +++++++++++++++++++++++++++-------------------
 tcg/tcg-op.c              |  24 ++-
 3 files changed, 286 insertions(+), 185 deletions(-)

-- 
2.14.3
