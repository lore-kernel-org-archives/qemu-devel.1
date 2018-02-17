Received: from eggs.gnu.org ([2001:4830:134:3::10]:46176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en5Xa-0005OP-J5
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en5XX-0001j7-GC
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:46 -0500
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:34483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en5XX-0001ip-98
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 11:40:43 -0500
Received: by mail-pl0-x244.google.com with SMTP id bd10so3365713plb.1
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 08:40:43 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	a6sm29152324pfi.99.2018.02.17.08.40.39 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 08:40:40 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 08:40:35 -0800
Message-Id: <20180217164037.15727-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] tcg: tcg_can_emit_vec_op cleanup+fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

While rearranging/rebasing my SVE patch set, I triggered an
assert in tcg_gen_mul_vec.  Turns out we should not have gone
down that path, due to a missing tcg_can_emit_vec_op check.

Tidy the usage of tcg_can_emit_vec_op to avoid code clutter.


r~


Richard Henderson (2):
  tcg: Fold unspecified opcode test into tcg_can_emit_vec_op
  tcg: Add missing tcg_can_emit_vec_op check in tcg_gen_gvec_2s

 tcg/aarch64/tcg-target.inc.c |  4 ++++
 tcg/i386/tcg-target.inc.c    |  4 ++++
 tcg/tcg-op-gvec.c            | 37 ++++++++++++++++++-------------------
 3 files changed, 26 insertions(+), 19 deletions(-)

-- 
2.14.3
