Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035ABC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9A52146E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 21:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="okw/qoRU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9A52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCsAb-00083Z-IW
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 17:16:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw3-0002Zx-KN
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iCrw0-0004Uk-MI
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:23 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:46901)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iCrvy-0004T8-Lk
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 17:01:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id o18so3608426wrv.13
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 14:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=b6FIcOabpKRLlHH33rbrRAMy6kyScJiPH3lkiBmUDds=;
 b=okw/qoRUVaUP/y63sa59+x14iASUzjA997Bg85Hb/qlfO3by5/lp2CZCX/bsr21heB
 NyjeN9zGqqv6Jz/r2BTHxnkp/KzgYuPQyxdFmv6KBfpOPwDbUk366khyDIj21MJu0o7J
 dJBc9ifuK5Uz1M9RgNTxqc5kf67lSfeNJeF5fn/a00Mo4n4N5e2uFWTvvHdPUDSlfvdV
 wBfqHexJjL4GkpSzVuq4T5QZjdB4yyxZd5vAKBsWNXRTjDIRGMmoVNgw5Pszxf48lnvu
 vMwg36FNRl5UBA4RkY8EfjSj3gse3Ij3XWgbIbB7Ngg6MaZbcL75b2GtoHoH4Hq5KKCU
 lSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=b6FIcOabpKRLlHH33rbrRAMy6kyScJiPH3lkiBmUDds=;
 b=BVvuFyQWChSx99IE63NFmLIN2R0b4Yg3iHUsVQVJDAuvGcuMsB+S78E659S+WfjjUJ
 SfKkgN7J29CKOv/nR3qA5DMLmeLTH9SrCxBWhgD1TukfGz19GtEkjzI5m4zpT2nHX3Qw
 JkgIc9+yrdhf9AD4uVF/WKeyCUdTElCihB/RpErvrtCV99B2979nB3oR5qcNKPywj7gC
 0aX18IcPC6eB4A8jIOcLQsV1te7KQlYo6oVVaT1wcYSawO6NrHfFglwMBtWUUnefoZmp
 pWiVFvXsmigxDOOjC/tHGqlvgmQ6OIekWY4y/Ct4k5LeIF2oqmdjadqbtWZisKvCsFsH
 CDSA==
X-Gm-Message-State: APjAAAWzIhcwh1XpKLEw5pyPm5h0iipr2C8yDyd6VZcxnwt6D5is8TI5
 +zu6YEPIMb3h+5l4a8gDPRbm4w==
X-Google-Smtp-Source: APXvYqx7vw2SVlCw+GiALEYH1OQxA7QfRBWPOlfklIqIeVkQEJyv/bduR6GWphoQCluFWaLeJrR1cg==
X-Received: by 2002:adf:ed05:: with SMTP id a5mr4850644wro.35.1569358875236;
 Tue, 24 Sep 2019 14:01:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n22sm998996wmk.19.2019.09.24.14.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 14:01:11 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B4C091FF9A;
 Tue, 24 Sep 2019 22:01:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/33] migration/postcopy: Recognise the recovery states as
 'in_postcopy'
Date: Tue, 24 Sep 2019 22:00:43 +0100
Message-Id: <20190924210106.27117-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190924210106.27117-1-alex.bennee@linaro.org>
References: <20190924210106.27117-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>, jsnow@redhat.com, f4bug@amsat.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Various parts of the migration code do different things when they're
in postcopy mode; prior to this patch this has been 'postcopy-active'.
This patch extends 'in_postcopy' to include 'postcopy-paused' and
'postcopy-recover'.

In particular, when you set the max-postcopy-bandwidth parameter, this
only affects the current migration fd if we're 'in_postcopy';
this leads to a race in the postcopy recovery test where it increases
the speed from 4k/sec to unlimited, but that increase can get ignored
if the change is made between the point at which the reconnection
happens and it transitions back to active.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190923174942.12182-1-dgilbert@redhat.com>
---
 migration/migration.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 01863a95f5f..5f7e4d15e95 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1659,7 +1659,14 @@ bool migration_in_postcopy(void)
 {
     MigrationState *s = migrate_get_current();
 
-    return (s->state == MIGRATION_STATUS_POSTCOPY_ACTIVE);
+    switch (s->state) {
+    case MIGRATION_STATUS_POSTCOPY_ACTIVE:
+    case MIGRATION_STATUS_POSTCOPY_PAUSED:
+    case MIGRATION_STATUS_POSTCOPY_RECOVER:
+        return true;
+    default:
+        return false;
+    }
 }
 
 bool migration_in_postcopy_after_devices(MigrationState *s)
-- 
2.20.1


