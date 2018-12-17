Received: from eggs.gnu.org ([2001:4830:134:3::10]:37492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqby-0002vo-4B
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:59:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gYqZx-00005B-9G
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:58 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:42383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gYqZx-0008WE-2Y
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 05:56:53 -0500
Received: by mail-wr1-x42a.google.com with SMTP id q18so11761936wrx.9
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 02:56:53 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 17 Dec 2018 10:56:35 +0000
Message-Id: <20181217105650.27361-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v3 00/15] Hardfloat + softfloat maintainers
 update and gitdm
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

The following changes since commit b019f5e5375224a003f260c89d424fea7767b7fc:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-misc-20181214' into staging (2018-12-16 16:32:43 +0000)

are available in the Git repository at:

  https://github.com/stsquad/qemu.git tags/pull-hardfloat-and-gitdm-171218-3

for you to fetch changes up to d9fe9db943d4e855a75424978d7ab87fd54edd98:

  hardfloat: implement float32/64 comparison (2018-12-17 08:25:25 +0000)

----------------------------------------------------------------
Hardfloat + maintainers and gitdm

----------------------------------------------------------------
Alex Bennée (2):
      contrib: add a basic gitdm config
      MAINTAINERS: update status of FPU emulation

Emilio G. Cota (13):
      fp-test: pick TARGET_ARM to get its specialization
      softfloat: add float{32,64}_is_{de,}normal
      target/tricore: use float32_is_denormal
      softfloat: rename canonicalize to sf_canonicalize
      softfloat: add float{32,64}_is_zero_or_normal
      tests/fp: add fp-bench
      fpu: introduce hardfloat
      hardfloat: implement float32/64 addition and subtraction
      hardfloat: implement float32/64 multiplication
      hardfloat: implement float32/64 division
      hardfloat: implement float32/64 fused multiply-add
      hardfloat: implement float32/64 square root
      hardfloat: implement float32/64 comparison

 MAINTAINERS                         |   4 +-
 contrib/gitdm/aliases               |  27 ++
 contrib/gitdm/domain-map            |  19 +
 contrib/gitdm/filetypes.txt         | 146 ++++++
 contrib/gitdm/group-map-academics   |  14 +
 contrib/gitdm/group-map-cadence     |   3 +
 contrib/gitdm/group-map-codeweavers |   1 +
 contrib/gitdm/group-map-ibm         |   6 +
 contrib/gitdm/group-map-individuals |  10 +
 contrib/gitdm/group-map-redhat      |   7 +
 contrib/gitdm/group-map-wavecomp    |  18 +
 fpu/softfloat.c                     | 865 ++++++++++++++++++++++++++++++++++--
 gitdm.config                        |  50 +++
 include/fpu/softfloat.h             |  30 ++
 target/tricore/fpu_helper.c         |   9 +-
 tests/fp/.gitignore                 |   1 +
 tests/fp/Makefile                   |   8 +-
 tests/fp/fp-bench.c                 | 630 ++++++++++++++++++++++++++
 18 files changed, 1791 insertions(+), 57 deletions(-)
 create mode 100644 contrib/gitdm/aliases
 create mode 100644 contrib/gitdm/domain-map
 create mode 100644 contrib/gitdm/filetypes.txt
 create mode 100644 contrib/gitdm/group-map-academics
 create mode 100644 contrib/gitdm/group-map-cadence
 create mode 100644 contrib/gitdm/group-map-codeweavers
 create mode 100644 contrib/gitdm/group-map-ibm
 create mode 100644 contrib/gitdm/group-map-individuals
 create mode 100644 contrib/gitdm/group-map-redhat
 create mode 100644 contrib/gitdm/group-map-wavecomp
 create mode 100644 gitdm.config
 create mode 100644 tests/fp/fp-bench.c

-- 
2.17.1
