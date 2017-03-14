Received: from eggs.gnu.org ([2001:4830:134:3::10]:48950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2f-0007S4-7g
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cne2c-00079w-5B
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 00:26:37 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 14 Mar 2017 15:26:26 +1100
Message-Id: <20170314042626.20020-5-david@gibson.dropbear.id.au>
In-Reply-To: <20170314042626.20020-1-david@gibson.dropbear.id.au>
References: <20170314042626.20020-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 4/4] dtc: Update submodule to avoid build errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, pbonzini@redhat.com, aik@ozlabs.ru, David Gibson <david@gibson.dropbear.id.au>

The currently included version of the dtc/libfdt submodule has some build
errors on certain distributions (including RHEL7).  This is due to some
poorly named macros in libfdt.h; they're designed for use with the sparse
static checker, but use reserved names which conflict with some symbols in
the standard headers.

That's been corrected in upstream dtc, this updates the qemu submodule to
bring the fix to qemu.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 dtc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dtc b/dtc
index fa8bc7f..558cd81 160000
--- a/dtc
+++ b/dtc
@@ -1 +1 @@
-Subproject commit fa8bc7f928ac25f23532afc8beb2073efc8fb063
+Subproject commit 558cd81bdd432769b59bff01240c44f82cfb1a9d
-- 
2.9.3
