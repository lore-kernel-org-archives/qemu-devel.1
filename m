Received: from eggs.gnu.org ([2001:4830:134:3::10]:39785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7k3w-0006iG-QG
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 11:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7k3s-0005g1-Gj
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 11:27:15 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:51132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7k3s-0005eZ-9q
	for qemu-devel@nongnu.org; Thu, 26 Oct 2017 11:27:12 -0400
Received: by mail-wr0-x244.google.com with SMTP id p96so3542637wrb.7
	for <qemu-devel@nongnu.org>; Thu, 26 Oct 2017 08:27:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 26 Oct 2017 17:27:02 +0200
Message-Id: <20171026152704.24525-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] tcg constant pool fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, laurent.desnogues@gmail.com

As noted by Laurent in private mail, foo-linux-user is currently
broken on aarch64 host in unususal circumstances.  By inspection,
the same thing could happen for armv6 host.  My testing is always
on armv7 hardware, so I wouldn't have seen this.

With that fixed, the s390x code can be simplified a bit to take
advantage of this.

If the s390x maintainers could test this, I would appreciate it. 
The test case is

  ./i386-linux-user/qemu-i386 -B 0x111231000 ./some-static-i386

e.g. using the binary in the busyboxes tarball linked from

  https://wiki.qemu.org/Testing#User_mode_emulation

although any staticly linked binary would work.


r~


Richard Henderson (2):
  tcg: Allow constant pool entries in the prologue
  tcg/s390x: Use constant pool for prologue

 tcg/s390/tcg-target.inc.c | 44 ++++++++++++------------------------------
 tcg/tcg.c                 | 49 ++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 54 insertions(+), 39 deletions(-)

-- 
2.13.6
