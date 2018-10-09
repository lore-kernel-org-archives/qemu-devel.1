Received: from eggs.gnu.org ([2001:4830:134:3::10]:58181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tUL-0007RC-5e
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 11:00:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g9tU1-0006Na-E6
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:54 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:33759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g9tU1-0006M0-1y
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:59:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id e4-v6so2211505wrs.0
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:59:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  9 Oct 2018 15:59:30 +0100
Message-Id: <20181009145933.18925-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH  v2 0/3]  Travis tweaks and tcg test fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, f4bug@amsat.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

The new patches fix the building the i386 tests when clang is the
system compiler. All currently need review.

Alex Bennée (2):
  .travis.yml: split MacOSX builds and reduce target list
  tests/tcg: disable enterN insn tests for test-i386 with clang

Theodore Dubois (1):
  tests/tcg: make test-i386 test program compile on clang

 .travis.yml                |  8 +++++++-
 tests/tcg/i386/test-i386.c | 22 ++++++++++++++++++----
 2 files changed, 25 insertions(+), 5 deletions(-)

-- 
2.17.1
