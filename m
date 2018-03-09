Received: from eggs.gnu.org ([2001:4830:134:3::10]:50319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdN-00009H-9g
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euOdM-0006tj-Iw
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euOdM-0006tY-Ch
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:28:56 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri,  9 Mar 2018 17:28:26 -0300
Message-Id: <20180309202827.12085-8-ehabkost@redhat.com>
In-Reply-To: <20180309202827.12085-1-ehabkost@redhat.com>
References: <20180309202827.12085-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 7/8] device-crash-test: Don't print warnings in
 quiet mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>

This will be useful for hiding known crashes on "make check".

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index ed9a552fa1..36194e4347 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -533,7 +533,7 @@ def main():
                         dest='loglevel', const=logging.INFO,
                         help='verbose output')
     parser.add_argument('-q', '--quiet',action='store_const',
-                        dest='loglevel', const=logging.WARN,
+                        dest='loglevel', const=logging.ERROR,
                         help='non-verbose output')
     parser.add_argument('-r', '--random', type=int, metavar='COUNT',
                         help='run a random sample of COUNT test cases',
-- 
2.14.3
