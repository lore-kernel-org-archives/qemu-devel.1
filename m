Received: from eggs.gnu.org ([209.51.188.92]:52122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gkAM6-0004K4-27
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gkAM5-0000fe-9q
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:21 -0500
Received: from smtp45.i.mail.ru ([94.100.177.105]:35880)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gkAM5-0000Tp-0W
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:17:21 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 17 Jan 2019 19:16:37 +0300
Message-Id: <20190117161640.5496-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v4 0/3] tests/microbit-test: Add UART device
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

v4:
    * Replace sprintf with g_strdup_printf [Peter]
    * Move socket connection to qtest library [Peter]
    * Use memcmp instead of strcmp [Stefan]
    * Remove using global_qtest [Thomas]
v3:
    * Fix directory leak [Stefan]

Based-on: <20190110094020.18354-1-stefanha@redhat.com>

Julia Suvorova (3):
  tests/libqtest: Introduce qtest_init_with_serial()
  tests/microbit-test: Make test independent of global_qtest
  tests/microbit-test: Check nRF51 UART functionality

 tests/libqtest.c      |  26 ++++
 tests/libqtest.h      |  11 ++
 tests/microbit-test.c | 331 +++++++++++++++++++++++++++---------------
 3 files changed, 250 insertions(+), 118 deletions(-)

-- 
2.17.1
