Received: from eggs.gnu.org ([2001:4830:134:3::10]:46905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gHYqj-0006mZ-BH
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gHYqi-0000tY-M7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:34:45 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235]:46404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1gHYqi-0000st-ES
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 14:34:44 -0400
Received: by mail-lj1-x235.google.com with SMTP id x3-v6so12374891lji.13
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 11:34:44 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Tue, 30 Oct 2018 11:34:24 -0700
Message-Id: <20181030183424.609-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PULL 0/2] target/xtensa updates for 3.1
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

please pull the following series that adds bFLT binaries support for
target/xtensa.

The following changes since commit 3892f1f1a963e59dfe012cd9d461d33b2986fa3b:

  Merge remote-tracking branch 'remotes/dgibson/tags/libfdt-20181002' into staging (2018-10-02 09:54:44 +0100)

are available in the git repository at:

  git://github.com/OSLL/qemu-xtensa.git tags/20181030-xtensa

for you to fetch changes up to 5c76d652ab567a230f2ef0022b7ea5acb693e19c:

  linux-user/flatload: fix initial stack pointer alignment (2018-10-30 11:23:32 -0700)

----------------------------------------------------------------
target/xtensa: support for bFLT binaries

- add support for bFLT binaries for target/xtensa
- fix per-architecture target_flat.h customization
- fix initial stack pointer for bFLT

----------------------------------------------------------------
Max Filippov (2):
      linux-user: xtensa: enable bFLT support
      linux-user/flatload: fix initial stack pointer alignment

 configure                       |  1 +
 linux-user/flatload.c           |  8 ++++----
 linux-user/xtensa/target_flat.h | 10 ++++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)
 create mode 100644 linux-user/xtensa/target_flat.h

Thanks.
-- Max
