Received: from eggs.gnu.org ([2001:4830:134:3::10]:58584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpJ-0002ng-9J
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fPqpF-0003xm-BU
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:17 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:35463)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fPqpF-0003x6-4a
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 10:51:13 -0400
Received: by mail-wr0-x243.google.com with SMTP id l10-v6so9449093wrn.2
	for <qemu-devel@nongnu.org>; Mon, 04 Jun 2018 07:51:12 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon,  4 Jun 2018 15:51:02 +0100
Message-Id: <20180604145109.30498-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 0/7] updates for Docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi,

I was prompted on IRC so I've gathered together some of the
outstanding docker related patches from the list. It also includes a
few of the docker related tweaks from my mega TCG testing series whcih
should hopefully bring the delta down. I plan to send the pull request
in tomorrow if nothing comes up.

Alex.

Alex Bennée (2):
  docker: add "probe" command for configure
  configure: add test for docker availability

Fam Zheng (3):
  Makefile: Rename TARGET_DIRS to TARGET_LIST
  docker: Add fedora-i386-cross image
  docker: Update fedora image to 28

Paolo Bonzini (1):
  docker: test-mingw: use SDL2 and GTK+3

Philippe Mathieu-Daudé (1):
  docker: add debian/tricore image

 Makefile                                      | 20 ++++++++--------
 configure                                     | 19 ++++++++++++++-
 scripts/create_config                         |  2 +-
 tests/Makefile.include                        |  2 +-
 tests/docker/Makefile.include                 |  3 +++
 tests/docker/docker.py                        | 18 +++++++++++++++
 .../dockerfiles/debian-tricore-cross.docker   | 23 +++++++++++++++++++
 .../dockerfiles/fedora-i386-cross.docker      | 14 +++++++++++
 tests/docker/dockerfiles/fedora.docker        | 10 ++++----
 tests/docker/test-mingw                       |  4 ++--
 10 files changed, 95 insertions(+), 20 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-tricore-cross.docker
 create mode 100644 tests/docker/dockerfiles/fedora-i386-cross.docker

-- 
2.17.0
