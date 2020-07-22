Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA429C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:01:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A309D2065E
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TFK6oXAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A309D2065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyBYh-0002dn-VO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 06:01:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55756)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxi-0008Oj-IY
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:54 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531]:33099)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1jyAxg-0006H3-AY
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 05:22:54 -0400
Received: by mail-pg1-x531.google.com with SMTP id o13so895047pgf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MqJ1W7Xx6Rp4RwGFL/cojw2iykbesH1Xy4iT4eyuvxQ=;
 b=TFK6oXAmpE4GwPcmKizc2c4ZIln0NzP4fFxg/NfqCom1NHwcWklZRlqClYmC0X8qJ9
 F2n3h++8MAYoaWB5vU8Q6qwzuKmNo7EezJ5rNe6O842UiTxQLBHbTCcBTZIKr76VO+Ma
 zR23MRQjkR3spt4vj5QpFVlltkHZJ0oCTje12/av8xzTktHxEpksjMr5v8vV9UljJyeu
 KH6nnhZpweRyyy0/R0iE7fj27icmQxjFPT/IRd8A+j3fz20AW1IDgmJxxpUCQxo8qMqF
 FpvjrgtcuI9UEXvOJHkhzFimtaQyGHuZyuTwUpsmnDsnEvATkR9jnlRh3M/y8W/Qf7fw
 urGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MqJ1W7Xx6Rp4RwGFL/cojw2iykbesH1Xy4iT4eyuvxQ=;
 b=swTzphvvYL2bKJwjfat0GhFRNFkPv3mwOZO/QKfGRfWG/Pur2SeNU68APd2bzYZkSE
 1lS/w3WxeUyFiTIRxogjQoKJC5V/1lYl1KDehcnavF1Ybr3uY+uV0INq415J1C6iHLjg
 gt3NlrYF6wSxccnpRPIxe9WamDzwNOmhB4mV7tnkdy81FoE7RpA8+U2wWXvXjkPn5ah2
 Ng9f6T/3DfhbXx9VVj5IhNl68MIgarUzsVXKI5sI2XWpbq+2i1yzmwIPbRjJ4ROzVdAe
 wVUHXjos22wpVWRT/7UvqBynVaCykmWiEjlKsVAVb0SOkEly7GZRL0EAE31o3H7uiVzg
 OZEw==
X-Gm-Message-State: AOAM531pzUpENnpkVzEHYbwRK6BVUnkestyhOAASegVLj9iV87Y80b6u
 cGUOeHur4HWMIFSeZtf8PfdKxsRwmfE=
X-Google-Smtp-Source: ABdhPJwhk2+ZYsuIY7BNcbGN4g1i7wHjjy6Jdk7GL+Kf3tsx4uJzLz3KxIM4Ja0dBlRWDru1sTdAig==
X-Received: by 2002:a05:6a00:2b0:: with SMTP id
 q16mr29635976pfs.79.1595409770535; 
 Wed, 22 Jul 2020 02:22:50 -0700 (PDT)
Received: from frankchang-ThinkPad-T490.internal.sifive.com
 (114-34-229-221.HINET-IP.hinet.net. [114.34.229.221])
 by smtp.gmail.com with ESMTPSA id c125sm22301879pfa.119.2020.07.22.02.22.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2020 02:22:50 -0700 (PDT)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Subject: [RFC v2 75/76] target/riscv: gdb: support vector registers for rv64
Date: Wed, 22 Jul 2020 17:16:38 +0800
Message-Id: <20200722091641.8834-76-frank.chang@sifive.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722091641.8834-1-frank.chang@sifive.com>
References: <20200722091641.8834-1-frank.chang@sifive.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=frank.chang@sifive.com; helo=mail-pg1-x531.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Frank Chang <frank.chang@sifive.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Hsiangkai Wang <kai.wang@sifive.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Hsiangkai Wang <kai.wang@sifive.com>

Signed-off-by: Hsiangkai Wang <kai.wang@sifive.com>
Signed-off-by: Frank Chang <frank.chang@sifive.com>
---
 configure                           |  2 +-
 gdb-xml/riscv-64bit-csr.xml         |  7 ++++
 gdb-xml/riscv-64bit-vector-128b.xml | 59 +++++++++++++++++++++++++++
 gdb-xml/riscv-64bit-vector-256b.xml | 59 +++++++++++++++++++++++++++
 gdb-xml/riscv-64bit-vector-512b.xml | 59 +++++++++++++++++++++++++++
 target/riscv/gdbstub.c              | 62 ++++++++++++++++++++++++++++-
 6 files changed, 245 insertions(+), 3 deletions(-)
 create mode 100644 gdb-xml/riscv-64bit-vector-128b.xml
 create mode 100644 gdb-xml/riscv-64bit-vector-256b.xml
 create mode 100644 gdb-xml/riscv-64bit-vector-512b.xml

diff --git a/configure b/configure
index ee6c3c6792..8d69013a97 100755
--- a/configure
+++ b/configure
@@ -8228,7 +8228,7 @@ case "$target_name" in
     TARGET_BASE_ARCH=riscv
     TARGET_ABI_DIR=riscv
     mttcg=yes
