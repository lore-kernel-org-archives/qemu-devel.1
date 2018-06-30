Received: from eggs.gnu.org ([2001:4830:134:3::10]:60633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZNJ6-00042C-0X
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 17:21:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fZNJ5-0005Hx-24
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 17:21:23 -0400
Received: from mail-lf0-x241.google.com ([2a00:1450:4010:c07::241]:39909)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1fZNJ4-0005HI-QW
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 17:21:22 -0400
Received: by mail-lf0-x241.google.com with SMTP id y6-v6so1219748lfg.6
	for <qemu-devel@nongnu.org>; Sat, 30 Jun 2018 14:21:22 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sat, 30 Jun 2018 14:21:09 -0700
Message-Id: <20180630212109.5562-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/6] target/xtensa updates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Max Filippov <jcmvbkbc@gmail.com>

Hi Peter,

please pull the following batch of updates for the target/xtensa.

The following changes since commit e3800998e66c13b24d8cc8a06fdcc8d03cd408fc:

  Merge remote-tracking branch 'remotes/armbru/tags/pull-monitor-2018-06-30' into staging (2018-06-30 17:30:09 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20180630-xtensa

for you to fetch changes up to 0f02251a30ea8c4ce64d9a240795e10bb3c5852c:

  xtensa: Avoid calling get_page_addr_code() from helper function (2018-06-30 12:00:17 -0700)

----------------------------------------------------------------
target/xtensa updates:

- add diagnostic for zero-overhead loop alignment;
- convert to TranslatorOps;
- don't call get_page_addr_code() from helper functions.

----------------------------------------------------------------
Max Filippov (1):
      target/xtensa: check zero overhead loop alignment

Peter Maydell (1):
      xtensa: Avoid calling get_page_addr_code() from helper function

Richard Henderson (4):
      target/xtensa: Replace DISAS_UPDATE with DISAS_NORETURN
      target/xtensa: Convert to DisasContextBase
      target/xtensa: Change gen_intermediate_code dc to pointer
      target/xtensa: Convert to TranslatorOps

 target/xtensa/cpu.h          |   1 +
 target/xtensa/op_helper.c    |   6 +-
 target/xtensa/overlay_tool.h |   1 +
 target/xtensa/translate.c    | 334 +++++++++++++++++++++++--------------------
 4 files changed, 182 insertions(+), 160 deletions(-)

-- 
Thanks.
-- Max
