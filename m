Received: from eggs.gnu.org ([2001:4830:134:3::10]:41176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA4E-0001B3-JB
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dpA44-0002g2-RT
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dpA44-0002fU-Lw
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:22:36 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  5 Sep 2017 10:22:22 +0100
Message-Id: <20170905092230.8243-2-berrange@redhat.com>
In-Reply-To: <20170905092230.8243-1-berrange@redhat.com>
References: <20170905092230.8243-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 1/9] io: fix temp directory used by
 test-io-channel-tls test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The test-io-channel-tls test was mistakenly using two of the
same directories as test-crypto-tlssession. This causes a
sporadic failure when using make -j$BIGNUM.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 tests/test-io-channel-tls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index 8eaa208e1b..ff96877323 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -127,8 +127,8 @@ static void test_io_channel_tls(const void *opaque)
     /* We'll use this for our fake client-server connection */
     g_assert(socketpair(AF_UNIX, SOCK_STREAM, 0, channel) == 0);
 
-#define CLIENT_CERT_DIR "tests/test-crypto-tlssession-client/"
-#define SERVER_CERT_DIR "tests/test-crypto-tlssession-server/"
+#define CLIENT_CERT_DIR "tests/test-io-channel-tls-client/"
+#define SERVER_CERT_DIR "tests/test-io-channel-tls-server/"
     mkdir(CLIENT_CERT_DIR, 0700);
     mkdir(SERVER_CERT_DIR, 0700);
 
-- 
2.13.5
