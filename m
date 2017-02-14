Received: from eggs.gnu.org ([2001:4830:134:3::10]:55728)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cda12-00063z-Uu
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cda0x-0008LY-VT
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:07:20 -0500
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:33718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cda0x-0008LA-Nv
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:07:15 -0500
Received: by mail-wr0-x230.google.com with SMTP id i10so166528653wrb.0
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 02:07:15 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 14 Feb 2017 10:07:30 +0000
Message-Id: <20170214100733.22280-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 0/3] Docker cross-compile targets and user
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

Here is the latest iteration of the docker changes without the random
guff from the last posting. I've re-arranged the docker images so now
the cross-builds targets are explicitly built from the Debian base.
This means a standard cross build can be triggered as normal with:

   make docker-test-build@debian-armhf-cross J=9 \
     EXTRA_CONFIGURE_OPTS="--cross-prefix=arm-linux-gnueabihf-" \
     TARGET_LIST="arm-softmmu,arm-linux-user"

I've included the shippable.yml which exercises the cross build docker
recipes and runs a limited build with them. I'm happy to include this
in my next Travis related pull once the underlying Docker bits are
merged.

Regards,


Alex.


Alex Bennée (3):
  tests/docker: add basic user mapping support
  new: debian docker targets for cross-compiling
  .shippable.yml: new CI provider

 .shippable.yml                                     | 23 ++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 tests/docker/Makefile.include                      |  6 ++++++
 tests/docker/docker.py                             | 15 +++++++++++--
 tests/docker/dockerfiles/debian-arm64-cross.docker | 12 +++++++++++
 tests/docker/dockerfiles/debian-armhf-cross.docker | 12 +++++++++++
 tests/docker/dockerfiles/debian.docker             | 25 ++++++++++++++++++++++
 7 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 .shippable.yml
 create mode 100644 tests/docker/dockerfiles/debian-arm64-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian-armhf-cross.docker
 create mode 100644 tests/docker/dockerfiles/debian.docker

-- 
2.11.0
