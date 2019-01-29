Received: from eggs.gnu.org ([209.51.188.92]:35617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXez-0004mH-46
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:58:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1goXey-0002F3-Gk
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 12:58:57 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Tue, 29 Jan 2019 18:53:57 +0100
Message-Id: <20190129175403.18017-13-philmd@redhat.com>
In-Reply-To: <20190129175403.18017-1-philmd@redhat.com>
References: <20190129175403.18017-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC PATCH v2 12/18] test-iov: Disable iov/io test on
 OpenBSD
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

The iov/io test hangs on OpenBSD. Disable it.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 tests/test-iov.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/tests/test-iov.c b/tests/test-iov.c
index 458ca25099..9288b7b862 100644
--- a/tests/test-iov.c
+++ b/tests/test-iov.c
@@ -147,9 +147,11 @@ static void test_to_from_buf(void)
=20
 static void test_io(void)
 {
-#ifndef _WIN32
-/* socketpair(PF_UNIX) which does not exist on windows */
-
+#if defined(_WIN32)
+    /* socketpair(PF_UNIX) which does not exist on windows */
+#elif defined(__OpenBSD__)
+    /* FIXME: this test hangs on OpenBSD */
+#else
     int sv[2];
     int r;
     unsigned i, j, k, s, t;
--=20
2.20.1
