Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C363C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9D620665
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 15:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OjyaHq3h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9D620665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHqNN-0000mf-3w
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 11:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4r-0000i1-Qq
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:34 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:52445)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kHq4k-0000Da-AR
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 11:07:30 -0400
Received: by mail-wm1-x341.google.com with SMTP id q9so372194wmj.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 08:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+qj72lK8wx2iNL797q3LY8hGwabeZRPUrw3VVMi4u3Y=;
 b=OjyaHq3hQx/JIUjAgrGwsYCLPtYXQ0C+AxMg+d7Eg90Om/c8OqcECCRhAsxPK/FSLQ
 ZVmHE5sPlxtgmPkdeAOaKC9WjM8QG6jXVQbdS1QMpnZLsUihD7fMAXrgpV//ajYOc7dP
 Om3hKL0QYldc/ZKonnKmzhTokgeQ5ZlDVs6q1KTDIW58Ez2mjg4e3479hmPaXD9umDMl
 2yo/j1uyRfioeiUPmlfefwc0A8mdSIZUE3pjqtBZnHlNst5CzYPIMC6xM3FooEiE4BpV
 Tk1VSRLBdliOm2TzMvQH7NcDf6p5hoaN3pVKRypJYH490z8QWEVXZJaTfvGU/05CRv/c
 CTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+qj72lK8wx2iNL797q3LY8hGwabeZRPUrw3VVMi4u3Y=;
 b=F1VPv7gO/uegdJRpnKeItq0t16PXgGpoyudfuRPbiineIZrp/Uzwig8kIdroZgS/M1
 fI/O5/7526V6B1kW/SWf6kn9b3hrwTk3GH6XWl4fW1XGtzvLYJgufLPIQWRMd3OYS8Ib
 0DYxpGeP8nAjMqOwpmafgSDb3mrhwIizwKwdHSUbFyrZSodjOyNASOfyKUtJV6NdIuU5
 QC4VKptcnEvXeDPDD56upPGWG0xP/wfFWV7eUOapT2f+Ql3iJBaIKQddrp0xqvG3EF3V
 8oFcb/Fl2ZkW3NSFZjMAz4wNCIf/T1z+qLzRb4ELMTR/X4iIpzV5xBt7yQe4aUWBlXAb
 YEjA==
X-Gm-Message-State: AOAM531DGzuthEgDix+obsgFrDFBXmnqMYcyl1tSaIkO33f44hOUKVgu
 x7ULKfOx3wCcbAGC2egobM625qL+YHjZsA==
X-Google-Smtp-Source: ABdhPJxGlkopwD3BuA6SaRfPrVQUBDwE8ICBSH11D+7S6jENuhPMkJfn7GVefzx8P9KRwgUhnBdbfw==
X-Received: by 2002:a1c:2e17:: with SMTP id u23mr16310203wmu.73.1600096042834; 
 Mon, 14 Sep 2020 08:07:22 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m13sm20395126wrr.74.2020.09.14.08.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 08:07:18 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 291D11FF8F;
 Mon, 14 Sep 2020 16:07:17 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 3/6] configure: also skip deprecated targets with
 target-list-exclude
Date: Mon, 14 Sep 2020 16:07:13 +0100
Message-Id: <20200914150716.10501-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914150716.10501-1-alex.bennee@linaro.org>
References: <20200914150716.10501-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now the user has to make an even more deliberate decision to
enable a deprecated target rather than getting it as a side effect of
using --target-exclude-list.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 configure | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/configure b/configure
index e365a90cc133..50052378e417 100755
--- a/configure
+++ b/configure
@@ -1722,9 +1722,15 @@ if [ "$bsd_user" = "yes" ]; then
     mak_wilds="${mak_wilds} $source_path/default-configs/*-bsd-user.mak"
 fi
 
-if test -z "$target_list_exclude" -a -z "$target_list"; then
-    # if the user doesn't specify anything lets skip deprecating stuff
-    target_list_exclude=ppc64abi32-linux-user
+# If the user doesn't explicitly specify a deprecated target we will
+# skip it.
+if test -z "$target_list"; then
+    deprecated_targets_list=ppc64abi32-linux-user
+    if test -z "$target_list_exclude"; then
+        target_list_exclude="$deprecated_targets_list"
+    else
+        target_list_exclude="$target_list_exclude,$deprecated_targets_list"
+    fi
 fi
 
 exclude_list=$(echo "$target_list_exclude" | sed -e 's/,/ /g')
-- 
2.20.1


