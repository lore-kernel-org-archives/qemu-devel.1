Received: from eggs.gnu.org ([209.51.188.92]:51602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKV6-0000cg-Vx
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 17:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1gpKL2-0002x7-0m
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:36 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:37467)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@walle.cc>) id 1gpKL1-0002pp-Kj
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 16:57:35 -0500
From: Michael Walle <michael@walle.cc>
Date: Thu, 31 Jan 2019 22:56:08 +0100
Message-Id: <20190131215611.29341-1-michael@walle.cc>
Subject: [Qemu-devel] [RFC PATCH 0/3] lm32: convert to new common tcg
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Walle <michael@walle.cc>

The main problem here is, that there is no prebuilt compiler packages. Thus
I have to build the toolchain from scratch. I don't know if this is OK in
the docker image. For now only binutils is built. But then, I'll have to
pass the LD and AS environment variables, too. And it won't work with the
native host cross toolchain - unless we'll probe for the assembler and
linker, too.

Any ideas?

Michael Walle (3):
  tests/docker: add debian-lm32-cross image
  tests/tcg: also pass AS and LD variables
  tests/tcg/lm32: enable system tests

 tests/docker/Makefile.include                     |   5 +-
 tests/docker/dockerfiles/debian-lm32-cross.docker |  31 +++++++
 tests/tcg/Makefile.include                        |  13 ++-
 tests/tcg/lm32/Makefile                           | 106 ----------------------
 tests/tcg/lm32/Makefile.include                   |   8 ++
 tests/tcg/lm32/Makefile.softmmu-target            |  33 +++++++
 6 files changed, 86 insertions(+), 110 deletions(-)
 create mode 100644 tests/docker/dockerfiles/debian-lm32-cross.docker
 delete mode 100644 tests/tcg/lm32/Makefile
 create mode 100644 tests/tcg/lm32/Makefile.include
 create mode 100644 tests/tcg/lm32/Makefile.softmmu-target

-- 
2.11.0
