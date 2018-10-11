Received: from eggs.gnu.org ([2001:4830:134:3::10]:54211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkaq-0001o6-DS
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gAkak-00029W-48
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:12 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:38558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gAkai-0001tD-2w
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 19:42:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id f8-v6so4906643pgq.5
	for <qemu-devel@nongnu.org>; Thu, 11 Oct 2018 16:42:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 11 Oct 2018 16:41:52 -0700
Message-Id: <20181011234159.11496-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/7] target/ppc: Some cleanups to fp exceptions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: david@gibson.dropbear.id.au, qemu-ppc@nongnu.org

There are a few bugs here, primarily wrt usage of GETPC().
But there is opportunity to share more code between paths
that operate on different floating point types.

This is not everything that could be done, but it's a good start.
Better for this not to hang out on a branch for another release.


r~


Richard Henderson (7):
  target/ppc: Split up float_invalid_op_excp
  target/ppc: Remove float_check_status
  target/ppc: Introduce fp number classification
  target/ppc: Split out float_invalid_op_addsub
  target/ppc: Split out float_invalid_op_mul
  target/ppc: Split out float_invalid_op_div
  target/ppc: Split out float_invalid_cvt

 target/ppc/fpu_helper.c | 661 ++++++++++++++++++++--------------------
 1 file changed, 327 insertions(+), 334 deletions(-)

-- 
2.17.1
