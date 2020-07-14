Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7373C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 929A22193E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 04:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrmZe/vH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929A22193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvCwv-0008EL-Tj
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 00:53:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvCuf-00043H-Or
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:51:29 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835]:32969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvCue-0004tb-5Q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 00:51:29 -0400
Received: by mail-qt1-x835.google.com with SMTP id 6so11911626qtt.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 21:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=QV/g2t0NpdkBzTj+x8KMODp4Xrlo4zYUbZRu8cLnIcU=;
 b=LrmZe/vH3Ng1h7jx/6ZRnIj6PZtvMi1ExAHnZJvKc/7KE85U0nyaTAPRz6ERu5Hnbq
 4zH/s/O1X4ktRztPznrFwjRAc3YVhPepmYkcDxufBD5fDfQ5ZWrGpbms6fNFRmMNyeij
 UMS3SVK57jGjfAflwcJ9hIaj1wJY3vpMq6hiiHNylfORgQ+PiCsZGcHEXRQBYGQb41qh
 XD7GIpHeVD9X84W3PBFMw0ut0I6Ww0Tq6aCBHdHjeFRBvD983JsqWKtiKupEgvnyNTpQ
 9mY66jO31cMFEDGt2U3XiASroBTeofnPh7Mh+0wXC6W4n+VM/YYS8X4+ee9UODEwPUgb
 pxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=QV/g2t0NpdkBzTj+x8KMODp4Xrlo4zYUbZRu8cLnIcU=;
 b=SZZQ7P6V/JabYT4qV1UWxNaRjJaPCXA03jrGuB+CJSuoXZ/HY7rf1qnt0+QyxO6Hvu
 utAOiNz5hhzSH1Utbz8caaej4tFaj3QEtVhOZez2BXD+EVJOWXvjNXczF25z4x04f5Hg
 HhlBq9JKLJqn2qEY4n3xOfvBP3nMtImwjo3ySdypD/7bW/S7TKPk/9by2XGhxp/ltSJJ
 qABaDjgP2hKoJY2UtB3oeCplUWMj9TldNCzpMRULZL4wD+Avj5wN5vIBis5QebmQxm6k
 6t7wYdvdCQb+mVtwMRH/xFMOOUp3NN3XYsSUj0WdcIByJs1TD4zsiJucaQ56NSt16Sh7
 UZ+Q==
X-Gm-Message-State: AOAM531gTI0i04FBXm9mmMEUSfv6ZMyBjZyZXY4iOTkIUjyQ3ecDtspq
 jatZrh521vcHALKSqMaPoaYbcH9X
X-Google-Smtp-Source: ABdhPJyGtSpehM1kJXgDrA4OAW7fRpC0A6TBLbJ4H8TbkMuXJLlBxTU67egt8A+ykqGiVfTgQhvSDA==
X-Received: by 2002:ac8:4718:: with SMTP id f24mr2676557qtp.95.1594702286667; 
 Mon, 13 Jul 2020 21:51:26 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id m4sm23060359qtf.43.2020.07.13.21.51.25
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 13 Jul 2020 21:51:26 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PULL 1/4] qga-win: Fix QGA VSS Provider service stop failure
Date: Mon, 13 Jul 2020 23:51:11 -0500
Message-Id: <20200714045114.29319-2-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200714045114.29319-1-mdroth@linux.vnet.ibm.com>
References: <20200714045114.29319-1-mdroth@linux.vnet.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=flukshun@gmail.com; helo=mail-qt1-x835.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
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
Cc: peter.maydell@linaro.org, Basil Salman <bsalman@redhat.com>,
 Basil Salman <basil@daynix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Basil Salman <bsalman@redhat.com>

On one hand "guest-fsfreeze-freeze" command, "COM+ System Application service" is
stopped, on the other hand "guest-fsfreeze-thaw" stops QGA VSS Provider service from
"COM+ Application Admin Catalog".
Invoking a series of freeze and thaw commands may result in QGA failing to stop
VSS Provider service as "COM+ System Application service" is stopped, which can
cause some delay in qga response.
In this commit StopService function was changed and VSS Provider service is now
stopped using Winsvc library API.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1549425

Signed-off-by: Basil Salman <bsalman@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/vss-win32/install.cpp | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index a456841360..40de133774 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -19,6 +19,7 @@
 #include <comdef.h>
 #include <comutil.h>
 #include <sddl.h>
+#include <winsvc.h>
 
 #define BUFFER_SIZE 1024
 
@@ -509,26 +510,32 @@ namespace _com_util
     }
 }
 
-/* Stop QGA VSS provider service from COM+ Application Admin Catalog */
-
+/* Stop QGA VSS provider service using Winsvc API  */
 STDAPI StopService(void)
 {
     HRESULT hr;
-    COMInitializer initializer;
-    COMPointer<IUnknown> pUnknown;
-    COMPointer<ICOMAdminCatalog2> pCatalog;
+    SC_HANDLE manager = OpenSCManager(NULL, NULL, SC_MANAGER_ALL_ACCESS);
+    SC_HANDLE service = NULL;
 
-    int count = 0;
+    if (!manager) {
+        errmsg(E_FAIL, "Failed to open service manager");
+        hr = E_FAIL;
+        goto out;
+    }
+    service = OpenService(manager, QGA_PROVIDER_NAME, SC_MANAGER_ALL_ACCESS);
 
-    chk(QGAProviderFind(QGAProviderCount, (void *)&count));
-    if (count) {
-        chk(CoCreateInstance(CLSID_COMAdminCatalog, NULL, CLSCTX_INPROC_SERVER,
-            IID_IUnknown, (void **)pUnknown.replace()));
-        chk(pUnknown->QueryInterface(IID_ICOMAdminCatalog2,
-            (void **)pCatalog.replace()));
-        chk(pCatalog->ShutdownApplication(_bstr_t(QGA_PROVIDER_LNAME)));
+    if (!service) {
+        errmsg(E_FAIL, "Failed to open service");
+        hr =  E_FAIL;
+        goto out;
+    }
+    if (!(ControlService(service, SERVICE_CONTROL_STOP, NULL))) {
+        errmsg(E_FAIL, "Failed to stop service");
+        hr = E_FAIL;
     }
 
 out:
+    CloseServiceHandle(service);
+    CloseServiceHandle(manager);
     return hr;
 }
-- 
2.17.1


