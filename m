Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43526C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:51:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D94520715
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 15:51:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="oyYCqOsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D94520715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsTPG-0001un-Aq
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 11:51:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <basil@daynix.com>) id 1jsTOK-0000GR-IE
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:50:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:53515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <basil@daynix.com>) id 1jsTOI-0000Cy-BH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 11:50:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id j18so39995109wmi.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 08:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B1jVK9vQgYXYAM4FFoT/Ng/ENDlxlgeUIJbxuwGvDnU=;
 b=oyYCqOsvY388cRiO6JRYYTFv7sQJwlm7WitwP/dZnL5DNHC5/e0N6z97Kn2VetLTd4
 dNcflDKh/GF9HSg5xXyi0LQPY8cLSgI0Z9Aef/IZnhzpqPd8/QhFKb0xtRq6lr+68EKC
 M37BtwGleKS22+ILZKd+kEL43ktq66WFfQCAwXbIKsc3NnjzdQrnX0AIMBv2JLKBj37b
 6GA83nFUTo/kDwu/17MUHc48hlCmTAzsZE6K3yMD8FpwXM4HEnIYOByLHrXdpTp1kaNL
 8kgWSat/x8CkyRys231qQYR4wcVt1KCrUg6Tpd0yOu54pEd44tOCh7KAGThtYeE6KQX6
 atFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=B1jVK9vQgYXYAM4FFoT/Ng/ENDlxlgeUIJbxuwGvDnU=;
 b=lDjN5MpWfOJ5Gs44MfxhRzipWizCx3PbNZQK6p0y0wbZ2adkdtMtxNJl7q6NkSHYYG
 isqDsgjxafNONerNSsCGH27TF3KiqsEcKC8W7JQmUbRiM9tEPCVC1WhSn7jspVu0GbqZ
 FiTp9FE6ZtLGoiivGXVSS9akcXpHM+lHf8bcB6yXDS9IjYCnYkcKA4WWrF0pp4hi85x0
 5rTGfZRXvKbzOVFcBe/4bE1JrMAcl3/vSGyn95XftIxc0VWgJrzEN0Ejtn64CPBdMLw0
 qI1vIWBg5+xRFz2hDKleVIRsls4KOqIaLO2pWR5atRqCDoIP3hcX368FdBHfTZ/MiOWc
 L+Dw==
X-Gm-Message-State: AOAM531+/fE3swgiCLG0UKSb7NqmFQojBKQy3d3+xZQ2SLSPYgi/CTx6
 zXLPcmQgu1QeU3re6cziRdd7myAaBiE=
X-Google-Smtp-Source: ABdhPJyOCgTqXq8WCkfr25ZdQpeEXtljM/fcUZqEJpKcAIBrN7sVgQGV3Bq00S0YVuP+xUjGqscz1w==
X-Received: by 2002:a7b:c746:: with SMTP id w6mr52964322wmk.171.1594050643906; 
 Mon, 06 Jul 2020 08:50:43 -0700 (PDT)
Received: from localhost.localdomain (bzq-84-110-34-91.static-ip.bezeqint.net.
 [84.110.34.91])
 by smtp.gmail.com with ESMTPSA id m16sm20493234wro.0.2020.07.06.08.50.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2020 08:50:43 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH 1/1] qga-win: Fix QGA VSS Provider service stop failure
Date: Mon,  6 Jul 2020 18:50:39 +0300
Message-Id: <20200706155039.610109-1-basil@daynix.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::341;
 envelope-from=basil@daynix.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
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
Cc: Yan Vugenfirer <yan@daynix.com>
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
2.23.0


