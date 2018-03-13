Received: from eggs.gnu.org ([2001:4830:134:3::10]:40190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn4K-0000y2-4e
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1evn4F-0000TC-UR
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:32 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:41693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1evn4F-0000T0-NX
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:46:27 -0400
Received: by mail-wr0-x22f.google.com with SMTP id f14so723034wre.8
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 09:46:27 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 13 Mar 2018 16:46:22 +0000
Message-Id: <20180313164625.4646-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] Reduce Travis timeouts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, berrange@redhat.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The following changes since commit 22ef7ba8e8ce7fef297549b3defcac333742b804:

  Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-03-13 11:42:45 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-travis-speedup-130318-1

for you to fetch changes up to 0b438fa627ca192e4be2c527bf188706d64bdd0d:

  .travis.yml: add --disable-user with the rest of the disables (2018-03-13 16:22:23 +0000)

----------------------------------------------------------------
Some updates to reduce timeouts in Travis

----------------------------------------------------------------
Alex Bennée (3):
      .travis.yml: drop setting default log output
      .travis.yml: split default config into system and user
      .travis.yml: add --disable-user with the rest of the disables

 .travis.yml | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)


-- 
2.16.2
