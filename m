Received: from eggs.gnu.org ([209.51.188.92]:38758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9W-0008Ji-PR
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpa9V-00044E-RL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:46 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpa9V-00041I-Kt
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 09:50:45 -0500
Received: by mail-wr1-x443.google.com with SMTP id l9so7329157wrt.13
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 06:50:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 14:50:25 +0000
Message-Id: <20190201145035.22739-2-peter.maydell@linaro.org>
In-Reply-To: <20190201145035.22739-1-peter.maydell@linaro.org>
References: <20190201145035.22739-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/11] docs/cpu-hotplug.rst: Fix rST markup
 issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

sphinx-build complains:

docs/cpu-hotplug.rst:67: ERROR: Unexpected indentation.
docs/cpu-hotplug.rst:69: ERROR: Unexpected indentation.
docs/cpu-hotplug.rst:74: WARNING: Block quote ends without a blank line; unexpected unindent.
docs/cpu-hotplug.rst:75: WARNING: Block quote ends without a blank line; unexpected unindent.
docs/cpu-hotplug.rst:76: SEVERE: Unexpected section title.

}
{
docs/cpu-hotplug.rst:78: WARNING: Block quote ends without a blank line; unexpected unindent.

These are the result of not indicating one of the literal
blocks by finishing the preceding paragraph with the "::" marker.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/cpu-hotplug.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/cpu-hotplug.rst b/docs/cpu-hotplug.rst
index 1c268e00b41..e2d4e893b01 100644
--- a/docs/cpu-hotplug.rst
+++ b/docs/cpu-hotplug.rst
@@ -60,7 +60,7 @@ vCPU hotplug
     hot-plugged (no "qom-path" member).  From its output in step (3), we
     can see that ``IvyBridge-IBRS-x86_64-cpu`` is present in socket 0,
     while hot-plugging a CPU into socket 1 requires passing the listed
-    properties to QMP ``device_add``:
+    properties to QMP ``device_add``::
 
       (QEMU) device_add id=cpu-2 driver=IvyBridge-IBRS-x86_64-cpu socket-id=1 core-id=0 thread-id=0
       {
-- 
2.20.1
