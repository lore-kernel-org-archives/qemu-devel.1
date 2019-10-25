Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B08CA9EBD
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:52:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CA020867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 06:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="labMApue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CA020867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNtSz-0000vF-4H
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 02:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35530)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtE1-0003Hq-3k
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iNtDz-0008QK-0K
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:29 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:33275)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iNtDy-0008Q5-PR
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 02:37:26 -0400
Received: by mail-wm1-x334.google.com with SMTP id 6so3526459wmf.0
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 23:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=44V7jQqOs3ZoLqNrh7jJMlyq1xec1lAdesBPk7eaAP4=;
 b=labMApuedQHad2h2Hq2Hy+SJhDAUXrp9o0fLu4a67lYCUd3WLNBaVQQ3D8mjKZM9J9
 pJAbvSFkPvu4l8c9i24yRHhDePn44MuNVt4Z5YD9Z3vphr8UugLgvbkgDdlt/CC3g/LQ
 /Q8bj+aDVRyXjX78sgOGCoCLtBfIXUqFmB14sNSsuLeGwT8Cm6IiHCUJv9WNFKGzx6Ho
 Kx/5qz+4OA2FnVNuEEIVZMy75rirKOu8g6hFBpOxuyXJjLviWZGuDfa3uqwYg9eZmKt5
 /C6Xc+zUGYM3SKvKmYWrAUC8XeUN4toof2oIZi8V4HYTjgGeA8WajW16LqSivtktKb+g
 fqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=44V7jQqOs3ZoLqNrh7jJMlyq1xec1lAdesBPk7eaAP4=;
 b=HuFSPL13rLz/S7hKuHTD5tCpYbCaTPxilLl7VXM3nPNpOISnMUAwvRNOrrpuimA7RE
 MXRMsPJH6EbfhdRG6DTqMa8wgX3xG2W/Wrs7dpzoYlzalU1kDJns7wzj05Yohk501kMt
 Dhf30ik92iXAPUd5oza8hT8aYXhHcTE4NmtpE+PMMFFBZHJRwtIYNaos1ggHr5GpbvM5
 Hy8xGiERPoM6SJxfK1XJ2fZJMT9BAoPDwaNMi6i8QGmBTz5KUiS1q/eVV8krTKaB/QLl
 Vyx7BZ9nppHWxOiCvCMeXl3cauNtSGLlYjjXb4rHgClTiBY5OUCLDxnTNWsKEXcGjGSE
 is6Q==
X-Gm-Message-State: APjAAAVTX+C1L9zh7KH2g6AuWxOcMYhlwOXZ3bpl5QiDvDH4e0Kosdqy
 QKyq2sKXx5WRmQr7LRBz3RlDRw==
X-Google-Smtp-Source: APXvYqwRJe6ZfjtBwUgNtMEPVScbfoDfzNnbvpHc1KeYyMhld5osmhZG5XO45tSXL/ijL+ep2VaAPA==
X-Received: by 2002:a05:600c:2487:: with SMTP id
 7mr1823283wms.164.1571985445608; 
 Thu, 24 Oct 2019 23:37:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q25sm2598951wra.3.2019.10.24.23.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 23:37:24 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AE4101FFCC;
 Fri, 25 Oct 2019 07:37:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL v2 53/73] plugin: add API symbols to qemu-plugins.symbols
Date: Fri, 25 Oct 2019 07:36:53 +0100
Message-Id: <20191025063713.23374-54-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025063713.23374-1-alex.bennee@linaro.org>
References: <20191025063713.23374-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::334
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Emilio G. Cota <cota@braap.org>
[AJB: moved into plugins]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

diff --git a/Makefile b/Makefile
index 94d25185511..bd6376d295f 100644
--- a/Makefile
+++ b/Makefile
@@ -74,6 +74,12 @@ CONFIG_ALL=y
 config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
 	@echo $@ is out-of-date, running configure
 	@./config.status
+
+# Force configure to re-run if the API symbols are updated
+ifeq ($(CONFIG_PLUGIN),y)
+config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
+endif
+
 else
 config-host.mak:
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
@@ -737,6 +743,7 @@ distclean: clean
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
 	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
 	rm -f qemu-doc.vr qemu-doc.txt
+	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
diff --git a/configure b/configure
index 2995559ed21..eabe84af6ed 100755
--- a/configure
+++ b/configure
@@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPMO="${TMPDIR1}/${TMPB}.mo"
+TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
 
@@ -5476,6 +5477,61 @@ if compile_prog "" "" ; then
   atomic64=yes
 fi
 
+#########################################
+# See if --dynamic-list is supported by the linker
+ld_dynamic_list="no"
+if test "$static" = "no" ; then
+    cat > $TMPTXT <<EOF
+{
+  foo;
+};
+EOF
+
+    cat > $TMPC <<EOF
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
+    if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
+        ld_dynamic_list="yes"
+    fi
+fi
+
+#########################################
+# See if -exported_symbols_list is supported by the linker
+
+ld_exported_symbols_list="no"
+if test "$static" = "no" ; then
+    cat > $TMPTXT <<EOF
+  _foo
+EOF
+
+    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
+        ld_exported_symbols_list="yes"
+    fi
+fi
+
+if  test "$plugins" = "yes" &&
+    test "$ld_dynamic_list" = "no" &&
+    test "$ld_exported_symbols_list" = "no" ; then
+  error_exit \
+      "Plugin support requires dynamic linking and specifying a set of symbols " \
+      "that are exported to plugins. Unfortunately your linker doesn't " \
+      "support the flag (--dynamic-list or -exported_symbols_list) used " \
+      "for this purpose. You can't build with --static."
+fi
+
 ########################################
 # See if 16-byte vector operations are supported.
 # Even without a vector unit the compiler may expand these.
@@ -7283,6 +7339,22 @@ fi
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


