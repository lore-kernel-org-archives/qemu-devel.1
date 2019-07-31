Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C7C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:30:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AF25206B8
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 16:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNeoSnN6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AF25206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsrUl-0000DF-Bl
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 12:30:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45222)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPo-00052W-9P
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hsrPn-0000NZ-9R
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32769)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hsrPn-0000N6-3G
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 12:25:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id n9so70471426wru.0
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 09:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SeHSnn6Q7MbUbj1wOiuXEk2fDQ1yqleXTuadw7oSvuI=;
 b=LNeoSnN6Kg+VGwYH8Z4RbpDn3H9/yFqSwzDxeJtve72ahZzm0iXMyXKgWAaR8+fkWH
 DmbSPVaBUmj3G3umtKXnbKOkZszfjqr0NjxxtyF1m+3EKl5AhM2VC2XC5+dv+l/U96SD
 UFOk1x5CBDu32Y9cmkb58bzynzAzP2jtdzgiStBZXC7DCfVIfr/2pFt+AIDRoNXVjgUq
 g2tQ0NMMO6yn2W4oSE8OXAnTl1dPN1VeL7yMCrMK96lyDfLgKWYTysNZMj6/XjmLm9jI
 vWRgcldwl9zb8QZmYE8L+GHy0PDCAFHZOrMDTTpuaL21/NP4b/2EcIYyPOMpwgLpVXGg
 HIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SeHSnn6Q7MbUbj1wOiuXEk2fDQ1yqleXTuadw7oSvuI=;
 b=q4217IYDg0zpiSlarf9ZcRaNq0cXni3zMwKidYbZdVSyZFAY2TJgx/tFmUahQ+V8wr
 N3b4/nGzcMP6cY4tluA/Sh8Q/ADz68oGzff8OfRr0F0y/to0CkskUHWeq4UCUtSXGyUa
 XDlfKMgs4rEdmBuSp45ETRvlgflSqM3ezEus1sScqg2h8yOObMTCEMD5z/LQtu8b2C6o
 g3CTrrGH5ahzjkPsTPa4XkB/Orh9wHFEnUVUL8vzTY2uRuOJjPXCe2XdswE0gmFGY+UE
 Fmcd4gz1m+AjuiEumPDzOpGg5+MAZeSgnD5MJAoN1mm5mIqTcxuLpIkr0tk3cvNPhudi
 zt2w==
X-Gm-Message-State: APjAAAXXmNqtqoRmdFudQYmUpPV4DEK5MwFwigTIwzoTvgJ2LQFRzpIo
 XjmmomUUNuFmpExXoHIVFaxmIg==
X-Google-Smtp-Source: APXvYqyo24WJUOkbGrYkUhB1Rs2vPWdpsX9Vo/dmAgoeOdpFUJAVoawbuS28Fgh+ULuGWXgANjcs+w==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr130688452wro.60.1564590322088; 
 Wed, 31 Jul 2019 09:25:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h16sm74107395wrv.88.2019.07.31.09.25.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 31 Jul 2019 09:25:17 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E5B591FF8F;
 Wed, 31 Jul 2019 17:07:20 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 17:06:41 +0100
Message-Id: <20190731160719.11396-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190731160719.11396-1-alex.bennee@linaro.org>
References: <20190731160719.11396-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: [Qemu-devel] [PATCH  v4 16/54] queue: add QTAILQ_REMOVE_SEVERAL
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
Cc: bobby.prani@gmail.com, cota@braap.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 aaron@os.amperecomputing.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

This is faster than removing elements one by one.

Will gain a user soon.

Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/qemu/queue.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/qemu/queue.h b/include/qemu/queue.h
index 0379bd8fdbb..66e834dad11 100644
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


