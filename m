Received: from eggs.gnu.org ([2001:4830:134:3::10]:35629)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFDp2-0000sh-RI
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yu.ning@linux.intel.com>) id 1eFDoy-0002sO-Q0
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:38:48 -0500
Received: from mga09.intel.com ([134.134.136.24]:61746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yu.ning@linux.intel.com>)
	id 1eFDoy-0002r3-F2
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 01:38:44 -0500
From: yu.ning@linux.intel.com
Date: Thu, 16 Nov 2017 14:50:25 +0800
Message-Id: <1510815025-27857-1-git-send-email-yu.ning@linux.intel.com>
Subject: [Qemu-devel] [PATCH] hax-interface: Add BSD license
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yu Ning <yu.ning@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

From: Yu Ning <yu.ning@intel.com>

hax-interface.h defines the interface between the HAXM kernel
module and the HAXM QEMU accelerator. The same code can be found in
the following files of the HAXM kernel module:

 include/hax_interface.h
 include/vcpu_state.h
 core/include/vm.h

These files are now open source under the 3-clause BSD license,
whereas hax-interface.h in QEMU uses GPLv2.

Address this inconsistency by adding the BSD license to the QEMU
file, per Stefan Weil's comment on this HAXM pull request:

 https://github.com/intel/haxm/pull/2

Signed-off-by: Yu Ning <yu.ning@intel.com>
---
 target/i386/hax-interface.h | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/target/i386/hax-interface.h b/target/i386/hax-interface.h
index d141308..9a36c9a 100644
--- a/target/i386/hax-interface.h
+++ b/target/i386/hax-interface.h
@@ -1,4 +1,33 @@
 /*
+ * Copyright (c) 2011 Intel Corporation
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *
+ *   1. Redistributions of source code must retain the above copyright notice,
+ *      this list of conditions and the following disclaimer.
+ *
+ *   2. Redistributions in binary form must reproduce the above copyright
+ *      notice, this list of conditions and the following disclaimer in the
+ *      documentation and/or other materials provided with the distribution.
+ *
+ *   3. Neither the name of the copyright holder nor the names of its
+ *      contributors may be used to endorse or promote products derived from
+ *      this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+/*
  * QEMU HAXM support
  *
  * Copyright (c) 2011 Intel Corporation
-- 
2.7.4
