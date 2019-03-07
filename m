Received: from eggs.gnu.org ([209.51.188.92]:42642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rz3-0006I6-2Q
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1rz2-0001OO-4s
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1rz1-0001Nm-US
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:18:44 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Thu,  7 Mar 2019 12:18:38 +0000
Message-Id: <20190307121838.6345-3-berrange@redhat.com>
In-Reply-To: <20190307121838.6345-1-berrange@redhat.com>
References: <20190307121838.6345-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] docs: add note about stibp CPU feature for
 spectre v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

While the stibp CPU feature is not commonly used by guest OS for spectre
mitigation due to its performance impact, it is none the less best
practice to expose it to all guest OS. This allows the guest OS to
decide whether to make use or it.

Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 docs/qemu-cpu-models.texi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index 0ce528806d..23c11dc86f 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -168,6 +168,17 @@ Requires the host CPU microcode to support this feat=
ure before it
 can be used for guest CPUs.
=20
=20
+@item @code{stibp}
+
+Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
+operating systems.
+
+Must be explicitly turned on for all Intel CPU models.
+
+Requires the host CPU microcode to support this feature before it
+can be used for guest CPUs.
+
+
 @item @code{ssbd}
=20
 Required to enable the CVE-2018-3639 fix
@@ -258,6 +269,17 @@ Requires the host CPU microcode to support this feat=
ure before it
 can be used for guest CPUs.
=20
=20
+@item @code{stibp}
+
+Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
+operating systems.
+
+Must be explicitly turned on for all AMD CPU models.
+
+Requires the host CPU microcode to support this feature before it
+can be used for guest CPUs.
+
+
 @item @code{virt-ssbd}
=20
 Required to enable the CVE-2018-3639 fix
--=20
2.20.1
