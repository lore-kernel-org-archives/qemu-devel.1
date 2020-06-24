Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48D4C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F2FB206FA
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 15:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LNnWDVCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F2FB206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo7R6-0001F7-Ez
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 11:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jo7Ni-0004xc-Uf
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:32:10 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40721)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jo7Ng-0000JD-I7
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 11:32:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id h5so2721073wrc.7
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 08:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fbv3/jSdw1PhrwDJKSxYWcMIUCkmRMAgXUZr/+9Jw3g=;
 b=LNnWDVCDIAt/hP0hdi1ZiGOKjeS6R1hZkrcfQ2WqxF3rqatQkLTpUC/V4LYV0Kw7MN
 IC6XpWEjU4ZT6Oiqg+oqB7+5mJ3ylFjr2a2glOc5Eol1gYeiX7f7fgqSk8Y8kvaI3FIm
 4xvdzgcuuv1meoJx998CZ+uxn3T7d7Q0W6fe2eUQ1Qs7R4/qOTw/ZEiw66H6aldjBn8Y
 7XuxzLHV1fFMUYYGq6qAcUMeJUbMIJW1R+Bwbi76OAP+HnJ2b1ksqbPzgonWybACswPD
 gb1mPm88DyS3F5QSHY7slvelsXjtR2Z77F9SA3BahwbFiFCCURP1urFwMBqT0pr4qjG9
 QbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fbv3/jSdw1PhrwDJKSxYWcMIUCkmRMAgXUZr/+9Jw3g=;
 b=nPwnagN/NdIH2nvQdso1S9bL/6yLZWvv6gDSrzOY4hEcLJqtjfUGxhvojtoGrmtSsI
 /8C5qOLzuSd1VWj6r6lmbKRnWx9GFWJlUb+1MZBGNf1YJQODWlr/B9OhjgJh+ok9Wm32
 hecISs8xPN6aSfsLwrEKI8E0CZB/0wCfn2joB4Nz26Kn2wHgg/TfmuvltycNXfWv0LNy
 /aQ+vpdmEK7ndLv1HF9HyA9L5O108c2r8BHu8uGn+f1BJFrFOaXtCnTCzsQUv01BisEx
 KDskPbgpybTEGsC+9+kveV1kzGhyrDiXhoT6aaR4EoWLGthIgoY9GCkoGli8sffaAZks
 kzsA==
X-Gm-Message-State: AOAM530feJOQ8wJMwSuErVKqOxIavoISEWMt1iB21ytwBZTQvGP/AKcL
 Bod5dhHt143KAGNLdVfYnowejVcg
X-Google-Smtp-Source: ABdhPJwEydeNNpyIuCuy/mERv9CkXStfqEDfzVfBw0CYOCg5QGXU2/HZqn16QhhHtkI96L6L+z3ZIg==
X-Received: by 2002:a05:6000:128c:: with SMTP id
 f12mr20132274wrx.67.1593012726942; 
 Wed, 24 Jun 2020 08:32:06 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.65.131])
 by smtp.gmail.com with ESMTPSA id b184sm2011299wmc.20.2020.06.24.08.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 08:32:06 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, rth@twiddle.net,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v3 3/3] MAINTAINERS: Add 'Performance Tools and Tests'
 subsection
Date: Wed, 24 Jun 2020 17:31:42 +0200
Message-Id: <20200624153142.13247-4-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200624153142.13247-1-ahmedkhaledkaraman@gmail.com>
References: <20200624153142.13247-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This commit creates a new 'Miscellaneous' section which hosts a new
'Performance Tools and Tests' subsection.
The subsection will contain the the performance scripts and benchmarks
written as a part of the 'TCG Continuous Benchmarking' project.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..ee4bfc5fb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2974,3 +2974,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: docs/conf.py
 F: docs/*/conf.py
+
+Miscellaneous
+-------------
+Performance Tools and Tests
+M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+S: Maintained
+F: scripts/performance/
-- 
2.17.1


