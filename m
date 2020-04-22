Return-Path: <SRS0=gSpC=6G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 274FBC54FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6CFC20672
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2020 04:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8YdVlUF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6CFC20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jR75v-0002Uz-2M
	for qemu-devel@archiver.kernel.org; Wed, 22 Apr 2020 00:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74X-0000PO-0I
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jR74W-0004g3-4W
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:16 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jR74V-0004c7-Nd
 for qemu-devel@nongnu.org; Wed, 22 Apr 2020 00:33:15 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ms17so378984pjb.0
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2020 21:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iKZvtr9IPAzyq9GBvX8e6ybeQtJDWGAh30ejEfYLqNo=;
 b=O8YdVlUFMeAyiQckNOrUjTA+kG9wxt/Vpotnkg7s2jSHuklfDef4zCNAvnL92Kigk9
 /YcwhcFjzqs7MJlzEy+8erOYdtH/uYgiWm60rrvtmf1M2rAzGQqJQTtQvXAw9JbgpUHE
 cw4CI0vWTkGYmmsVrve8uUfTWPLHT33mmXnmPdqIBsw3gXBbPrRwGx8Wo8fjLZzAg9R/
 EewiN/3oJH4I0oSwcEs0aTyDlJ16LOQSgE6q0OHnfPwafr8yX6Mb2dde1AzkvfNqgckp
 spvobVVvQHyo1JF1wa3lsT9ANXCRqJPfmTxyIOdSR5+MZXGfpHUtMFF+9IY4+Bd5iWuF
 2ZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iKZvtr9IPAzyq9GBvX8e6ybeQtJDWGAh30ejEfYLqNo=;
 b=cZ7nUdH8Bp9WxqumKcqMtVXTJjSmTyZoK0VvrQcxGNw/u4iRaG+HBKz47OBypXQJAl
 jggbjWwTpVF+pAheMniyhjlefjld8gdHgOHVlsF9kUpXi+UfQ+olsF03O+28Qk2D7PG7
 1IwYtUhpcToH4aytpButDs3fbkx8WMB18F+RmH88RZuLuh8lsZ6pkOawyxRwKvsIqX3C
 qRLp736+x3YlPrLuvU9yji+nxvX8YWCnKF6olnlqh598V1aaD603MJgMUrSJQW1llIhm
 jtlBFasV7cANuvxr/48d1lEZTLBBxxsNs8e5MvnSNice363LsrL8l1AxXoXVtLuovaE7
 dFbg==
X-Gm-Message-State: AGi0PuYBPqD8tr72Rhex55aKDM+TsFZLodA4ZM74JUvgnYefKAJAuBkT
 JEsSy2pRO4nsH475XT76V815270kyh0=
X-Google-Smtp-Source: APiQypK2qCPnp2UnbQY1n2fJ/o/xseD6sg2lbdhJQApQGmsXV7zjwzoq82YpV9WABYu18HfW0h5KZQ==
X-Received: by 2002:a17:902:d201:: with SMTP id
 t1mr3566571ply.328.1587529993856; 
 Tue, 21 Apr 2020 21:33:13 -0700 (PDT)
Received: from localhost.localdomain (174-21-149-226.tukw.qwest.net.
 [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id l137sm4129613pfd.107.2020.04.21.21.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2020 21:33:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 02/18] exec: Fix cpu_watchpoint_address_matches address
 length
Date: Tue, 21 Apr 2020 21:32:53 -0700
Message-Id: <20200422043309.18430-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200422043309.18430-1-richard.henderson@linaro.org>
References: <20200422043309.18430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only caller of cpu_watchpoint_address_matches passes
TARGET_PAGE_SIZE, so the bug is not currently visible.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 exec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/exec.c b/exec.c
index 2874bb5088..5162f0d12f 100644
--- a/exec.c
+++ b/exec.c
@@ -1127,7 +1127,7 @@ int cpu_watchpoint_address_matches(CPUState *cpu, vaddr addr, vaddr len)
     int ret = 0;
 
     QTAILQ_FOREACH(wp, &cpu->watchpoints, entry) {
-        if (watchpoint_address_matches(wp, addr, TARGET_PAGE_SIZE)) {
+        if (watchpoint_address_matches(wp, addr, len)) {
             ret |= wp->flags;
         }
     }
-- 
2.20.1


