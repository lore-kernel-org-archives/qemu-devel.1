Received: from eggs.gnu.org ([209.51.188.92]:33836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utD-0002V7-7O
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:24:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1utC-0004kA-Aw
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:24:55 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:39120)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1utC-0004jO-3V
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 10:24:54 -0500
Received: by mail-wm1-x336.google.com with SMTP id z84so9649162wmg.4
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 07:24:53 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id d1sm5338345wrs.13.2019.03.07.07.24.51
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 07 Mar 2019 07:24:51 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Mar 2019 15:24:38 +0000
Message-Id: <20190307152450.20340-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 00/12] sphinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The only difference from the v3 patchset is that I've
changed a -d to -e in patch 10 as suggested by RTH.

thanks
-- PMM

The following changes since commit 32694e98b8d7a246345448a8f707d2e11d6c65e2:

  Merge remote-tracking branch 'remotes/ehabkost/tags/machine-next-pull-request' into staging (2019-03-06 18:52:19 +0000)

are available in the Git repository at:

  https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-sphinx-20190307

for you to fetch changes up to c10e01b996df09f6cb4eceb2b7a9754bece927c9:

  MAINTAINERS: Add entry for Sphinx documentation infrastructure (2019-03-07 14:26:47 +0000)

----------------------------------------------------------------
Enable building and installing rST docs with Sphinx

----------------------------------------------------------------
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

 configure                             |  15 ++-
 Makefile                              |  78 ++++++++----
 .gitignore                            |   1 +
 MAINTAINERS                           |   6 +
 docs/conf.py                          | 216 ++++++++++++++++++++++++++++++++++
 docs/cpu-hotplug.rst                  |   2 +-
 docs/devel/conf.py                    |  15 +++
 docs/devel/index.rst                  |  21 ++++
 docs/devel/{memory.txt => memory.rst} | 128 +++++++++++---------
 docs/index.rst                        |  15 +++
 docs/interop/conf.py                  |  15 +++
 docs/interop/index.rst                |  18 +++
 12 files changed, 449 insertions(+), 81 deletions(-)
 create mode 100644 docs/conf.py
 create mode 100644 docs/devel/conf.py
 create mode 100644 docs/devel/index.rst
 rename docs/devel/{memory.txt => memory.rst} (85%)
 create mode 100644 docs/index.rst
 create mode 100644 docs/interop/conf.py
 create mode 100644 docs/interop/index.rst
