Received: from eggs.gnu.org ([2001:4830:134:3::10]:44566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiShh-0005nz-Dg
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 17:24:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eiShd-000679-C4
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 17:24:05 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:42829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eiShd-000668-5E
	for qemu-devel@nongnu.org; Sun, 04 Feb 2018 17:24:01 -0500
Received: by mail-pg0-x243.google.com with SMTP id m28so300793pgc.9
	for <qemu-devel@nongnu.org>; Sun, 04 Feb 2018 14:24:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Sun,  4 Feb 2018 14:23:53 -0800
Message-Id: <20180204222356.14546-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 0/3] hppa-softmmu update
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Clean up, and add to, make check-qtest-hppa.


r~


The following changes since commit fb2516ef94b8399ddded4a41c4346cbc1d5d98fc:

  Merge remote-tracking branch 'remotes/kraxel/tags/vga-20180202-pull-request' into staging (2018-02-02 17:24:00 +0000)

are available in the Git repository at:

  git://github.com/rth7680/qemu.git tags/pull-hppa-20180204

for you to fetch changes up to edf90bd0af98bf03ec1e60e5c7632774f62837d8:

  roms/seabios-hppa: Update submodule and image (2018-02-04 14:11:18 -0800)

----------------------------------------------------------------
hppa-softmmu update

----------------------------------------------------------------
Richard Henderson (3):
      hw/hppa: Use qemu_log_mask instead of fprintf to stderr
      tests: Enable boot-serial-test for hppa
      roms/seabios-hppa: Update submodule and image

 hw/hppa/machine.c         |  17 ++++++++---------
 tests/boot-serial-test.c  |   1 +
 pc-bios/hppa-firmware.img | Bin 461352 -> 215696 bytes
 roms/seabios-hppa         |   2 +-
 tests/Makefile.include    |   2 ++
 5 files changed, 12 insertions(+), 10 deletions(-)
