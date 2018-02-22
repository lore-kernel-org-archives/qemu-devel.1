Received: from eggs.gnu.org ([2001:4830:134:3::10]:49276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ep0ch-0002Dt-9y
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ep0c8-0007x5-GM
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:49:59 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:44203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ep0c7-0007uL-Od
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 18:49:23 -0500
Received: by mail-pg0-x242.google.com with SMTP id l4so2638534pgp.11
	for <qemu-devel@nongnu.org>; Thu, 22 Feb 2018 15:49:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 22 Feb 2018 15:49:18 -0800
Message-Id: <20180222234919.9060-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/1] Add decodetree.py
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

The following changes since commit ff8689611a1d954897d857b28f7ef404e11cfa2c:

  Merge remote-tracking branch 'remotes/mcayland/tags/qemu-openbios-signed' into staging (2018-02-22 11:37:05 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-decode-20180222

for you to fetch changes up to 568ae7efae7e4b90e213049efb8b6e4e12b47ca3:

  scripts: Add decodetree.py (2018-02-22 15:44:07 -0800)

----------------------------------------------------------------
Add decodetree.py

----------------------------------------------------------------
Richard Henderson (1):
      scripts: Add decodetree.py

 scripts/decodetree.py            | 1062 ++++++++++++++++++++++++++++++++++++++
 tests/Makefile.include           |    9 +-
 tests/decode/check.sh            |   18 +
 tests/decode/err_argset1.decode  |    5 +
 tests/decode/err_argset2.decode  |    5 +
 tests/decode/err_field1.decode   |    5 +
 tests/decode/err_field2.decode   |    5 +
 tests/decode/err_field3.decode   |    5 +
 tests/decode/err_field4.decode   |    6 +
 tests/decode/err_field5.decode   |    5 +
 tests/decode/err_init1.decode    |    6 +
 tests/decode/err_init2.decode    |    6 +
 tests/decode/err_init3.decode    |    7 +
 tests/decode/err_init4.decode    |    7 +
 tests/decode/err_overlap1.decode |    6 +
 tests/decode/err_overlap2.decode |    6 +
 tests/decode/err_overlap3.decode |    6 +
 tests/decode/err_overlap4.decode |    6 +
 tests/decode/err_overlap5.decode |    5 +
 tests/decode/err_overlap6.decode |    6 +
 tests/decode/err_overlap7.decode |    6 +
 tests/decode/err_overlap8.decode |    5 +
 tests/decode/err_overlap9.decode |    6 +
 23 files changed, 1202 insertions(+), 1 deletion(-)
 create mode 100755 scripts/decodetree.py
 create mode 100755 tests/decode/check.sh
 create mode 100644 tests/decode/err_argset1.decode
 create mode 100644 tests/decode/err_argset2.decode
 create mode 100644 tests/decode/err_field1.decode
 create mode 100644 tests/decode/err_field2.decode
 create mode 100644 tests/decode/err_field3.decode
 create mode 100644 tests/decode/err_field4.decode
 create mode 100644 tests/decode/err_field5.decode
 create mode 100644 tests/decode/err_init1.decode
 create mode 100644 tests/decode/err_init2.decode
 create mode 100644 tests/decode/err_init3.decode
 create mode 100644 tests/decode/err_init4.decode
 create mode 100644 tests/decode/err_overlap1.decode
 create mode 100644 tests/decode/err_overlap2.decode
 create mode 100644 tests/decode/err_overlap3.decode
 create mode 100644 tests/decode/err_overlap4.decode
 create mode 100644 tests/decode/err_overlap5.decode
 create mode 100644 tests/decode/err_overlap6.decode
 create mode 100644 tests/decode/err_overlap7.decode
 create mode 100644 tests/decode/err_overlap8.decode
 create mode 100644 tests/decode/err_overlap9.decode
