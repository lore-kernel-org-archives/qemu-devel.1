Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99B5C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:25:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3090B206E6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 18:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMrE1uh6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3090B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56870 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kG4n1-0006fr-7a
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 14:25:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51900)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4m7-00067y-L8
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:24:55 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44670)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kG4m4-0004zr-Jq
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 14:24:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id s12so3976839wrw.11
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2020 11:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=5WCkNoCLy7bJ+Jwn4aAaigxjEqEG/w4S2Y14CNfN5Mk=;
 b=LMrE1uh6Wo0wzOrsutzO/jKXzyVd/OsljCNpZ6fTIsz7lfWqSFHEXcMCSw+Npptguh
 nWRuIznAJMXs8t+PGlBKElmCj+20sc5o8w9kmuiPZzz7cj+zAApG6FqnXE/arkvmmdXa
 CduUbtAKEBHGSWz+yyQD7OyOJl0/qhu/7Z1TdZRGEKEOqv7ZIox8/59tTOtShsvwTE6B
 a4hLOockqzad03S/koN08VSqqPsPnKuWKiTIeeL7N8g7W/p1loZoTyeJ4H/bm7OFG9Jq
 uRQGwPDUG7l8UA0FO2agcTGkMczFdpsmC11Hk+rMxTxe1LWtYv3MefQOCZAUH3yXxrnb
 HF9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=5WCkNoCLy7bJ+Jwn4aAaigxjEqEG/w4S2Y14CNfN5Mk=;
 b=a/oLIvXs/J5yCTfFPjOJGjhnqfl5L7GPYSyaAFvOVRUU/JcCTlXDnYnB9VE2Mbcn1g
 bhdEp/n81w9fhmDML1Gj1wBujyRra8kJ2rcKEx9uBmBffkjJleoiMmHjHiuAuuWiUvNd
 LiBjWz8KDQSwaiIsDlgUYU/eiEFWk9g5FNWCqRXqL5QTJiUHcS8bgBHw7vAfI62t0Ugl
 8LaNODiDZOau06UokjKAtakqpe+RW+hELnAMKg5u7yPMJkJO66zFzDbIzSfpYhGQ4el7
 nXmCntE0gJQiKDuoVQ1GzBZYVd+RBb/dE/HV2whdsIwkoC3Xq7qN5sbAdE5XYCI2P7Ly
 pSrQ==
X-Gm-Message-State: AOAM5339Y5jOB5QYb4Enk85DOJsGKqhiQdFt84WJQP4fjvpivIPuEfiy
 W/wv6ErON7LFvn3H/3q5AkTxkkWAAWI=
X-Google-Smtp-Source: ABdhPJzLNKbtvyjIGGL/vlLFBMGZmbdL4jFrHEAGZGw/c02yQ/GzdG9/pVqjYJEg8+ibhpkUAYMErA==
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr5437953wrr.104.1599675890663; 
 Wed, 09 Sep 2020 11:24:50 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id t203sm4848482wmg.43.2020.09.09.11.24.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 11:24:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Do not intent to build WHPX on 32-bit host
Date: Wed,  9 Sep 2020 20:24:49 +0200
Message-Id: <20200909182449.360472-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Stefan Weil <sw@weilnetz.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hyper-V is available on 64-bit versions of Windows,
do not try to build its support on 32-bit versions.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 configure | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configure b/configure
index 4231d56bcc0..4bd08f5469b 100755
--- a/configure
+++ b/configure
@@ -2989,6 +2989,9 @@ if test "$whpx" != "no" ; then
         fi
         whpx="no"
     fi
+    if test "$whpx" = "yes" && test "$ARCH" = "i386"; then
+      error_exit "WHPX requires 64-bit host"
+    fi
 fi
 
 ##########################################
-- 
2.26.2


