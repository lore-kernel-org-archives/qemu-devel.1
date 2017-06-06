Received: from eggs.gnu.org ([2001:4830:134:3::10]:38572)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dICJO-0005hA-56
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dICJL-0002wl-Fe
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:06:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dICJL-0002wW-9q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 07:06:07 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  6 Jun 2017 12:05:55 +0100
Message-Id: <20170606110556.12922-2-berrange@redhat.com>
In-Reply-To: <20170606110556.12922-1-berrange@redhat.com>
References: <20170606110556.12922-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] docs: document deprecated features in
 appendix
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The deprecation of features in QEMU is totally adhoc currently,
with no way for the user to get a list of what is deprecated
in each release. This adds an appendix to the doc that records
when each deprecation[1] was made and provides text explaining
what to use instead.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

[1] This is a lie. I've only listed one deprecated feature. Once
    we agree on the general concept, we can fill out the doc
    with the rest of the currently deprecated features.
---
 qemu-doc.texi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 965ba59..29f89d8 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -37,6 +37,7 @@
 * QEMU Guest Agent::
 * QEMU User space emulator::
 * Implementation notes::
+* Deprecations::
 * License::
 * Index::
 @end menu
@@ -3016,6 +3017,19 @@ Run the emulation in single step mode.
 
 @include qemu-tech.texi
 
+@node Deprecations
+@appendix Deprecations
+
+The following is a list of features which have been marked as deprecated,
+pending removal in a future release:
+
+@section -drive boot=on|off (since v1.3.0)
+Since release 1.3.0, the ``boot=on|off'' parameter to ``-drive''
+is no longer honoured. It is currently ignored, but a future verson
+will reject this parameter with an error. Applications should use
+the ``bootindex=N'' parameter to set an absolute ordering between
+devices instead.
+
 @node License
 @appendix License
 
-- 
2.9.3
