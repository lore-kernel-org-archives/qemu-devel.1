Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DATE_IN_FUTURE_03_06,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06F5C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:07:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19C4B2226A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 14:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="fABPhvIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C4B2226A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48146 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGjiL-00031Q-3D
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 10:07:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43948)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGjgy-0000Rn-18
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:06:20 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:41906)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dereksu@qnap.com>) id 1kGjgw-0000E2-Dt
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 10:06:19 -0400
Received: by mail-pf1-x441.google.com with SMTP id z19so7417759pfn.8
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 07:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=yc2O5Wa6K6s4opTbeAyI6WQxmH83VIozCbZYKuarzYI=;
 b=fABPhvIHsGOtdCzRLODjmuzrf9huLHT8rHEfaTldnzjJ/1TKheQPOAuY5IPEtXEgV8
 qznkJl/oiAUwcDbmm/u0B9fQRVbrP9jJ0L350R0648Bj5EbrOLJxQJxNwQ3vVvX+xHNN
 Ho8bGaJks7RgdqJv9fyEgjBDB//5I6/dk8VdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=yc2O5Wa6K6s4opTbeAyI6WQxmH83VIozCbZYKuarzYI=;
 b=CRwMC7rSuV+P4fhBnU6lBiAvQqDQRq0EaRoCBJFy8tyfpsTdOvo266SEYUj2p9Wwg6
 4Lh2QCvu+oqiVGPB5BlsJSzXlMXF2eIyjWNUYw7AAKlFf0ChZLnJ7ggGOSmHUIGxyMF7
 HUA6e50oZTDnRtuOxFprjV3qpHxx0y3+ohpJN8erHVB3oiCJzpDpWMsgNqb65TRsjiO2
 Nm/ISuLYEPTETUqmTOC+WgqAY83Wqt3rYYzMYPPkOBTrt6yuesxaCC8/4zMfPz+cqedQ
 EwWArSTGM47W3LHbCuS/bXV4mXH06vBzedHhHeTOwFc4vlNShnep7v5vQeDXJj0ys7CM
 nBnw==
X-Gm-Message-State: AOAM532auupNyUqaWegMfVgSHYYLzPauAxYbwR1YX0QIOUhcqlO4XBXX
 9QCBBcLpiorYY+VcaLu6radekBNh14LdpRwq
X-Google-Smtp-Source: ABdhPJwaZNt8NrtJzoOjROFSwdGDPoW50tNgRYYSeS++iAWScQuZIqevHbp/ZW5FBEgUrjwZF1y9+A==
X-Received: by 2002:a63:1464:: with SMTP id 36mr1773248pgu.160.1599833176668; 
 Fri, 11 Sep 2020 07:06:16 -0700 (PDT)
Received: from localhost.localdomain (211-23-39-77.HINET-IP.hinet.net.
 [211.23.39.77])
 by smtp.googlemail.com with ESMTPSA id y5sm2203179pge.62.2020.09.11.07.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2020 07:06:16 -0700 (PDT)
From: Derek Su <dereksu@qnap.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/2] colo-compare: Fix incorrect data type conversion
Date: Fri, 11 Sep 2020 19:05:07 +0000
Message-Id: <20200911190508.1316487-2-dereksu@qnap.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200911190508.1316487-1-dereksu@qnap.com>
References: <20200911190508.1316487-1-dereksu@qnap.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=dereksu@qnap.com; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 43
X-Spam_score: 4.3
X-Spam_bar: ++++
X-Spam_report: (4.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_03_06=3.027,
 DKIMWL_WL_HIGH=-0.001, DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Derek Su <dereksu@qnap.com>, chen.zhang@intel.com, jasowang@redhat.com,
 lizhijian@cn.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix data type conversion of compare_timeout. The incorrect
conversion results in a random compare_timeout value and
unexpected stalls in packet comparison.

Signed-off-by: Derek Su <dereksu@qnap.com>
---
 net/colo-compare.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 2c20de1537..c4de86ef34 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -619,11 +619,12 @@ static int colo_packet_compare_other(Packet *spkt, Packet *ppkt)
                                        ppkt->size - offset);
 }
 
-static int colo_old_packet_check_one(Packet *pkt, int64_t *check_time)
+static int colo_old_packet_check_one(Packet *pkt, void *user_data)
 {
     int64_t now = qemu_clock_get_ms(QEMU_CLOCK_HOST);
+    uint32_t check_time = *(uint32_t *)user_data;
 
-    if ((now - pkt->creation_ms) > (*check_time)) {
+    if ((now - pkt->creation_ms) > check_time) {
         trace_colo_old_packet_check_found(pkt->creation_ms);
         return 0;
     } else {
-- 
2.25.1


