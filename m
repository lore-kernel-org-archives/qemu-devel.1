Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E367DC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:54:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBAF2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 07:54:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU6xdCpJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBAF2074D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl6QJ-0000PM-V0
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 03:54:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NV-0003eA-6z; Tue, 16 Jun 2020 03:51:29 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jl6NT-00084A-Jj; Tue, 16 Jun 2020 03:51:28 -0400
Received: by mail-wr1-x443.google.com with SMTP id r7so19697962wro.1;
 Tue, 16 Jun 2020 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=u02Arpcubj9mPZ8wYNHVoADOr5FJrLRUYb2irB7o4Ig=;
 b=NU6xdCpJWWMjotGt3hh8qLQaEU6IcuR807+1T9o24PWWNqD9Vogza4t5sE/67Lc+Ul
 RGfzxZSZE3DbR+GqQrdbaiR5Itv2TJ5BXlyrssUbjIyUavUjrD2sL32ipexO5Un6L8HN
 jChBwkWzR2d4Cahzr2jOrEAHMxxk3Nvvv00VClpD+StLtJp282jata4OgZXBnCyzhuHJ
 fiQtd6K4ljhhVoDkTZI+jjJkNZjozK9Q5hQMOo0FuF7f02NHidx60lb9OLa8Hq+rbBND
 c/5y0//UT6HrihapbCL3sNis3PVVmmf4Y/hXtSZpzXycZPTqZWz43ZOq67pcJlu4blwI
 cTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=u02Arpcubj9mPZ8wYNHVoADOr5FJrLRUYb2irB7o4Ig=;
 b=sB9i9cEqcfUFeFbX9TDjMgB1Y/1w+PyCoubmqdEbvZXndPVIHJof2MtTyIujEucH2O
 3tCGslzDLeAJDGv/bLqh5I5KWFvJtq+eVE2gT+bS8SCKK535pXBnjnt4h9D2iqJJ7bfL
 r+T9qNCNLXR0X99sj3Hm9saUU0UCMat+LJvQXoVclGWYhwgOTsY2Tu2X6HyAUIaV916W
 zj6hkcCzTUC7X5MlTllv5MgvquBTOb47pIZ6KN12ASOhoCAiCWVWe2TYWKIoY+/yR9v7
 dR0HzCujmJnyLntEnvtF0t1SGlcYiYjtS7QRdaxoSKj90GPcNSPdiFhtdz+7YSlzQ9T0
 WM/w==
X-Gm-Message-State: AOAM530HZnPY6nW8AXq/VGctOoOsdsFWEYsoLFQKkqOONIAOMtpAt6n+
 UA6rMSmt/e1N8BZ+8EnIONFRR7NQ
X-Google-Smtp-Source: ABdhPJyvI98LxdXs/QaF0wr5dlrQ7y8cygnVOjolGcediY1CUVmrWxnbvLxbeYibXrGIgZMBGQIhoQ==
X-Received: by 2002:a5d:4f09:: with SMTP id c9mr1617618wru.3.1592293885188;
 Tue, 16 Jun 2020 00:51:25 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q11sm28093538wrv.67.2020.06.16.00.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 00:51:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/7] qemu-common: Briefly document qemu_timedate_diff() unit
Date: Tue, 16 Jun 2020 09:51:15 +0200
Message-Id: <20200616075121.12837-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200616075121.12837-1-f4bug@amsat.org>
References: <20200616075121.12837-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 David Hildenbrand <david@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It is not obvious that the qemu_timedate_diff() and
qemu_ref_timedate() functions return seconds. Briefly
document it.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/qemu-common.h | 1 +
 softmmu/vl.c          | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/qemu-common.h b/include/qemu-common.h
index d0142f29ac..e97644710c 100644
--- a/include/qemu-common.h
+++ b/include/qemu-common.h
@@ -27,6 +27,7 @@ int qemu_main(int argc, char **argv, char **envp);
 #endif
 
 void qemu_get_timedate(struct tm *tm, int offset);
+/* Returns difference with RTC reference time (in seconds) */
 int qemu_timedate_diff(struct tm *tm);
 
 void *qemu_oom_check(void *ptr);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f669c06ede..215459c7b5 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -737,7 +737,7 @@ void qemu_system_vmstop_request(RunState state)
 }
 
 /***********************************************************/
-/* RTC reference time/date access */
+/* RTC reference time/date access (in seconds) */
 static time_t qemu_ref_timedate(QEMUClockType clock)
 {
     time_t value = qemu_clock_get_ms(clock) / 1000;
-- 
2.21.3


