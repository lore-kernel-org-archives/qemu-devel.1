Received: from eggs.gnu.org ([2001:4830:134:3::10]:58027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8ri-0004Ow-DC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdavidsaver@gmail.com>) id 1fb8rh-0006DT-BC
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:26 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:35342)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mdavidsaver@gmail.com>)
	id 1fb8rh-0006DE-2e
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 14:20:25 -0400
Received: by mail-pf0-x236.google.com with SMTP id q7-v6so5028530pff.2
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 11:20:25 -0700 (PDT)
From: Michael Davidsaver <mdavidsaver@gmail.com>
Date: Thu,  5 Jul 2018 11:19:53 -0700
Message-Id: <20180705182001.16537-7-mdavidsaver@gmail.com>
In-Reply-To: <20180705182001.16537-1-mdavidsaver@gmail.com>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
Subject: [Qemu-devel] [PATCH 06/14] tests: ds-rtc test 12 hour mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, Michael Davidsaver <mdavidsaver@gmail.com>

Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
---
 tests/ds-rtc-set-test.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tests/ds-rtc-set-test.c b/tests/ds-rtc-set-test.c
index 35e1a36281..c48406ee2c 100644
--- a/tests/ds-rtc-set-test.c
+++ b/tests/ds-rtc-set-test.c
@@ -29,6 +29,18 @@ static uint8_t test_time_24_12am[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_12am[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 00:30:53 +0000 */
+    0x53,
+    0x30,
+    0x52, /* 12 AM in 12 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 static uint8_t test_time_24_6am[8] = {
     0, /* address */
     /* Wed, 22 Nov 2017 06:30:53 +0000 */
@@ -41,6 +53,18 @@ static uint8_t test_time_24_6am[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_6am[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 06:30:53 +0000 */
+    0x53,
+    0x30,
+    0x46, /* 6 AM in 12 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 static uint8_t test_time_24_12pm[8] = {
     0, /* address */
     /* Wed, 22 Nov 2017 12:30:53 +0000 */
@@ -53,6 +77,18 @@ static uint8_t test_time_24_12pm[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_12pm[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 12:30:53 +0000 */
+    0x53,
+    0x30,
+    0x72, /* 12 PM in 24 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 static uint8_t test_time_24_6pm[8] = {
     0, /* address */
     /* Wed, 22 Nov 2017 18:30:53 +0000 */
@@ -65,6 +101,18 @@ static uint8_t test_time_24_6pm[8] = {
     0x17,
 };
 
+static uint8_t test_time_12_6pm[8] = {
+    0, /* address */
+    /* Wed, 22 Nov 2017 18:30:53 +0000 */
+    0x53,
+    0x30,
+    0x66, /* 6 PM in 12 hour mode */
+    0x03, /* monday is our day 1 */
+    0x22,
+    0x11 | 0x80,
+    0x17,
+};
+
 /* write in and read back known time */
 static
 void test_rtc_set(const void *raw)
@@ -108,6 +156,10 @@ int main(int argc, char *argv[])
     qtest_add_data_func("/ds-rtc-i2c/set24_6am", test_time_24_6am, test_rtc_set);
     qtest_add_data_func("/ds-rtc-i2c/set24_12pm", test_time_24_12pm, test_rtc_set);
     qtest_add_data_func("/ds-rtc-i2c/set24_6pm", test_time_24_6pm, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_12am", test_time_12_12am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_6am", test_time_12_6am, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_12pm", test_time_12_12pm, test_rtc_set);
+    qtest_add_data_func("/ds-rtc-i2c/set12_6pm", test_time_12_6pm, test_rtc_set);
 
     ret = g_test_run();
 
-- 
2.11.0
