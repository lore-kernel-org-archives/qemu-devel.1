Received: from eggs.gnu.org ([2001:4830:134:3::10]:33598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uS-0001bz-3W
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gW4uO-0006o0-Cy
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:35 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:55759)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gW4uN-0005sx-Vi
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 14:38:32 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun,  9 Dec 2018 14:37:45 -0500
Message-Id: <20181209193749.12277-35-cota@braap.org>
In-Reply-To: <20181209193749.12277-1-cota@braap.org>
References: <20181209193749.12277-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v2 34/38] plugin: add API symbols to
 qemu-plugins.symbols
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 qemu-plugins.symbols | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 qemu-plugins.symbols

diff --git a/qemu-plugins.symbols b/qemu-plugins.symbols
new file mode 100644
index 0000000000..2a5b18862a
--- /dev/null
+++ b/qemu-plugins.symbols
@@ -0,0 +1,34 @@
+{
+  qemu_plugin_uninstall;
+  qemu_plugin_register_vcpu_init_cb;
+  qemu_plugin_register_vcpu_exit_cb;
+  qemu_plugin_register_vcpu_idle_cb;
+  qemu_plugin_register_vcpu_resume_cb;
+  qemu_plugin_register_vcpu_insn_exec_cb;
+  qemu_plugin_register_vcpu_insn_exec_inline;
+  qemu_plugin_register_vcpu_mem_cb;
+  qemu_plugin_register_vcpu_mem_haddr_cb;
+  qemu_plugin_register_vcpu_mem_inline;
+  qemu_plugin_ram_addr_from_host;
+  qemu_plugin_register_vcpu_tb_trans_cb;
+  qemu_plugin_register_vcpu_tb_exec_cb;
+  qemu_plugin_register_vcpu_tb_exec_inline;
+  qemu_plugin_register_flush_cb;
+  qemu_plugin_register_vcpu_syscall_cb;
+  qemu_plugin_register_vcpu_syscall_ret_cb;
+  qemu_plugin_register_atexit_cb;
+  qemu_plugin_tb_n_insns;
+  qemu_plugin_tb_get_insn;
+  qemu_plugin_tb_vaddr;
+  qemu_plugin_insn_data;
+  qemu_plugin_insn_size;
+  qemu_plugin_insn_vaddr;
+  qemu_plugin_insn_haddr;
+  qemu_plugin_mem_size_shift;
+  qemu_plugin_mem_is_sign_extended;
+  qemu_plugin_mem_is_big_endian;
+  qemu_plugin_mem_is_store;
+  qemu_plugin_vcpu_for_each;
+  qemu_plugin_n_vcpus;
+  qemu_plugin_n_max_vcpus;
+};
-- 
2.17.1
