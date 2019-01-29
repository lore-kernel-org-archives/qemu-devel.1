Received: from eggs.gnu.org ([209.51.188.92]:35753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXfU-0005I5-2w
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXfQ-0002Xp-5x
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:59:25 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:54:00 +0100
Message-Id: <20190129175403.18017-16-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 15/18] iotests: Let verify_platform()
 check for unsupported platforms
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brad Smith <brad@comstyle.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <fam@euphon.net>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

Instead of checking for a supported platforms, it might be useful
to test for the opposite.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/qemu-iotests/iotests.py | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index cbedfaf1df..9b6387b0a3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -696,9 +696,11 @@ def verify_protocol(supported=3D[], unsupported=3D[]=
):
     if not_sup or (imgproto in unsupported):
         notrun('not suitable for this protocol: %s' % imgproto)
=20
-def verify_platform(supported_oses=3D['linux']):
+def verify_platform(supported_oses=3D['linux'], unsupported_oses=3D[]):
     if True not in [sys.platform.startswith(x) for x in supported_oses]:
         notrun('not suitable for this OS: %s' % sys.platform)
+    if True in [sys.platform.startswith(x) for x in unsupported_oses]:
+        notrun('not suitable for this OS: %s' % sys.platform)
=20
 def verify_cache_mode(supported_cache_modes=3D[]):
     if supported_cache_modes and (cachemode not in supported_cache_modes=
):
--=20
2.20.1
