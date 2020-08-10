Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77985C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FAC722BF3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 19:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="au9d957s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FAC722BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Dqg-00051b-7U
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 15:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoW-00005A-32
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:32 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:46895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5DoU-0004jF-CP
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 15:50:31 -0400
Received: by mail-wr1-x42a.google.com with SMTP id f12so9305369wru.13
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2020 12:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NK7m3uoWmCtcbXsGQreBTTuezmJYVKaA5MHLH71vKCc=;
 b=au9d957sT+BXStmJAnu0OeN23N5SDALeo4EBFOXmM5YuLP32Ql9aZapp0BGJOJaC/5
 N4vou9gORHwBo0TlOmu2hexIvLFiYceWytADQtC+crT6ag8JOUWQkv1kbIeniz3gA+nG
 uB5T56hkv0ivD0BKHByoh+JC58ZJxkoYjCSG8mngTfYjo8AtCLrq4KGQXIApBFpoiBHM
 nH6T75FmNz/lH+SPplpdUi8ebhkSj8gLl2nA7z7sVOybYI8EwgUR95sp5s445oLiAdTr
 9OQ1LyZLbvVl4afB+c43ncU/pB3CsZW4e/sO4kFjioTy2Ew+YwzOwtVnd19A0A6g8UMe
 sWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NK7m3uoWmCtcbXsGQreBTTuezmJYVKaA5MHLH71vKCc=;
 b=IgqcmEGb28/q6Sz09YDstWIrUSmPHEFd9tOcO9GBSCxNhjaIJBJAw42LJhupwzRR40
 ngLPEh4L5x6tEK3hHUjg5b4joUYkv5EBNsgAa8aSveyAkzllXqyfJbzyAnuBrDWg40FX
 +QUmCeAKXO83lGrYuELHRHY35Spg6rJRWzefkQjS0SyhOtFR9ocHTKAJuvzwQ4vPL8XU
 5Ptoa6w8A3vOoNgk4Dxc1h3xM1+a5DZthzT43o6r4EZqiBPQp6MadQy6vAxzRgZZbh3D
 1VEqQWeBpzcKmpEybGHAyEnFj7DNfy30GtV5xS+yFfhctDKlaL7Hz2ythTIyxUsBlkYM
 jw8Q==
X-Gm-Message-State: AOAM533w0EGJtoy+jQd/y6K8qwYLkZDhmFTGhZ/1ArdPLZiqmqyeK8pB
 bkqvAU9Us3vEFbqpeR5lGQ8xI24pkx1k+Q==
X-Google-Smtp-Source: ABdhPJyZtEjJvshDEby8ed7gkF2E+UiN/S8MqGY19x5WuusiVJ2/K4i5+JmXnpL9yFW4muIVY2tx3g==
X-Received: by 2002:adf:e8cc:: with SMTP id k12mr27013186wrn.2.1597089028382; 
 Mon, 10 Aug 2020 12:50:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id b129sm976087wmb.29.2020.08.10.12.50.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2020 12:50:27 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 04/20] qapi/qapi-schema.json: Put headers in their own
 doc-comment blocks
Date: Mon, 10 Aug 2020 20:50:03 +0100
Message-Id: <20200810195019.25427-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200810195019.25427-1-peter.maydell@linaro.org>
References: <20200810195019.25427-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

Our current QAPI doc-comment markup allows section headers
(introduced with a leading '=' or '==') anywhere in any documentation
comment.  This works for texinfo because the texi generator simply
prints a texinfo heading directive at that point in the output
stream.  For rST generation, since we're assembling a tree of
docutils nodes, this is awkward because a new section implies
starting a new section node at the top level of the tree and
generating text into there.

New section headings in the middle of the documentation of a command
or event would be pretty nonsensical, and in fact we only ever output
new headings using 'freeform' doc comment blocks whose only content
is the single line of the heading, with two exceptions, which are in
the introductory freeform-doc-block at the top of
qapi/qapi-schema.json.

Split that doc-comment up so that the heading lines are in their own
doc-comment.  This will allow us to tighten the specification to
insist that heading lines are always standalone, rather than
requiring the rST document generator to look at every line in a doc
comment block and handle headings in odd places.

This change makes no difference to the generated texi.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qapi/qapi-schema.json | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index f03ff91ceb5..5fc0771eb04 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -2,7 +2,9 @@
 # vim: filetype=python
 ##
 # = Introduction
-#
+##
+
+##
 # This document describes all commands currently supported by QMP.
 #
 # Most of the time their usage is exactly the same as in the user Monitor, this
@@ -26,9 +28,13 @@
 #
 # Please, refer to the QMP specification (docs/interop/qmp-spec.txt) for
 # detailed information on the Server command and response formats.
-#
+##
+
+##
 # = Stability Considerations
-#
+##
+
+##
 # The current QMP command set (described in this file) may be useful for a
 # number of use cases, however it's limited and several commands have bad
 # defined semantics, specially with regard to command completion.
-- 
2.20.1


