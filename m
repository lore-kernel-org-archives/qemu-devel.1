Received: from eggs.gnu.org ([2001:4830:134:3::10]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbO-00010X-Ax
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fTmbK-0006Er-C9
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:10 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:35978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fTmbJ-0006Dw-Sd
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:09:06 -0400
Received: by mail-wr0-x22e.google.com with SMTP id f16-v6so9545215wrm.3
	for <qemu-devel@nongnu.org>; Fri, 15 Jun 2018 04:09:05 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 15 Jun 2018 12:09:00 +0100
Message-Id: <20180615110903.29674-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] Travis updates
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

The following changes since commit 409c241f887a38bb7a2ac12e34d3a8d73922a9a5:

  Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180614-pull-request' into staging (2018-06-14 14:04:14 +0100)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-travis-updates-140618-1

for you to fetch changes up to f8309de9b7e7de1bfdfaddf8df4130a06e7e31b7:

  travis: reduce time taken for trace-backend testing (2018-06-14 20:24:07 +0100)

----------------------------------------------------------------
Travis updates

  - show config.log when failing
  - reduce time for gprof build
  - reduce time for alternate trace builds

----------------------------------------------------------------
Alex Bennée (2):
      travis: reduce coverage of gprof build
      travis: reduce time taken for trace-backend testing

Daniel P. Berrangé (1):
      travis: display config.log when configure fails

 .travis.yml | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

-- 
2.17.1
