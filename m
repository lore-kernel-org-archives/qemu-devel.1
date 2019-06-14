Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1159BC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F66217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 17:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zcDMbdsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F66217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbq5x-0001cP-NT
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 13:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56082)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkM-0000hU-9d
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hbpkL-00035f-2D
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:14 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e]:35204)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hbpkK-00033o-QD
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:12:12 -0400
Received: by mail-wr1-x42e.google.com with SMTP id m3so3333187wrv.2
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aaXX3gQaQ+yIC35QS28KS1PNhW44kKO1FarcjHXQujo=;
 b=zcDMbdsVZHKFdWKcOG1ih54C6DlGeQg9GtBKioQMfxzCTCA1Qhd7HGs5D3+ky2uSXR
 EtSVoNmPy31OKfsQ5DHKyOsMeVmmXIa5hEBNLvzUOEjLYxqRB4S+rH+458/yfWXfXvtr
 1bijvpYtspE6nbwJRGRvafRKEoOl/UT7reve2TBwI9rUcRmF56lzfuoe1FyqiF/yBVGX
 BszD2krN+/GyYDdy3cQ/W3QRbGJwagg45VosMISpt61hBXavLLewFmkTzGbJCalHjJlR
 d+cLuCkhtiCA2DTIgyilVsl2GDBnguaHEeR3234z0Qf6rwvpjM+o8B9zR+wNRwVRydgU
 tieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aaXX3gQaQ+yIC35QS28KS1PNhW44kKO1FarcjHXQujo=;
 b=tHNQrjGwgUfQVcPo1ArpvNo6uFVH2CwVFtdjIBtUIMu9gefFfqJVs2ltLto2Vu1JdI
 4bpghqSbsgA1aD0eOB9nzRGROIVJs9FfC4WbyJSicQx/qn5CMC/xcRxzFFOvFYMYy+cJ
 r2BlTHZANJr7OCVXfKfUZ/y49ArmgIEG/A2P7zw4LiRgOOyaAMdARPwxaPZvKsisUSlf
 mTOzUy3NvEcnuALFAuo+zITMXDiCvkGCgedYnheaGz/o104i7LTBqBXTwvAzNUYiUQnp
 R98v6IE8I5PGD/o2zHnncVJZ4BQEnM5McqKEl3KrimfBtGCWGahl0O9mvSkFqhV4dDwj
 NKWw==
X-Gm-Message-State: APjAAAUK0PcLnd70sH03t4x2XOwh2B16DHFAz6hlVBPk7zoNrPzv40fl
 wYZ+sxM4OYcGbTGCgYuuNbdNYRIlveY=
X-Google-Smtp-Source: APXvYqzVc0ERLxe4zVPhF+NdbC2UoHxMn40unJe13UrKbZkUKeIRoRgGgmTsBZszjNO8+sY/dLK2kg==
X-Received: by 2002:a5d:484e:: with SMTP id n14mr651654wrs.348.1560532331384; 
 Fri, 14 Jun 2019 10:12:11 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id g19sm4392261wmg.10.2019.06.14.10.12.03
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 14 Jun 2019 10:12:05 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5867E1FF9A;
 Fri, 14 Jun 2019 18:12:01 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Fri, 14 Jun 2019 18:11:20 +0100
Message-Id: <20190614171200.21078-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190614171200.21078-1-alex.bennee@linaro.org>
References: <20190614171200.21078-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42e
Subject: [Qemu-devel] [PATCH  v3 10/50] queue: add QTAILQ_REMOVE_SEVERAL
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
Cc: "Emilio G. Cota" <cota@braap.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This is faster than removing elements one by one.

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/qemu/queue.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 0379bd8fdb..66e834dad1 100644
--- a/include/qemu/queue.h
+++ b/include/qemu/queue.h
@@ -422,6 +422,16 @@ union {                                                                 \
         (elm)->field.tqe_circ.tql_prev = NULL;                          \
 } while (/*CONSTCOND*/0)
 
+/* remove @left, @right and all elements in between from @head */
+#define QTAILQ_REMOVE_SEVERAL(head, left, right, field) do {            \
+        if (((right)->field.tqe_next) != NULL)                          \
+            (right)->field.tqe_next->field.tqe_circ.tql_prev =          \
+                (left)->field.tqe_circ.tql_prev;                        \
+        else                                                            \
+            (head)->tqh_circ.tql_prev = (left)->field.tqe_circ.tql_prev; \
+        (left)->field.tqe_circ.tql_prev->tql_next = (right)->field.tqe_next; \
+    } while (/*CONSTCOND*/0)
+
 #define QTAILQ_FOREACH(var, head, field)                                \
         for ((var) = ((head)->tqh_first);                               \
                 (var);                                                  \
-- 
2.20.1


