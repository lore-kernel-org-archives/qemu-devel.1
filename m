Return-Path: <SRS0=TjK1=SW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C9FC282DD
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:39:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 856B1208C0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2019 07:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0NxmqD6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856B1208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38107 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHkbD-0003qw-P4
	for qemu-devel@archiver.kernel.org; Sat, 20 Apr 2019 03:39:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWa-0008Sh-W4
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hHkWa-0007tf-00
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:35:00 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hHkWZ-0007tJ-Qa
	for qemu-devel@nongnu.org; Sat, 20 Apr 2019 03:34:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id g8so3601647pgf.2
	for <qemu-devel@nongnu.org>; Sat, 20 Apr 2019 00:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=from:to:cc:subject:date:message-id:in-reply-to:references;
	bh=ZZYr6QJr2rUipHfB54gIFVWp7UFMrAAprd2zd5BHTXI=;
	b=Z0NxmqD6VG5KXqTJ8B5iyjXs4h3dlY11z9YNVik5iJZ8vdHY0SOnePGvoqRFdcdSCs
	p5IFzWFmitcm6K1mmCLPQ81Ol0vTOkAkadVydY//pt26mlGOMfjo2lljEZsDn8duYQ05
	tPq532T8STQLuzLPsXiHRw4nG6VgysGJvQ3lHIPx88Ww3guEjH64LcqeOfEaNWt7G2nG
	nSZVqB6bsE9MMjFqojZ/NVi1BXZhKBzopbzAx3ZyonWGmbEjgvqg9xLA4aSHXBumlBQQ
	rFv4AF4XTwwbutRIAnweKxDS6RFRWiCBgc+BTOch0jQkzbbmyQiwz6r+8c+vd3owZ+ul
	fO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references;
	bh=ZZYr6QJr2rUipHfB54gIFVWp7UFMrAAprd2zd5BHTXI=;
	b=i+t2KDvRVulOutwlzDawxafBlzKr7GQv3ZJj0GNcJm2qTTyr4a7JzTCvN2psBZ/tub
	FN629pd9tsr3i4pmmOAEjmzHkWFmyle82/9CsX2bcHUnT6/hhzCZJBgI1IF8D9pr5532
	8vooS+0KOZTky5jdNX1UWzyQN+Dty3E5cluHH+VVH6fj+FSiqnsAg98iICGHGeBG1wmY
	83d538nkgYeeLZi3FUqbXCa0PpIRPMuJCEO18WqSs86tdm6VvdrISqxPc1443DBEvsnf
	znAgi0/RUDXfv+GarXBPzJ5IKW6JKT2b0cLMLNkQMyD8sLvJjP7d9JEAh621fPvbc9jc
	tXPQ==
X-Gm-Message-State: APjAAAWvdqBUCblr4Co3phmCLbYZOoWgKf2MzOL+rO7tKliaSFuYNkBG
	BvIp/BcUXiOFcdUu3tOGYKPt/EvwpxQ=
X-Google-Smtp-Source: APXvYqyxojhLTh24tODFIZ2D9N5t8fDQxKO38/MWMHWfdiKY/feucXVKjeDxRiBPwlrjmH0QRJ3i7Q==
X-Received: by 2002:a62:1b8a:: with SMTP id b132mr8381430pfb.19.1555745698634; 
	Sat, 20 Apr 2019 00:34:58 -0700 (PDT)
Received: from localhost.localdomain (rrcs-66-91-136-155.west.biz.rr.com.
	[66.91.136.155]) by smtp.gmail.com with ESMTPSA id
	z22sm7025492pgv.23.2019.04.20.00.34.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 20 Apr 2019 00:34:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 19 Apr 2019 21:34:12 -1000
Message-Id: <20190420073442.7488-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190420073442.7488-1-richard.henderson@linaro.org>
References: <20190420073442.7488-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::544
Subject: [Qemu-devel] [PATCH 08/38] tcg: Add tcg_out_dupm_vec to the backend
 interface
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190420073412.iB3MGULOBOfc6tGh25lWj4iKC4zSD8IK2DpgLj1TpX4@z>

Currently stubbed out in all backends that support vectors.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target.inc.c |  6 ++++++
 tcg/i386/tcg-target.inc.c    |  7 +++++++
 tcg/tcg.c                    | 19 ++++++++++++++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index b272822969..3f95930e88 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -822,6 +822,12 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg r, TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
 static void tcg_out_movi(TCGContext *s, TCGType type, TCGReg rd,
                          tcg_target_long value)
 {
diff --git a/tcg/i386/tcg-target.inc.c b/tcg/i386/tcg-target.inc.c
index 49691c4f56..0be7d8f589 100644
--- a/tcg/i386/tcg-target.inc.c
+++ b/tcg/i386/tcg-target.inc.c
@@ -891,6 +891,13 @@ static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
     return true;
 }
 
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg r, TCGReg base, intptr_t offset)
+{
+    return false;
+}
+
+
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg ret, tcg_target_long arg)
 {
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 55498b63d7..1c34c08791 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -110,6 +110,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, const TCGArg *args,
 #if TCG_TARGET_MAYBE_vec
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                             TCGReg dst, TCGReg src);
+static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                             TCGReg dst, TCGReg base, intptr_t offset);
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                              TCGReg dst, tcg_target_long arg);
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc, unsigned vecl,
@@ -121,6 +123,11 @@ static inline bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
 {
     g_assert_not_reached();
 }
+static inline bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
+                                    TCGReg dst, TCGReg base, intptr_t offset)
+{
+    g_assert_not_reached();
+}
 static inline void tcg_out_dupi_vec(TCGContext *s, TCGType type,
                                     TCGReg dst, tcg_target_long arg)
 {
@@ -3416,6 +3423,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
     TCGRegSet dup_out_regs, dup_in_regs;
     TCGTemp *its, *ots;
     TCGType itype, vtype;
+    intptr_t endian_fixup;
     unsigned vece;
     bool ok;
 
@@ -3485,7 +3493,16 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
         /* fall through */
 
     case TEMP_VAL_MEM:
-        /* TODO: dup from memory */
+#ifdef HOST_WORDS_BIGENDIAN
+        endian_fixup = itype == TCG_TYPE_I32 ? 4 : 8;
+        endian_fixup -= 1 << vece;
+#else
+        endian_fixup = 0;
+#endif
+        if (tcg_out_dupm_vec(s, vtype, vece, ots->reg, its->mem_base->reg,
+                             its->mem_offset + endian_fixup)) {
+            goto done;
+        }
         tcg_out_ld(s, itype, ots->reg, its->mem_base->reg, its->mem_offset);
         break;
 
-- 
2.17.1


