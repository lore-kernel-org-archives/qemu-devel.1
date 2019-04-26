Received: from eggs.gnu.org ([209.51.188.92]:60721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1N-0006TE-Db
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu1M-0005hv-ET
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:07:41 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:06:21 +1000
Message-Id: <20190426060627.18153-31-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/36] target/ppc/trace-events: Fix trivial typo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155445151931.302073.18436485925081597460.stgit@bahia.lan>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/trace-events | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/ppc/trace-events b/target/ppc/trace-events
index 3858f97dff..ed4d57c6d9 100644
--- a/target/ppc/trace-events
+++ b/target/ppc/trace-events
@@ -1,5 +1,5 @@
 # See docs/devel/tracing.txt for syntax documentation.
=20
 # kvm.c
-kvm_failed_spr_set(int str, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
-kvm_failed_spr_get(int str, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
+kvm_failed_spr_set(int spr, const char *msg) "Warning: Unable to set SPR=
 %d to KVM: %s"
+kvm_failed_spr_get(int spr, const char *msg) "Warning: Unable to retriev=
e SPR %d from KVM: %s"
--=20
2.20.1
