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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6251CC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 268F720838
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:23:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sThXLve0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 268F720838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBni0-0002ow-CZ
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:23:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh3-0001cV-ME; Fri, 28 Aug 2020 19:22:01 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:32962)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1kBnh2-0006JM-6Y; Fri, 28 Aug 2020 19:22:01 -0400
Received: by mail-ej1-x644.google.com with SMTP id a21so1271947ejp.0;
 Fri, 28 Aug 2020 16:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LGDBKWC08oc7KjFCWYV40h60UwUROAE9zpPW6K9PPWM=;
 b=sThXLve0gHWuAnVPWSG9o+PuBba9m7C7kbw0hc+O37Br/z4GEqv4XgGInAm+SZ64uS
 HorBCg01u141eTxI7ij24wGUXHlgWqwetp67udBSUYpL630Ea0rPvvKkjDtAOUAEK9u7
 r+Ms293bv3PfpZPT9db42vtdYcbJjCrhajWMty4nuBBhBY263JptzgpHkhV7UITAWjBF
 u3+e6ohUPIP5RQQ9Mw2iMigq75hP0ROIsvQMMH8GAMpSuOuzXqnzw/esj4/PArhepOEz
 h0rkgbfy2B06YaEHApxjQFIu8VEN96KHyG7vpONw1czPJ56oCD0I2lW0mtuAIq531hEG
 Jzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LGDBKWC08oc7KjFCWYV40h60UwUROAE9zpPW6K9PPWM=;
 b=HFY9JvpCKAU4UnVOlxs9M8NGAtKK0gkBbGxR8l2N4UC4avyHZKrBI9jsvvuJqgze0f
 ha/Q8RyY/G0X/lS+Ns4wYXg53lt8SkMgxoKHhunhYgjt27eIx2Y2FrP0QMMmoyxxrMSw
 3WDKUk4Llbfeq9rcEEBrlMuPqFRxx3VkE+5hsKKeF4PBFetyB31xTx+Id4tbSz+5YY3J
 YZABY/fv7ejzIkChrJwXdlUjO5Uj7hAwwdUJQD/heWMhW1CN1EXM4R4QXw946nOa9D+m
 hO5BZ9KR8Us/VjBvr1r5kcetSlkKXd2XzKCBZITyTA1EMYyRkN9nsD7sZJowNA4aZcTV
 WZfw==
X-Gm-Message-State: AOAM533us+9K2fh+Ch8K9BQkXr2rM3uKvSROIWcUiso7H5yaev2DTBBA
 7eRNIWumvBiVFjpJ4qucdb2Cl9tyKfdhYTn0
X-Google-Smtp-Source: ABdhPJyYqngonIu/Ibcvlj8WIIPNDeky7d+0btmqqDjd0bENZciN3E9Mkvw2AW5FZ905YklBMf2qnQ==
X-Received: by 2002:a17:906:bb0e:: with SMTP id
 jz14mr1118079ejb.525.1598656918180; 
 Fri, 28 Aug 2020 16:21:58 -0700 (PDT)
Received: from localhost.localdomain (109-186-204-55.bb.netvision.net.il.
 [109.186.204.55])
 by smtp.gmail.com with ESMTPSA id j21sm523436eja.109.2020.08.28.16.21.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 16:21:57 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/5] qemu-iotests: Fix FilePaths cleanup
Date: Sat, 29 Aug 2020 02:21:48 +0300
Message-Id: <20200828232152.205833-2-nsoffer@redhat.com>
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

If os.remove() fails to remove one of the paths, for example if the file
was removed by the test, the cleanup loop would exit silently, without
removing the rest of the files.

Fixes: de263986b5dc
Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index e197c73ca5..2fd5c916fa 100644
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


