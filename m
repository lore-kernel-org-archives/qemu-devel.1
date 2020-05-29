Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91451C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 609C820721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 13:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uNCgit04"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609C820721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jef0T-00066r-IZ
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 09:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezC-0004P7-Ep
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:46 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:52840)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jeezB-0003bU-Li
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:23:46 -0400
Received: by mail-pj1-x1042.google.com with SMTP id k2so1336581pjs.2
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 06:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=kxh2o1V8iXkuJj8JRvzQtcAUGmlKoLZ53V+la2Fi9CI=;
 b=uNCgit04YDQHmsPJ1hn7g7A32J2F8OcqB7Rbr+VquM/4XMzFKyNMa39Dr/lp9j4azi
 Fkr347gghRRa916B+smlsQwc/VKEnH0AJLbM0uz+MYMyX8OklDFEa0jrIpud1crr7JLV
 OD88Z6cbc6GMRmbu55lJ/LgXwFsaDy/P4fH4vrDtnfT+S84sVaPDDi2pkJg/kh5JhbbE
 iafLk65UrDREY3I6L/dSzQyb26GWH2wOiqlcBMiD8TMFzBBCU8GIXOyzTSYp0r38TLwj
 vqCT9rq1SYExuW4sWWT+hkVbFFcHAstsfkg1vpPHuYURrPRp2GGxYdklkmxcjj0sYWsL
 7a9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=kxh2o1V8iXkuJj8JRvzQtcAUGmlKoLZ53V+la2Fi9CI=;
 b=XS3ZY3KEwDJ88QUd+I6HFkQs3SwlICuqQF8SYLETLUlOgmjGrCzceGraIOokpyVtdf
 EtN/DIIDokscLH0wRRH8qtSSnxikbEBNWSKv1uauzEkazu3jJQTrEjrwyu4d2IsYLarG
 jy9stZ20VB8IIu0AmEXWSiJEyUCqO8a9wuE0PPqFJVnrVOm5Ne6VYSVbjwp4/rler7gp
 INqf3S5rS2Rls5gUH8QAatYMlJ1MH+BzPdB79V29e+b8S+z6+fPGIDjExjCN/CToa2nW
 wfEoiVXa7rkMD9a3Th8rL+91+WnZ/uIF/hKs50pyT/oZpU6TwbhIDVN2VnAlucyQB+Zc
 ft9g==
X-Gm-Message-State: AOAM530+ZW2WTmxQBZpFFM8cSSnWju3k8Izoi0b7yytFBAtIKWluYRTd
 1YqvfJHM7Z0lCnc1AzXm9NzqO8sDi4SvJw==
X-Google-Smtp-Source: ABdhPJwKd+tqq3huXh4No03f70CMmaWJufj2EydvvgX4qvgEYOaDtuoKAmzjtudKsR8imtSFsSx2sA==
X-Received: by 2002:a17:90b:d8a:: with SMTP id
 bg10mr9416204pjb.103.1590758624015; 
 Fri, 29 May 2020 06:23:44 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:75ac:d268:da04:dde4])
 by smtp.gmail.com with ESMTPSA id e13sm1998686pfd.10.2020.05.29.06.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2020 06:23:43 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 05/12] qht: call qemu_spin_destroy for head buckets
Date: Fri, 29 May 2020 09:23:35 -0400
Message-Id: <20200529132341.755-5-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529132341.755-1-robert.foley@linaro.org>
References: <20200529132341.755-1-robert.foley@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=robert.foley@linaro.org; helo=mail-pj1-x1042.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: peter.puhov@linaro.org, cota@braap.org, alex.bennee@linaro.org,
 robert.foley@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 util/qht.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/qht.c b/util/qht.c
index aa51be3c52..67e5d5b916 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -348,6 +348,7 @@ static inline void qht_chain_destroy(const struct qht_bucket *head)
     struct qht_bucket *curr = head->next;
     struct qht_bucket *prev;
 
+    qemu_spin_destroy(&head->lock);
     while (curr) {
         prev = curr;
         curr = curr->next;
-- 
2.17.1


