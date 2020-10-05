Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88652C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:35:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F7820756
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 16:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oQgwciJ8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F7820756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPTSs-0006Dj-1c
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 12:35:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLt-0007ps-Uq
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:41 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036]:39353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kPTLp-0006qp-KE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 12:28:41 -0400
Received: by mail-pj1-x1036.google.com with SMTP id i3so69933pjz.4
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 09:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=61hqAm5Gfbn5fOfTcu744GQ1URMnAU9kqYVlDTeB9H4=;
 b=oQgwciJ8coUkiedWNamPwwjTaNH1E4rPEMNmeNOw1Bl3cQC+pooGWMqF1yJ2lyYV9+
 3cUKJsDYTIgm8ZuhczuICip7cPSfkoSpsu9C8v9nCHzpg97M1tN6htM4Is/ZHQbhUGqA
 WMk7ZN2qeR1VigPOljO550KSQGn6xtj/uazOUgBvWtPK3eFMGyA1AKXN4nD3ysvfY6re
 DYusrKgAuYL3o6FcR4RmhGAP97nfgfc2GXLyV779MBjhmGhKWa3s35IR7ubL28tCkJve
 aKzz2w7toUUW1BwHDzNzRrKtDsc+QbB31qqwS4SWFep5vSe4w26YosuKpItLH1oiUrZx
 OJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=61hqAm5Gfbn5fOfTcu744GQ1URMnAU9kqYVlDTeB9H4=;
 b=nNURk2SrOGxy7SDtn0DM1kVacqC4wAvn0bcCrQe6e2CJjg4yb7/T5u2vLfGBYt6d+a
 dWfT6SYSshApd9jSSWuqyuKg0Bq8NgLDerlJr28Z/zHAJ5gG+HhGrR3KWxpkk/8C7xi9
 ouZek5T7QiqBRW4iXrGiNAPY5KQZUCHMesdcmny3QPV7Rnr1yvj8/qXHYnR+7rDlRitf
 U2iod3itYrDfz5SSw3w6j3FVIFSw2HKBaKM1SLTZykIpC/8TPR7dEF5omlnyiYaxduyd
 1VUbXNuDrtdThzzuyhlSanSW01huzm8xky/X8oZmmNib5hIRI9JgjwDbG4vrzh54LBj4
 v8ig==
X-Gm-Message-State: AOAM531CY3dZYAOzMDNteQk2MX09JBKWnx0RIVBe7AopGXRf1Li38UGp
 RKcMlMgXRWL2FTbx4BCJqicQbSNh4oddGQ==
X-Google-Smtp-Source: ABdhPJynMglKeOtIU7uNrwIuB0ZXZmcfYjzOi2wEAYsvtJQ+zGDLSQnADllwui7Tu84KGExE8eaxog==
X-Received: by 2002:a17:90a:5292:: with SMTP id
 w18mr231639pjh.72.1601915313804; 
 Mon, 05 Oct 2020 09:28:33 -0700 (PDT)
Received: from localhost.localdomain ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id x13sm374725pfj.199.2020.10.05.09.28.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 09:28:32 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 5/6] plugin: Getting qemu-plugin works under win32.
Date: Tue,  6 Oct 2020 00:28:05 +0800
Message-Id: <20201005162806.1350-6-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <20201005162806.1350-1-luoyonggang@gmail.com>
References: <20201005162806.1350-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=luoyonggang@gmail.com; helo=mail-pj1-x1036.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Define QEMU_PLUGIN_API_IMPLEMENTATION in api.c and core.c
We removed the need of .symbols file, so is the
configure script, if we one expose a function to qemu-plugin
just need prefix the function with QEMU_PLUGIN_EXPORT

We use QEMU_PLUGIN_EXPORT export the functions in api.c and core.c
and loading it in qemu_plugin_initialize, so we need a list of function pointer
deceleration such as
QEMU_PLUGIN_EXTERN qemu_plugin_uninstall_t qemu_plugin_uninstall;
If we only have a single .c file in a plugin, then define
QEMU_PLUGIN_EXTERN to empty is OK, but if we have multiple .c files
in a plugin, then we need distinguish the implementation and the
deceleration. only the main .c file should define the macro QEMU_PLUGIN_IMPLEMENTATION
other sources are user and should use extern

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 Makefile                     |   1 -
 configure                    |  71 -------------
 contrib/plugins/hotblocks.c  |   1 +
 contrib/plugins/hotpages.c   |   1 +
 contrib/plugins/howvec.c     |   1 +
 contrib/plugins/lockstep.c   |   1 +
 include/qemu/qemu-plugin.h   | 193 +++++++++++++++++++++++++++--------
 meson.build                  |   6 +-
 plugins/api.c                |  68 ++++++------
 plugins/core.c               |  16 ++-
 plugins/loader.c             |  50 ++++++++-
 plugins/meson.build          |  10 +-
 plugins/plugin.h             |   1 +
 plugins/qemu-plugins.symbols |  40 --------
 tests/plugin/bb.c            |   1 +
 tests/plugin/empty.c         |   1 +
 tests/plugin/insn.c          |   1 +
 tests/plugin/mem.c           |   1 +
 18 files changed, 261 insertions(+), 203 deletions(-)
 delete mode 100644 plugins/qemu-plugins.symbols

diff --git a/Makefile b/Makefile
index f27bd4b2eb..f8f0450fc0 100644
--- a/Makefile
+++ b/Makefile
@@ -105,7 +105,6 @@ config-host.mak: $(SRC_PATH)/configure $(SRC_PATH)/pc-bios $(SRC_PATH)/VERSION
 
 # Force configure to re-run if the API symbols are updated
 ifeq ($(CONFIG_PLUGIN),y)
-config-host.mak: $(SRC_PATH)/plugins/qemu-plugins.symbols
 
 .PHONY: plugins
 plugins:
