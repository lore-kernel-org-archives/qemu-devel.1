Received: from eggs.gnu.org ([209.51.188.92]:35467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlB-00025l-M9
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlA-0000LK-DD
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:45 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1Dl9-0000EV-W8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:44 -0500
Received: by mail-wm1-x336.google.com with SMTP id n19so3357982wmi.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:21:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 17:21:27 +0000
Message-Id: <20190305172139.32662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 00/12] Enable build and install of our rST
 docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

This patchset enables building and installing the various rST
docs we have started to accumulate in our docs/ directory.

Version 3 is almost the same as version 2: the only
differences are:
 * patch 5 enabling the Alabaster theme also adds
   "needs_sphinx = '1.3'" to docs/conf.py, since that is
   where the Alabaster theme was added to Sphinx proper
 * patch 9 has a new has_sphinx_build() function which
   specifically tests that sphinx-build can handle our
   conf.py, rather than just testing the executable
   is present
 * patch 9 adds /.doctrees to the .gitignore
 * patch 12 is new and provides a MAINTAINERS entry
   for the conf.py files (ie the build infrastructure,
   as distinct from the content)

I figured the changes in patches 5 and 9 were small enough
that I've kept the various reviewed/tested/etc tags.

thanks
-- PMM

Peter Maydell (12):
  docs/cpu-hotplug.rst: Fix rST markup issues
  docs: Convert memory.txt to rst format
  docs: Commit initial files from sphinx-quickstart
  docs/conf.py: Disable unused _static directory
  docs/conf.py: Configure the 'alabaster' theme
  docs/conf.py: Don't include rST sources in HTML build
  docs/conf.py: Disable option warnings
  docs: Provide separate conf.py for each manual we want
  Makefile, configure: Support building rST documentation
  Makefile: Abstract out "identify the pkgversion" code
  docs/conf.py: Don't hard-code QEMU version
  MAINTAINERS: Add entry for Sphinx documentation infrastructure

 configure                             |  15 +-
 Makefile                              |  78 +++++++---
 .gitignore                            |   1 +
 MAINTAINERS                           |   6 +
 docs/conf.py                          | 216 ++++++++++++++++++++++++++
 docs/cpu-hotplug.rst                  |   2 +-
 docs/devel/conf.py                    |  15 ++
 docs/devel/index.rst                  |  21 +++
 docs/devel/{memory.txt => memory.rst} | 128 ++++++++-------
 docs/index.rst                        |  15 ++
 docs/interop/conf.py                  |  15 ++
 docs/interop/index.rst                |  18 +++
 12 files changed, 449 insertions(+), 81 deletions(-)
 create mode 100644 docs/conf.py
 create mode 100644 docs/devel/conf.py
 create mode 100644 docs/devel/index.rst
 rename docs/devel/{memory.txt => memory.rst} (85%)
 create mode 100644 docs/index.rst
 create mode 100644 docs/interop/conf.py
 create mode 100644 docs/interop/index.rst

-- 
2.20.1
