Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1257BECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3AD120815
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 13:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n1crnLFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3AD120815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFINt-0001Ju-O0
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 09:40:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58099)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKV-00069A-Bb
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iFIKU-0001ij-0D
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:39 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:45662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iFIKT-0001hv-Q8
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 09:36:37 -0400
Received: by mail-wr1-x442.google.com with SMTP id r5so15528736wrm.12
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=XQJk1DHPtMxR5rn6iJkZ4+R9JTJIU95kBBNqy6kS5R0=;
 b=n1crnLFrnWMAFmXM2fvPkmuxHnEPVHkESQ7/Bj1t1Q6iM9SzCHQQ+OP82UYtbcGz3C
 RjugMKKrkxZJlez+WShpU2sM8BC8qoDJw08cwY0S0gFyYbH0wbl0I7g/o5wsk7adjR8P
 eguHOU361aa1FJhmNkZOczQnkfhebb3eJzRjf8kiomgnzFiH130uDqQsQjclR/0sA7P3
 mO3orDyLiOxrCsiw1MQuwFDw33DtQh1UyRwaQhvaS+cDjrioeNOOs8yrse282rvOYwtD
 yIHjbG7ODvLysBxkfEGbWJU9HItY0OxMzHxvOrUUzwebhv8N9vpZ0RUm/MhSNKLPI6/n
 XP0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=XQJk1DHPtMxR5rn6iJkZ4+R9JTJIU95kBBNqy6kS5R0=;
 b=RZjWD8cixsHxghrUqf4JdJ3vpoLLPGX1knzkW6jYavYO1RnrH6z8/D99bxoP8SzQVU
 QqhisbfrGWpfj4BKiTi3UngkXlnqUNaFWZz9dJz0J5V6GUCoTbZmKJZWD2mVFg+3Lh8M
 7g8acMP8noiC2CXpboBCu7cdy189xDhHDlgMP7rg3zWp8Uh8UYpDq/GSszhlj3PeH498
 t/Gm9olVdOfSiu3ux8qfBxr+kXz3heP0tZAUHGY8PoocvVFlnjhs8O/3To5b6rgNTX9h
 NmhSxjItvvgkRPSkA/LlXo45CbredHM5Ai1chSRrej2/koqWLpP19ZwUDxeNaBkfY2Dp
 +1nw==
X-Gm-Message-State: APjAAAVQ+VyMhWuHlC3CswrEXOeLxtBZfDim+tPhS0hlYsMUzQu2fSru
 N5XvutsiEYIZY7BwRWjsZqVl+JFT
X-Google-Smtp-Source: APXvYqz8QwYaoriERgu8f+91qPdv085nQaa5oBF2PsiDoIinpGUS7jIDODgtJq3FkFdKvLRmXymuyA==
X-Received: by 2002:adf:9d84:: with SMTP id p4mr17432697wre.39.1569936996448; 
 Tue, 01 Oct 2019 06:36:36 -0700 (PDT)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id q192sm4424575wme.23.2019.10.01.06.36.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 06:36:35 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] cris: do not leak struct cris_disasm_data
Date: Tue,  1 Oct 2019 15:36:26 +0200
Message-Id: <1569936988-635-7-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
References: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Use a stack-allocated struct to avoid a memory leak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 disas/cris.c | 59 +++++++++++++++++++++++++++++------------------------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/disas/cris.c b/disas/cris.c
index 2f43c9b..0b0a3fb 100644
--- a/disas/cris.c
+++ b/disas/cris.c
@@ -1294,24 +1294,17 @@ static int cris_constraint
 /* Parse disassembler options and store state in info.  FIXME: For the
    time being, we abuse static variables.  */
 
-static bfd_boolean
-cris_parse_disassembler_options (disassemble_info *info,
+static void
+cris_parse_disassembler_options (struct cris_disasm_data *disdata,
+				 char *disassembler_options,
 				 enum cris_disass_family distype)
 {
-  struct cris_disasm_data *disdata;
-
-  info->private_data = calloc (1, sizeof (struct cris_disasm_data));
-  disdata = (struct cris_disasm_data *) info->private_data;
-  if (disdata == NULL)
-    return false;
-
   /* Default true.  */
   disdata->trace_case
-    = (info->disassembler_options == NULL
-       || (strcmp (info->disassembler_options, "nocase") != 0));
+    = (disassembler_options == NULL
+       || (strcmp (disassembler_options, "nocase") != 0));
 
   disdata->distype = distype;
-  return true;
 }
 
 static const struct cris_spec_reg *
@@ -2736,9 +2729,10 @@ static int
 print_insn_cris_with_register_prefix (bfd_vma vma,
 				      disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v0_v10))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, true);
 }
 /* Disassemble, prefixing register names with `$'.  CRIS v32.  */
@@ -2747,9 +2741,10 @@ static int
 print_insn_crisv32_with_register_prefix (bfd_vma vma,
 					 disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2761,9 +2756,10 @@ static int
 print_insn_crisv10_v32_with_register_prefix (bfd_vma vma,
 					     disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_common_v10_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, true);
 }
 
@@ -2773,9 +2769,10 @@ static int
 print_insn_cris_without_register_prefix (bfd_vma vma,
 					 disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v0_v10))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v0_v10);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2785,9 +2782,10 @@ static int
 print_insn_crisv32_without_register_prefix (bfd_vma vma,
 					    disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 
@@ -2798,9 +2796,10 @@ static int
 print_insn_crisv10_v32_without_register_prefix (bfd_vma vma,
 						disassemble_info *info)
 {
-  if (info->private_data == NULL
-      && !cris_parse_disassembler_options (info, cris_dis_common_v10_v32))
-    return -1;
+  struct cris_disasm_data disdata;
+  info->private_data = &disdata;
+  cris_parse_disassembler_options (&disdata, info->disassembler_options,
+				   cris_dis_common_v10_v32);
   return print_insn_cris_generic (vma, info, false);
 }
 #endif
-- 
1.8.3.1



