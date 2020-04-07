Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99536C2BA16
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:53:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BEE20747
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 05:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlOb8lPV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BEE20747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLhAb-0005ry-F9
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 01:53:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jLh9k-0004Y9-2Y
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jLh9j-0002Us-2E
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35661)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jLh9i-0002UR-St
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 01:52:15 -0400
Received: by mail-wr1-x442.google.com with SMTP id g3so2413948wrx.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2020 22:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=hlOb8lPVwlbSKrVCLmDsmo0QhXmf6m/HN2h3+eWUpL7ylAjEneopn3/4zPQCbAevDf
 UDcoVmwYCUnnpZCc4W2wwbGrrCzHCRId3jfunybglVY1h81LTU1ofZFp7K+G2n2cuBsh
 Ln0RoMDm7HH6xFFJd0o7O/mc8KSlfUJLNLWq9AK923R2IT1rc+JVuVL314M8XK4FNiZt
 yV9t/v3osWRqn3+RxXQzAmnjwOkyfhLzhzTT+5IcfmWwlm7FeatOZADtIeviPHvLIfIO
 C0vkw3PbESEGvOjVSk49/ebSyyV9HLja/K/8ud+fqiOYreJaXWFkrmH85ejyUiQvJTBW
 cEDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=FjcpP1pmLkZ1tykLhuYoTP2WLLBc7ODdvyinJYGxa9L4f2uw9vc6NaccZWRgt9hXDK
 RORiWY6huamB77QIzZcevtY9OYA0K22LZZp8xUCkikPBgtOLD//ZNComSELLEODB6Y4+
 pTveCXk7LSKH29/Nu6OJHQ/OkbieVl3ou7GMVqemrSA/zk2kGr+9ud6fWOy1r+uEjZ1N
 X8TPIcaNJAr6Qu1+o3k1+EKV7Yqn6yci9QaPOXhYuNTFF/VwiAuMTjWWJprn+WsjAaWO
 xXy8ObwKwlG1GMN3f+qkHyITqSz0NF5PgI9AppBVsN0uHYyf6CAeTdeiNY2UhLH2wQ8X
 qxnw==
X-Gm-Message-State: AGi0PuaBULWNBy93b1blibcrjbsO2memaAEyNc7vLqMoL/3YwR4gV4/E
 HhNRYM08RTDXnNXAuqoWd7JYhhM4pvQ=
X-Google-Smtp-Source: APiQypIIzwqu4Qbwq8TGSv/PB41OhV5iPGHSaBV6M/hiOBKzE/hSb/ppyJLW4HPY6BCvAuzaj9ok2w==
X-Received: by 2002:adf:ee42:: with SMTP id w2mr766510wro.8.1586238733861;
 Mon, 06 Apr 2020 22:52:13 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-55.inter.net.il. [84.229.155.55])
 by smtp.gmail.com with ESMTPSA id
 n11sm32271007wrg.72.2020.04.06.22.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2020 22:52:13 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/7] hyperv: expose API to determine if synic is enabled
Date: Tue,  7 Apr 2020 08:51:50 +0300
Message-Id: <20200407055156.137249-2-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407055156.137249-1-arilou@gmail.com>
References: <20200407055156.137249-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: mail@maciej.szmigiero.name, eyakovlev@virtuozzo.com, ehabkost@redhat.com,
 rvkagan@gmail.com, liran.alon@oracle.com, pbonzini@redhat.com,
 vkuznets@redhat.com, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/hyperv.c         | 8 ++++++++
 include/hw/hyperv/hyperv.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index 8ca3706f5b..ddf4f32c60 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -37,6 +37,13 @@ typedef struct SynICState {
 #define TYPE_SYNIC "hyperv-synic"
 #define SYNIC(obj) OBJECT_CHECK(SynICState, (obj), TYPE_SYNIC)
 
+static bool synic_enabled;
+
+bool hyperv_is_synic_enabled(void)
+{
+    return synic_enabled;
+}
+
 static SynICState *get_synic(CPUState *cs)
 {
     return SYNIC(object_resolve_path_component(OBJECT(cs), "synic"));
@@ -133,6 +140,7 @@ void hyperv_synic_add(CPUState *cs)
     object_property_add_child(OBJECT(cs), "synic", obj, &error_abort);
     object_unref(obj);
     object_property_set_bool(obj, true, "realized", &error_abort);
+    synic_enabled = true;
 }
 
 void hyperv_synic_reset(CPUState *cs)
diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index 597381cb01..a63ee0003c 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -79,5 +79,6 @@ void hyperv_synic_add(CPUState *cs);
 void hyperv_synic_reset(CPUState *cs);
 void hyperv_synic_update(CPUState *cs, bool enable,
                          hwaddr msg_page_addr, hwaddr event_page_addr);
+bool hyperv_is_synic_enabled(void);
 
 #endif
-- 
2.24.1


