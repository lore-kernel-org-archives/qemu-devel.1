Return-Path: <SRS0=QAbx=Z6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A197C43603
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:17:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 680CF20663
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Dec 2019 19:17:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCGb/AsY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 680CF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie23s-0001Mc-DF
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 14:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37646)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tz-0002Mo-Dw
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003Lx-Tz
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:39 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35781)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>) id 1ie1Tw-0003Fz-KW
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 13:40:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id g17so13563589wro.2
 for <qemu-devel@nongnu.org>; Sun, 08 Dec 2019 10:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lmKu0nadoIAF5aXT323Ji4zM6wR9fpqsiNsQ/AlTLlc=;
 b=LCGb/AsYtFVxv8VqGctG3MUWhfA4aGwKMPXV+GKybpf5Sz3jEPpZVoveK7aWiw8+F5
 LQBzSd6uwYsLydYhmYvUrb5sWAKYjbNj91M5O30Liqzk0dPgP1GB2Zl2iuu7/QD0MWMV
 nGznMQ1Z/IxOsqeZopGn+l91oparx4kgAHwTEsSBNx7B57ZsqH/ksyD9FDTedqLz5oMT
 vGjm/kX4VegKM1MGst8ju98hrkfwIqCogiBx4TeKpMIUZ5cL9GEciojal1Y4ywN8bbUa
 b2wrVeeD+CQrkEBt31OjAsHgKLy0KDxHOCTN1jDr9+rrrVhVQNzXtCCbXD77rWIfXO33
 j9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lmKu0nadoIAF5aXT323Ji4zM6wR9fpqsiNsQ/AlTLlc=;
 b=DS/nkVIDMtIYB0+MWqKvHQio0DVGx3v+pk2oQvV9rxAT2OBe5c4X+PVRQ9tIkoA7C4
 0c/eZRgYNsVq7mkJnk7xqS2Urwy2WKesnZzgkNcNCCJk41lGJyN5Mw47FMjr3vtBOgJW
 9AFcqN2LOtWLJsNbh1GU6a314sLJXb96EPjeZGQj4Q+aUNpWpptWBJK3WXuoa+G+qKNT
 nobzJ9FzJOdwsXb9PHM+5WHu88PJha8tei/9fYNuGngku/t2V8DimUMZkZmNEiVrzN/T
 0APthp1TxzCxXv3oYYUX0ot5HQAD8SYh+gaOexleMYcQEDWEDVaae4fplkPLxuz5nr85
 3x1g==
X-Gm-Message-State: APjAAAXe4/XonWtxdGqepHo70EZPaVGrI8lLY4wuB5MpMVATc94OAdMR
 zASEY4l/Rx/tbkLyIwU47HL4SAcfkhZw7EUY
X-Google-Smtp-Source: APXvYqybR2ZBaXntQZUmha60QH5EOq+k1RXa8Xx8+h429h8gUEftFV9uwsfHZoSj1vQP8SnwPqC4sg==
X-Received: by 2002:a05:6000:12ce:: with SMTP id
 l14mr28560733wrx.342.1575830426882; 
 Sun, 08 Dec 2019 10:40:26 -0800 (PST)
Received: from 8c859074c0ff.ant.amazon.com.com
 (bzq-79-180-52-3.red.bezeqint.net. [79.180.52.3])
 by smtp.gmail.com with ESMTPSA id h17sm25289717wrs.18.2019.12.08.10.40.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 08 Dec 2019 10:40:26 -0800 (PST)
From: Michael Rolnik <mrolnik@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v38 19/22] target/avr: Update build system
Date: Sun,  8 Dec 2019 20:39:19 +0200
Message-Id: <20191208183922.13757-20-mrolnik@gmail.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
In-Reply-To: <20191208183922.13757-1-mrolnik@gmail.com>
References: <20191208183922.13757-1-mrolnik@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: thuth@redhat.com, Michael Rolnik <mrolnik@gmail.com>,
 me@xcancerberox.com.ar, richard.henderson@linaro.org, dovgaluk@ispras.ru,
 imammedo@redhat.com, philmd@redhat.com, aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Make AVR support buildable

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 configure                       |  7 +++++++
 default-configs/avr-softmmu.mak |  5 +++++
 target/avr/Makefile.objs        | 34 +++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 default-configs/avr-softmmu.mak
 create mode 100644 target/avr/Makefile.objs

diff --git a/configure b/configure
index 6099be1d84..e9dab313d5 100755
--- a/configure
+++ b/configure
@@ -7649,6 +7649,10 @@ case "$target_name" in
     mttcg="yes"
     gdb_xml_files="aarch64-core.xml aarch64-fpu.xml arm-core.xml arm-vfp.xml arm-vfp3.xml arm-neon.xml"
   ;;
+  avr)
+    gdb_xml_files="avr-cpu.xml"
+    target_compiler=$cross_cc_avr
+  ;;
   cris)
   ;;
   hppa)
@@ -7868,6 +7872,9 @@ for i in $ARCH $TARGET_BASE_ARCH ; do
       disas_config "ARM_A64"
     fi
   ;;
+  avr)
+    disas_config "AVR"
+  ;;
   cris)
     disas_config "CRIS"
   ;;
diff --git a/default-configs/avr-softmmu.mak b/default-configs/avr-softmmu.mak
new file mode 100644
index 0000000000..d1e1c28118
--- /dev/null
+++ b/default-configs/avr-softmmu.mak
@@ -0,0 +1,5 @@
+# Default configuration for avr-softmmu
+
+# Boards:
+#
+CONFIG_AVR_SAMPLE=y
diff --git a/target/avr/Makefile.objs b/target/avr/Makefile.objs
new file mode 100644
index 0000000000..7523e0c6e2
--- /dev/null
+++ b/target/avr/Makefile.objs
@@ -0,0 +1,34 @@
+#
+#  QEMU AVR CPU
+#
+#  Copyright (c) 2019 Michael Rolnik
+#
+#  This library is free software; you can redistribute it and/or
+#  modify it under the terms of the GNU Lesser General Public
+#  License as published by the Free Software Foundation; either
+#  version 2.1 of the License, or (at your option) any later version.
+#
+#  This library is distributed in the hope that it will be useful,
+#  but WITHOUT ANY WARRANTY; without even the implied warranty of
+#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+#  Lesser General Public License for more details.
+#
+#  You should have received a copy of the GNU Lesser General Public
+#  License along with this library; if not, see
+#  <http://www.gnu.org/licenses/lgpl-2.1.html>
+#
+
+DECODETREE = $(SRC_PATH)/scripts/decodetree.py
+decode-y = $(SRC_PATH)/target/avr/insn.decode
+
+target/avr/decode_insn.inc.c: $(decode-y) $(DECODETREE)
+	$(call quiet-command, \
+	  $(PYTHON) $(DECODETREE) -o $@ --decode decode_insn --insnwidth 16 $<, \
+	  "GEN", $(TARGET_DIR)$@)
+
+target/avr/translate.o: target/avr/decode_insn.inc.c
+
+obj-y += translate.o cpu.o helper.o
+obj-y += gdbstub.o
+obj-y += disas.o
+obj-$(CONFIG_SOFTMMU) += machine.o
-- 
2.17.2 (Apple Git-113)


