Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA195C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:36:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7521E2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV9lOaC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7521E2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYYn-0001W1-CE
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:36:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49176)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3E-0006SO-Pm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3D-0000zF-Iw
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:36 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:33882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3D-0000vL-AQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:03:35 -0500
Received: by mail-wr1-x42a.google.com with SMTP id t2so2029455wrr.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:03:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=L79BeMo6HCbokM7jk/FE+RUtQdWgo2iqz0AB4yqz6vk=;
 b=UV9lOaC5XmWEP5z0PqS0z0dx1KheABVCpwVFnzDTXvYdAwiXvA5rX14si+dl1DpazR
 6g2DzxJrzJ3VQtcuYJQ5l0P89MU8lUivf67txxNCZz743we/k315KVvc3oPdz5e0S9gB
 Y97n5e9cOQfRapWl+5geu8Yy/QSnhdoe/egvZHnCalLkUpE2khXpUoGqyZoMQsGzJck3
 THyy1teXcl2wSM4wUnokRl5IzqpFM7JMpk8ptfPl8MpOB0ljNRlH5Bh4JNqodAx2NMNM
 v1QLuTPPzX8PDLjzjentTip9qTBNMoXQtk/+P0B3kImp2SybhMPqgTK4OGz9C8Jj6Jxh
 aBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=L79BeMo6HCbokM7jk/FE+RUtQdWgo2iqz0AB4yqz6vk=;
 b=JAoG3A2Zav8dTzPLmsIjcHHbTcR6MtVrIhnRrDXfr4NMdpF1W3EIP6q5CUB1vuSQDm
 GTvH65jknPH9q3zcA4SUS7J5RGpnt+LuAL93ntMgdKbh6RuxCYeCIzjy8QGgT1CHBWJi
 Tr5rqESAtmNImkA+b/CmqbRfcSm2jyeUkeebqFbU404rkieW07lMoP8ySLsKz9rqB2s1
 LnPCRRq6tDe5RAlUjoUfGuY54stLd3FhPC+gp+O0CA7VNFrM+FhDrHukpD2R8Y9Dljos
 bhVFe6tYZXFGpb1zDzAo1CVuwxg4CzGrk5Mf9siSmuQ+zQUFg39N5jC1z5/tsCdQW4/t
 kd4A==
X-Gm-Message-State: APjAAAURNMpTVoQNPRO3o6ff1GCVsLdeOz4l6b5ry+FFS6WAokQSbrjY
 OaR2rCycQcc+E397KUG+BwizoyUC
X-Google-Smtp-Source: APXvYqwwEzEurWIm97zSIrJpEdZtBWNFRphdyJeuKJlhyeP0SapFX2dkvGYb0EOsXWqYDes2kb4DzQ==
X-Received: by 2002:adf:f605:: with SMTP id t5mr2405919wrp.282.1576670614055; 
 Wed, 18 Dec 2019 04:03:34 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.03.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:03:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 39/87] libvixl: remove per-target compiler flags
Date: Wed, 18 Dec 2019 13:02:05 +0100
Message-Id: <1576670573-48048-40-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
index 55d386c..0a63c75 100755
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
@@ -595,6 +595,7 @@ QEMU_CFLAGS="-Wall -Wundef -Wwrite-strings -Wmissing-prototypes $QEMU_CFLAGS"
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



