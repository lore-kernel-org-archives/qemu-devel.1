Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F46AC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:55:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF8C9206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 12:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAFtmbG1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF8C9206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihYrn-0002kM-SD
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 07:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57275)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3x-0007QR-3S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1ihY3v-0003ij-FT
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1ihY3v-0003ao-5M
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 07:04:19 -0500
Received: by mail-wr1-x442.google.com with SMTP id c9so2002162wrw.8
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 04:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=oWlQxy3gHFTwYR2OAKyR7heGQKIg7ID0fB2XfRVmZV0=;
 b=VAFtmbG1WmEbcoy3vxWyuytJK8xTNRjZ3LPZmlxs4bNP17hyqUAYSK04S46ixZenOQ
 l4WAw1NHT9rafXGePdqZCUW2OFy2M+jBOW3OZc9NIIlNO48HZMxSP0cCCSPhnzZWv08U
 ZJAt3jvxTHrfKq37P7IbKhWpEf80PPoTZkZoN5+GgycqhBqV3Qx+5SrXW4g8acbOjrvv
 XXbKLbilJnhZu/pRVXWz8q8PawgL6Q9apxthW1bhWFAU8WF/jSooShqm4T2Lw0/LsdAw
 GFlK5F3tuA/n2siBvkx68whLf9ygks193af8qQn8Ew/W/XPbu5g/QxblV+8utjRmutHO
 6UeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=oWlQxy3gHFTwYR2OAKyR7heGQKIg7ID0fB2XfRVmZV0=;
 b=twvufvffqheUJiqOz5t072rlAM6aWHLDKOgeKlp28ZWk87bRA09oIfCMErbcv9cYHl
 cAZESep8rhBmSawyPeNzKF8HtMgQPUh64t2zed1XqyXIvE/KyQEYi/Da0litrNoPUEuS
 AsGgjgWu6wzUAsNJcEALasym723KmzdIWti5Jgzh8SqrkyS0ah13GfDMWcR5ShZmg/CR
 iBQRm+2tgpDDSolHCpc3Y+OZbWCd6SyCdXl1mC5XoQj8fgymzP0scjuKpDqz/Wrlmb4o
 Vg8oNih83nEfs/3fSFe0B28LlBPd0hoFeYqXJjywnxu3flGmH/U3o+7s5Mq2UkvkCsBb
 ZGqg==
X-Gm-Message-State: APjAAAX+APdd4oQ4S04tzBXdKyFe+po0DcwKXU6bxyf/GM6kDVAIW4jM
 oaOhRK5h4sEGoP4rH9yzGiPoWT9j
X-Google-Smtp-Source: APXvYqyP29bwoVRnmYf5nsse0VFydatCcPFA+YCLCC3tbR3L9s+fhUFv3rntzcKIHhkkwSmrCx3SgQ==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr2494282wrv.302.1576670656716; 
 Wed, 18 Dec 2019 04:04:16 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n67sm2236838wmf.46.2019.12.18.04.04.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 18 Dec 2019 04:04:16 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 74/87] WHPX: refactor load library
Date: Wed, 18 Dec 2019 13:02:40 +0100
Message-Id: <1576670573-48048-75-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
References: <1576670573-48048-1-git-send-email-pbonzini@redhat.com>
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
Cc: Sunil Muthuswamy <sunilmut@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sunil Muthuswamy <sunilmut@microsoft.com>

This refactors the load library of WHV libraries to make it more
modular. It makes a helper routine that can be called on demand.
This allows future expansion of load library/functions to support
functionality that is dependent on some feature being available.

Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Message-Id: <MW2PR2101MB1116578040BE1F0C1B662318C0760@MW2PR2101MB1116.namprd21.prod.outlook.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whp-dispatch.h |  4 +++
 target/i386/whpx-all.c     | 85 +++++++++++++++++++++++++++++++---------------
 2 files changed, 62 insertions(+), 27 deletions(-)

diff --git a/target/i386/whp-dispatch.h b/target/i386/whp-dispatch.h
index 23791fb..87d049c 100644
--- a/target/i386/whp-dispatch.h
+++ b/target/i386/whp-dispatch.h
@@ -50,5 +50,9 @@ extern struct WHPDispatch whp_dispatch;
 
 bool init_whp_dispatch(void);
 