diff --git a/configure b/configure
index 30d7711edf..0f094860ec 100755
--- a/configure
+++ b/configure
@@ -5245,61 +5245,6 @@ if compile_prog "" "" ; then
   atomic64=yes
 fi
 
-#########################################
-# See if --dynamic-list is supported by the linker
-ld_dynamic_list="no"
-if test "$static" = "no" ; then
-    cat > $TMPTXT <<EOF
-{
-  foo;
-};
-EOF
-
-    cat > $TMPC <<EOF
-#include <stdio.h>
-void foo(void);
-
-void foo(void)
-{
-  printf("foo\n");
-}
-
-int main(void)
-{
-  foo();
-  return 0;
-}
-EOF
-
-    if compile_prog "" "-Wl,--dynamic-list=$TMPTXT" ; then
-        ld_dynamic_list="yes"
-    fi
-fi
-
-#########################################
-# See if -exported_symbols_list is supported by the linker
-
-ld_exported_symbols_list="no"
-if test "$static" = "no" ; then
-    cat > $TMPTXT <<EOF
-  _foo
-EOF
-
-    if compile_prog "" "-Wl,-exported_symbols_list,$TMPTXT" ; then
-        ld_exported_symbols_list="yes"
-    fi
-fi
-
-if  test "$plugins" = "yes" &&
-    test "$ld_dynamic_list" = "no" &&
-    test "$ld_exported_symbols_list" = "no" ; then
-  error_exit \
-      "Plugin support requires dynamic linking and specifying a set of symbols " \
-      "that are exported to plugins. Unfortunately your linker doesn't " \
-      "support the flag (--dynamic-list or -exported_symbols_list) used " \
-      "for this purpose. You can't build with --static."
-fi
-
 ########################################
 # See if __attribute__((alias)) is supported.
 # This false for Xcode 9, but has been remedied for Xcode 10.
@@ -6850,22 +6795,6 @@ fi
 
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> $config_host_mak
-    # Copy the export object list to the build dir
-    if test "$ld_dynamic_list" = "yes" ; then
-	echo "CONFIG_HAS_LD_DYNAMIC_LIST=yes" >> $config_host_mak
-	ld_symbols=qemu-plugins-ld.symbols
-	cp "$source_path/plugins/qemu-plugins.symbols" $ld_symbols
-    elif test "$ld_exported_symbols_list" = "yes" ; then
-	echo "CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST=yes" >> $config_host_mak
-	ld64_symbols=qemu-plugins-ld64.symbols
-	echo "# Automatically generated by configure - do not modify" > $ld64_symbols
-	grep 'qemu_' "$source_path/plugins/qemu-plugins.symbols" | sed 's/;//g' | \
-	    sed -E 's/^[[:space:]]*(.*)/_\1/' >> $ld64_symbols
-    else
-	error_exit \
-	    "If \$plugins=yes, either \$ld_dynamic_list or " \
-	    "\$ld_exported_symbols_list should have been set to 'yes'."
-    fi
 fi
 
 if test -n "$gdb_bin" ; then
diff --git a/contrib/plugins/hotblocks.c b/contrib/plugins/hotblocks.c
index 37435a3fc7..39e77d2980 100644
--- a/contrib/plugins/hotblocks.c
+++ b/contrib/plugins/hotblocks.c
@@ -13,6 +13,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/contrib/plugins/hotpages.c b/contrib/plugins/hotpages.c
index ecd6c18732..1ae3f44aed 100644
--- a/contrib/plugins/hotpages.c
+++ b/contrib/plugins/hotpages.c
@@ -16,6 +16,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/contrib/plugins/howvec.c b/contrib/plugins/howvec.c
index 3b9a6939f2..db1b4e5780 100644
--- a/contrib/plugins/howvec.c
+++ b/contrib/plugins/howvec.c
@@ -18,6 +18,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index a696673dff..7173b2910d 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -31,6 +31,7 @@
 #include <stdio.h>
 #include <errno.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
index daac8291b8..8d08f52f7f 100644
--- a/include/qemu/qemu-plugin.h
+++ b/include/qemu/qemu-plugin.h
@@ -21,11 +21,7 @@
  *   https://gcc.gnu.org/wiki/Visibility
  */
 #if defined _WIN32 || defined __CYGWIN__
-  #ifdef BUILDING_DLL
-    #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
-  #else
-    #define QEMU_PLUGIN_EXPORT __declspec(dllimport)
-  #endif
+  #define QEMU_PLUGIN_EXPORT __declspec(dllexport)
   #define QEMU_PLUGIN_LOCAL
 #else
   #if __GNUC__ >= 4
@@ -52,7 +48,9 @@ typedef uint64_t qemu_plugin_id_t;
 
 extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
 
-#define QEMU_PLUGIN_VERSION 0
+#define QEMU_PLUGIN_VERSION 1
+
+typedef void *(*qemu_plugin_global_dlsym_t)(void* context, const char *name);
 
 typedef struct {
     /* string describing architecture */
@@ -73,8 +71,23 @@ typedef struct {
             int max_vcpus;
         } system;
     };
+    void *context;
+    qemu_plugin_global_dlsym_t dlsym;
 } qemu_info_t;
 
