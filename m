Received: from eggs.gnu.org ([2001:4830:134:3::10]:60482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxd-00029m-U3
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxa-0000k2-RG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:53 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:34476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fYYxa-0000jB-MQ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 11:35:50 -0400
Received: by mail-qt0-x22c.google.com with SMTP id d23-v6so5115065qtp.1
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 08:35:50 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 28 Jun 2018 12:35:31 -0300
Message-Id: <20180628153535.1411-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/4] tests/vm: various trivial fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Hi,

These are various fixes I added to have the VM tests working for me.

Regards,

Phil.

Philippe Mathieu-Daudé (4):
  tests/vm: Support proxy / corporate firewall
  tests/vm: Add a dependency to qemu-img
  tests/vm: Only use -cpu 'host' if KVM is available
  tests/vm: Add flex and bison to the vm image

 tests/vm/Makefile.include | 3 +++
 tests/vm/basevm.py        | 3 ++-
 tests/vm/ubuntu.i386      | 6 +++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
2.18.0
