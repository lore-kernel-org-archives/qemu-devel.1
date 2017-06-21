Received: from eggs.gnu.org ([2001:4830:134:3::10]:52444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhlm-0006Cl-D1
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNhlh-0002pU-PJ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:14 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNhlh-0002pM-GQ
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:42:09 -0400
Received: by mail-wr0-x230.google.com with SMTP id c11so84692316wrc.3
	for <qemu-devel@nongnu.org>; Wed, 21 Jun 2017 08:42:09 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Wed, 21 Jun 2017 16:42:34 +0100
Message-Id: <20170621154244.28309-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH v6 00/10] Record/replay patches
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

Hi Peter,

Re-based with review comments addressed and tags added where
appropriate.

Alex Bennée (10):
  README: document the coding style used for risu
  build-all-archs: support cross building via docker
  risu: a bit more verbosity when starting
  risu: paramterise send/receive functions
  risu: add header to trace stream
  risu: add simple trace and replay support
  risu: handle trace through stdin/stdout
  risu: add support compressed tracefiles
  new: record_traces.sh helper script
  new: run_risu.sh script

 .dir-locals.el           |   2 +
 Makefile                 |   4 +-
 README                   |   9 +++
 build-all-archs          |  46 ++++++++++--
 configure                |  55 +++++++++++++-
 contrib/record_traces.sh |  32 +++++++++
 contrib/run_risu.sh      |  66 +++++++++++++++++
 reginfo.c                | 120 ++++++++++++++++++-------------
 risu.c                   | 181 ++++++++++++++++++++++++++++++++++++++++++-----
 risu.h                   |  23 +++++-
 risu_aarch64.c           |   5 ++
 risu_arm.c               |   5 ++
 risu_m68k.c              |   5 ++
 risu_ppc64.c             |   5 ++
 14 files changed, 481 insertions(+), 77 deletions(-)
 create mode 100644 .dir-locals.el
 create mode 100755 contrib/record_traces.sh
 create mode 100755 contrib/run_risu.sh

-- 
2.13.0
