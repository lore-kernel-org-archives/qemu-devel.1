Received: from eggs.gnu.org ([209.51.188.92]:53740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn27s-0008Hg-Rr
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gn27p-0003aD-1J
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gn27o-0003V1-GP
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 09:06:28 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 25 Jan 2019 12:06:09 -0200
Message-Id: <20190125140610.7810-2-ehabkost@redhat.com>
In-Reply-To: <20190125140610.7810-1-ehabkost@redhat.com>
References: <20190125140610.7810-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] device-crash-test: Python 3 compatibility
 fix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Nisarg Shah <nshah@disroot.org>

From: Nisarg Shah <nshah@disroot.org>

Restrict whitelist entry stats in debug mode to be sorted only by
"count", since Python 3 does not implicitly support comparing
dictionaries.

Signed-off-by: Nisarg Shah <nshah@disroot.org>
Message-Id: <20190116183358.30287-1-nshah@disroot.org>
[ehabkost: removed 2 unnecessary hunks from patch]
[ehabkost: edited commit message]
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 scripts/device-crash-test | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index 483dafb2fc..2a13fa4f84 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -557,7 +557,8 @@ def main():
         logger.info("Skipped %d test cases", skipped)
 
     if args.debug:
-        stats = sorted([(len(wl_stats.get(i, [])), wl) for i, wl in enumerate(ERROR_WHITELIST)])
+        stats = sorted([(len(wl_stats.get(i, [])), wl) for i, wl in
+                         enumerate(ERROR_WHITELIST)], key=lambda x: x[0])
         for count, wl in stats:
             dbg("whitelist entry stats: %d: %r", count, wl)
 
-- 
2.18.0.rc1.1.g3f1ff2140
