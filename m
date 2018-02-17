Received: from eggs.gnu.org ([2001:4830:134:3::10]:41858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en993-0008OP-2C
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1en98z-0000hU-Uh
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:41 -0500
Received: from mail-pl0-x236.google.com ([2607:f8b0:400e:c01::236]:45836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1en98z-0000hF-O2
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 15:31:37 -0500
Received: by mail-pl0-x236.google.com with SMTP id p5so3525748plo.12
	for <qemu-devel@nongnu.org>; Sat, 17 Feb 2018 12:31:37 -0800 (PST)
Received: from cloudburst.twiddle.net ([50.0.192.64])
	by smtp.gmail.com with ESMTPSA id
	y7sm48203797pfe.26.2018.02.17.12.31.33 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 17 Feb 2018 12:31:34 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sat, 17 Feb 2018 12:31:13 -0800
Message-Id: <20180217203132.31780-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/19] target/hppa: Convert to decodetree.py
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The existing hppa backend uses a lot of mask/compare tables
to do decoding beyond the major opcode.  Converting the port
to the autogenerator makes things lots easier to read.


r~


Richard Henderson (19):
  target/hppa: Use DisasContextBase.is_jmp
  target/hppa: Begin using scripts/decodetree.py
  target/hppa: Convert move to/from system registers
  target/hppa: Convert remainder of system insns
  target/hppa: Unify specializations of OR
  target/hppa: Convert memory management insns
  target/hppa: Convert arithmetic/logical insns
  target/hppa: Convert indexed memory insns
  target/hppa: Convert fp multiply-add
  target/hppa: Convert conditional branches
  target/hppa: Convert shift, extract, deposit insns
  target/hppa: Convert direct and indirect branches
  target/hppa: Convert arithmetic immediate insns
  target/hppa: Convert offset memory insns
  target/hppa: Convert fp indexed memory insns
  target/hppa: Convert halt/reset insns
  target/hppa: Convert fp fused multiply-add insns
  target/hppa: Convert fp operate insns
  target/hppa: Merge translate_one into hppa_tr_translate_insn

 target/hppa/translate.c   | 3186 ++++++++++++++++++---------------------------
 target/hppa/Makefile.objs |    8 +
 target/hppa/insns.decode  |  525 ++++++++
 3 files changed, 1781 insertions(+), 1938 deletions(-)
 create mode 100644 target/hppa/insns.decode

-- 
2.14.3
