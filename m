Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86A7C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7979A22BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zLSxyn2l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7979A22BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5DtY-00039p-Jd
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Doq-0000sO-8V
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:52 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:52422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5Don-0004tG-VB
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:51 -0400
Received: by mail-wm1-x32c.google.com with SMTP id x5so606191wmi.2
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=cp52Tz1lECqYI3uEVQbbG4Lu/4PnK1R1by9RglA8G/g=;
 b=zLSxyn2lgqXet73mPvGJK+Yi84f3FsWZcQSRGfjvGHe8BNBMvyp/cOf96+pIyUk2sB
 DIXItBkcyIFGZ50H24jTGL+P8uumiNnIvXYlz1/0xbIQpCnsEXIaXcZRRfjq8ri1u0v9
 0OSra/3UyNq1gmJm6XrtoFcIbv8Grzjf9u3d7u9NolIY3mk/EsyxG5p1yLDeUu21jUw9
 wlOhok6emZubW5p5Q7WfHji9YY0+w/4ZmOafuzfrc9byfwc672k5jIUv0z1m1H58Yp+4
 s4b6b9uglprNjJJ2yul4a8phM130aksvHn9rsP3pOurLn+gL48haNU6jUUGPtlsjl9oA
 1F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cp52Tz1lECqYI3uEVQbbG4Lu/4PnK1R1by9RglA8G/g=;
 b=UdWp4VG81sn44rVX3q0P9GG6seOGrqeClYOG6tTnvJyz+9woareFkWsi1dc0sSIbMS
 WGqIyNN7BGdz4Iz3o68DCrfrneS99zKdvovy55pqbpY+ftEw0059MM4sXyIv2YBkmHKR
 0PQY2cNY9CCnHizJWDXsO1pJzJFnZfYDLyH4bGMDEw1NgYbiSoL8W36S9ipxMFlfH3Xn
 xrmlkZ5CC0iCuT2V45hiP2xeQdYHqkSNYUgkk7HPpmGbNI/Y1UDg/MlxOyt/AsRB9FHG
 IA1L88QzK4PEqnABuPCbV7cJQYhIDdkXXh7qeibtjd8WbZKDJoLxGfLlOXp4pc9D1wIt
 MvRA==
X-Gm-Message-State: AOAM532NzMiiVDCyM49ltODO5NVWoWPFIsgUSBHs8FQ7GtsGP0xiZeuw
 8JdD984k4JXPvspbLUp9OLGgdIMXjjs+1g==
X-Google-Smtp-Source: ABdhPJxlDBFgmzwgzRHu1GHLAFG2KcqjaPdVn2Gu4K6ndq8gNfiUAZ3oVtljK4Q9UUmDknIKb1C4IA==
X-Received: by 2002:a05:600c:2888:: with SMTP id
 g8mr802278wmd.118.1597089047684; 
 Mon, 10 Aug 2020 12:50:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/20] docs/devel/qapi-code-gen.txt: Update to new rST
 backend conventions
Date: Mon, 10 Aug 2020 20:50:14 +0100
Message-Id: <20200810195019.25427-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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
Cc: Markus Armbruster <armbru@redhat.com>
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
 * headings and subheadings must now be in a freeform
   documentation comment of their own
 * we support arbitrary levels of sub- and sub-sub-heading, not
   just a main and sub-heading like the old texinfo generator

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/devel/qapi-code-gen.txt | 90 ++++++++++++++++++++++++------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index 69eede6c283..263f1c0b44c 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -824,21 +824,39 @@ See below for more on definition documentation.
 Free-form documentation may be used to provide additional text and
 structuring content.
 
+==== Headings and subheadings ====
+
+A free-form documentation comment containing a single line
+which starts with some '=' symbols and then a space defines
+a section heading:
+
+    ##
+    # = This is a top level heading
+    ##
+
+    ##
+    # This is a free-form comment which will go under the
+    # top level heading.
+    ##
+
+    ##
+    # == This is a second level heading
+    ##
+
+Section headings must always be correctly nested, so you can only
+define a third-level heading inside a second-level heading, and so
+on. The documentation generator will catch nesting mistakes and report
+a syntax error.
 
 ==== Documentation markup ====
 
-Comment text starting with '=' is a section title:
+Documentation comments can use most rST markup. In particular,
+a '::' literal block can be used for examples:
 
-    # = Section title
-
-Double the '=' for a subsection title:
-
-    # == Subsection title
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
 
@@ -854,37 +872,35 @@ A decimal number followed by '.' starts a numbered list:
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
+be used. If you need a single literal '*' you will need to backslash-escape it.
+As an extension beyond the usual rST syntax, you can also
+use '@foo' to reference a name in the schema; this is rendered
+the same way as '``foo``'.
 
 Example:
 
 ##
-# = Section
-# == Subsection
-#
-# Some text foo with *strong* and _emphasis_
+# Some text foo with **bol** and *emphasis*
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
 
-
 ==== Definition documentation ====
 
 Definition documentation, if present, must immediately precede the
@@ -899,6 +915,12 @@ commands and events), member (for structs and unions), branch (for
 alternates), or value (for enums), and finally optional tagged
 sections.
 
+Descriptions of arguments can span multiple lines; if they
+do then the second and subsequent lines must be indented
+to line up with the first character of the first line of the
+description. The parser will report a syntax error if there
+is insufficient indentation.
+
 FIXME: the parser accepts these things in almost any order.
 FIXME: union branches should be described, too.
 
@@ -912,6 +934,16 @@ The section ends with the start of a new section.
 A 'Since: x.y.z' tagged section lists the release that introduced the
 definition.
 
+The text of a section can start on a new line, in
+which case it must not be indented at all. It can also start
+on the same line as the 'Note:', 'Returns:', etc tag. In this
+case if it spans multiple lines then second and subsequent
+lines must be indented to match the first.
+
+An 'Example' or 'Examples' section is automatically rendered
+entirely as literal fixed-width text. In other sections,
+the text is formatted, and rST markup can be used.
+
 For example:
 
 ##
-- 
2.20.1


