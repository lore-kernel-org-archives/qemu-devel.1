Received: from eggs.gnu.org ([2001:4830:134:3::10]:48375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZe-0005u1-74
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZa-00025C-TI
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:26 -0400
Received: from mail-qk0-x229.google.com ([2607:f8b0:400d:c09::229]:35215)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dfXZa-00024D-Pl
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 16:27:22 -0400
Received: by mail-qk0-x229.google.com with SMTP id d145so42817552qkc.2
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 13:27:21 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  9 Aug 2017 17:26:56 -0300
Message-Id: <20170809202712.6951-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for-2.11 v3 00/16] travis: speedup to reduce
 failures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

These patches try to improve our Travis CI usage (few failures the last days):
- lower false negative rate (mostly network issues),
- improved code coverage,
- speedup failure detection.

dropped since v2 (will follow as a separate series)
- multicore parallelism use
- cache use

Patch 1 is expected to enter /master as of yesterday.
Travis warned few months ago:
  "On Wednesday, June 21st 2017, we are going to update all our Ubuntu Trusty
  14.04 images."

Patches 4-6 try to avoid aborting a job on network failure.

Patches 7-9 intend to speedup jobs.

Patch 10 gives hint when ./configure fails, patch 12 silent build warnings.

RFC patch 13 uses upgraded GCC v5 -> v6.
RFC patch 14 don't fails the build if the slow gprof/gcov job fail.

Patches 15, 16 add more OSX VMs/toolchains (older, newer, bleeding edge).

Regards,

Phil.

Peter Maydell (1):
  travis: install more library dependencies

Philippe Mathieu-Daudé (15):
  travis: update sudo-enabled Trusty images
  travis: enable multiple caching features
  travis: increase S3 cache timeout
  travis: retry if llvm.org timeouts
  travis: retry when git submodules initialization fails
  travis: split the gprof/gcov job
  travis: reorder matrix to speedup failure
  travis: reduce git clone depth
  travis: check ./configure outcome, dump config.log on failure
  travis/osx: use readable YAML
  travis/osx: silent texinfo warnings
  RFC travis: use gcc-6 sanitizers
  RFC travis: allow_failures for gprof/gcov
  RFC travis/osx: build using more Xcode versions
  NOTFORMERGE travis/osx: build using bleeding Xcode

 .travis.yml | 134 +++++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 97 insertions(+), 37 deletions(-)

-- 
2.13.3
