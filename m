Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA550C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:42:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C1720809
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 15:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7pkVPYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89C1720809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmJ9Y-0006zh-Rf
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 11:42:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4p-0006Rd-53
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:37:11 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35647)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jmJ4n-00055m-La
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 11:37:10 -0400
Received: by mail-wr1-x442.google.com with SMTP id g18so1044948wrm.2
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=fbv3/jSdw1PhrwDJKSxYWcMIUCkmRMAgXUZr/+9Jw3g=;
 b=O7pkVPYAt17UOTiJrR7zoqr5BLwkfpQHVlQUpaFT38EYwZBWzl3DZwkYszoWjKyuQ8
 pub2+j3QyfcLxb0YLc/qtFmQVdjzdxQ4sPBx8U0Wc8Jy95DZcaD3/iuyQX3Usyyghsli
 IJOsEhHs3UgrcA067QojUaakZHUaE/mSBjrJC9RKpLddrhqhgVH9wmg87g1tNVFylOwc
 /SqLr2npfvR/xDSG986De1J4aEtN4L7Wd+j3yvX1ovPeblhCLOl70mU3XA+1qqPH3+jI
 RQeAyn7bE+HonDU0wAJUEdk0wLQwLhl6qT62mHB7tYP5fyZHSxMeHVjY2FTWWYl9tAed
 +yTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=fbv3/jSdw1PhrwDJKSxYWcMIUCkmRMAgXUZr/+9Jw3g=;
 b=s5Au2I60e6eHL1RcsBNCZCbLpK134jJf1SjCaEUDwKt18yU20FFioiOTn9h/cNHswF
 sRJnZEF1X508cJoiCCcwUtrTF57fIDTxoyitvAEemuEY5a9heQeLvnACVzFWytvPz/hw
 eQuT/0AAHjX3wCSn1URhyTXeByvPLx3cclSED9LlB1ExCf3a16Lym++FK8aXhuqiDXyt
 ITWnQDuFT3eHr/2lQ854M4sK7TGyUhw49u7oGO67bIFNcutLnoXe9/rT/PqsD8K6OE9g
 0uAbBLsNRg0XJkuEjSeBGKzWxv5uUjqxhh/eRh6iPfGcnYe55nkQjbY97clmMsbQMc0N
 34Kw==
X-Gm-Message-State: AOAM533rv3wbuPdQpQXl5X8eOaopmFSWPJiV2kFtfkzbvCgNZfEhv/0K
 ug7jckaH/zT+6kIFQNDrMxCjH7Fr
X-Google-Smtp-Source: ABdhPJwpBR94wHEkCp0vFWKyWAtMu+Lyou0zQjIrh5o9jkTfkH/p0la19nJBg6/BWrRv2mTmuesjVg==
X-Received: by 2002:adf:8b5a:: with SMTP id v26mr4620952wra.165.1592581028145; 
 Fri, 19 Jun 2020 08:37:08 -0700 (PDT)
Received: from AK-L.domain.name ([41.232.120.95])
 by smtp.gmail.com with ESMTPSA id x186sm7341354wmg.8.2020.06.19.08.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2020 08:37:07 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, rth@twiddle.net,
 ldoktor@redhat.com, ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH v2 3/3] MAINTAINERS: Add 'Performance Tools and Tests'
 subsection
Date: Fri, 19 Jun 2020 17:36:32 +0200
Message-Id: <20200619153632.1365-4-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
References: <20200619153632.1365-1-ahmedkhaledkaraman@gmail.com>
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


