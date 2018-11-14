Received: from eggs.gnu.org ([2001:4830:134:3::10]:40470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuvu-0001K8-PK
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMuvr-0004Gf-GZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:14 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:38049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMuvr-0004Fe-4R
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 08:10:11 -0500
Received: by mail-wr1-x42c.google.com with SMTP id e3-v6so17251179wrs.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 05:10:11 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 14 Nov 2018 13:10:06 +0000
Message-Id: <20181114131008.27599-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL for 3.1 0/2] Testing tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 186ac05f749c69e98030f037aa930ff2bc4ad7fb:

  Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-pull-request' into staging (2018-11-13 11:45:16 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-testing-fixes-for-3.1-141118-1

for you to fetch changes up to 1f442da51e088160e892c4e059c154eec3f058c5:

  tests/tcg/multiarch: fix 32bit linux-test on 64bit host (2018-11-14 11:07:06 +0000)

----------------------------------------------------------------
Testing tweaks:

  - split MacOSX build
  - fix for readdir() failures in check-tcg

----------------------------------------------------------------
Alex Bennée (1):
      .travis.yml: split MacOSX builds and reduce target list

Laurent Vivier (1):
      tests/tcg/multiarch: fix 32bit linux-test on 64bit host

 .travis.yml                      | 8 +++++++-
 tests/tcg/multiarch/linux-test.c | 4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.17.1