+/**
+ * qemu_plugin_initialize() - Initialize a plugin before install
+ * @info: a block describing some details about the guest
+ *
+ * All plugins must export this symbol, and in most case using qemu-plugin.h
+ * provided implementation directly.
+ * For plugin provide this function, the QEMU_PLUGIN_VERSION should >= 1
+ *
+ * Note: This function only used to loading qemu's exported functions, nothing
+ * else should doding in this function.
+ */
+QEMU_PLUGIN_EXPORT int qemu_plugin_initialize(const qemu_info_t *info);
+
 /**
  * qemu_plugin_install() - Install a plugin
  * @id: this plugin's opaque ID
@@ -121,7 +134,7 @@ typedef void (*qemu_plugin_vcpu_udata_cb_t)(unsigned int vcpu_index,
  *
  * Note: Calling this function from qemu_plugin_install() is a bug.
  */
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+typedef void (*qemu_plugin_uninstall_t)(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
  * qemu_plugin_reset() - Reset a plugin
@@ -134,7 +147,7 @@ void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  * Plugins are reset asynchronously, and therefore the given plugin receives
  * callbacks until @cb is called.
  */
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
+typedef void (*qemu_plugin_reset_t)(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
 
 /**
  * qemu_plugin_register_vcpu_init_cb() - register a vCPU initialization callback
@@ -145,7 +158,7 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb);
  *
  * See also: qemu_plugin_register_vcpu_exit_cb()
  */
-void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_init_cb_t)(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
 /**
@@ -157,7 +170,7 @@ void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
-void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_exit_cb_t)(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
 /**
@@ -167,7 +180,7 @@ void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU idles.
  */
-void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_idle_cb_t)(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb);
 
 /**
@@ -177,7 +190,7 @@ void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a vCPU resumes execution.
  */
-void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_resume_cb_t)(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb);
 
 /*
@@ -214,7 +227,7 @@ enum qemu_plugin_mem_rw {
 typedef void (*qemu_plugin_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
                                                struct qemu_plugin_tb *tb);
 
-void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_tb_trans_cb_t)(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb);
 
 /**
@@ -226,7 +239,7 @@ void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
  *
  * The @cb function is called every time a translated unit executes.
  */
-void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+typedef void (*qemu_plugin_register_vcpu_tb_exec_cb_t)(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
                                           void *userdata);
@@ -246,7 +259,7 @@ enum qemu_plugin_op {
  * Useful if you just want to increment a single counter somewhere in
  * memory.
  */
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+typedef void (*qemu_plugin_register_vcpu_tb_exec_inline_t)(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm);
 
@@ -259,7 +272,7 @@ void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
  *
  * The @cb function is called every time an instruction is executed
  */
-void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_insn_exec_cb_t)(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
                                             void *userdata);
@@ -275,26 +288,26 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
  * Insert an inline op to every time an instruction executes. Useful
  * if you just want to increment a single counter somewhere in memory.
  */
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_insn_exec_inline_t)(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm);
 
 /*
  * Helpers to query information about the instructions in a block
  */
-size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb);
+typedef size_t (*qemu_plugin_tb_n_insns_t)(const struct qemu_plugin_tb *tb);
 
-uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb);
+typedef uint64_t (*qemu_plugin_tb_vaddr_t)(const struct qemu_plugin_tb *tb);
 
-struct qemu_plugin_insn *
-qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx);
+typedef struct qemu_plugin_insn *
+(*qemu_plugin_tb_get_insn_t)(const struct qemu_plugin_tb *tb, size_t idx);
 
-const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn);
+typedef const void *(*qemu_plugin_insn_data_t)(const struct qemu_plugin_insn *insn);
 
-size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn);
+typedef size_t (*qemu_plugin_insn_size_t)(const struct qemu_plugin_insn *insn);
 
-uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn);
-void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn);
+typedef uint64_t (*qemu_plugin_insn_vaddr_t)(const struct qemu_plugin_insn *insn);
+typedef void *(*qemu_plugin_insn_haddr_t)(const struct qemu_plugin_insn *insn);
 
 /*
  * Memory Instrumentation
@@ -307,10 +320,10 @@ typedef uint32_t qemu_plugin_meminfo_t;
 struct qemu_plugin_hwaddr;
 
 /* meminfo queries */
-unsigned int qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info);
-bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info);
-bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info);
-bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
+typedef unsigned int (*qemu_plugin_mem_size_shift_t)(qemu_plugin_meminfo_t info);
+typedef bool (*qemu_plugin_mem_is_sign_extended_t)(qemu_plugin_meminfo_t info);
+typedef bool (*qemu_plugin_mem_is_big_endian_t)(qemu_plugin_meminfo_t info);
+typedef bool (*qemu_plugin_mem_is_store_t)(qemu_plugin_meminfo_t info);
 
 /*
  * qemu_plugin_get_hwaddr():
@@ -324,7 +337,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info);
  * information about the handle should be recovered before the
  * callback returns.
  */
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+typedef struct qemu_plugin_hwaddr *(*qemu_plugin_get_hwaddr_t)(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr);
 
 /*
@@ -332,21 +345,21 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
  * to return information about it. For non-IO accesses the device
  * offset will be into the appropriate block of RAM.
  */
-bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr);
-uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr);
+typedef bool (*qemu_plugin_hwaddr_is_io_t)(const struct qemu_plugin_hwaddr *haddr);
+typedef uint64_t (*qemu_plugin_hwaddr_device_offset_t)(const struct qemu_plugin_hwaddr *haddr);
 
 typedef void
 (*qemu_plugin_vcpu_mem_cb_t)(unsigned int vcpu_index,
                              qemu_plugin_meminfo_t info, uint64_t vaddr,
                              void *userdata);
 
-void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_mem_cb_t)(struct qemu_plugin_insn *insn,
                                       qemu_plugin_vcpu_mem_cb_t cb,
                                       enum qemu_plugin_cb_flags flags,
                                       enum qemu_plugin_mem_rw rw,
                                       void *userdata);
 
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+typedef void (*qemu_plugin_register_vcpu_mem_inline_t)(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm);
@@ -359,15 +372,15 @@ typedef void
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
 
-void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_vcpu_syscall_cb_t)(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb);
 
 typedef void
 (*qemu_plugin_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_idx,
                                      int64_t num, int64_t ret);
 
