Received: from eggs.gnu.org ([2001:4830:134:3::10]:33427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXDWC-00086k-VY
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dXDWA-0003On-2B
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:25:28 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:34275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dXDW9-0003OM-TG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 17:25:25 -0400
Received: by mail-qt0-x244.google.com with SMTP id 19so293220qty.1
	for <qemu-devel@nongnu.org>; Mon, 17 Jul 2017 14:25:25 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Mon, 17 Jul 2017 11:24:38 -1000
Message-Id: <20170717212446.15268-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL v2 0/8] target/s390x tcg improvements
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

Instructions implementing another missing facility,
getting us a bit closer to being able to upgrade the
default tcg cpu.

Plus one bug fix for an existing instruction that
isn't used unless we upgrade the tcg cpu.

v2: Adjust the CSST patch to work when CONFIG_ATOMIC64
is not defined, as seen with clang 3.8.


r~


The following changes since commit ca4e667dbf431d4a2a5a619cde79d30dd2ac3eb2:

  Merge remote-tracking branch 'remotes/kraxel/tags/usb-20170717-pull-request' into staging (2017-07-17 17:54:17 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-s390-20170717

for you to fetch changes up to dbdaaff43adc49f1debd935b1fd58e2b47ba7676:

  target/s390x: Fix risbg handling (2017-07-17 14:13:17 -0700)

----------------------------------------------------------------
Queued s390x tcg patches, v2

----------------------------------------------------------------
David Hildenbrand (1):
      target/s390x: Allow to enable "idtes" feature for TCG

Richard Henderson (7):
      target/s390x: Implement CSST
      target/s390x: Implement CONVERT UNICODE insns
      target/s390x: Tidy SRST
      target/s390x: Implement SRSTU
      target/s390x: Implement TRTR
      target/s390x: Mark ETF3 and ETF3_ENH facilities as available
      target/s390x: Fix risbg handling

 target/s390x/helper.h      |  11 +-
 target/s390x/cpu_models.c  |   5 +
 target/s390x/mem_helper.c  | 585 +++++++++++++++++++++++++++++++++++++++++++--
 target/s390x/translate.c   |  99 +++++++-
 target/s390x/insn-data.def |  21 +-
 5 files changed, 696 insertions(+), 25 deletions(-)
