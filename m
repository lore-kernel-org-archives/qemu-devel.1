Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A5AC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E24B520700
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D62jLyco"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E24B520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxZQ-0005gU-N1
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53944)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXs-0003WP-5K
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jRxXq-0003dz-HI
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:03 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40322)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1jRxXq-0003Zt-1s
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:35:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id u16so10511724wmc.5
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=D62jLycox9T9cbHAFuqYZ2dPl0qnHspWnFVq8fc6TPKi2ttn9Mv/90JXo5V5ZizFf6
 P1rkZ2P7I3+Ie2LjRRoUtIMQXgwIa+gyhmoatUwmPBBYz4Kp9ezN+CNAHBI1TDBaOCxC
 sDb9D/R7SnpjuvK8WB8IGQ4jw5Jgx6180MOCXWJAu35KqZDUpXtzQY1zIgz9WlqVpbUy
 bcthAq9Ba8VSRx7xsab3IRkkm11ucFWrUloyYxNdVBA5AyFg3do7d1qZyWcks9nlnZ7h
 9MmKHhYDv0muIUyUFS+MrUGTPDAmizc3bU7wyRq0RlL/wmpLHhib9Rkeub6X9coIJYOs
 GCCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=imvgrh5CLRXjGRf8oINjCuQbqKhClC+atzlLnIhVByzp+EATLDhAW4ZzzsZSWk7pFQ
 njlJljctU6juiCxP4WrhYZA/1CemZYXAjtt7LwiLmsKplFNB4lyTP3iF0q5KlSmTS90p
 InIk+dxzuQEczr0zMzyBFRWUAma0gRuOLRk/rmQvYcwJsHDZuzGzGBVYnYR3+NOfPvmp
 Njbf74EEUc/k6t9J1uB0mDWEQ4XitXqF9ddeAz8olybE4bem7yJfmyj9lGFNoPJ2BtiO
 MeG9j9phxvNQzYd2bahEDN/bihQ2W5IED4vRdELIyuP80f1S81fZ7yGqFuUJsFZn0ow/
 w1qw==
X-Gm-Message-State: AGi0PuaHdLi8wmMC1ccKns1W5nhuGXgo4NfQTWZq8Qde/jq/az1c1TKg
 mSwB/bVl57uCGX+fkv/HuAjHMh23pm5rBQ==
X-Google-Smtp-Source: APiQypLMKTtxq71ZQJYQZgLJOi/DlFxaNthIohpZEp8GGJeuPa6EbLqlZp8vzqHcUiiFoU4wWw56BA==
X-Received: by 2002:a1c:8106:: with SMTP id c6mr9848392wmd.88.1587731700351;
 Fri, 24 Apr 2020 05:35:00 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-154-20.inter.net.il. [84.229.154.20])
 by smtp.gmail.com with ESMTPSA id
 91sm8462859wra.37.2020.04.24.05.34.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2020 05:34:59 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/6] hyperv: expose API to determine if synic is enabled
Date: Fri, 24 Apr 2020 15:34:39 +0300
Message-Id: <20200424123444.3481728-2-arilou@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200424123444.3481728-1-arilou@gmail.com>
References: <20200424123444.3481728-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=arilou@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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