+typedef enum WHPFunctionList {
+    WINHV_PLATFORM_FNS_DEFAULT,
+    WINHV_EMULATION_FNS_DEFAULT,
+} WHPFunctionList;
 
 #endif /* WHP_DISPATCH_H */
diff --git a/target/i386/whpx-all.c b/target/i386/whpx-all.c
index def0c28..3ed2aa1 100644
--- a/target/i386/whpx-all.c
+++ b/target/i386/whpx-all.c
@@ -1356,6 +1356,58 @@ static void whpx_handle_interrupt(CPUState *cpu, int mask)
 }
 
 /*
+ * Load the functions from the given library, using the given handle. If a
+ * handle is provided, it is used, otherwise the library is opened. The
+ * handle will be updated on return with the opened one.
+ */
+static bool load_whp_dispatch_fns(HMODULE *handle,
+    WHPFunctionList function_list)
+{
+    HMODULE hLib = *handle;
+
+    #define WINHV_PLATFORM_DLL "WinHvPlatform.dll"
+    #define WINHV_EMULATION_DLL "WinHvEmulation.dll"
+    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
+        whp_dispatch.function_name = \
+            (function_name ## _t)GetProcAddress(hLib, #function_name); \
+        if (!whp_dispatch.function_name) { \
+            error_report("Could not load function %s", #function_name); \
+            goto error; \
+        } \
+
+    #define WHP_LOAD_LIB(lib_name, handle_lib) \
+    if (!handle_lib) { \
+        handle_lib = LoadLibrary(lib_name); \
+        if (!handle_lib) { \
+            error_report("Could not load library %s.", lib_name); \
+            goto error; \
+        } \
+    } \
+
+    switch (function_list) {
+    case WINHV_PLATFORM_FNS_DEFAULT:
+        WHP_LOAD_LIB(WINHV_PLATFORM_DLL, hLib)
+        LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
+        break;
+
+    case WINHV_EMULATION_FNS_DEFAULT:
+        WHP_LOAD_LIB(WINHV_EMULATION_DLL, hLib)
+        LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
+        break;
+    }
+
+    *handle = hLib;
+    return true;
+
+error:
+    if (hLib) {
+        FreeLibrary(hLib);
+    }
+
+    return false;
+}
+
+/*
  * Partition support
  */
 
@@ -1490,51 +1542,30 @@ static void whpx_type_init(void)
 
 bool init_whp_dispatch(void)
 {
-    const char *lib_name;
-    HMODULE hLib;
-
     if (whp_dispatch_initialized) {
         return true;
     }
 
-    #define WHP_LOAD_FIELD(return_type, function_name, signature) \
-        whp_dispatch.function_name = \
-            (function_name ## _t)GetProcAddress(hLib, #function_name); \
-        if (!whp_dispatch.function_name) { \
-            error_report("Could not load function %s from library %s.", \
-                         #function_name, lib_name); \
-            goto error; \
-        } \
-
-    lib_name = "WinHvPlatform.dll";
-    hWinHvPlatform = LoadLibrary(lib_name);
-    if (!hWinHvPlatform) {
-        error_report("Could not load library %s.", lib_name);
+    if (!load_whp_dispatch_fns(&hWinHvPlatform, WINHV_PLATFORM_FNS_DEFAULT)) {
         goto error;
     }
-    hLib = hWinHvPlatform;
-    LIST_WINHVPLATFORM_FUNCTIONS(WHP_LOAD_FIELD)
 
-    lib_name = "WinHvEmulation.dll";
-    hWinHvEmulation = LoadLibrary(lib_name);
-    if (!hWinHvEmulation) {
-        error_report("Could not load library %s.", lib_name);
+    if (!load_whp_dispatch_fns(&hWinHvEmulation, WINHV_EMULATION_FNS_DEFAULT)) {
         goto error;
     }
-    hLib = hWinHvEmulation;
-    LIST_WINHVEMULATION_FUNCTIONS(WHP_LOAD_FIELD)
 
     whp_dispatch_initialized = true;
-    return true;
-
-    error:
 
+    return true;
+error:
     if (hWinHvPlatform) {
         FreeLibrary(hWinHvPlatform);
     }
+
     if (hWinHvEmulation) {
         FreeLibrary(hWinHvEmulation);
     }
+
     return false;
 }
 
-- 
1.8.3.1