-void
-qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
+typedef void
+(*qemu_plugin_register_vcpu_syscall_ret_cb_t)(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb);
 
 
@@ -378,7 +391,7 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
  * Returns an allocated string containing the disassembly
  */
 
-char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
+typedef char *(*qemu_plugin_insn_disas_t)(const struct qemu_plugin_insn *insn);
 
 /**
  * qemu_plugin_vcpu_for_each() - iterate over the existing vCPU
@@ -389,25 +402,117 @@ char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn);
  *
  * See also: qemu_plugin_register_vcpu_init_cb()
  */
-void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_vcpu_for_each_t)(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb);
 
-void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_flush_cb_t)(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb);
 
-void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
+typedef void (*qemu_plugin_register_atexit_cb_t)(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb, void *userdata);
 
 /* returns -1 in user-mode */
-int qemu_plugin_n_vcpus(void);
+typedef int (*qemu_plugin_n_vcpus_t)(void);
 
 /* returns -1 in user-mode */
-int qemu_plugin_n_max_vcpus(void);
+typedef int (*qemu_plugin_n_max_vcpus_t)(void);
 
 /**
  * qemu_plugin_outs() - output string via QEMU's logging system
  * @string: a string
  */
-void qemu_plugin_outs(const char *string);
+typedef void (*qemu_plugin_outs_t)(const char *string);
+
+#if !defined(QEMU_PLUGIN_API_IMPLEMENTATION)
+#if defined(QEMU_PLUGIN_IMPLEMENTATION)
+#define QEMU_PLUGIN_EXTERN
+#else
+#define QEMU_PLUGIN_EXTERN extern
+#endif
+
+QEMU_PLUGIN_EXTERN qemu_plugin_uninstall_t qemu_plugin_uninstall;
+QEMU_PLUGIN_EXTERN qemu_plugin_reset_t qemu_plugin_reset;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_init_cb_t qemu_plugin_register_vcpu_init_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_exit_cb_t qemu_plugin_register_vcpu_exit_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_idle_cb_t qemu_plugin_register_vcpu_idle_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_resume_cb_t qemu_plugin_register_vcpu_resume_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_tb_trans_cb_t qemu_plugin_register_vcpu_tb_trans_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_tb_exec_cb_t qemu_plugin_register_vcpu_tb_exec_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_tb_exec_inline_t qemu_plugin_register_vcpu_tb_exec_inline;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_insn_exec_cb_t qemu_plugin_register_vcpu_insn_exec_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_insn_exec_inline_t qemu_plugin_register_vcpu_insn_exec_inline;
+QEMU_PLUGIN_EXTERN qemu_plugin_tb_n_insns_t qemu_plugin_tb_n_insns;
+QEMU_PLUGIN_EXTERN qemu_plugin_tb_vaddr_t qemu_plugin_tb_vaddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_tb_get_insn_t qemu_plugin_tb_get_insn;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_data_t qemu_plugin_insn_data;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_size_t qemu_plugin_insn_size;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_vaddr_t qemu_plugin_insn_vaddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_haddr_t qemu_plugin_insn_haddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_size_shift_t qemu_plugin_mem_size_shift;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_is_sign_extended_t qemu_plugin_mem_is_sign_extended;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_is_big_endian_t qemu_plugin_mem_is_big_endian;
+QEMU_PLUGIN_EXTERN qemu_plugin_mem_is_store_t qemu_plugin_mem_is_store;
+QEMU_PLUGIN_EXTERN qemu_plugin_get_hwaddr_t qemu_plugin_get_hwaddr;
+QEMU_PLUGIN_EXTERN qemu_plugin_hwaddr_is_io_t qemu_plugin_hwaddr_is_io;
+QEMU_PLUGIN_EXTERN qemu_plugin_hwaddr_device_offset_t qemu_plugin_hwaddr_device_offset;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_mem_cb_t qemu_plugin_register_vcpu_mem_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_mem_inline_t qemu_plugin_register_vcpu_mem_inline;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_syscall_cb_t qemu_plugin_register_vcpu_syscall_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_vcpu_syscall_ret_cb_t qemu_plugin_register_vcpu_syscall_ret_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_insn_disas_t qemu_plugin_insn_disas;
+QEMU_PLUGIN_EXTERN qemu_plugin_vcpu_for_each_t qemu_plugin_vcpu_for_each;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_flush_cb_t qemu_plugin_register_flush_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_register_atexit_cb_t qemu_plugin_register_atexit_cb;
+QEMU_PLUGIN_EXTERN qemu_plugin_n_vcpus_t qemu_plugin_n_vcpus;
+QEMU_PLUGIN_EXTERN qemu_plugin_n_max_vcpus_t qemu_plugin_n_max_vcpus;
+QEMU_PLUGIN_EXTERN qemu_plugin_outs_t qemu_plugin_outs;
+
+#if defined(QEMU_PLUGIN_IMPLEMENTATION)
+
+QEMU_PLUGIN_EXPORT int qemu_plugin_initialize(const qemu_info_t *info)
+{
+    qemu_plugin_uninstall = info->dlsym(info->context, "qemu_plugin_uninstall");
+    qemu_plugin_reset = info->dlsym(info->context, "qemu_plugin_reset");
+    qemu_plugin_register_vcpu_init_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_init_cb");
+    qemu_plugin_register_vcpu_exit_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_exit_cb");
+    qemu_plugin_register_vcpu_idle_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_idle_cb");
+    qemu_plugin_register_vcpu_resume_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_resume_cb");
+    qemu_plugin_register_vcpu_tb_trans_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_tb_trans_cb");
+    qemu_plugin_register_vcpu_tb_exec_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_tb_exec_cb");
+    qemu_plugin_register_vcpu_tb_exec_inline = info->dlsym(info->context, "qemu_plugin_register_vcpu_tb_exec_inline");
+    qemu_plugin_register_vcpu_insn_exec_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_insn_exec_cb");
+    qemu_plugin_register_vcpu_insn_exec_inline = info->dlsym(info->context, "qemu_plugin_register_vcpu_insn_exec_inline");
+    qemu_plugin_tb_n_insns = info->dlsym(info->context, "qemu_plugin_tb_n_insns");
+    qemu_plugin_tb_vaddr = info->dlsym(info->context, "qemu_plugin_tb_vaddr");
+    qemu_plugin_tb_get_insn = info->dlsym(info->context, "qemu_plugin_tb_get_insn");
+    qemu_plugin_insn_data = info->dlsym(info->context, "qemu_plugin_insn_data");
+    qemu_plugin_insn_size = info->dlsym(info->context, "qemu_plugin_insn_size");
+    qemu_plugin_insn_vaddr = info->dlsym(info->context, "qemu_plugin_insn_vaddr");
+    qemu_plugin_insn_haddr = info->dlsym(info->context, "qemu_plugin_insn_haddr");
+    qemu_plugin_mem_size_shift = info->dlsym(info->context, "qemu_plugin_mem_size_shift");
+    qemu_plugin_mem_is_sign_extended = info->dlsym(info->context, "qemu_plugin_mem_is_sign_extended");
+    qemu_plugin_mem_is_big_endian = info->dlsym(info->context, "qemu_plugin_mem_is_big_endian");
+    qemu_plugin_mem_is_store = info->dlsym(info->context, "qemu_plugin_mem_is_store");
+    qemu_plugin_get_hwaddr = info->dlsym(info->context, "qemu_plugin_get_hwaddr");
+    qemu_plugin_hwaddr_is_io = info->dlsym(info->context, "qemu_plugin_hwaddr_is_io");
+    qemu_plugin_hwaddr_device_offset = info->dlsym(info->context, "qemu_plugin_hwaddr_device_offset");
+    qemu_plugin_register_vcpu_mem_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_mem_cb");
+    qemu_plugin_register_vcpu_mem_inline = info->dlsym(info->context, "qemu_plugin_register_vcpu_mem_inline");
+    qemu_plugin_register_vcpu_syscall_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_syscall_cb");
+    qemu_plugin_register_vcpu_syscall_ret_cb = info->dlsym(info->context, "qemu_plugin_register_vcpu_syscall_ret_cb");
+    qemu_plugin_insn_disas = info->dlsym(info->context, "qemu_plugin_insn_disas");
+    qemu_plugin_vcpu_for_each = info->dlsym(info->context, "qemu_plugin_vcpu_for_each");
+    qemu_plugin_register_flush_cb = info->dlsym(info->context, "qemu_plugin_register_flush_cb");
+    qemu_plugin_register_atexit_cb = info->dlsym(info->context, "qemu_plugin_register_atexit_cb");
+    qemu_plugin_n_vcpus = info->dlsym(info->context, "qemu_plugin_n_vcpus");
+    qemu_plugin_n_max_vcpus = info->dlsym(info->context, "qemu_plugin_n_max_vcpus");
+    qemu_plugin_outs = info->dlsym(info->context, "qemu_plugin_outs");
+    return 0;
+}
+
+#endif
+
+#endif /* QEMU_PLUGIN_API_IMPLEMENTATION */
+
 
 #endif /* QEMU_PLUGIN_API_H */
