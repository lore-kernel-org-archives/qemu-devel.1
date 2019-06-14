Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906C8C31E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64F5321848
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:53:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zaCNsjX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F5321848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53904 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbqNz-00072G-G0
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:53:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34005)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0F-00075Y-Ba
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbq0B-0003td-TX
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:37 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33062)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbq0A-0003kk-Ib
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:28:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so3385863wru.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gsafAaKWWEo4Uo36EmX0kTE77G4d03quI77xyI/6ztg=;
 b=zaCNsjX1Sklh9vJ7E9Ciq6mN5AED+FXPDKin3o4rpH9/iYlUeuUcdmMDAwAfkBPcCD
 vXTH3tB9meeGKyTLyf36QMweGwyE8CP8wypVMv5b/sgIVy6H6LII1DAniff5POyWPhIf
 VXyk3E8PQFAgt/85+vfDJHuT36bWIizc+SWn3ZxPdeSPgCnY5nPST/thWVKrZAaWs99b
 /jsyNFT/qXeeTQa9ZX8//sRsY8VWmjR3PHFn7R0/d2o/bJwbVyXZ4yeEitrqZeij3B1T
 YPrjft0KgWGk6A0rw6LU5rJJoHnPaz2ZH7KjjRbGe7aDKG7m1YnhGUwBqtlzLX2HE/Vz
 xcQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gsafAaKWWEo4Uo36EmX0kTE77G4d03quI77xyI/6ztg=;
 b=DQ0tSY5JsWuxXhX7nyBKz6pItMIUa6K4lS1HUxic/X8kbNmunnSOpOyQGGgUs2pcGS
 ZRymssa5o9rUYJk8sDRIBt/O+KLh6mWpHAKDkW3fvyQeHl8iwg01V3Akx5OXgi+aI6dQ
 LDEcce8NE5o5Lei6rGkhthlZuT2JXuQ+y1uAOSvXNVQ2JTb5DMmwHw+gFaL6Is0Glgfa
 jNU/mpR8QKS4JpBPCs70VMxdVd206WEPZLftsUKECWbojsg6OcD5qfCqE3/qsDpkTgA3
 qCd/5s9cNDrYFzw0VSjy+w6nL1t+r5gJwHB3ELrxYb4eBNoR5IsLMzMAChhwvvsL7TjE
 Fxng==
X-Gm-Message-State: APjAAAX9vQ6zdx2W/bTUcFAxaPKJs/CN7Tg+bVye5e2uyNi/JXRq+wxV
 QUnwm/fV80ETdhW0sMa6xnz0w2sMvig=
X-Google-Smtp-Source: APXvYqzShaMTBTlWtca3XdE385bmHNBYE1HD2AUHWAB14uht18erwzmYwVRIHvACmmk+HHUVFTtD7A==
X-Received: by 2002:a5d:4b4f:: with SMTP id w15mr8689164wrs.199.1560533309569; 
 Fri, 14 Jun 2019 10:28:29 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id b5sm3951472wru.69.2019.06.14.10.28.27
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:28:27 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D5B0E1FFBD;
 Fri, 14 Jun 2019 18:12:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:48 +0100
Message-Id: <20190614171200.21078-39-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH v3 38/50] plugin: add API symbols to
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
Cc: "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
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
 plugins/qemu-plugins.symbols | 35 ++++++++++++++++++
 5 files changed, 121 insertions(+)
 create mode 100644 plugins/.gitignore
 create mode 100644 plugins/qemu-plugins.symbols

diff --git a/Makefile b/Makefile
index 37d396ab88..f3f0c68e85 100644
--- a/Makefile
+++ b/Makefile
@@ -718,6 +718,7 @@ distclean: clean
 	rm -f qemu-doc.fn qemu-doc.fns qemu-doc.info qemu-doc.ky qemu-doc.kys
 	rm -f qemu-doc.log qemu-doc.pdf qemu-doc.pg qemu-doc.toc qemu-doc.tp
 	rm -f qemu-doc.vr qemu-doc.txt
+	rm -f qemu-plugins-ld.symbols qemu-plugins-ld64.symbols
 	rm -f config.log
 	rm -f linux-headers/asm
 	rm -f docs/version.texi
diff --git a/configure b/configure
index 48f3263e55..d3bf254191 100755
--- a/configure
+++ b/configure
@@ -30,6 +30,7 @@ TMPO="${TMPDIR1}/${TMPB}.o"
 TMPCXX="${TMPDIR1}/${TMPB}.cxx"
 TMPE="${TMPDIR1}/${TMPB}.exe"
 TMPMO="${TMPDIR1}/${TMPB}.mo"
+TMPTXT="${TMPDIR1}/${TMPB}.txt"
 
 rm -f config.log
 
@@ -5496,6 +5497,58 @@ if compile_prog "" "" ; then
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
@@ -7307,6 +7360,22 @@ fi
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
index 0000000000..7b8aaa1f10
--- /dev/null
+++ b/plugins/.gitignore
@@ -0,0 +1,2 @@
+qemu-plugins-ld.symbols
+qemu-plugins-ld64.symbols
diff --git a/plugins/Makefile.objs b/plugins/Makefile.objs
index 95baabf3d2..6f14d91ccb 100644
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
index 0000000000..38d47b7922
--- /dev/null
+++ b/plugins/qemu-plugins.symbols
@@ -0,0 +1,35 @@
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
+  qemu_plugin_vcpu_for_each;
+  qemu_plugin_n_vcpus;
+  qemu_plugin_n_max_vcpus;
+};
-- 
2.20.1


