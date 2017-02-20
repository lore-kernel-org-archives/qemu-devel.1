Received: from eggs.gnu.org ([2001:4830:134:3::10]:53382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZD-0006iC-H0
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cflZA-0006Ko-EO
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:39 -0500
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35396)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cflZA-0006KE-8H
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 05:51:36 -0500
Received: by mail-wr0-x233.google.com with SMTP id s27so14708802wrb.2
	for <qemu-devel@nongnu.org>; Mon, 20 Feb 2017 02:51:35 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 20 Feb 2017 10:51:35 +0000
Message-Id: <20170220105139.21581-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 0/4] Docker cross-compile targets and user
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

Hopefully this is the final iteration. A couple of minor typos fixes
and your suggestions taken into account. I have also added some
review/tesing tags from Philippe.

Alex.


Alex Bennée (4):
  tests/docker: add basic user mapping support
  new: debian docker targets for cross-compiling
  .shippable.yml: new CI provider
  MAINTAINERS: merge Build and test automation with Docker tests

 .shippable.yml                                     | 19 ++++++++++++++++
 MAINTAINERS                                        | 13 ++++++-----
 tests/docker/Makefile.include                      |  6 ++++++
 tests/docker/common.rc                             |  2 +-
 tests/docker/docker.py                             | 16 ++++++++++++--
 tests/docker/dockerfiles/debian-arm64-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker | 15 +++++++++++++
 tests/docker/dockerfiles/debian.docker             | 25 ++++++++++++++++++++++
 8 files changed, 101 insertions(+), 10 deletions(-)
 create mode 100644 .shippable.yml
 create mode 100644 tests/docker/dockerfiles/debian-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian.docker

-- 
2.11.0