diff --git a/meson.build b/meson.build
index d515ece664..95a532bd29 100644
--- a/meson.build
+++ b/meson.build
@@ -331,7 +331,11 @@ endif
 rt = cc.find_library('rt', required: false)
 libdl = not_found
 if 'CONFIG_PLUGIN' in config_host
-  libdl = cc.find_library('dl', required: true)
+  if targetos == 'windows'
+    libdl = declare_dependency(compile_args: [], link_args: [])
+  else
+    libdl = cc.find_library('dl', required: true)
+  endif
 endif
 libiscsi = not_found
 if 'CONFIG_LIBISCSI' in config_host
diff --git a/plugins/api.c b/plugins/api.c
index 13177d3578..96e3345a3f 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -35,6 +35,7 @@
  */
 
 #include "qemu/osdep.h"
+#define QEMU_PLUGIN_API_IMPLEMENTATION
 #include "qemu/plugin.h"
 #include "cpu.h"
 #include "sysemu/sysemu.h"
@@ -48,14 +49,17 @@
 #endif
 #include "trace/mem.h"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wmissing-prototypes"
+
 /* Uninstall and Reset handlers */
 
-void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+QEMU_PLUGIN_EXPORT void qemu_plugin_uninstall(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
 {
     plugin_reset_uninstall(id, cb, false);
 }
 
-void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
+QEMU_PLUGIN_EXPORT void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
 {
     plugin_reset_uninstall(id, cb, true);
 }
@@ -67,19 +71,19 @@ void qemu_plugin_reset(qemu_plugin_id_t id, qemu_plugin_simple_cb_t cb)
  * during the translation.
  */
 
-void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_init_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INIT, cb);
 }
 
-void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_exit_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXIT, cb);
 }
 
-void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                           qemu_plugin_vcpu_udata_cb_t cb,
                                           enum qemu_plugin_cb_flags flags,
                                           void *udata)
@@ -88,14 +92,14 @@ void qemu_plugin_register_vcpu_tb_exec_cb(struct qemu_plugin_tb *tb,
                                   cb, flags, udata);
 }
 
-void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_tb_exec_inline(struct qemu_plugin_tb *tb,
                                               enum qemu_plugin_op op,
                                               void *ptr, uint64_t imm)
 {
     plugin_register_inline_op(&tb->cbs[PLUGIN_CB_INLINE], 0, op, ptr, imm);
 }
 
-void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
                                             qemu_plugin_vcpu_udata_cb_t cb,
                                             enum qemu_plugin_cb_flags flags,
                                             void *udata)
