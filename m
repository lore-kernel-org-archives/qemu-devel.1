Received: from eggs.gnu.org ([209.51.188.92]:43723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0l-0001jk-0H
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gzf0f-0001R1-EQ
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:22 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:32985)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gzf0f-0001QH-74
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 05:03:17 -0500
Received: by mail-wr1-x430.google.com with SMTP id i12so25233562wrw.0
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 02:03:17 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  1 Mar 2019 10:03:10 +0000
Message-Id: <20190301100310.22345-6-alex.bennee@linaro.org>
In-Reply-To: <20190301100310.22345-1-alex.bennee@linaro.org>
References: <20190301100310.22345-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/5] contrib: gitdm: add a mapping for Janus
 Technologies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Currently this just includes Marcel who is a fairly prolific
contributor.

Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/gitdm/group-map-janustech | 5 +++++
 gitdm.config                      | 1 +
 2 files changed, 6 insertions(+)
 create mode 100644 contrib/gitdm/group-map-janustech

diff --git a/contrib/gitdm/group-map-janustech b/contrib/gitdm/group-map-janustech
new file mode 100644
index 0000000000..4ae7cc24f2
--- /dev/null
+++ b/contrib/gitdm/group-map-janustech
@@ -0,0 +1,5 @@
+#
+# Janus Technologies contributors using non-corporate email
+#
+
+marcel.apfelbaum@gmail.com
diff --git a/gitdm.config b/gitdm.config
index 7472d4b8be..c01c219078 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -36,6 +36,7 @@ GroupMap contrib/gitdm/group-map-wavecomp Wave Computing
 GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
 GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
 GroupMap contrib/gitdm/group-map-ibm IBM
+GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 
 # Also group together our prolific individual contributors
 # and those working under academic auspices
-- 
2.20.1
