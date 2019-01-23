Received: from eggs.gnu.org ([209.51.188.92]:38555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gmHOX-0002Ua-4c
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gmHKM-00074S-Je
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:08:21 -0500
Received: from smtp56.i.mail.ru ([217.69.128.36]:53634)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gmHKJ-00071x-6J
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 07:08:16 -0500
From: Julia Suvorova <jusual@mail.ru>
Date: Wed, 23 Jan 2019 15:07:56 +0300
Message-Id: <20190123120759.7162-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v5 0/3] tests/microbit-test: Add UART device
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

v5:
    * Replace g_assert with g_assert_* [Thomas, Alex]
    * Increase the waiting time for an event [Thomas]
    * Remove 'nowait' [Thomas]
    * Rewrite uart_wait_for_event to use time difference instead of loop
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

 tests/libqtest.c      |  25 ++++
 tests/libqtest.h      |  11 ++
 tests/microbit-test.c | 336 +++++++++++++++++++++++++++---------------
 3 files changed, 254 insertions(+), 118 deletions(-)

-- 
2.17.1
