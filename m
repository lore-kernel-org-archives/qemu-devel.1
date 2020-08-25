Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 380A6C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:59:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3E642071E
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpGSKVI3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3E642071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgyR-0005JI-7h
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgxA-0002Mt-MU; Tue, 25 Aug 2020 17:58:04 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:41522)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1kAgx7-0000Xv-Kp; Tue, 25 Aug 2020 17:58:04 -0400
Received: by mail-qt1-x841.google.com with SMTP id t20so12959qtr.8;
 Tue, 25 Aug 2020 14:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BxaXqcaJ3YwDhwzhxTIh6QGfPMHlC2aIVJsVz9sdbO8=;
 b=FpGSKVI3qXQ3oio0PJag6nDdy1m8OdH64jqMd0u+rXAuaPqHWjM3ONKUfL9eqN1mHJ
 zaQEsqq6SxPq2pRhqBzlxGL8MjU6toiWzyM5HmzzEOUymbWYdV7/4CtKtlrFJ2ZFdzdH
 5aemhdhwJb9EuJHpvic9qeYcmr9igiWR7bjOZROQiaYgdR4NgyD21j45Uj/QMUxbJPg0
 NQSjpqKYnN6uUFch6vENzWFPn88PhzICRV/dMH0V4rrnfJN49/g39Ca5bl03THu3Pm4k
 sL6gokH5Vvd19ZLxjt2lMitkbMP4muRZaOB7eQ0arrr6kk7gHWHJc4LlWyZLAlNXu64u
 9SqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BxaXqcaJ3YwDhwzhxTIh6QGfPMHlC2aIVJsVz9sdbO8=;
 b=KrOZlaywhc3pUlWVszXAUSoVMs1/rnp2r26RdfLmJJpLUHy4DTFaIhRgqbf1th+05s
 lVcrxXMSDtDoTaohlYJTzhkSXNWiG9RoMwTyJuXwgZIyyNhIkBrfQpoSxg25tvVKEOdD
 sM60R9wB4BsafLWTrGEqbnI+jkk9X9rOPjEchfb+dmlY2mV5P+ZhkjjQ3cnkDaDuhtx6
 KkDFaCeYXboFd/Ho71nxca5dfjhfL5Nv6bBBpsMzbSuU13Bhth2NfUVca02iAvxG41Yy
 Bl9y2HdOEwdnVBk7SmHdojxXm/kY8FWjOmrZBJIqQxfh2erysYUhZCoeB6yi3ZB3UDOl
 5Wmw==
X-Gm-Message-State: AOAM5336ytvMd+TuA579kK5ukiT4TiYcwiNl9VNEBEfdbDmR9A4ykNMe
 Mi6agvH2hU98KCa5DsBoEgQc8P2oLhM=
X-Google-Smtp-Source: ABdhPJzaNslfl68zZXHGcHUJ+d7FEbEbJpB1blKIp2UHAAYJCZucFtMtMe+baUyA0xIViVAUemIZoA==
X-Received: by 2002:ac8:1488:: with SMTP id l8mr11429791qtj.131.1598392680184; 
 Tue, 25 Aug 2020 14:58:00 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7c7:c152:8180:e1dd:d6ac:1152])
 by smtp.gmail.com with ESMTPSA id z2sm347362qtu.11.2020.08.25.14.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:57:59 -0700 (PDT)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] ppc/spapr_nvdimm: use g_autofree in
 spapr_nvdimm_validate_opts()
Date: Tue, 25 Aug 2020 18:57:47 -0300
Message-Id: <20200825215749.213536-2-danielhb413@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200825215749.213536-1-danielhb413@gmail.com>
References: <20200825215749.213536-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::841;
 envelope-from=danielhb413@gmail.com; helo=mail-qt1-x841.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-ppc@nongnu.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since we're using the string just once, just use g_autofree and
avoid leaking it without calling g_free().

Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ppc/spapr_nvdimm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 81410aa63f..9a20a65640 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -33,7 +33,7 @@
 void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
                                 Error **errp)
 {
-    char *uuidstr = NULL;
+    g_autofree char *uuidstr = NULL;
     QemuUUID uuid;
     int ret;
 
@@ -54,7 +54,6 @@ void spapr_nvdimm_validate_opts(NVDIMMDevice *nvdimm, uint64_t size,
                                       &error_abort);
     ret = qemu_uuid_parse(uuidstr, &uuid);
     g_assert(!ret);
-    g_free(uuidstr);
 
     if (qemu_uuid_is_null(&uuid)) {
         error_setg(errp, "NVDIMM device requires the uuid to be set");
-- 
2.26.2


