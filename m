Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0BCC43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:01:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C49F206D7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 17:01:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddCFy1xT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C49F206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igtkN-0002xg-2w
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 12:01:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFQ-0005Wg-Sv
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1igtFP-0008FW-MT
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:28 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:41941)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1igtFP-0008E9-G7
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 11:29:27 -0500
Received: by mail-wr1-x42c.google.com with SMTP id c9so8038595wrw.8
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 08:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=BGBt01mjWcpv3t8vsUW2U8xt8/YYqyeKISoIMxkLyoU=;
 b=ddCFy1xTxh6tEE+OIC2lkmB8CW9tWNxJmBLdv5BNg8/FhNPhI8sy6pmYPF+msuG5eT
 bULm277fHCU7KVJrQ8R/WQhwwkPoj9aehHWT6emqdkWSoFoPXElPZv0Cxpl1kezAYaWl
 OyI7jhV0UhU/26xQPxyVDLWL+skHlswuWL2LIj38C95RPGESXIFNBrwUQOzjEkVYNkOd
 Co2zVSyWOK8RrraknjtRi/eLQ9+jYU8FRQ1JBaDGPhf5C7RUZm5O7ajEMT8kPUncm83K
 74nIkd4CZGJFsqE3P0iIN4Lur+l1bwfPpUQI7/f2eE/wP5uzxbhOPr3IbkX7CkdTXe2w
 puBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=BGBt01mjWcpv3t8vsUW2U8xt8/YYqyeKISoIMxkLyoU=;
 b=nt71P3a8TP4S2UfWtfSGAh2gumX7V4vWFT/MQwPE9uXX+WYL2rqBKABVr5ODSwRnMR
 rqVG9y4WDno6683n9Y4Nep5KA3TQ4uglhdtFgCy4ZZIrBVv8JNJnT9CCOn2AlHoEva2L
 +CHGcYuEzbETNXKIooe7gXrNTe7x+UpP9wdyJRbDruwkTlSbl6X5RDAlZ/XbYJQy0R86
 +//CQ5YYSk2whjJyeufEkQ4/pLaGIUcwZvvUfBrP2enEtxcEWAMICyezvtFW98/VzkeW
 pNA4HqpW/6ySW4LkNbE/HHDBiIEMZz+Fa1V7mX9oR1x9oIUo+pzIRGca20fbFxqJNlR0
 UJug==
X-Gm-Message-State: APjAAAVUgVomwutKTv1XRsK06P6A71+BLaJXzxiWyHdEq8FCyAJHXfDM
 iIV7fXZre4uc0sUlJCRvXJZds0SG
X-Google-Smtp-Source: APXvYqz/SS/O9Qa8M7+h73+TxUpOZywcyKfzuUr28sFQVcgnqQKLhi4R+eyIikh/gjkWiYYZ/a3Lzw==
X-Received: by 2002:a5d:50cf:: with SMTP id f15mr31529530wrt.381.1576513766332; 
 Mon, 16 Dec 2019 08:29:26 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q68sm19962334wme.14.2019.12.16.08.29.25
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 16 Dec 2019 08:29:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/62] libvixl: remove per-target compiler flags
Date: Mon, 16 Dec 2019 17:28:23 +0100
Message-Id: <1576513726-53700-40-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
References: <1576513726-53700-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We are already including -D__STDC_LIMIT_MACROS in the global CXXFLAGS,
so it makes sense to do the same for -D__STDC_CONSTANT_MACROS and
-D__STDC_FORMAT_MACROS instead of limiting that to libvixl.

The -Wno-sign-compare option can also be removed since GCC 4.6 is not
supported anymore.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                   |  3 ++-
 disas/libvixl/Makefile.objs | 11 +----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/configure b/configure
index 8fb26ad..394f7f5 100755
--- a/configure
+++ b/configure
@@ -101,7 +101,7 @@ update_cxxflags() {
     # Set QEMU_CXXFLAGS from QEMU_CFLAGS by filtering out those
     # options which some versions of GCC's C++ compiler complain about
     # because they only make sense for C programs.
-    QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS"
+    QEMU_CXXFLAGS="$QEMU_CXXFLAGS -D__STDC_LIMIT_MACROS -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS"
 
     for arg in $QEMU_CFLAGS; do
         case $arg in
@@ -596,6 +596,7 @@ QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
 QEMU_CFLAGS="-Wstrict-prototypes -Wredundant-decls $QEMU_CFLAGS"
 QEMU_CFLAGS="-D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE $QEMU_CFLAGS"
 QEMU_INCLUDES="-iquote . -iquote \$(SRC_PATH) -iquote \$(SRC_PATH)/accel/tcg -iquote \$(SRC_PATH)/include"
+QEMU_INCLUDES="$QEMU_INCLUDES -iquote \$(SRC_PATH)/disas/libvixl"
 if test "$debug_info" = "yes"; then
     CFLAGS="-g $CFLAGS"
     LDFLAGS="-g $LDFLAGS"
diff --git a/disas/libvixl/Makefile.objs b/disas/libvixl/Makefile.objs
index 27183b7..99a637f 100644
--- a/disas/libvixl/Makefile.objs
+++ b/disas/libvixl/Makefile.objs
@@ -1,14 +1,5 @@
-libvixl_OBJS = vixl/utils.o \
+common-obj-$(CONFIG_ARM_A64_DIS) = vixl/utils.o \
                vixl/compiler-intrinsics.o \
                vixl/a64/instructions-a64.o \
                vixl/a64/decoder-a64.o \
                vixl/a64/disasm-a64.o
-
-# The -Wno-sign-compare is needed only for gcc 4.6, which complains about
-# some signed-unsigned equality comparisons which later gcc versions do not.
-$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CXXFLAGS := -I$(SRC_PATH)/disas/libvixl $(QEMU_CXXFLAGS) -Wno-sign-compare
-# Ensure that C99 macros are defined regardless of the inclusion order of
-# headers in vixl. This is required at least on NetBSD.
-$(addprefix $(obj)/,$(libvixl_OBJS)): QEMU_CXXFLAGS += -D__STDC_CONSTANT_MACROS -D__STDC_FORMAT_MACROS
-
-common-obj-$(CONFIG_ARM_A64_DIS) += $(libvixl_OBJS)
-- 
1.8.3.1



