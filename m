Received: from eggs.gnu.org ([2001:4830:134:3::10]:48428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceLH4-0007pP-Ug
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ceLH0-0001DN-MC
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:35:02 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:36927)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ceLH0-0001Cp-GE
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 07:34:58 -0500
Received: by mail-wm0-x236.google.com with SMTP id v77so14049162wmv.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 04:34:58 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 16 Feb 2017 12:34:52 +0000
Message-Id: <20170216123456.28621-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 0/4] Docker cross-compile targets and user
 build support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Fam,

Here is the latest iteration of the docker changes incorporating your
suggestions:

  - -u behaves safely if user already added
  - cross containers specify QEMU_CONFIGURE_OPTS
  - merged docker and build automation in MAINTAINERS

Regards,

Alex Bennée (4):
  tests/docker: add basic user mapping support
  new: debian docker targets for cross-compiling
  .shippable.yml: new CI provider
  MAINTAINERS: merge Build and test automation with Docker tests

 .shippable.yml                                     | 21 ++++++++++++++++++
 MAINTAINERS                                        | 13 ++++++-----
 tests/docker/Makefile.include                      |  6 ++++++
 tests/docker/common.rc                             |  2 +-
 tests/docker/docker.py                             | 16 ++++++++++++--
 tests/docker/dockerfiles/debian-arm64-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian.docker             | 25 ++++++++++++++++++++++
 8 files changed, 103 insertions(+), 10 deletions(-)
 create mode 100644 .shippable.yml
 create mode 100644 tests/docker/dockerfiles/debian-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian.docker

-- 
2.11.0
