Received: from eggs.gnu.org ([2001:4830:134:3::10]:37756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZNl-0003cD-Iy
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsZNg-0006Gl-Q4
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:01:01 -0400
Received: from mail-pf0-x22e.google.com ([2607:f8b0:400e:c00::22e]:51735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsZNg-0006GO-I0
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 15:00:56 -0400
Received: by mail-pf0-x22e.google.com with SMTP id b70so146803pfl.8
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 12:00:56 -0700 (PDT)
Received: from bigtime.twiddle.net (97-126-103-167.tukw.qwest.net.
	[97.126.103.167]) by smtp.gmail.com with ESMTPSA id
	m24sm32941520pfj.28.2017.09.14.12.00.53 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Thu, 14 Sep 2017 12:00:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Sep 2017 12:00:49 -0700
Message-Id: <20170914190053.27625-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] tcg: Fully convert tcg_target_op_def
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The tcg/aarch64 version has already been posted as a part
of my vector operations patch set.  This is simply source
code quality improvement, therefore I skip tcg/tci.  But
this takes care of all of the rest.


r~


Richard Henderson (4):
  tcg/arm: Fully convert tcg_target_op_def
  tcg/ppc: Fully convert tcg_target_op_def
  tcg/sparc: Fully convert tcg_target_op_def
  tcg/mips: Fully convert tcg_target_op_def

 tcg/arm/tcg-target.inc.c   | 186 +++++++++++++++-----------
 tcg/mips/tcg-target.inc.c  | 324 ++++++++++++++++++++++++---------------------
 tcg/ppc/tcg-target.inc.c   | 321 +++++++++++++++++++++++---------------------
 tcg/sparc/tcg-target.inc.c | 239 +++++++++++++++++++--------------
 4 files changed, 582 insertions(+), 488 deletions(-)

-- 
2.13.5
