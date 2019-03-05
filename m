Received: from eggs.gnu.org ([209.51.188.92]:35471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlC-000260-0z
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1DlB-0000Qa-57
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:51247)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1DlA-0000KV-UB
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:21:45 -0500
Received: by mail-wm1-x32b.google.com with SMTP id n19so3358051wmi.1
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 09:21:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Mar 2019 17:21:28 +0000
Message-Id: <20190305172139.32662-2-peter.maydell@linaro.org>
In-Reply-To: <20190305172139.32662-1-peter.maydell@linaro.org>
References: <20190305172139.32662-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 01/12] docs/cpu-hotplug.rst: Fix rST markup
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>

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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Message-id: 20190228145624.24885-2-peter.maydell@linaro.org
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
