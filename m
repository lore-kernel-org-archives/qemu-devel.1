Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E784C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:45:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E07E21881
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 16:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EKyvj/8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E07E21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvlXu-0002Rq-EI
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 12:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55154)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTi-0004TJ-HX
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvlTg-0007aj-H8
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:26 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51178)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvlTg-0007WT-Aa
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 12:41:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id v15so3054017wml.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2019 09:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LIEv4P2C0/9YawvAT5IGyHCWDJnkHqheUeFneAyCCc4=;
 b=EKyvj/8+60PxD75cfBZDjxeJr/WUJFAsLaDwf7Ub5i3HIyCVIrtlNXVuQ/WDivflGV
 sRyYFmWy8hERER1LXm6YAtRNcwSR6EBZgx/Uz69nOfJUyUiZJU3oqGZEJyxy1KGlLpcG
 CEt7Q6LcN4wgfWspEVynO7vJJ0yjv0yH9mLy1im/j9dpt6EsDR82zkwe86NHIzkFkTaG
 r7xt6n0Hr4th50lpdcdRLq/mSFA9GhowVGvKMhE1/+bUmz16KFC0dBw649XbsSyHlUlV
 HEoAwhcobzcK8xDiLv6ehqWFIuSAerWuY5Ewq2QeSdv2OLFEHYNZuPE37Sjt0rvm6EBu
 6hCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LIEv4P2C0/9YawvAT5IGyHCWDJnkHqheUeFneAyCCc4=;
 b=npdrHADPa2VmiyG461HPynu0Eln5n5SHc1LZ+jWW1HWojo/n8Tvk+aPFKkb4KY1QfK
 cQ2x7z9xMBckFL7ir1j/JLC7ojXf2AWCgzJ9hWFjuBsR1VkkE56ZvV8cGn5tRdOn5imh
 mO+cQ9iDUNfqLoedS9OWB6NpGSo3ddR1F43B2ocQ384FSV+KnP1FDXbg6uGp9exM0zk7
 /9RdN+Oq1WMlPvT8aYvsAqycBWtiTU035CQ6c/STXAosAGd8BlVvZUogoLpLxikvxeLP
 j1N61vVfSTk57BHdHoare9L4DIDQOuznQ/OK0GMcIdxUYTKh1jMt35C71RM1JAvXSuzo
 dk7Q==
X-Gm-Message-State: APjAAAXS3RvDxWN9hEaT7JDlvzVarGHnj+QgUCZm5xg35KOHGZwplqEI
 k6UIXmjvxj8WVe/lVCxvOe4eyfdwlxw=
X-Google-Smtp-Source: APXvYqyasgvoSpX7I4Vl+Rd8yiXIKjEiQpDMn4SFWBuMF/KiH5lCINnEuL4WFbyZsMTUwBHBeN3/Qw==
X-Received: by 2002:a7b:c4c1:: with SMTP id g1mr5591465wmk.14.1565282482437;
 Thu, 08 Aug 2019 09:41:22 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id h8sm3438803wmf.12.2019.08.08.09.41.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 08 Aug 2019 09:41:21 -0700 (PDT)
Received: from zen.linaroharston. (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E3A721FF92;
 Thu,  8 Aug 2019 17:41:18 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 17:41:15 +0100
Message-Id: <20190808164117.23348-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190808164117.23348-1-alex.bennee@linaro.org>
References: <20190808164117.23348-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: [Qemu-devel] [PATCH v1 5/7] target/mips: rationalise softfloat
 includes
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, armbru@redhat.com,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should avoid including the whole of softfloat headers in cpu.h and
explicitly include it only where we will be calling softfloat
functions. We can use the -types.h and -helpers.h in cpu.h for the few
bits that are global.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/cpu.h        | 3 ++-
 target/mips/msa_helper.c | 1 +
 target/mips/op_helper.c  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 21c0615e020..f146924623c 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -5,7 +5,8 @@
 
 #include "cpu-qom.h"
 #include "exec/cpu-defs.h"
-#include "fpu/softfloat.h"
+#include "fpu/softfloat-types.h"
+#include "fpu/softfloat-helpers.h"
 #include "mips-defs.h"
 
 #define TCG_GUEST_DEFAULT_MO (0)
diff --git a/target/mips/msa_helper.c b/target/mips/msa_helper.c
index a5a86572b4a..f24061e2af7 100644
--- a/target/mips/msa_helper.c
+++ b/target/mips/msa_helper.c
@@ -22,6 +22,7 @@
 #include "internal.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
+#include "fpu/softfloat.h"
 
 /* Data format min and max values */
 #define DF_BITS(df) (1 << ((df) + 3))
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 9e2e02f8586..f88a3ab9043 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -25,6 +25,7 @@
 #include "exec/exec-all.h"
 #include "exec/cpu_ldst.h"
 #include "sysemu/kvm.h"
+#include "fpu/softfloat.h"
 
 /*****************************************************************************/
 /* Exceptions processing helpers */
-- 
2.20.1


