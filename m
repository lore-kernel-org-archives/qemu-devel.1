Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17CA62074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLy4Oa17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CA62074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9Vy-0005B4-91
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9V7-0003RF-9W
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44877
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jh9V6-0006OK-Fv
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:23:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591352579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DeVz5TjKOT0p1ZFW/1IBT7jKGkXxB4CDp7QQNIm666M=;
 b=HLy4Oa17h2tXnzH+OkpvMJaM/MP2JfZRlFOKQ8Td/k6o23feKL+l7rgdX68W1hzOEoVeBC
 TgV7edLAAXiETNxzfXUKw3qa2E6xiTBmVJ3A3DtooNCdsl3WwUC69B4WZM5z0E2HHAErdK
 AnDJYPgMyCX8PXpSFFYthttREpsDvJY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-eWR5RYyBOKmLulT-kPVckg-1; Fri, 05 Jun 2020 06:22:58 -0400
X-MC-Unique: eWR5RYyBOKmLulT-kPVckg-1
Received: by mail-wr1-f72.google.com with SMTP id c14so3573641wrw.11
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:22:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DeVz5TjKOT0p1ZFW/1IBT7jKGkXxB4CDp7QQNIm666M=;
 b=oyMwLpVlXcIRuDbVOUS6Vw6EvYtcuW7WeI0bEyDhUavNNs7q0XqG41vMhDHXENa7A1
 6dV5NGEP6VKOb/PSSoYBmdIzbI0sEPLKA7JWx1D8xbcm/HHVHTMwqgDLSr4cKSMF7f9K
 z3PYsxmcStDRd4H0UQw5AyS77Z2b00lKRPPxC4wl69VLCVIzIBUUy67O8NN09MZ9aRHl
 MI+wF13uhq77jRA+8sk9jrTlMXkXL54J7e95wJ35ot9OwNLv4SGOPLH71oL/YCy2DMiB
 ukHjUslvBtJfNUwvAEBtuph0AJDqqlcmHsAd8ELPjJvrN1kxzmponChFOXOVo/8Yntng
 O1AA==
X-Gm-Message-State: AOAM53149wS+oahxPzrzbV+LSpgkY008l//CVdONAjWa62MN3RjCxHQd
 K5XKwzQ5rf2Spsq8zQzxmKy70Ujj7iFdIjbPmzf1Foe3doWVTHoCCOqijA0UjFqg54qK/bOczk6
 6TkWS5EkPPIZ5+Ko=
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr9311391wrx.66.1591352576822; 
 Fri, 05 Jun 2020 03:22:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrQiGjAj+NyAbVIPKTVgxw4iqRdgUoSbvheMGP576Mae2prfljWl2HDLT5wuBcRyZlT0s1ww==
X-Received: by 2002:a05:6000:18c:: with SMTP id
 p12mr9311373wrx.66.1591352576663; 
 Fri, 05 Jun 2020 03:22:56 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id h27sm13726018wrb.18.2020.06.05.03.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:22:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/11] hw/sd/sdcard: Update the SDState documentation
Date: Fri,  5 Jun 2020 12:22:24 +0200
Message-Id: <20200605102230.21493-6-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200605102230.21493-1-philmd@redhat.com>
References: <20200605102230.21493-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:35:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Add more descriptive comments to keep a clear separation
between static property vs runtime changeable.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 4cc1ecf9f9..9bfd65ac34 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -92,11 +92,14 @@ struct SDState {
     uint32_t card_status;
     uint8_t sd_status[64];
 
-    /* Configurable properties */
+    /* Static properties */
+
     uint8_t spec_version;
     BlockBackend *blk;
     bool spi;
 
+    /* Runtime changeables */
+
     uint32_t mode;    /* current card mode, one of SDCardModes */
     int32_t state;    /* current card state, one of SDCardStates */
     uint32_t vhs;
-- 
2.21.3