@@ -104,7 +108,7 @@ void qemu_plugin_register_vcpu_insn_exec_cb(struct qemu_plugin_insn *insn,
         cb, flags, udata);
 }
 
-void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
                                                 enum qemu_plugin_op op,
                                                 void *ptr, uint64_t imm)
 {
@@ -114,7 +118,7 @@ void qemu_plugin_register_vcpu_insn_exec_inline(struct qemu_plugin_insn *insn,
 
 
 
-void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                       qemu_plugin_vcpu_mem_cb_t cb,
                                       enum qemu_plugin_cb_flags flags,
                                       enum qemu_plugin_mem_rw rw,
@@ -124,7 +128,7 @@ void qemu_plugin_register_vcpu_mem_cb(struct qemu_plugin_insn *insn,
                                 cb, flags, rw, udata);
 }
 
-void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
                                           enum qemu_plugin_mem_rw rw,
                                           enum qemu_plugin_op op, void *ptr,
                                           uint64_t imm)
@@ -133,19 +137,19 @@ void qemu_plugin_register_vcpu_mem_inline(struct qemu_plugin_insn *insn,
         rw, op, ptr, imm);
 }
 
-void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_tb_trans_cb(qemu_plugin_id_t id,
                                            qemu_plugin_vcpu_tb_trans_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_TB_TRANS, cb);
 }
 
-void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_syscall_cb(qemu_plugin_id_t id,
                                           qemu_plugin_vcpu_syscall_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_SYSCALL, cb);
 }
 
-void
+QEMU_PLUGIN_EXPORT void
 qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_syscall_ret_cb_t cb)
 {
@@ -168,17 +172,17 @@ qemu_plugin_register_vcpu_syscall_ret_cb(qemu_plugin_id_t id,
  * each translated instruction.
  */
 
-size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
+QEMU_PLUGIN_EXPORT size_t qemu_plugin_tb_n_insns(const struct qemu_plugin_tb *tb)
 {
     return tb->n;
 }
 
-uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
+QEMU_PLUGIN_EXPORT uint64_t qemu_plugin_tb_vaddr(const struct qemu_plugin_tb *tb)
 {
     return tb->vaddr;
 }
 
-struct qemu_plugin_insn *
+QEMU_PLUGIN_EXPORT struct qemu_plugin_insn *
 qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
 {
     if (unlikely(idx >= tb->n)) {
@@ -194,27 +198,27 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
  * instruction being translated.
  */
 
-const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT const void *qemu_plugin_insn_data(const struct qemu_plugin_insn *insn)
 {
     return insn->data->data;
 }
 
-size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
 {
     return insn->data->len;
 }
 
-uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
 {
     return insn->vaddr;
 }
 
-void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
     return insn->haddr;
 }
 
-char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
+QEMU_PLUGIN_EXPORT char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
 {
     CPUState *cpu = current_cpu;
     return plugin_disas(cpu, insn->vaddr, insn->data->len);
@@ -225,22 +229,22 @@ char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
  * memory access.
  */
 
-unsigned qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT unsigned qemu_plugin_mem_size_shift(qemu_plugin_meminfo_t info)
 {
     return info & TRACE_MEM_SZ_SHIFT_MASK;
 }
 
-bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_mem_is_sign_extended(qemu_plugin_meminfo_t info)
 {
     return !!(info & TRACE_MEM_SE);
 }
 
-bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_mem_is_big_endian(qemu_plugin_meminfo_t info)
 {
     return !!(info & TRACE_MEM_BE);
 }
 
-bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
 {
     return !!(info & TRACE_MEM_ST);
 }
@@ -253,7 +257,7 @@ bool qemu_plugin_mem_is_store(qemu_plugin_meminfo_t info)
 static __thread struct qemu_plugin_hwaddr hwaddr_info;
 #endif
 
-struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
+QEMU_PLUGIN_EXPORT struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
                                                   uint64_t vaddr)
 {
 #ifdef CONFIG_SOFTMMU
@@ -273,7 +277,7 @@ struct qemu_plugin_hwaddr *qemu_plugin_get_hwaddr(qemu_plugin_meminfo_t info,
 #endif
 }
 
-bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
+QEMU_PLUGIN_EXPORT bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 {
 #ifdef CONFIG_SOFTMMU
     return haddr->is_io;
@@ -282,7 +286,7 @@ bool qemu_plugin_hwaddr_is_io(const struct qemu_plugin_hwaddr *haddr)
 #endif
 }
 
-uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr)
+QEMU_PLUGIN_EXPORT uint64_t qemu_plugin_hwaddr_device_offset(const struct qemu_plugin_hwaddr *haddr)
 {
 #ifdef CONFIG_SOFTMMU
     if (haddr) {
@@ -313,7 +317,7 @@ static MachineState * get_ms(void)
 }
 #endif
 
-int qemu_plugin_n_vcpus(void)
+QEMU_PLUGIN_EXPORT int qemu_plugin_n_vcpus(void)
 {
 #ifdef CONFIG_USER_ONLY
     return -1;
@@ -322,7 +326,7 @@ int qemu_plugin_n_vcpus(void)
 #endif
 }
 
-int qemu_plugin_n_max_vcpus(void)
+QEMU_PLUGIN_EXPORT int qemu_plugin_n_max_vcpus(void)
 {
 #ifdef CONFIG_USER_ONLY
     return -1;
@@ -334,7 +338,9 @@ int qemu_plugin_n_max_vcpus(void)
 /*
  * Plugin output
  */
-void qemu_plugin_outs(const char *string)
+QEMU_PLUGIN_EXPORT void qemu_plugin_outs(const char *string)
 {
     qemu_log_mask(CPU_LOG_PLUGIN, "%s", string);
 }
+
+#pragma GCC diagnostic pop
diff --git a/plugins/core.c b/plugins/core.c
index 51bfc94787..dd1ec7b3fc 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -12,6 +12,7 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 #include "qemu/osdep.h"
+#define QEMU_PLUGIN_API_IMPLEMENTATION
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "qapi/error.h"
@@ -32,6 +33,9 @@
 #include "trace/mem-internal.h" /* mem_info macros */
 #include "plugin.h"
 
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wmissing-prototypes"
+
 struct qemu_plugin_cb {
     struct qemu_plugin_ctx *ctx;
     union qemu_plugin_cb_sig f;
@@ -233,7 +237,7 @@ static void plugin_vcpu_for_each(gpointer k, gpointer v, gpointer udata)
     args->cb(args->ctx->id, cpu_index);
 }
 
-void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_vcpu_for_each(qemu_plugin_id_t id,
                                qemu_plugin_vcpu_simple_cb_t cb)
 {
     struct plugin_for_each_args args;
@@ -384,19 +388,19 @@ void qemu_plugin_vcpu_resume_cb(CPUState *cpu)
     plugin_vcpu_cb__simple(cpu, QEMU_PLUGIN_EV_VCPU_RESUME);
 }
 
-void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id,
                                        qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_IDLE, cb);
 }
 
-void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
                                          qemu_plugin_vcpu_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
 }
 
-void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
                                    qemu_plugin_simple_cb_t cb)
 {
     plugin_register_cb(id, QEMU_PLUGIN_EV_FLUSH, cb);
@@ -463,7 +467,7 @@ void qemu_plugin_atexit_cb(void)
     plugin_cb__udata(QEMU_PLUGIN_EV_ATEXIT);
 }
 
-void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
+QEMU_PLUGIN_EXPORT void qemu_plugin_register_atexit_cb(qemu_plugin_id_t id,
                                     qemu_plugin_udata_cb_t cb,
                                     void *udata)
 {
@@ -500,3 +504,5 @@ static void __attribute__((__constructor__)) plugin_init(void)
              QHT_MODE_AUTO_RESIZE);
     atexit(qemu_plugin_atexit_cb);
 }
