Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D790C55179
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC19C208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="slNatfOy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC19C208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVwNN-0006sX-Nw
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwKD-0002gt-Lf; Fri, 23 Oct 2020 08:37:41 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:38155)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVwKB-0003jS-Us; Fri, 23 Oct 2020 08:37:41 -0400
Received: by mail-pl1-x642.google.com with SMTP id bh6so790342plb.5;
 Fri, 23 Oct 2020 05:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=HF7WxCoU141NN82TMoYgFYduXuLv/LrNAeQnct+AkvY=;
 b=slNatfOy7/n6EOvu6SbgmnGR/WaOIdBVCjdwJlPiMzu2Zwt8QvCqf9peRMIWCdkdMe
 N1PBtfLSIb8vkkj88zFZg1S5Ek6F/PFAiuYS8p4Aki8uDjeYpHN0NVS1Yfm4ZM8NWK4k
 RFVFG5XlDBgcAxzVaoZvQORrNYZXgtZtvTFVYE8knKv4prnbuqpiKAL4N6HlA93N4drg
 fZM+E/F4KLQoKnBTdJVfisnAPOX+Gt1gBoo1nvE15NypfZjiZOtCwhmcQ2xlEjVbhdMk
 +nBVzPwzmbVbDu6S2kCTEXO1b5Eblv5VpS9B+7BMRgvfKj0YZcBXJK9WTwtvqWG/tvOi
 odXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=HF7WxCoU141NN82TMoYgFYduXuLv/LrNAeQnct+AkvY=;
 b=KFG/dPzviadVwRXVMybzt6QQ3yJUpUKB46ac/VNhiH01GtL5vd9eDfhyBNfmAMIbT5
 97uKRFLk9/UoN0WQZvBpfcGFokFfiRMaVeRSiMWNSHYSNzxsoJh1a5m+1XjydZ0p3xvj
 Tp4Ln7oZM9iaVvllJsNy2TXG3eDleIkDA1vHZsn2pwUg9u5IVxUkfKgRD6Nbkp8vCDtc
 9gSIKtNUF70anMcuyzbye72yKlTcmJ0TKacZBvZhKfZovFUrvhUI24z9NihDzgoh2SBq
 /FmT3DO8l0UaQysrGPkgrjuadvUtMrzq4WOw6770cpFPqfcD+HSOwHLT2V+anO9ZuuvZ
 P3Bg==
X-Gm-Message-State: AOAM5313zLRicaICt7agsE5FuEGeLv9O3WYXQWyBn7VayFrpjSfTtitK
 fveZCj4CwtAA5qHNL5mSEsI86jWtRE05zyL8
X-Google-Smtp-Source: ABdhPJzZM9nJ5w6FDW5iCielKYeHSigIWURLAsr9T/mBvDxOHlvuJ+Z+uWfqbMhiMJltbT2iVOQ9uA==
X-Received: by 2002:a17:902:204:b029:d3:9c43:3715 with SMTP id
 4-20020a1709020204b02900d39c433715mr1991511plc.74.1603456657563; 
 Fri, 23 Oct 2020 05:37:37 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id t30sm782734pfg.126.2020.10.23.05.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:37:36 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 24/30] w32: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:36:24 +0000
Message-Id: <20201023123624.19891-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=chetan4windows@gmail.com; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: sw@weilnetz.de, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 util/oslib-win32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/oslib-win32.c b/util/oslib-win32.c
index c654daf..48e34c1 100644
--- a/util/oslib-win32.c
+++ b/util/oslib-win32.c
@@ -367,7 +367,7 @@ char *qemu_get_exec_dir(void)
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


