Return-Path: <SRS0=dPN4=5U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555AFC2BA16
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B320206F5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2020 08:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d98Uhjb/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B320206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKeC7-00078J-3X
	for qemu-devel@archiver.kernel.org; Sat, 04 Apr 2020 04:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47547)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <arilou@gmail.com>) id 1jKeB7-0005jA-38
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <arilou@gmail.com>) id 1jKeB6-0001tr-6w
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:21 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <arilou@gmail.com>) id 1jKeB6-0001t9-1g
 for qemu-devel@nongnu.org; Sat, 04 Apr 2020 04:29:20 -0400
Received: by mail-wm1-x343.google.com with SMTP id h2so1455966wmb.4
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2020 01:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=d98Uhjb/5WsY5PZfure8a9iu/Xrj3F1GYFK4Yzy2YNhLI5mo6MYqW2UpuuLNVnDBud
 3JJY9PfS1W/GgFcWg2jZe3gQHUjvgPzNzPnE2gIzGzxEFPO866TTQRIq7X5heUP4L1+5
 nuRamnFHJFXb7fQrcTmtayLlkxgzp/aWHY6/3V1cYgk9XjKAoYBLd3/1rONBpjwtIr5N
 cZ5oGG60OzQwasATotUke8/QkFlghTef+d+UAhZJGE7DFdM4NyG+n97CJzM2d1P2reN3
 qMeZodwnuRdGbmyx+Y/pMBUTWkgh8smdLLbTrBIcwQsnEgaScbVErA0vC6yR4ipnnpI0
 zNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZGszGX7/dlFFly+wjt/H+SDs19eZmIByirBcMM+A3k0=;
 b=nWyduu3t+3PhJ2lBAEBaYdedKYUYs+S6WkZiytKuhBn2+NNmVkOvqIOSRQ0ir46bFu
 oVRhw3Jn2aRVfPZezAxu6R9gCnAG8YMbV0CPLpiIsj32LO8JqjVTBfV2nl+ev/7pWMAG
 NM/kyXUqaw1Dq6G9QkOkfJw3HGiWI2uqlTM9SuR0eFxzZHkeCNTjJTS/1Diy7QGbOYnc
 9PgDfG3zwZrzaUE/GNJfGDekuy1RDbG8xPTB02WJnduuWXURugoxW0RvPExbpn8sHNXl
 ceppVfg5KgVrnfmIbk06yxMRwkB7F3yjr3mNv6I//a8DPVHKDX/73RZKVmeWrgwDJzOZ
 RIlw==
X-Gm-Message-State: AGi0Puad79yiuEKc4t44vYW+/CQH0fQvs9ejbxuNbjD9hW1GSD4JfX2j
 dGYtawtI+JHPdkrw2kRXNmS3r8QG+ibOYw==
X-Google-Smtp-Source: APiQypLbDr0KzIjLr/in3SPg/3OxM21h1VeFknW1n80N9qiRQyICQUWMrwC8sv/klTQk0o0nwBH1oQ==
X-Received: by 2002:a1c:5ac4:: with SMTP id o187mr1529335wmb.79.1585988958774; 
 Sat, 04 Apr 2020 01:29:18 -0700 (PDT)
Received: from jondnuc.lan (IGLD-84-229-155-40.inter.net.il. [84.229.155.40])
 by smtp.gmail.com with ESMTPSA id
 a10sm15884778wrm.87.2020.04.04.01.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2020 01:29:18 -0700 (PDT)
From: Jon Doron <arilou@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/7] hyperv: expose API to determine if synic is enabled
Date: Sat,  4 Apr 2020 11:28:54 +0300
Message-Id: <20200404082900.33711-2-arilou@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200404082900.33711-1-arilou@gmail.com>
References: <20200404082900.33711-1-arilou@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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


