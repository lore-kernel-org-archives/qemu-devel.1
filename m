Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF366C4727D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C24920756
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i5/J1hb3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C24920756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55892 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLqlL-0001K1-Jb
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 12:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVd-0006oD-TX
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:47 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLqVZ-0006qL-Mh
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 12:23:44 -0400
Received: by mail-wr1-x441.google.com with SMTP id k10so1105378wru.6
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 09:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cfp9eJVJmCGyE7NM1DFsFZRmLQWVMNY4XbJuSqV3KAI=;
 b=i5/J1hb3qHNo/FQGX4QOAymq0Lmk0Cy8GpAovH+YRToo/MLhu00S+5gsIZ0G3qX47a
 hMCmIzl7X5ezXCoEOkcFi4VdZTlBjRMZK4/Q0M0A+g0Kf9cn6swUZtDBFEzT9FpCR8V3
 YOOowViK43UOpJFYqI+Eqk0A4GxFFwsPBJ1TXdXd4rhueMtWpPEEKTNffGxO1i/SbfDz
 1p8uKYkrVaZX7/TdFHtshWK736rvduP3kkCp+diq/e92IO8bNe2RMayw/LS/Wg0icL21
 k9V6SQN1L54amdGyoHJJB/t5FnZb3Kd9v9cP79BKw1cXyelNqJqzl4hG9sJ7QH8bHBuX
 Q7Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cfp9eJVJmCGyE7NM1DFsFZRmLQWVMNY4XbJuSqV3KAI=;
 b=gkvhbqU01TrpXdPb1WwOgSKuFB1qyEjGU5EEMGHaMvMYy+NB/cSt1RVGOfkjXmp4JD
 YclqN/iQALkb76KD+sH4VfklKVwiGFDKxVgbWS0sv4pHbeqR3ePFIWpGnpso6wsmo3me
 GCjEZUb8nFwWfLRPGhatTjxtusrHq/fFv/5qYEbioxnjSD7m9Pm04cxFRJYR5xoAKxSX
 AwDtivwFRmr0xOnRxYKEKc+s8AMTdO7XV4/NTxTkeGpa/DlWAB7CzsKkR1BRAWxkY9ko
 08THXfw1agLvVRIH0lgrO37O31o1wH3TvbzytaEfyc63WNnWY05zxb8cCZ8vM6L5ogKJ
 0mkw==
X-Gm-Message-State: AOAM530VvFTqsPcrJJtgNw2HrZjnoh3wY6XKTGv1uOkQAKA7syf1ZGA1
 TBSrZ8HEZgsUcSIXKc1/tXW49gCHsNP2926s
X-Google-Smtp-Source: ABdhPJyHcFlllSzNOHzuzD6DukzWgMn1ZwLoN84O1LiXSHYhPc+Hs3UPFH3H1pYFA0kzx8IIyYLLrg==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr4885771wrs.388.1601051019185; 
 Fri, 25 Sep 2020 09:23:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d6sm3565824wrq.67.2020.09.25.09.23.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 09:23:38 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 17/21] docs/devel/qapi-code-gen.txt: Update to new rST
 backend conventions
Date: Fri, 25 Sep 2020 17:23:12 +0100
Message-Id: <20200925162316.21205-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925162316.21205-1-peter.maydell@linaro.org>
References: <20200925162316.21205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Update the documentation of QAPI document comment syntax to match
the new rST backend requirements. The principal changes are:
 * whitespace is now significant, and multiline definitions
   must have their second and subsequent lines indented to
   match the first line
 * general rST format markup is permitted, not just the small
   set of markup the old texinfo generator handled. For most
   things (notably bulleted and itemized lists) the old format
   is the same as rST was.
 * Specific things that might trip people up:
   - instead of *bold* and _italic_ rST has **bold** and *italic*
   - lists need a preceding and following blank line
   - a lone literal '*' will need to be backslash-escaped to
     avoid a rST syntax error
 * the old leading '|' for example (literal text) blocks is
   replaced by the standard rST '::' literal block.
 * we support arbitrary levels of sub- and sub-sub-heading, not
   just a main and sub-heading like the old texinfo generator

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/qapi-code-gen.txt | 83 +++++++++++++++++++++++-------------
 1 file changed, 53 insertions(+), 30 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 69eaffac376..7d2479dde82 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -824,23 +824,37 @@ See below for more on definition documentation.
 Free-form documentation may be used to provide additional text and
 structuring content.
 
+==== Headings and subheadings ====
+
+A free-form documentation comment containing a line which starts with
+some '=' symbols and then a space defines a section heading:
+
+    ##
+    # = This is a top level heading
+    #
+    # This is a free-form comment which will go under the
+    # top level heading.
+    ##
+
+    ##
+    # == This is a second level heading
+    ##
+
+A heading line must be the first line of the documentation
+comment block.
+
+Section headings must always be correctly nested, so you can only
+define a third-level heading inside a second-level heading, and so on.
 
 ==== Documentation markup ====
 
-Comment text starting with '=' is a section title:
+Documentation comments can use most rST markup.  In particular,
+a '::' literal block can be used for examples:
 
-    # = Section title
-
-Double the '=' for a subsection title:
-
-    # == Subsection title
-
-Both are only permitted in free-form documentation.
-
-'|' denotes examples:
-
-    # | Text of the example, may span
-    # | multiple lines
+    # ::
+    #
+    #   Text of the example, may span
+    #   multiple lines
 
 '*' starts an itemized list:
 
@@ -856,34 +870,33 @@ A decimal number followed by '.' starts a numbered list:
     #    multiple lines
     # 2. Second item
 
-The actual number doesn't matter.  You could even use '*' instead of
-'2.' for the second item.
+The actual number doesn't matter.
 
-Lists can't be nested.  Blank lines are currently not supported within
-lists.
+Lists of either kind must be preceded and followed by a blank line.
+If a list item's text spans multiple lines, then the second and
+subsequent lines must be correctly indented to line up with the
+first character of the first line.
 
-Additional whitespace between the initial '#' and the comment text is
-permitted.
-
-*foo* and _foo_ are for strong and emphasis styles respectively (they
-do not work over multiple lines).  @foo is used to reference a name in
-the schema.
+The usual '**strong**', '*emphasised*' and '``literal``' markup should
+be used.  If you need a single literal '*' you will need to
+backslash-escape it.  As an extension beyond the usual rST syntax, you
+can also use '@foo' to reference a name in the schema; this is
+rendered the same way as '``foo``'.
 
 Example:
 
 ##
-# = Section
-# == Subsection
-#
-# Some text foo with *strong* and _emphasis_
+# Some text foo with **bold** and *emphasis*
 # 1. with a list
 # 2. like that
 #
 # And some code:
-# | $ echo foo
-# | -> do this
-# | <- get that
 #
+# ::
+#
+#   $ echo foo
+#   -> do this
+#   <- get that
 ##
 
 
@@ -937,6 +950,16 @@ multiline argument descriptions.
 A 'Since: x.y.z' tagged section lists the release that introduced the
 definition.
 
+The text of a section can start on a new line, in
+which case it must not be indented at all.  It can also start
+on the same line as the 'Note:', 'Returns:', etc tag.  In this
+case if it spans multiple lines then second and subsequent
+lines must be indented to match the first.
+
+An 'Example' or 'Examples' section is automatically rendered
+entirely as literal fixed-width text.  In other sections,
+the text is formatted, and rST markup can be used.
+
 For example:
 
 ##
-- 
2.20.1


