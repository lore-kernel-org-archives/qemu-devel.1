Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07922C4363D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:56:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E630206DB
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOjWrSyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E630206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46926 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLnGg-0004Ka-L6
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCn-0007jz-H1
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a]:39297)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kLnCl-0001PC-Om
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:52:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id b79so3165493wmb.4
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BtOwqygZxNZk6oWCI22F6lqMw1LRPXvFIADZTQl+rOY=;
 b=fOjWrSyCvJQYpMmASANN0N5QLGO7rBHdRnm4ZVIiBVZlboHIMioFdOTj8nD0PTwhEv
 k/IGXoGYu3E5ubzC3bbcoLsONq5pPZuY1RfllMwg2CURFDzpYPe5K0cafBWCDhEU7dhp
 qp2WvHMxU24jfTi3SacCtzZjqZFRLXpuIkjsf3PZMjqGOEYktpXJZ//HQERRHsxDVfNG
 F7aQsxtpv9FimpmVRLFaU3JP/oMwKAcJ854HlbhxoZEvitK741+tB/KwWEP9DXYBl+Fy
 yRcExZhp/9sThFMQ+pFYyy8KLFlqKVS/a4D60ETPCuECkpiOfg6MMpPbJob43Qkdsz+8
 FiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BtOwqygZxNZk6oWCI22F6lqMw1LRPXvFIADZTQl+rOY=;
 b=W1AzrZQkuoTR1UxT+Al8bmOX2NH2vHNnzMvl/RjhnQ7JjlIx3Ad1zzFL4yBOTtFeP/
 3PV0XaGC8sIS3agz+JxuTK4dj4uQZzXRFNSv3PZxiEKywLvBISQ4ImpgdgS/AT0vXPkX
 KOHw6oPUckEXx8/dxXS3jzPicQOkXNdJIu3NpcD0Fhr5SH+i6aFgzpaWFM1G2GcJ5PUu
 umclrrg6ApNJBlucp7AhY0N2nzhTFS3uaUJJqEziAKDgAV3GdJpHjozhF9qU0U8lcvKF
 oPe/P8ShLOGff+caMMwONAdwM1uvBNTa6BQ7n0gRTe4/D6Ju6udfBYUP8NHqKEiB0VEG
 ZB0A==
X-Gm-Message-State: AOAM532eT1dsI4YbIyi2SJsa1oFamaXnMyyLhG4xhmr75GOuPzdaZcyH
 Q0Yo7UNaejpeBGA4t1wB34bcoA==
X-Google-Smtp-Source: ABdhPJykzsVoFuABJlyF48BUdTgFdDhu4D6Z6tqvRMH73d8CJkJCXeBVJNsmCMLI+v2nkSCEGVIPrw==
X-Received: by 2002:a05:600c:252:: with SMTP id
 18mr2846464wmj.63.1601038322276; 
 Fri, 25 Sep 2020 05:52:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm3046659wro.27.2020.09.25.05.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB33B1FF93;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 07/19] tools/vhost-user-rpmb: implement
 --print-capabilities
Date: Fri, 25 Sep 2020 13:51:35 +0100
Message-Id: <20200925125147.26943-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

A very simple capabilities dump.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tools/vhost-user-rpmb/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tools/vhost-user-rpmb/main.c b/tools/vhost-user-rpmb/main.c
index a40a680a74ca..6b1989125bd6 100644
--- a/tools/vhost-user-rpmb/main.c
+++ b/tools/vhost-user-rpmb/main.c
@@ -7,6 +7,7 @@
  */
 
 #include <glib.h>
+#include <stdio.h>
 
 static gchar *socket_path;
 static gint socket_fd;
@@ -20,6 +21,14 @@ static GOptionEntry options[] =
     { NULL }
 };
 
+/* Print vhost-user.json backend program capabilities */
+static void print_capabilities(void)
+{
+    printf("{\n");
+    printf("  \"type\": \"block\"\n");
+    printf("}\n");
+}
+
 int main (int argc, char *argv[])
 {
     GError *error = NULL;
@@ -33,5 +42,9 @@ int main (int argc, char *argv[])
         exit (1);
     }
 
+    if (print_cap) {
+        print_capabilities();
+        exit(0);
+    }
 
 }
-- 
2.20.1


