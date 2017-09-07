Received: from eggs.gnu.org ([2001:4830:134:3::10]:51185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nL-0004WZ-F1
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dq1nG-0005Xs-S9
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:44:55 -0400
Received: from mail-pg0-x22d.google.com ([2607:f8b0:400e:c05::22d]:38179)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dq1nG-0005Xj-LG
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:44:50 -0400
Received: by mail-pg0-x22d.google.com with SMTP id v66so940680pgb.5
	for <qemu-devel@nongnu.org>; Thu, 07 Sep 2017 11:44:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Sep 2017 11:44:44 -0700
Message-Id: <20170907184447.22752-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 0/3] target/hppa update
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

Just the conversion to TranslatorOps.


r~


The following changes since commit cda4a338c4243fa3bff4498b935340ac7121cc76:

  tcg/tci: Add TCG_TARGET_DEFAULT_MO (2017-09-07 18:57:34 +0100)

are available in the git repository at:

  git://github.com/rth7680/qemu.git tags/pull-pa-20170907

for you to fetch changes up to 51b061fbf027f844cc0bfb1eaaf0ae818e3ceb36:

  target/hppa: Convert to TranslatorOps (2017-09-07 11:23:13 -0700)

----------------------------------------------------------------
Conversion to TranslatorOps

----------------------------------------------------------------
Richard Henderson (3):
      target/hppa: Convert to DisasJumpType
      target/hppa: Convert to DisasContextBase
      target/hppa: Convert to TranslatorOps

 target/hppa/translate.c | 894 ++++++++++++++++++++++++------------------------
 1 file changed, 448 insertions(+), 446 deletions(-)
