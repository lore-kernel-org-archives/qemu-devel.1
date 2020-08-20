Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632B5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:55:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 312C720674
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:55:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQM2m0OY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 312C720674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uPT-00020i-E1
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 19:55:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45966)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOC-0000H2-G2; Thu, 20 Aug 2020 19:54:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40736)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOA-00070m-L4; Thu, 20 Aug 2020 19:54:36 -0400
Received: by mail-wr1-x443.google.com with SMTP id l2so339337wrc.7;
 Thu, 20 Aug 2020 16:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=dEMPiCqe9PefxpWTTe3SJ7uQAbS0drp2NTOLNfe8U44=;
 b=kQM2m0OYVuLBN6jSDlqJlSz6hPWcob2zyci9GLLCFUKYBdgmAWHr4wpkxt0V3fRuKn
 kiiDGhmJcZJPUL4kvhz0YtcmGsRrFHVvxcIv1CuQUM0jE1WGWTnqvHKxHoB/7LOZVrk4
 P87pelL9m3Vs7lTXcJ52yx43BADmwAecKHs+C30NGqQgRuWVrshHv4D/9WZiBZRGXHF6
 eEVpcV9lx7+a6An7F47Fjt/7wSTaWFERP3ywJm2x2u9bWXbBED8+on7805R76FkErRm3
 xKYlQHhuzQ/iOM9vN+qep1ZVaKbzTz1xmNSauY6EyTjhSQ2T9udrSFilS9YKGP2or0Dt
 VwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=dEMPiCqe9PefxpWTTe3SJ7uQAbS0drp2NTOLNfe8U44=;
 b=q/YUsZ8SKMkreTYaZubcVl2694Jax4g+VZrNKS0cYrVBU0/0XDkPXduvYxpH0YVoQm
 nrGUG6sYNHFubJsavk09hw/a4RJOJAI8uWbAjgl1eNGHb4giyDNM1pa+saBjyF6VfuQ+
 2f1IUK+9JNhHa3D1VL0mVcxOBMHYYozgMljGyZfPo570Evv91QS0K2o5Hr5R+8xKEAd6
 howeVJcTO7VLT6Q1PkuD6c1kFc7gPLCpp+xNZeGwXNE4wxeVvd0eOMs5GDtnAGkKY8KI
 3s0SnPNrgvTmVTQc7EYDc5LrnxoplJueTOZEzqEzgOtRqcZ98hK0uiDHdLhlvqFrRyqd
 pCTw==
X-Gm-Message-State: AOAM5322zNs+AoR4ThoNlp0aUiDKmPf6Jd3NeEIuQ9JpkCiAFOxamtWL
 xuSKwOX/lEnoF6LEinGklGD4tyGEljHfnL8/
X-Google-Smtp-Source: ABdhPJwahq30JprhS/yA4Rb8O051zjWBIvx9eWrphPvKHw8RrOdVdQ/bR0sL6XTB4FL+S8uxyali4A==
X-Received: by 2002:adf:80c7:: with SMTP id 65mr153449wrl.35.1597967672431;
 Thu, 20 Aug 2020 16:54:32 -0700 (PDT)
Received: from localhost.localdomain (109-186-18-89.bb.netvision.net.il.
 [109.186.18.89])
 by smtp.gmail.com with ESMTPSA id o128sm556506wmo.39.2020.08.20.16.54.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 16:54:31 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 1/5] qemu-iotests: Fix FilePaths cleanup
Date: Fri, 21 Aug 2020 02:54:23 +0300
Message-Id: <20200820235427.374645-2-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820235427.374645-1-nsoffer@redhat.com>
References: <20200820235427.374645-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If os.remove() fails to remove one of the paths, for example if the file
was removed by the test, the cleanup loop would exit silently, without
removing the rest of the files.

Fixes: de263986b5dc
Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/iotests.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 717b5b652c..16a04df8a3 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -468,11 +468,11 @@ class FilePaths:
         return self.paths
 
     def __exit__(self, exc_type, exc_val, exc_tb):
-        try:
-            for path in self.paths:
+        for path in self.paths:
+            try:
                 os.remove(path)
-        except OSError:
-            pass
+            except OSError:
+                pass
         return False
 
 class FilePath(FilePaths):
-- 
2.26.2


