Return-Path: <SRS0=Pynu=7U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCCEC433E1
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A04F2073B
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2020 19:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oc/y/bf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A04F2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ji1I1-0005gJ-Jw
	for qemu-devel@archiver.kernel.org; Sun, 07 Jun 2020 15:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FY-0003pq-6J
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:32 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:56259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1ji1FU-0004kU-Oc
 for qemu-devel@nongnu.org; Sun, 07 Jun 2020 15:46:31 -0400
Received: by mail-wm1-x32b.google.com with SMTP id c71so13281032wmd.5
 for <qemu-devel@nongnu.org>; Sun, 07 Jun 2020 12:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Gyc4jAqqb4iRdL2lJtXMg0ZbvCkpCJJT7AmeHRVjQIU=;
 b=Oc/y/bf2YKbsou+FlECJQQaWRWfE/7OhJ/02ijQSogrkL+dUbvzNJUUYqc5nCju72I
 eTq0dAS3izv3b0jJMTvhDX0fcSwBvUz7G0pm8iOxL6b3YxK7FMydc0InC8mRIto3OAng
 2s3lH+kJj2BWvEo3zMqxicvIYsUSAbQwfYHmUeuEOS21UV02bklR8Eh41Ql+LgGvsWgb
 YEvq9IWm8++COw0cI5IlrSyY38+8xP8bX29RKXcEH6Cr8J3I4EPNJTL/IV54s+5suKQl
 HQ2WaO3sflqnQkcLbqgdqYT9U/fqQc4MFVCM+y4DtAriE3XAo3MH3gV6glGoNtJzVNmp
 UGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Gyc4jAqqb4iRdL2lJtXMg0ZbvCkpCJJT7AmeHRVjQIU=;
 b=tuKrEOkAr509XlY21MWjoLByGTZIHRy7ie0diYoZ5ifyQOLKg+eEruq5LLv4iX3dJd
 mYMO2BhhDcii8D3Kjhy6sg6dc4nMGuosyfMA59tgh4D/NAXlBHO+8EovGd6CAs+qK2dp
 6t229h0uBAb9d9erf+7DvmtR7/7gQfCT/jeiv1hdkQ+WdkcOT698ZWFWPS+8LyjO5iPo
 OvpAzV8v9VUebNrQN9Q/cVxtwbGig73Y9MvW5oQ77gJ5Nuh7X1HOCuTsxAQVlrBRf5+k
 idXpcSuHBlJ1lOz4e8tiyg7oQ05QuEYGKKgadRknS3emGnXssjT8Z8nMXw2WPUWQlXuC
 UY3w==
X-Gm-Message-State: AOAM533ZHVbBzK4iEgz8UKoFL5iPVOJwmLHz66FfgklDuXM7eZCb3Jab
 HSTohsi2VgP7H4BydQ+vmo/D5YnR
X-Google-Smtp-Source: ABdhPJyr3f5wRPm0XgYy715q3Ru7xWkQPHX73N4SznEciEeEX0OnYqUjkQZxXYIHtDgjMA5p88O2oA==
X-Received: by 2002:a1c:810a:: with SMTP id c10mr13079865wmd.107.1591559187212; 
 Sun, 07 Jun 2020 12:46:27 -0700 (PDT)
Received: from rtrkw774-lin.syrmia.com ([46.240.135.226])
 by smtp.gmail.com with ESMTPSA id u130sm21091339wmg.32.2020.06.07.12.46.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 07 Jun 2020 12:46:26 -0700 (PDT)
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 01/21] mailmap: Change email address of Filip Bozuta
Date: Sun,  7 Jun 2020 21:46:05 +0200
Message-Id: <1591559185-31287-2-git-send-email-aleksandar.qemu.devel@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: aleksandar.qemu.devel@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Filip Bozuta wants to use his new email address for his future
work in QEMU.

CC: Filip Bozuta <filip.bozuta@syrmia.com>
Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Reviewed-by: Filip Bozuta <filip.bozuta@syrmia.com>
Message-Id: <20200602085215.12585-2-aleksandar.qemu.devel@gmail.com>
---
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index e3628c7..9f2a3a5 100644
--- a/.mailmap
+++ b/.mailmap
@@ -45,6 +45,7 @@ Aleksandar Markovic <aleksandar.qemu.devel@gmail.com> <amarkovic@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
 Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
+Filip Bozuta <filip.bozuta@syrmia.com> <filip.bozuta@rt-rk.com.com>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <leif@nuviainc.com> <leif.lindholm@linaro.org>
 Paul Burton <pburton@wavecomp.com> <paul.burton@mips.com>
-- 
2.7.4


