Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32803C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:24:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAFC920838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1PSKMEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAFC920838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnj4-0004DO-6s
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:24:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh5-0001eV-F8; Fri, 28 Aug 2020 19:22:03 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:44584)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh3-0006Jb-Ro; Fri, 28 Aug 2020 19:22:03 -0400
Received: by mail-ej1-x644.google.com with SMTP id bo3so1187560ejb.11;
 Fri, 28 Aug 2020 16:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=CUWOPdxbZMjjlgVu2jD4P/2CDhJJfs5x+yzzwsdv4cs=;
 b=B1PSKMEqygi70lKdyXxj86DvB9a9WQs2Q//zCBuuiR5VmqCJTI9TVjJnatAn1fc4vH
 iWYYyNG4tMYGJ2a7yW61DO8QFltW9i62FYfrsemQ6c2jcNPASrQSE0q7EFuzJfSLxuqD
 spbb02itWJ3G/HK65eJyinASjhldAz7imABrWJzJoUtaUp9weZ+rUwchtP1yH0fIomfy
 iHDz38svTSJZonup+nRv2JeNdxe3a2XIn4QsJN5XdB2I7M6X+bsfbNZclfWjcFFHSSL7
 6ASf2wTOwl/ekre3T4rU1RhvWbaq3xUA3pIUWMuXZ2RFHfphzA3c8ZAXrYExvy8hTYVx
 vq6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CUWOPdxbZMjjlgVu2jD4P/2CDhJJfs5x+yzzwsdv4cs=;
 b=aHli+A53YpJMg1b+y0jPOTZbb+YIcf8xv4965iMe09CYw1I6DfrGm168lwnroi7CWk
 TP3o1xVn/+dqdJa3P8Tho8/gXdMz7wD319O1K+k20V4ZYKpFr6T8yiTMBbIk8CELhLZf
 4g/AFOiiqBMAGtuOyEgEZtc4NsqyfOULzn0lc6ZannOEc6TfTlCJdt756uJFM+g6CxSf
 d+Smyera40GyQcl1s2VMkKkU6LIf+eedO/oX/s9U/W3alpdo0+rWilJhZUWhvktY84da
 +F3gOI0wEckcrthdcAWuviMl2ozT2B5f3rI48d083lSdn4WhqvvSfunFyfHMo3WZkGhl
 fLDw==
X-Gm-Message-State: AOAM533VEA8MtNPSqlWdugGZzysANFIQP3/Sj6Xh22w2gcdGD80peiiq
 1QUa1+3glzwwC8SV4YhNrrapP41W735lSwt+
X-Google-Smtp-Source: ABdhPJybNi27GC3NxlTE0TlH+wXn19BkSmRFX5nFvm690bvRJ3b0CxJY1ilxRDclR41OftgOXB1jlg==
X-Received: by 2002:a17:907:262e:: with SMTP id
 aq14mr1162575ejc.79.1598656919934; 
 Fri, 28 Aug 2020 16:21:59 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id j21sm523436eja.109.2020.08.28.16.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 16:21:59 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 2/5] qemu-iotests: Fix FilePaths docstring
Date: Sat, 29 Aug 2020 02:21:49 +0300
Message-Id: <20200828232152.205833-3-nsoffer@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200828232152.205833-1-nsoffer@redhat.com>
References: <20200828232152.205833-1-nsoffer@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=nirsof@gmail.com; helo=mail-ej1-x644.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Nir Soffer <nsoffer@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When this class was extracted from FilePath, the docstring was not
updated for generating multiple files, and the example usage was
referencing unrelated file.

While fixing the docstring, add example for creating sockets, which
should use iotests.sock_dir instead of the default base_dir.

Fixes: de263986b5dc
Signed-off-by: Nir Soffer <nsoffer@redhat.com>
---
 tests/qemu-iotests/iotests.py | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 2fd5c916fa..4abfe63662 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -450,14 +450,21 @@ def file_pattern(name):
 
 class FilePaths:
     """
-    FilePaths is an auto-generated filename that cleans itself up.
+    Context manager generating multiple file names. The generated files are
+    removed when exiting the context.
 
-    Use this context manager to generate filenames and ensure that the file
-    gets deleted::
+    Example usage:
+
+        with FilePaths(['a.img', 'b.img']) as (img_a, img_b):
+            # Use img_a and img_b here...
+
+        # a.img and b.img are automatically removed here.
+
+    By default images are created in iotests.test_dir. To create socket use
+    iotests.sock_dir:
+
+       with FilePaths(['a.sock'], base_dir=iotests.sock_dir) as (sock,):
 
-        with FilePaths(['test.img']) as img_path:
-            qemu_img('create', img_path, '1G')
-        # migration_sock_path is automatically deleted
     """
     def __init__(self, names, base_dir=test_dir):
         self.paths = []
-- 
2.26.2


