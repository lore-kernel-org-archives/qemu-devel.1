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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2538C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C49920720
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 23:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sbtoQxF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C49920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8uQw-00055D-Py
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 19:57:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45972)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOD-0000IY-Hc; Thu, 20 Aug 2020 19:54:37 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:40735)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k8uOB-000712-UM; Thu, 20 Aug 2020 19:54:37 -0400
Received: by mail-wr1-x441.google.com with SMTP id l2so339376wrc.7;
 Thu, 20 Aug 2020 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=JyZ42iytgyulxF3b/igSJBiCpRIiXynOvr9XqZCe6AQ=;
 b=sbtoQxF0Ljo53A4d8raN0AYvL6SC7z15jKoqCjtGJjRVzY5k9GKMerkXvVhC2FS+hJ
 s2BJ5wYRNnn0wfzFLnGfQCVxVgpJbtph2uxESVX6wzB5fm0GqHYfyUumXdh2G5YucivQ
 yd2JpnQdOrnikV6tWZJv8D02N8hFfxCxKRIEtXZnVDAKz56O5VEaaXgUtOWv41EPOoKn
 NDmUmVTc4u9uCWqT2Y48cs0q8E1r4Xr4HwimDbITFuVxh4stBJIE39NP1oEvI5iKN2ua
 WMwnzbFzD6enL76GBy2FOgvjmh44ckjw1weQq3OuLigwHCZ79L/L79CVd/oGjpau3IqD
 7ZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JyZ42iytgyulxF3b/igSJBiCpRIiXynOvr9XqZCe6AQ=;
 b=dgycLcRGQir7pCx9Dvno9ujjKEh3+cvNUPks6rVlyO+wIRX0UsGA6XEiji3tyG1js8
 BEhcQ3Nq0+ABZP7UomZHnSJpQzrt2GoVTOP56WtXzM2plQVwCcJyPZDLigAQAfhG37FK
 dWgmNnKtBM5nOrEP+xJOefaga0B5teuDltGMGl5NI4YFBfs8jxDkH4cm91DMD6NWOKml
 QdxFkws2f0YWLgT5AWg+sVVwUTlnz8MGdMyirIm59TZ+RShO+um7f272h18cZiuDypnc
 6W2WtpxN6ddtSy29tFHqLH//2fqe14NK7Q+3WJbxrzm515oggXMFuRL9mApdbnUUAJSe
 cHyw==
X-Gm-Message-State: AOAM533c39R7KylswZ9gEcs3k1RR7p5nTrek1LNv8YsHZq2+A4Eohz43
 53bUJ+Icrh7Kgmzog0E7DgBW6p0Vtlo6Q2Aq
X-Google-Smtp-Source: ABdhPJxvad/NuMT4ZgAWJh2LT4HCaPJX/NfmJB8Ts+KlG+BgfNaKKtQvX/t5pgJiabod53xM9+00+A==
X-Received: by 2002:adf:9561:: with SMTP id 88mr165827wrs.240.1597967673960;
 Thu, 20 Aug 2020 16:54:33 -0700 (PDT)
Received: from localhost.localdomain (109-186-18-89.bb.netvision.net.il.
 [109.186.18.89])
 by smtp.gmail.com with ESMTPSA id o128sm556506wmo.39.2020.08.20.16.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 16:54:33 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/5] qemu-iotests: Fix FilePaths docstring
Date: Fri, 21 Aug 2020 02:54:24 +0300
Message-Id: <20200820235427.374645-3-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820235427.374645-1-nsoffer@redhat.com>
References: <20200820235427.374645-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=nirsof@gmail.com; helo=mail-wr1-x441.google.com
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

When this class was extracted from FilePath, the docstring was not
updated for generating multiple files, and the example usage was
referencing unrelated file.

Fixes: de263986b5dc
Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/iotests.py | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 16a04df8a3..f34a1d7ef1 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -450,14 +450,16 @@ def file_pattern(name):
 
 class FilePaths:
     """
-    FilePaths is an auto-generated filename that cleans itself up.
+    Context manager generating multiple file names. The generated files are
+    removed when exiting the context.
 
-    Use this context manager to generate filenames and ensure that the file
-    gets deleted::
+    Example usage:
+
+        with FilePaths(['test.img', 'test.sock']) as (img_path, sock_path):
+            # Use img_path and sock_path here...
+
+        # img_path and sock_path are automatically removed here.
 
-        with FilePaths(['test.img']) as img_path:
-            qemu_img('create', img_path, '1G')
-        # migration_sock_path is automatically deleted
     """
     def __init__(self, names, base_dir=test_dir):
         self.paths = []
-- 
2.26.2