+
+#pragma GCC diagnostic pop
diff --git a/plugins/loader.c b/plugins/loader.c
index 8ac5dbc20f..53fb1671ee 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -63,6 +63,7 @@ QemuOptsList qemu_plugin_opts = {
     },
 };
 
+typedef int (*qemu_plugin_initialize_func_t)(const qemu_info_t *);
 typedef int (*qemu_plugin_install_func_t)(qemu_plugin_id_t, const qemu_info_t *, int, char **);
 
 extern struct qemu_plugin_state plugin;
@@ -152,10 +153,12 @@ static uint64_t xorshift64star(uint64_t x)
 
 static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
 {
+    qemu_plugin_initialize_func_t initialize = NULL;
     qemu_plugin_install_func_t install;
     struct qemu_plugin_ctx *ctx;
     gpointer sym;
     int rc;
+    int version = -1;
 
     ctx = qemu_memalign(qemu_dcache_linesize, sizeof(*ctx));
     memset(ctx, 0, sizeof(*ctx));
@@ -184,7 +187,7 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
                      desc->path, g_module_error());
         goto err_symbol;
     } else {
-        int version = *(int *)sym;
+        version = *(int *)sym;
         if (version < QEMU_PLUGIN_MIN_VERSION) {
             error_report("TCG plugin %s requires API version %d, but "
                          "this QEMU supports only a minimum version of %d",
@@ -198,6 +201,21 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
         }
     }
 
+    if (version >= QEMU_PLUGIN_VERSION_1) {
+        /* This version should call to qemu_plugin_initialize first */
+        if (!g_module_symbol(ctx->handle, "qemu_plugin_initialize", &sym)) {
+            error_report("%s: %s", __func__, g_module_error());
+            goto err_symbol;
+        }
+        initialize = (qemu_plugin_initialize_func_t) sym;
+        /* symbol was found; it could be NULL though */
+        if (initialize == NULL) {
+            error_report("%s: %s: qemu_plugin_initialize is NULL",
+                        __func__, desc->path);
+            goto err_symbol;
+        }
+    }
+
     qemu_rec_mutex_lock(&plugin.lock);
 
     /* find an unused random id with &ctx as the seed */
@@ -216,6 +234,16 @@ static int plugin_load(struct qemu_plugin_desc *desc, const qemu_info_t *info)
         }
     }
     QTAILQ_INSERT_TAIL(&plugin.ctxs, ctx, entry);
+    if (initialize != NULL) {
+        rc = initialize(info);
+        if (rc) {
+            error_report("%s: qemu_plugin_initialize returned error code %d",
+                        __func__, rc);
+            /* qemu_plugin_initialize only loading function symbols */
+            goto err_symbol;
+        }
+    }
+
     ctx->installing = true;
     rc = install(ctx->id, info, desc->argc, desc->argv);
     ctx->installing = false;
@@ -254,6 +282,17 @@ static void plugin_desc_free(struct qemu_plugin_desc *desc)
     g_free(desc);
 }
 
