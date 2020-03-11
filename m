Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32920C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:05:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CB8B20736
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="bpEhk+iA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CB8B20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC4nl-0007gJ-5b
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 13:05:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53049)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <basil@daynix.com>) id 1jC4mR-0005Pm-Mi
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <basil@daynix.com>) id 1jC4mQ-0000Hn-ME
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:27 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35694)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <basil@daynix.com>) id 1jC4mQ-0000Gk-Fm
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 13:04:26 -0400
Received: by mail-wm1-x342.google.com with SMTP id m3so2986198wmi.0
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=arRHgga2quA2/zACUqHImErod+MeexWEf7WnETjMy7A=;
 b=bpEhk+iAyW7E0B+pErmDiXNrHI5sn9dD/3/FNx5BbA1vptIa22OvOVJpC390wH1T92
 zUqiMbeMIlVHfPGfc2e4vGCb75eXHtlMzNHz9EMyEGrUOZeZx2YZ4goeRDtMOKIn22U3
 YyZHkk4enkWiD/MFFwlgcNI5XPzpkTOpTa/YEpGdoqyNTSLUQ8WK5Byw3lnZX1F0lTnt
 qLATCxGNxB10X0vdFm5YBfIppjTBHmWVDScabKl1M3oxQ5HHb3ETu8L35gaKJ8B7TXRy
 wUEl+axyWKlqx0x0c/968m8ELSY2UGAJmGHfn441Qkj685RDvkWiK04x/02N7EtV94a1
 4YoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=arRHgga2quA2/zACUqHImErod+MeexWEf7WnETjMy7A=;
 b=lQBOE/YKrl6dv54wRbpdM00O0h9XqmyEySERo0EI08lju+gz4o44Qh+eozRf40wlDr
 nrJJ9amTaWZ/yVJI5HrRFnquvP+EVt+V9VHnEpgF0G9fjoyevbsl+5OaOXbHVR8d+4Bo
 gjp1Jc93E9tr+TIOVqxpYO+yjSqQvPIg2aU6GcaaJeWr/jrlLxDE+4wtIi+NYTXWsRj+
 j2my2u+kocIQQLhPwLjCF/TP+xfNdSTYrQU7xWtW9tNtpXrxVauMjkJCpjWlP0YhyUm5
 +lLflCJ9c5NXVqfP1/wVX1ouzywfMF0EWISmivXPb4WNNUMBL6A8htcTlFsmH/ETO94T
 fCmw==
X-Gm-Message-State: ANhLgQ32ZelgEGu57pFj7mti3cu8xAsfwjjqdkXjAWDg5gNIfOOQoJuJ
 zS+t528Cf6h8STdHeQ+fWuplnVHm7o4=
X-Google-Smtp-Source: ADFU+vsR/IQ4bOQ4gOx1ZAuRzqYn6ng9lpYivfAeCTkh20cwWJnCSi+F3M3NEakqk99j2Mu5SfSxcw==
X-Received: by 2002:a7b:c458:: with SMTP id l24mr4538976wmi.120.1583946265196; 
 Wed, 11 Mar 2020 10:04:25 -0700 (PDT)
Received: from localhost.localdomain (bzq-84-110-34-91.static-ip.bezeqint.net.
 [84.110.34.91])
 by smtp.gmail.com with ESMTPSA id o26sm8510925wmc.33.2020.03.11.10.04.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 10:04:24 -0700 (PDT)
From: Basil Salman <basil@daynix.com>
To: qemu-devel@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>
Subject: [PATCH v3 2/3] qga-win: Handle VSS_E_PROVIDER_ALREADY_REGISTERED error
Date: Wed, 11 Mar 2020 19:04:16 +0200
Message-Id: <20200311170417.13415-3-basil@daynix.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20200311170417.13415-1-basil@daynix.com>
References: <20200311170417.13415-1-basil@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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

From: Sameeh Jubran <sjubran@redhat.com>

This patch handles the case where VSS Provider is already registered,
where in such case qga uninstalls the provider and registers it again.

Signed-off-by: Sameeh Jubran <sjubran@redhat.com>
Signed-off-by: Basil Salman <basil@daynix.com>
---
 qga/vss-win32/install.cpp | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
index 6713e58670..a456841360 100644
--- a/qga/vss-win32/install.cpp
+++ b/qga/vss-win32/install.cpp
@@ -443,6 +443,17 @@ STDAPI DllRegisterServer(void)
                                      VSS_PROV_SOFTWARE,
                                      const_cast<WCHAR*>(QGA_PROVIDER_VERSION),
                                      g_gProviderVersion);
+    if (hr == (long int) VSS_E_PROVIDER_ALREADY_REGISTERED) {
+        DllUnregisterServer();
+        hr = pVssAdmin->RegisterProvider(g_gProviderId, CLSID_QGAVSSProvider,
+                                         const_cast<WCHAR * >
+                                         (QGA_PROVIDER_LNAME),
+                                         VSS_PROV_SOFTWARE,
+                                         const_cast<WCHAR * >
+                                         (QGA_PROVIDER_VERSION),
+                                         g_gProviderVersion);
+    }
+
     if (FAILED(hr)) {
         errmsg_dialog(hr, "RegisterProvider failed");
     }
-- 
2.17.2


