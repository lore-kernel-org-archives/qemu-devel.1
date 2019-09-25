Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3672C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:53:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B150C222C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bbVQHKnF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B150C222C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56114 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCPe-0008QJ-Gk
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:53:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46987)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIZ-0001h1-2Y
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCIY-0004EF-25
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:58 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37023)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCIX-0004Dr-TD
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:45:58 -0400
Received: by mail-pf1-x443.google.com with SMTP id y5so4160998pfo.4
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 11:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tEvO5tw4/suCh+mwvodKHXWtN16PlVfrxqaiSrTER6g=;
 b=bbVQHKnFvAbHmLIb7cT7R+nAFllNJtICyzl/XE6Kih9SFhg6LmnrXZHdgDpICNJbHI
 TloWJcSxR4kNLINaxiblKd1IWStyQ6vI8fJgLp+SFlLzfDaBFlxR7BQlboBeT3JN5dgw
 TEe/sBHh6MvVT3ckgmtz+x0vtw6KwOqI3RpIqEvt4ZFQdlKLgkmnfRrVAyX44wbVzxDE
 sLMHT83TWCCkQxDhWBwLFlNEBH/yT0R7BX/tN8NePh90B1SqVe3kF5RlMetgvsFYmA40
 aYQomumq1WLkPSd7VOt+5zo1UAQ6DKePMRkVX7uJatJXdlge+elD78gKjdJnxn7LoQ3u
 GHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tEvO5tw4/suCh+mwvodKHXWtN16PlVfrxqaiSrTER6g=;
 b=hLLT+9I+4TtVuqGsNnyayjPBHX8zh87nC1MA9P5D64OzgBpnllDrzCkykDchUKOE/O
 YS9puqkTSfjs/jzBGf9b9S6GT81uDEOU5gzhgjakvHXDLTia77dkJLtWDOc5Hg/uwFRe
 TPaDi6vNTe8czFjcwDz8hE3irXsvuJswtO3w07x1RpkHijJKug1pkNI6Oz2zNAHNlW+i
 Fwfo7OP0DlLCTd533pYWon3oYVngB99UoMHmT0COcSPa8lF3CqXW2vYMqJGPEZysi+8U
 Eg7Iha1MLFDAbeAH+AkhumLF87kgkxcm7wrhOAmO9jrORWTCODmgwmgTY3/lNE5BXoS8
 Pj+Q==
X-Gm-Message-State: APjAAAXy3ZXXVXWXmCAdvC/uV+iHTUDYRB9JaK22YdP+sKWl330N6ZVW
 0iax10qlN/OQDfMBu6rwQWGghJbHU9w=
X-Google-Smtp-Source: APXvYqxdmw+2pSxaCnR1PDrhfRmbPNDMuw7gl57iR5Zfc5i8EH9+51EcJ5jdl8pgm0ul59oz1joqRw==
X-Received: by 2002:a62:7ece:: with SMTP id z197mr18817pfc.78.1569437156411;
 Wed, 25 Sep 2019 11:45:56 -0700 (PDT)
Received: from localhost.localdomain ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id l24sm6133229pff.151.2019.09.25.11.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 11:45:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/16] cputlb: Use qemu_build_not_reached in load/store_helpers
Date: Wed, 25 Sep 2019 11:45:36 -0700
Message-Id: <20190925184548.30673-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190925184548.30673-1-richard.henderson@linaro.org>
References: <20190925184548.30673-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

Increase the current runtime assert to a compile-time assert.

Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/cputlb.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 2222b87764..e31378bce3 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1396,7 +1396,7 @@ load_helper(CPUArchState *env, target_ulong addr, TCGMemOpIdx oi,
         res = ldq_le_p(haddr);
         break;
     default:
-        g_assert_not_reached();
+        qemu_build_not_reached();
     }
 
     return res;
@@ -1680,8 +1680,7 @@ store_helper(CPUArchState *env, target_ulong addr, uint64_t val,
         stq_le_p(haddr, val);
         break;
     default:
-        g_assert_not_reached();
-        break;
+        qemu_build_not_reached();
     }
 }
 
-- 
2.17.1