-    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
+    gdb_xml_files="riscv-64bit-cpu.xml riscv-32bit-fpu.xml riscv-64bit-fpu.xml riscv-64bit-vector-128b.xml riscv-64bit-vector-256b.xml riscv-64bit-vector-512b.xml riscv-64bit-csr.xml riscv-64bit-virtual.xml"
   ;;
   rx)
     TARGET_ARCH=rx
diff --git a/gdb-xml/riscv-64bit-csr.xml b/gdb-xml/riscv-64bit-csr.xml
index 9039456293..28a7c9a9f3 100644
--- a/gdb-xml/riscv-64bit-csr.xml
+++ b/gdb-xml/riscv-64bit-csr.xml
@@ -248,4 +248,11 @@
   <reg name="mucounteren" bitsize="64"/>
   <reg name="mscounteren" bitsize="64"/>
   <reg name="mhcounteren" bitsize="64"/>
+  <reg name="vstart" bitsize="64"/>
+  <reg name="vxsat" bitsize="64"/>
+  <reg name="vxrm" bitsize="64"/>
+  <reg name="vcsr" bitsize="64"/>
+  <reg name="vl" bitsize="64"/>
+  <reg name="vtype" bitsize="64"/>
+  <reg name="vlenb" bitsize="64"/>
 </feature>
diff --git a/gdb-xml/riscv-64bit-vector-128b.xml b/gdb-xml/riscv-64bit-vector-128b.xml
new file mode 100644
index 0000000000..f6150968b3
--- /dev/null
+++ b/gdb-xml/riscv-64bit-vector-128b.xml
@@ -0,0 +1,59 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.vector">
+<vector id="bytes" type="uint8" count="16"/>
+<vector id="shorts" type="uint16" count="8"/>
+<vector id="words" type="uint32" count="4"/>
+<vector id="longs" type="uint64" count="2"/>
+<vector id="quads" type="uint128" count="1"/>
+  <union id="riscv_vector">
+    <field name="b" type="bytes"/>
+    <field name="s" type="shorts"/>
+    <field name="w" type="words"/>
+    <field name="l" type="longs"/>
+    <field name="q" type="quads"/>
+  </union>
+
+  <reg name="v0" bitsize="128" save-restore="no" type="riscv_vector" group="vector" regnum="69"/>
+  <reg name="v1" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v2" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v3" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v4" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v5" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v6" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v7" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v8" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v9" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v10" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v11" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v12" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v13" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v14" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v15" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v16" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v17" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v18" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v19" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v20" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v21" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v22" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v23" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v24" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v25" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v26" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v27" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v28" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v29" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v30" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v31" bitsize="128" save-restore="no" type="riscv_vector" group="vector"/>
+</feature>
diff --git a/gdb-xml/riscv-64bit-vector-256b.xml b/gdb-xml/riscv-64bit-vector-256b.xml
new file mode 100644
index 0000000000..6183846a35
--- /dev/null
+++ b/gdb-xml/riscv-64bit-vector-256b.xml
@@ -0,0 +1,59 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.vector">
+<vector id="bytes" type="uint8" count="32"/>
+<vector id="shorts" type="uint16" count="16"/>
+<vector id="words" type="uint32" count="8"/>
+<vector id="longs" type="uint64" count="4"/>
+<vector id="quads" type="uint128" count="2"/>
+  <union id="riscv_vector">
+    <field name="b" type="bytes"/>
+    <field name="s" type="shorts"/>
+    <field name="w" type="words"/>
+    <field name="l" type="longs"/>
+    <field name="q" type="quads"/>
+  </union>
+
+  <reg name="v0" bitsize="256" save-restore="no" type="riscv_vector" group="vector" regnum="69"/>
+  <reg name="v1" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v2" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v3" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v4" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v5" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v6" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v7" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v8" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v9" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v10" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v11" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v12" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v13" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v14" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v15" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v16" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v17" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v18" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v19" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v20" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v21" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v22" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v23" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v24" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v25" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v26" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v27" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v28" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v29" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v30" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v31" bitsize="256" save-restore="no" type="riscv_vector" group="vector"/>
+</feature>
diff --git a/gdb-xml/riscv-64bit-vector-512b.xml b/gdb-xml/riscv-64bit-vector-512b.xml
new file mode 100644
index 0000000000..78bb147cdf
--- /dev/null
+++ b/gdb-xml/riscv-64bit-vector-512b.xml
@@ -0,0 +1,59 @@
+<?xml version="1.0"?>
+<!-- Copyright (C) 2018-2019 Free Software Foundation, Inc.
+
+     Copying and distribution of this file, with or without modification,
+     are permitted in any medium without royalty provided the copyright
+     notice and this notice are preserved.  -->
+
+<!-- Register numbers are hard-coded in order to maintain backward
+     compatibility with older versions of tools that didn't use xml
+     register descriptions.  -->
+
+<!DOCTYPE feature SYSTEM "gdb-target.dtd">
+<feature name="org.gnu.gdb.riscv.vector">
+<vector id="bytes" type="uint8" count="64"/>
+<vector id="shorts" type="uint16" count="32"/>
+<vector id="words" type="uint32" count="16"/>
+<vector id="longs" type="uint64" count="8"/>
+<vector id="quads" type="uint128" count="4"/>
+  <union id="riscv_vector">
+    <field name="b" type="bytes"/>
+    <field name="s" type="shorts"/>
+    <field name="w" type="words"/>
+    <field name="l" type="longs"/>
+    <field name="q" type="quads"/>
+  </union>
+
+  <reg name="v0" bitsize="512" save-restore="no" type="riscv_vector" group="vector" regnum="69"/>
+  <reg name="v1" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v2" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v3" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v4" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v5" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v6" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v7" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v8" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v9" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v10" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v11" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v12" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v13" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v14" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v15" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v16" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v17" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v18" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v19" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v20" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v21" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v22" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v23" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v24" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v25" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v26" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v27" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v28" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v29" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v30" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+  <reg name="v31" bitsize="512" save-restore="no" type="riscv_vector" group="vector"/>
+</feature>
diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
index f7c5212e27..1681f883e4 100644
--- a/target/riscv/gdbstub.c
+++ b/target/riscv/gdbstub.c
@@ -268,6 +268,13 @@ static int csr_register_map[] = {
     CSR_MUCOUNTEREN,
     CSR_MSCOUNTEREN,
     CSR_MHCOUNTEREN,
+    CSR_VSTART,
+    CSR_VXSAT,
+    CSR_VXRM,
+    CSR_VCSR,
+    CSR_VL,
+    CSR_VTYPE,
+    CSR_VLENB,
 };
 
 int riscv_cpu_gdb_read_register(CPUState *cs, GByteArray *mem_buf, int n)
