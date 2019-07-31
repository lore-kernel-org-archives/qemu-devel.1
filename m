Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211ACC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:27:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1BF4206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:27:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oh5VGq5d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1BF4206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrS9-0002oz-VR
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45254)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPp-00057p-ST
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPo-0000OM-5r
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPn-0000Ng-Va
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:24 -0400
Received: by mail-wr1-x443.google.com with SMTP id c2so67154890wrm.8
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4EXaES14kXYuknV6BmgHILnMsjbpC7Jf9OLUvLs/j/Y=;
 b=oh5VGq5dG6uFB4+VG7/rZwM0llAIDdbsHHAtnoRlXp7pEAlCLrzyNRjkqPv/toNcS4
 QzetqV+RSSzbTyVXuS/b9QTZDEuhIARsUNnL3d0t7YeU7yIpgP7k1Tanhhk5SZJCgY/G
 Cj6fyIp5oAzLtLlO6qsmqALPw+jpEjwhWksBvzNhx2+GEKJBNPrkdgRKadVWLUS1VQyy
 bM0NzML9TlIe3nRF8SJaUYud2maL+AmULON3LbGBfog8or5X0ULTNJqtNV3jwfx4kUqU
 W/Hp/WdXleANNg3fFgddOBpTsp41bM8ie9WATAHDbbhQx9inhRHQK6HdX3TnKxZGW1yN
 bVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4EXaES14kXYuknV6BmgHILnMsjbpC7Jf9OLUvLs/j/Y=;
 b=TWcTz7r0zsOyvEcVOWjwEHMM/M5qVr0PbLHsN0C+XuP38knP1vDC07puG2aw5goTMy
 bzEmzr0aPkARGa4lpJo6UPJTytIYCEfuvzQMRPbCcpMLgGn+p5COiZgPys7ZZATXVPGA
 WHO78j4OXl15wMYM1Qp7X1o3Ti3aIheTlj+mBFaJdt8Tgc04ONjg5HF6RcfYKAk72jeV
 KV8b84UGf0/n7ooxziH6nGwwmVME1yv9UNKg0k97YHTfFtdyoWis/dZjj6y5upLP6+7R
 20PhNionh77e9Ti/M1mBtyDiKgbolhUMAEx2KRD4CfcH7yR1UlT5e/29qV0ogTDWG1L4
 TGRQ==
X-Gm-Message-State: APjAAAVL7ta60yKOqFosJ/Hghc6WYJXmglEneNDxWypBTOvZEMflbgvV
 xk3TzlbZm7gpA0j/kNcdeFGI5Q==
X-Google-Smtp-Source: APXvYqzGU2Xb1CfqjqXoCbKXVARBLXLm8hKX7om61dLyU1TDgtfwKdebyx0NQvj1lKAnSCPCiZb/ZA==
X-Received: by 2002:a05:6000:1148:: with SMTP id
 d8mr119764076wrx.354.1564590322859; 
 Wed, 31 Jul 2019 09:25:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id a8sm55555823wma.31.2019.07.31.09.25.17
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 77E911FFC1;
 Wed, 31 Jul 2019 17:07:23 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:07:08 +0100
Message-Id: <20190731160719.11396-44-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v4 43/54] plugin: add API symbols to
 qemu-plugins.symbols
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: moved into plugins]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v3
  - moved to plugins/
  - include qemu_plugin_reset
---
 Makefile                     |  1 +
 configure                    | 69 ++++++++++++++++++++++++++++++++++++
 plugins/.gitignore           |  2 ++
 plugins/Makefile.objs        | 14 ++++++++
 plugins/qemu-plugins.symbols | 38 ++++++++++++++++++++
 5 files changed, 124 insertions(+)
 create mode 100644 plugins/.gitignore
 create mode 100644 plugins/qemu-plugins.symbols

diff --git a/Makefile b/Makefile
index ed4bb87f224..485e4bb2e85 100644
--- a/Makefile
+++ b/Makefile
@@ -726,6 +726,7 @@ distclean: clean
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
 	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
 	rm -f qemu-doc.vr qemu-doc.txt
+	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
diff --git a/configure b/configure
index dbc78f21b0c..7f6a1556fe2 100755
--- a/configure
+++ b/configure
@@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPMO="${TMPDIR1}/${TMPB}.mo"
+TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
 
