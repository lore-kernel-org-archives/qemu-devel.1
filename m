Received: from eggs.gnu.org ([2001:4830:134:3::10]:54994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVd2N-0007yC-E0
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fVd2J-0002k3-C7
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:39 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:36362)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fVd2J-0002jh-3M
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 09:20:35 -0400
Received: by mail-wr0-x244.google.com with SMTP id f16-v6so3296952wrm.3
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 06:20:35 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 20 Jun 2018 14:20:27 +0100
Message-Id: <20180620132032.12952-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 0/5] Tweak code coverage reporting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

While trying to make sense of some of the gcov reporting in the Travis
tests I came to the conclusion it wasn't really the most helpful
setting. This series pulls the per-test coverage reset and reporting
and adds a new target that uses the gcovr tool to generate nice pretty
html reports.

The travis build is tweaked to summarise the entire testing run at the
end rather than interleave the coverage reports while the tests are
running. Hopefully this makes filtering the noise out a little easier.

Alex Bennée (5):
  build-system: remove per-test GCOV reporting
  .gitignore: add .gcov files
  .travis.yml: add gcovr summary for GCOV build
  build-system: add clean-coverage target
  build-system: add coverage-report target

 .gitignore             |  1 +
 .travis.yml            |  3 +++
 Makefile               | 24 ++++++++++++++++++++++++
 docs/devel/testing.rst | 21 +++++++++++++++------
 tests/Makefile.include | 10 ----------
 5 files changed, 43 insertions(+), 16 deletions(-)

-- 
2.17.1
