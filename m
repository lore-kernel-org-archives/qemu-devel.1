Received: from eggs.gnu.org ([209.51.188.92]:46619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxrw-0001vf-J9
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLxrs-0007vb-TV
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:27 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:41269)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLxrq-0007u0-TN
	for qemu-devel@nongnu.org; Wed, 01 May 2019 18:38:23 -0400
Received: by mail-pf1-x431.google.com with SMTP id 188so115533pfd.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 15:38:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  1 May 2019 15:38:17 -0700
Message-Id: <20190501223819.8584-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] configure: Fix make check-tcg for ppc64le
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, david@gibson.dropbear.id.au, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org

At present make check-tcg will produce errors like

  RUN     tests for ppc64
  TEST    test-mmap (default) on ppc64
test-mmap: Invalid ELF image for this architecture
make[2]: *** [run-test-mmap] Error 255
make[1]: *** [run-guest-tests] Error 2
make: *** [run-tcg-tests-ppc64-linux-user] Error 2

which is caused by the use of the host ppc64le compiler
in building guest ppc64(be) executables.


r~


Richard Henderson (2):
  configure: Distinguish ppc64 and ppc64le hosts
  configure: Use quotes around uses of $CPU_CFLAGS

 configure | 54 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 20 deletions(-)

-- 
2.17.1