+static void *qemu_plugin_global_dlsym(void* context, const char *name)
+{
+    GModule *global_handle = context;
+    gpointer sym = NULL;
+    if (!g_module_symbol(global_handle, name, &sym)) {
+        error_report("%s: %s", __func__, g_module_error());
+        return NULL;
+    }
+    return sym;
+}
+
 /**
  * qemu_plugin_load_list - load a list of plugins
  * @head: head of the list of descriptors of the plugins to be loaded
@@ -267,6 +306,7 @@ int qemu_plugin_load_list(QemuPluginList *head)
 {
     struct qemu_plugin_desc *desc, *next;
     g_autofree qemu_info_t *info = g_new0(qemu_info_t, 1);
+    GModule *global_handle = NULL;
 
     info->target_name = TARGET_NAME;
     info->version.min = QEMU_PLUGIN_MIN_VERSION;
@@ -276,6 +316,12 @@ int qemu_plugin_load_list(QemuPluginList *head)
     info->system_emulation = true;
     info->system.smp_vcpus = ms->smp.cpus;
     info->system.max_vcpus = ms->smp.max_cpus;
+    global_handle = g_module_open(NULL, G_MODULE_BIND_LOCAL);
+    if (global_handle == NULL) {
+        goto err_dlopen;
+    }
+    info->dlsym = qemu_plugin_global_dlsym;
+    info->context = (void*)global_handle;
 #else
     info->system_emulation = false;
 #endif
@@ -289,6 +335,8 @@ int qemu_plugin_load_list(QemuPluginList *head)
         }
         QTAILQ_REMOVE(head, desc, entry);
     }
+
+err_dlopen:
     return 0;
 }
 
diff --git a/plugins/meson.build b/plugins/meson.build
index e77723010e..b48d2046ff 100644
--- a/plugins/meson.build
+++ b/plugins/meson.build
@@ -1,13 +1,5 @@
-if 'CONFIG_HAS_LD_DYNAMIC_LIST' in config_host
-  plugin_ldflags = ['-Wl,--dynamic-list=' + (meson.build_root() / 'qemu-plugins-ld.symbols')]
-elif 'CONFIG_HAS_LD_EXPORTED_SYMBOLS_LIST' in config_host
-  plugin_ldflags = ['-Wl,-exported_symbols_list,' + (meson.build_root() / 'qemu-plugins-ld64.symbols')]
-else
-  plugin_ldflags = []
-endif
-
 specific_ss.add(when: 'CONFIG_PLUGIN', if_true: [files(
   'loader.c',
   'core.c',
   'api.c',
-), declare_dependency(link_args: plugin_ldflags)])
+), declare_dependency(link_args: [], compile_args: [])])
diff --git a/plugins/plugin.h b/plugins/plugin.h
index 1aa29dcadd..406f246a72 100644
--- a/plugins/plugin.h
+++ b/plugins/plugin.h
@@ -15,6 +15,7 @@
 #include <gmodule.h>
 
 #define QEMU_PLUGIN_MIN_VERSION 0
+#define QEMU_PLUGIN_VERSION_1 1
 
 /* global state */
 struct qemu_plugin_state {
diff --git a/plugins/qemu-plugins.symbols b/plugins/qemu-plugins.symbols
deleted file mode 100644
index 4bdb381f48..0000000000
--- a/plugins/qemu-plugins.symbols
+++ /dev/null
@@ -1,40 +0,0 @@
-{
-  qemu_plugin_uninstall;
-  qemu_plugin_reset;
-  qemu_plugin_register_vcpu_init_cb;
-  qemu_plugin_register_vcpu_exit_cb;
-  qemu_plugin_register_vcpu_idle_cb;
-  qemu_plugin_register_vcpu_resume_cb;
-  qemu_plugin_register_vcpu_insn_exec_cb;
-  qemu_plugin_register_vcpu_insn_exec_inline;
-  qemu_plugin_register_vcpu_mem_cb;
-  qemu_plugin_register_vcpu_mem_haddr_cb;
-  qemu_plugin_register_vcpu_mem_inline;
-  qemu_plugin_ram_addr_from_host;
-  qemu_plugin_register_vcpu_tb_trans_cb;
-  qemu_plugin_register_vcpu_tb_exec_cb;
-  qemu_plugin_register_vcpu_tb_exec_inline;
-  qemu_plugin_register_flush_cb;
-  qemu_plugin_register_vcpu_syscall_cb;
-  qemu_plugin_register_vcpu_syscall_ret_cb;
-  qemu_plugin_register_atexit_cb;
-  qemu_plugin_tb_n_insns;
-  qemu_plugin_tb_get_insn;
-  qemu_plugin_tb_vaddr;
-  qemu_plugin_insn_data;
-  qemu_plugin_insn_size;
-  qemu_plugin_insn_vaddr;
-  qemu_plugin_insn_haddr;
-  qemu_plugin_insn_disas;
-  qemu_plugin_mem_size_shift;
-  qemu_plugin_mem_is_sign_extended;
-  qemu_plugin_mem_is_big_endian;
-  qemu_plugin_mem_is_store;
-  qemu_plugin_get_hwaddr;
-  qemu_plugin_hwaddr_is_io;
-  qemu_plugin_hwaddr_to_raddr;
-  qemu_plugin_vcpu_for_each;
-  qemu_plugin_n_vcpus;
-  qemu_plugin_n_max_vcpus;
-  qemu_plugin_outs;
-};
diff --git a/tests/plugin/bb.c b/tests/plugin/bb.c
index de09bdde4e..cda3fbdde9 100644
--- a/tests/plugin/bb.c
+++ b/tests/plugin/bb.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/tests/plugin/empty.c b/tests/plugin/empty.c
index 8fa6bacd93..0c3adf7aa0 100644
--- a/tests/plugin/empty.c
+++ b/tests/plugin/empty.c
@@ -11,6 +11,7 @@
 #include <unistd.h>
 #include <stdio.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/tests/plugin/insn.c b/tests/plugin/insn.c
index a9a6e41237..bf86fdafe6 100644
--- a/tests/plugin/insn.c
+++ b/tests/plugin/insn.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
diff --git a/tests/plugin/mem.c b/tests/plugin/mem.c
index 4725bd851d..f39be9c969 100644
--- a/tests/plugin/mem.c
+++ b/tests/plugin/mem.c
@@ -12,6 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
+#define QEMU_PLUGIN_IMPLEMENTATION
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
-- 
2.28.0.windows.1