@@ -351,6 +358,34 @@ static int riscv_gdb_set_fpu(CPURISCVState *env, uint8_t *mem_buf, int n)
     return 0;
 }
 
+static int riscv_gdb_get_vector(CPURISCVState *env, GByteArray *buf, int n)
+{
+    uint16_t vlenb = env_archcpu(env)->cfg.vlen >> 3;
+    if (n < 32) {
+        int i;
+        int cnt = 0;
+        for (i = 0; i < vlenb; i += 8) {
+            cnt += gdb_get_reg64(buf,
+                                 env->vreg[(n * vlenb + i) / 8]);
+        }
+        return cnt;
+    }
+    return 0;
+}
+
+static int riscv_gdb_set_vector(CPURISCVState *env, uint8_t *mem_buf, int n)
+{
+    uint16_t vlenb = env_archcpu(env)->cfg.vlen >> 3;
+    if (n < 32) {
+        int i;
+        for (i = 0; i < vlenb; i += 8) {
+            env->vreg[(n * vlenb + i) / 8] = ldq_p(mem_buf + i);
+        }
+        return vlenb;
+    }
+    return 0;
+}
+
 static int riscv_gdb_get_csr(CPURISCVState *env, GByteArray *buf, int n)
 {
     if (n < ARRAY_SIZE(csr_register_map)) {
@@ -416,15 +451,38 @@ void riscv_cpu_register_gdb_regs_for_features(CPUState *cs)
         gdb_register_coprocessor(cs, riscv_gdb_get_fpu, riscv_gdb_set_fpu,
                                  36, "riscv-32bit-fpu.xml", 0);
     }
+    if (env->misa & RVV) {
+        /* TODO: support vlen other than 128, 256, 512 bits. */
+        const char *vector_xml_name = NULL;
+        switch (cpu->cfg.vlen) {
+        case 128:
+            vector_xml_name = "riscv-64bit-vector-128b.xml";
+            break;
+        case 256:
+            vector_xml_name = "riscv-64bit-vector-256b.xml";
+            break;
+        case 512:
+            vector_xml_name = "riscv-64bit-vector-512b.xml";
+            break;
+        default:
+            vector_xml_name = NULL;
+            break;
+        }
+        if (vector_xml_name) {
+            gdb_register_coprocessor(cs, riscv_gdb_get_vector,
+                                     riscv_gdb_set_vector,
+                                     32, vector_xml_name, 0);
+        }
+    }
 #if defined(TARGET_RISCV32)
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             241, "riscv-32bit-csr.xml", 0);
+                             248, "riscv-32bit-csr.xml", 0);
 
     gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
                              1, "riscv-32bit-virtual.xml", 0);
 #elif defined(TARGET_RISCV64)
     gdb_register_coprocessor(cs, riscv_gdb_get_csr, riscv_gdb_set_csr,
-                             241, "riscv-64bit-csr.xml", 0);
+                             248, "riscv-64bit-csr.xml", 0);
 
     gdb_register_coprocessor(cs, riscv_gdb_get_virtual, riscv_gdb_set_virtual,
                              1, "riscv-64bit-virtual.xml", 0);
-- 
2.17.1


