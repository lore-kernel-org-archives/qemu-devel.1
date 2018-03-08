Received: from eggs.gnu.org ([2001:4830:134:3::10]:58754)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etuzI-0004tT-0r
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:49:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brijesh.singh@amd.com>) id 1etuzD-0003ez-RD
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:49:36 -0500
Received: from mail-co1nam03on0068.outbound.protection.outlook.com
	([104.47.40.68]:10675
	helo=NAM03-CO1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
	id 1etuzD-0003cj-Gj
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 07:49:31 -0500
From: Brijesh Singh <brijesh.singh@amd.com>
Date: Thu,  8 Mar 2018 06:48:34 -0600
Message-Id: <20180308124901.83533-2-brijesh.singh@amd.com>
In-Reply-To: <20180308124901.83533-1-brijesh.singh@amd.com>
References: <20180308124901.83533-1-brijesh.singh@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v12 01/28] memattrs: add debug attribute
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm@vger.kernel.org, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>, Alexander Graf <agraf@suse.de>, Bruce Rogers <brogers@suse.com>, Brijesh Singh <brijesh.singh@amd.com>

Extend the MemTxAttrs to include 'debug' flag. The flag can be used as
general indicator that operation was triggered by the debugger.

Later in the patch series we set the debug=1 when issuing a memory access
from the gdbstub or HMP commands. This patch is prerequisite to support
debugging the encrypted guest. If we see request with debug=1 then we
will need to use encryption APIs to access the guest memory.

Cc: Alistair Francis <alistair.francis@xilinx.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 include/exec/memattrs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a16420984b..08099e4f7e72 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -37,6 +37,8 @@ typedef struct MemTxAttrs {
     unsigned int user:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+    /* Memory access request from the debugger */
+    unsigned int debug:1;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
-- 
2.14.3
