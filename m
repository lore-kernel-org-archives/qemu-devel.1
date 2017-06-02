Received: from eggs.gnu.org ([2001:4830:134:3::10]:54397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp7w-0005wR-2F
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dGp7s-0004xz-PJ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:40 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:38198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dGp7s-0004xZ-Hb
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:08:36 -0400
Received: by mail-wm0-x22a.google.com with SMTP id n195so30607498wmg.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 09:08:36 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  2 Jun 2017 17:08:38 +0100
Message-Id: <20170602160848.4913-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v4 00/10] record/replay patches
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

Hi,

After much messing about I finally got this re-base working. The
recent re-factoring work has made the code a lot simple. I also
ran into problems getting a decent cross-compiler that could link
against a zlib. This was manly down to multi-arch conflicts when I try
and install zlib1g-dev:arm64 on my Ubuntu 16.04 dev box. Happily we
already have a decent cross compile solution for QEMU so I tweaked the
build-all-archs script to offer a --use-docker option.

The paramterise patch is a little white space messy due to the
inconsistent formatting. Maybe it would be easier to nail down what
the indent should be and run indent over the source tree?

Regards,

Alex Bennée (10):
  .gitignore: ignore build directories
  build-all-archs: support cross building via docker
  build-all-archs: support --static flag
  risu: a bit more verbosity when running
  risu: paramterise send/receive functions
  risu: add header to trace stream
  risu: add simple trace and replay support
  risu: add support compressed tracefiles
  new: record_traces.sh helper script
  new: run_risu.sh script

 .gitignore       |   1 +
 Makefile         |   4 +-
 build-all-archs  |  76 ++++++++++++++++++++++--
 configure        |  55 +++++++++++++++++-
 record_traces.sh |  20 +++++++
 reginfo.c        | 173 ++++++++++++++++++++++++++++++++-----------------------
 risu.c           | 147 ++++++++++++++++++++++++++++++++++++++++++----
 risu.h           |  23 +++++++-
 risu_aarch64.c   |   8 +++
 risu_arm.c       |   8 +++
 risu_m68k.c      |   5 ++
 risu_ppc64.c     |   5 ++
 run_risu.sh      |  53 +++++++++++++++++
 13 files changed, 484 insertions(+), 94 deletions(-)
 create mode 100755 record_traces.sh
 create mode 100755 run_risu.sh

-- 
2.13.0