@@ -5498,6 +5499,58 @@ if compile_prog "" "" ; then
   atomic64=yes
 fi
 
+#########################################
+# See if --dynamic-list is supported by the linker
+
+cat > $TMPTXT <<EOF
+{
+  foo;
+};
+EOF
+
+cat > $TMPC <<EOF
+#include <stdio.h>
+void foo(void);
+
+void foo(void)
+{
+  printf("foo\n");
+}
+
+int main(void)
+{
+  foo();
+  return 0;
+}
+EOF
+
+ld_dynamic_list="no"
+if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
+  ld_dynamic_list="yes"
+fi
+
+#########################################
+# See if -exported_symbols_list is supported by the linker
+
+cat > $TMPTXT <<EOF
+  _foo
+EOF
+
+ld_exported_symbols_list="no"
+if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
+  ld_exported_symbols_list="yes"
+fi
+
+if  test "$plugins" = "yes" &&
+    test "$ld_dynamic_list" = "no" &&
+    test "$ld_exported_symbols_list" = "no" ; then
+  error_exit \
+      "Plugin support requires specifying a set of symbols that " \
+      "are exported to plugins. Unfortunately your linker doesn't " \
+      "support the flag (--dynamic-list or -exported_symbols_list) used " \
+      "for this purpose."
+fi
+
 ########################################
 # See if 16-byte vector operations are supported.
 # Even without a vector unit the compiler may expand these.
@@ -7318,6 +7371,22 @@ fi
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
     LIBS="-ldl $LIBS"
+    # Copy the export object list to the build dir
+    if test "$ld_dynamic_list" = "yes" ; then
+	echo "CONFIG_HAS_LD_DYNAMIC_LIST=yes" >> $config_host_mak
+	ld_symbols=qemu-plugins-ld.symbols
+	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
+    elif test "$ld_exported_symbols_list" = "yes" ; then
+	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=yes" >> $config_host_mak
+	ld64_symbols=qemu-plugins-ld64.symbols
+	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
+	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g' | \
+	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
+    else
+	error_exit \
+	    "If \$plugins=yes, either \$ld_dynamic_list or " \
+	    "\$ld_exported_symbols_list should have been set to 'yes'."
+    fi
 fi
 
 if test "$tcg_interpreter" = "yes"; then
diff --git a/plugins/.gitignore b/plugins/.gitignore
new file mode 100644
index 00000000000..7b8aaa1f109
--- /dev/null
+++ b/plugins/.gitignore
@@ -0,0 +1,2 @@
+qemu-plugins-ld.symbols
+qemu-plugins-ld64.symbols
diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
index 95baabf3d2f..6f14d91ccb9 100644
--- a/plugins/Makefile.objs
+++ b/plugins/Makefile.objs
@@ -5,3 +5,17 @@
 obj-y += loader.o
 obj-y += core.o
 obj-y += api.o
+
+# Abuse -libs suffix to only link with --dynamic-list/-exported_symbols_list
+# when the final binary includes the plugin object.
+#
+# Note that simply setting LDFLAGS is not enough: we build binaries that
+# never link plugin.o, and the linker might fail (at least ld64 does)
+# if the symbols in the list are not in the output binary.
+ifdef CONFIG_HAS_LD_DYNAMIC_LIST
+api.o-libs := -Wl,--dynamic-list=$(BUILD_DIR)/qemu-plugins-ld.symbols
+else
+ifdef CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST
+api.o-libs := -Wl,-exported_symbols_list,$(BUILD_DIR)/qemu-plugins-ld64.symbols
+endif
+endif
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
new file mode 100644
index 00000000000..40c0d1abd2f
--- /dev/null
+++ b/plugins/qemu-plugins.symbols
@@ -0,0 +1,38 @@
+{
+  qemu_plugin_uninstall;
+  qemu_plugin_reset;
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
+  qemu_plugin_get_hwaddr;
+  qemu_plugin_hwaddr_is_io;
+  qemu_plugin_hwaddr_to_raddr;
+  qemu_plugin_vcpu_for_each;
+  qemu_plugin_n_vcpus;
+  qemu_plugin_n_max_vcpus;
+};
-- 
2.20.1


