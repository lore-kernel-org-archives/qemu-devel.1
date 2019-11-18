Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17660C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB95C22311
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 21:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+2Qho2v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB95C22311
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWoPL-0001p9-HT
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 16:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1iWoN8-0008R6-Rn
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1iWoN5-0005iU-1c
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:46 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1iWoN4-0005hz-Sj
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 16:15:42 -0500
Received: by mail-pg1-x544.google.com with SMTP id z188so10239807pgb.1
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 13:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=diXnF1IPkkxinXlGIqTBKK6HjgFjUcsfRfseHjAG8V0=;
 b=h+2Qho2vTpunhRLfbyinfHSPOa+YoaWCod/ZWn6WgkDrMlTjLAmIGN/bNzgia5xPpk
 YRk7BKwtye0qLaJijKZ+PfGxmnzlLWXYqbsv0Bk3hwxphR7kSPhEUt3+nyK3w3Z/p1fL
 1WtJMn6s0cGQ+pfsZW5C0KmmJ+QNXfbbQq/JRVQGl8Ao5WBxAlibD1bk+vnlpfMDAqn+
 wlgj9DEZe0ZqnxsboGd8Qh/X+qVvbXWyAs765Mem3hW5tAGlbWn2YaX/kuDhEdjeAJGa
 jXnnDaES1oFauz2IQ50oizgSXt+2az0+WcGe5Y4GDpUFm2nW35DUOhbo+ob1ucfi1Sp7
 nHRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=diXnF1IPkkxinXlGIqTBKK6HjgFjUcsfRfseHjAG8V0=;
 b=Kt4hV26hjg51C4Pes0FkFZ30FKMR5GgshlenpSDinP9elN29Wq+h1jMvEU1XhuoMyY
 xrPsiVJ0MKejaF9TOPognr9IB8/86/p/F2k3Gb+4PVYb1+JmB0APVuB4+C2QIlSqCDUn
 Fw/e4tqbchS5Ke5ZZ93anbFFMn/JNfXj/vDIoaj34EHj5szbZGfoig6qU3FrtchN/pEU
 EUnz+LPezvSirQVkeIqYCkPQz4KXcgMmjZoC6AJoaA0MUqF6+harEIENvyJ5oruiOlfP
 chiju0tN+XedjgFZcQoUVeyc8NIUDphZPHVuAQV5XCsDmPme4oLcVJoeZACmgXEn/FQs
 pFeA==
X-Gm-Message-State: APjAAAWmCFfZ3gA8TtTiJ622D9f4Tf9qZoJVwYFjt4cXsXZDCfrkXTOu
 Xuivo/zW79dst4aVyx4FE9aVglbKrko=
X-Google-Smtp-Source: APXvYqy+2N1iB+YkTEY1Jy2gp5MiS4ziTHhcp2pczMV9uYFIrZPhC8TlbLsoA4y6y+5U9hJVQQ0m2A==
X-Received: by 2002:a62:e914:: with SMTP id j20mr1510186pfh.245.1574111741581; 
 Mon, 18 Nov 2019 13:15:41 -0800 (PST)
Received: from Rfoley-MA01.usrd.futurewei.com ([12.111.81.71])
 by smtp.gmail.com with ESMTPSA id v15sm22301728pfe.44.2019.11.18.13.15.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2019 13:15:41 -0800 (PST)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/6] Fix double free issue in qemu_set_log_filename().
Date: Mon, 18 Nov 2019 16:15:23 -0500
Message-Id: <20191118211528.3221-2-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191118211528.3221-1-robert.foley@linaro.org>
References: <20191118211528.3221-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: richard.henderson@linaro.org, alex.bennee@linaro.org,
 robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After freeing the logfilename, we set logfilename to NULL, in case of an
error which returns without setting logfilename.

Signed-off-by: Robert Foley <robert.foley@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v2
    - moved this change to the beginning of the patch series.
---
v1
    - This is new in the patch v1.
---
 util/log.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/util/log.c b/util/log.c
index 1ca13059ee..4316fe74ee 100644
--- a/util/log.c
+++ b/util/log.c
@@ -113,6 +113,7 @@ void qemu_set_log_filename(const char *filename, Error **errp)
 {
     char *pidstr;
     g_free(logfilename);
+    logfilename = NULL;
 
     pidstr = strstr(filename, "%");
     if (pidstr) {
-- 
2.17.1


