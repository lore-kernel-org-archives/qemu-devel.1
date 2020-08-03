Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC73CC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B63A022C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 20:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d4nErp9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B63A022C9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2hXB-000466-Pe
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 16:58:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2hWE-0003e8-Rs
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:57:14 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40718)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2hWD-0006CE-34
 for qemu-devel@nongnu.org; Mon, 03 Aug 2020 16:57:14 -0400
Received: by mail-pf1-x442.google.com with SMTP id k18so11701796pfp.7
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2020 13:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MS6fe5pqK8dVuvq4lPUQ3McLZfkrtocF71lhmBH/Qg0=;
 b=d4nErp9rvwqHZu11W0s39YFnXMGgD8FeEM4HnQTKDnEFGTPoW563YfOH7Yueh6eNJj
 V298bPn4lct8IlxLlMbVvNZvdEFjrNT6gaJtP7L4mR54x3ls9oGMrSzdqAYWb62kZjt9
 uYF88myjPzD74RLo+hoI/Y2Z80/PPy10gay/Y2JgTmeguD44ow3Gp+bLYf3vdHhk4dTU
 5EzvyEUuHm640KVOS3jor4ZSZ/hyZK6m0RZcIB8N84jaGFNyBeGcvtDlYg828eo4jpsc
 mZYRkvEg8zwV5jDpmB7gZ7gWosZiCZw6CGBA6g6nS8nkQQpDL3YdE0ReXl2IkIdc++jk
 eh1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=MS6fe5pqK8dVuvq4lPUQ3McLZfkrtocF71lhmBH/Qg0=;
 b=Nos90VQ+N1QsRrfZnafe0gRnVpD58iYuy1SVcyala+WuSdwN1tn5kYl7045VOhnC9d
 wlwCv1MwCLB1r+o4vuK9nGc8coazJGx7DK47R+3k9IcB8gAXBC9VuaTPJw4G/QBwT8SN
 3BwsWG1Qa7qhMqmyzQDk3uie5IRNNv9BXcw1cHWcXFd3UzhPEI28BpHRda/HsuCe/NCy
 1k6op2KpQk5HiHn4FMGrm7juOSzlpibsVnCcIaQ6Y8M7TJvcJo3wwUnKkAcGJIJw8DiJ
 Bmzp7Q1PVtM1I9cX8SxEiUuSoEU+XYlafKzjBJqG4H7TIEoIJJwJJyS1+0FTCKaUbYqH
 ql+Q==
X-Gm-Message-State: AOAM533cQS6ibqIdIBikp5+b6aorgFF9RiLJlyXZS6uU+zhGGT4M/66G
 ims+fBPCtv26VL6RPhGAOwLTR9J6Ju4=
X-Google-Smtp-Source: ABdhPJwet3/jHzOWBFrjtkagAnYth4DGZF//d6NIPAqDp0mLav8JqPiJhqFeAMVZtfHLySuNuQ2JsA==
X-Received: by 2002:a63:df10:: with SMTP id u16mr3330074pgg.437.1596488230759; 
 Mon, 03 Aug 2020 13:57:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id lr18sm357687pjb.31.2020.08.03.13.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:57:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-5.1] docs/devel: Document decodetree no-overlap groups
Date: Mon,  3 Aug 2020 13:57:08 -0700
Message-Id: <20200803205708.315829-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When support for this feature went in, the update to the
documentation was forgotten.

Fixes: 067e8b0f45d6
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/devel/decodetree.rst | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/docs/devel/decodetree.rst b/docs/devel/decodetree.rst
index ce7f52308f..74f66bf46e 100644
--- a/docs/devel/decodetree.rst
+++ b/docs/devel/decodetree.rst
@@ -173,18 +173,25 @@ Pattern Groups
 
 Syntax::
 
-  group    := '{' ( pat_def | group )+ '}'
+  group            := overlap_group | no_overlap_group
+  overlap_group    := '{' ( pat_def | group )+ '}'
+  no_overlap_group := '[' ( pat_def | group )+ ']'
 
-A *group* begins with a lone open-brace, with all subsequent lines
-indented two spaces, and ending with a lone close-brace.  Groups
-may be nested, increasing the required indentation of the lines
-within the nested group to two spaces per nesting level.
+A *group* begins with a lone open-brace or open-bracket, with all
+subsequent lines indented two spaces, and ending with a lone
+close-brace or close-bracket.  Groups may be nested, increasing the
+required indentation of the lines within the nested group to two
+spaces per nesting level.
 
-Unlike ungrouped patterns, grouped patterns are allowed to overlap.
-Conflicts are resolved by selecting the patterns in order.  If all
-of the fixedbits for a pattern match, its translate function will
-be called.  If the translate function returns false, then subsequent
-patterns within the group will be matched.
+Patterns within overlap groups are allowed to overlap.  Conflicts are
+resolved by selecting the patterns in order.  If all of the fixedbits
+for a pattern match, its translate function will be called.  If the
+translate function returns false, then subsequent patterns within the
+group will be matched.
+
+Patterns within no-overlap groups are not allowed to overlap, just
+the same as ungrouped patterns.  Thus no-overlap groups are intended
+to be nested inside overlap groups.
 
 The following example from PA-RISC shows specialization of the *or*
 instruction::
@@ -200,7 +207,7 @@ instruction::
 When the *cf* field is zero, the instruction has no side effects,
 and may be specialized.  When the *rt* field is zero, the output
 is discarded and so the instruction has no effect.  When the *rt2*
-field is zero, the operation is ``reg[rt] | 0`` and so encodes
+field is zero, the operation is ``reg[r1] | 0`` and so encodes
 the canonical register copy operation.
 
 The output from the generator might look like::
-- 
2.25.1


