Received: from eggs.gnu.org ([2001:4830:134:3::10]:53671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fejyP-0000oJ-7I
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 12:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fejyM-0007QR-Cn
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 12:34:13 -0400
Received: from steffen-goertz.de ([88.198.119.201]:56806)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <contrib@steffen-goertz.de>) id 1fejyM-0007Nz-5N
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 12:34:10 -0400
From: =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>
Date: Sun, 15 Jul 2018 18:34:04 +0200
Message-Id: <20180715163404.10077-2-contrib@steffen-goertz.de>
In-Reply-To: <20180715163404.10077-1-contrib@steffen-goertz.de>
References: <20180715163404.10077-1-contrib@steffen-goertz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 2/2] arm: Add nRF51 GPIO tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <contrib@steffen-goertz.de>

Signed-off-by: Steffen G=C3=B6rtz <contrib@steffen-goertz.de>
---

Test stubs for GIPO. Tests will follow in v2.

 tests/microbit-test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/microbit-test.c b/tests/microbit-test.c
index c502ee3976..a1e2f67855 100644
--- a/tests/microbit-test.c
+++ b/tests/microbit-test.c
@@ -101,6 +101,12 @@ static void test_nrf51_nvmc(void)
     }
 }
=20
+static void test_nrf51_gpio(void)
+{
+    /* TODO add tests for GPIO */
+    g_assert_true(false);
+}
+
 int main(int argc, char **argv)
 {
     int ret;
@@ -110,6 +116,7 @@ int main(int argc, char **argv)
     global_qtest =3D qtest_startf("-machine microbit");
=20
     qtest_add_func("/microbit/nrf51/nvmc", test_nrf51_nvmc);
+    qtest_add_func("/microbit/nrf51/gpio", test_nrf51_gpio);
=20
     ret =3D g_test_run();
=20
--=20
2.18.0
