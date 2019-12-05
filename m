Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A25C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:11:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9463206D9
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 14:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HloIVpv2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9463206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icrqO-0004vD-D5
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 09:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1icrex-0002Xw-4s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:59:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1icrew-0000Yl-0H
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:59:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:38127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1icrev-0000VF-PO
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 08:59:09 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so3731489wrh.5
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 05:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=et7ltZY7DPRXGygmqJQSM9s82vIGOWea1S/OwancEF4=;
 b=HloIVpv2ZsUpCeB42Jm/DQW8F9xJlGHdlqPleFxK8RcIiHbRu8uIVNQs89iJZ5/fxA
 7XzBsbwZ5KPNkEtR2ApMkLaQYRFE+Mmdmya408z6SxkDKa+/vW1zjbbObGBq142BF2Oh
 W2ZCn9g/aqbtRNB7jvCxeRJs4Gb7ZWMDfDXZlSP9sK6S4uoGkICBhrHiy2g5BLFD1KRF
 pUEcggkqBm/3Xxtr+wJnX86SZ/KiZUzYBexdhh66dfKm8bTWGfLxK1LASWIlgaR6zCJb
 BL7POBLO9y0hffJYFCkiSYj+G/fEp1nAKU2HoyNx/5gd358sPM387nWpzZHxMsfaQ/cX
 R+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=et7ltZY7DPRXGygmqJQSM9s82vIGOWea1S/OwancEF4=;
 b=IwZesQVCPJLz961VtIPQ+WPHscbXUsi0lBYzSXdakNadPFXgJe/cr1eUwd0K+Ggw5P
 sX2tKclMLubjczE1dQ6XZxZk6kc8Ssli8Ln+6FzYztNPhTxmWyssa3z2P0d7iF7CDXXT
 Wtcy4YcCiIBZGkyRRC48UcogpORsTNS93Zl80sWKJWvWB8C1uDa8Tdlemrp/UUPXJJlt
 Mz2kdcm8d3VHWO7HgpyGatDtcSOviXdXPJs+bT/GX1PvL2dyj3U86RSHKjdN8z1h9eU0
 ACeub89ozPeQJlf4PbnzIfTFdIMgvN8NNlPD2PObgHqw3434L91cnTjU+GKkf1n2/5+k
 8Dbg==
X-Gm-Message-State: APjAAAVXstFaO6ItJM/wH6nZODRjYgWWdg93Qb3ZyXeY2rRjxx+HCrt8
 dtJCUvaTdp2AdK2IO30rTP9Pr9AFygs=
X-Google-Smtp-Source: APXvYqxvuHZ2tnnTGJfH/sNA0j6Lp6f1S8UalXH8PjWZADaUT4CiODLGGQR7QjXc65KJ0SFRf3RHkA==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr9712985wrq.396.1575548728753; 
 Thu, 05 Dec 2019 04:25:28 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i127sm10954997wma.35.2019.12.05.04.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2019 04:25:23 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 947E11FF93;
 Thu,  5 Dec 2019 12:25:18 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] trace: replace hand-crafted pattern_glob with
 g_pattern_match_simple
Date: Thu,  5 Dec 2019 12:25:17 +0000
Message-Id: <20191205122518.10010-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191205122518.10010-1-alex.bennee@linaro.org>
References: <20191205122518.10010-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already use g_pattern_match elsewhere so remove the duplication.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 trace/control.c | 35 +----------------------------------
 1 file changed, 1 insertion(+), 34 deletions(-)

diff --git a/trace/control.c b/trace/control.c
index d9cafc161bb..0fb81241607 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -98,38 +98,6 @@ TraceEvent *trace_event_name(const char *name)
     return NULL;
 }
 
-static bool pattern_glob(const char *pat, const char *ev)
-{
-    while (*pat != '\0' && *ev != '\0') {
-        if (*pat == *ev) {
-            pat++;
-            ev++;
-        }
-        else if (*pat == '*') {
-            if (pattern_glob(pat, ev+1)) {
-                return true;
-            } else if (pattern_glob(pat+1, ev)) {
-                return true;
-            } else {
-                return false;
-            }
-        } else {
-            return false;
-        }
-    }
-
-    while (*pat == '*') {
-        pat++;
-    }
-
-    if (*pat == '\0' && *ev == '\0') {
-        return true;
-    } else {
-        return false;
-    }
-}
-
-
 void trace_event_iter_init(TraceEventIter *iter, const char *pattern)
 {
     iter->event = 0;
@@ -148,8 +116,7 @@ TraceEvent *trace_event_iter_next(TraceEventIter *iter)
             iter->group++;
         }
         if (!iter->pattern ||
-            pattern_glob(iter->pattern,
-                         trace_event_get_name(ev))) {
+            g_pattern_match_simple(iter->pattern, trace_event_get_name(ev))) {
             return ev;
         }
     }
-- 
2.20.1


