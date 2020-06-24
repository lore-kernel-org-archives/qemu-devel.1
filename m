Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D8E8C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:14:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD94720781
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 14:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U5+yr8Ah"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD94720781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo6AC-0005nb-0K
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 10:14:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33456)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68r-00043l-6d
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39624)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jo68p-0005ta-B3
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 10:12:44 -0400
Received: by mail-wm1-x32b.google.com with SMTP id t194so2677415wmt.4
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kkJ3TlSVKMVotvh/AON95M2rOXL6DLcXLqurDZ1ML4w=;
 b=U5+yr8Ah+wdD1Tv5Yq6iMv4KxqWlivSYl+AqLVsBoTZfVMuIeoharISrhSuMY0aEXJ
 0dnXh71iWsL/5A/dvwAQO1uElLHONHgcCnBtRTzavwMKuWQcZi04pT/alFvPHtRoOlDR
 /Q4bqaaxfhG3F9uZJ/BqYB3tFvLqTTRYQywLAV/nxs5RYG6AgREsT9sZOPuKL5pZxnhO
 qJFb5MSSMN5G5s4GhWN3QHzwX0XgWdgtGGnl3G5FMJhZWVQ3eJk43gGA5NR358GmP6nE
 LkQkNp62ARw1R8TJ/SrocCkCaLzNEtMg2JFPRrmbN46rbV10xyjyqI/1KppP5qVnz7YX
 MTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kkJ3TlSVKMVotvh/AON95M2rOXL6DLcXLqurDZ1ML4w=;
 b=HjIEsCoVKSCQZLP+7R+YPok806vxdv5fsT/782+CN3I2XBJLz+Fv2o1JMbf7PmYswM
 zzqryswfBbIaDmOcA8kUiRq3VG275Bb4iqBN3/XzvRJxaqn4KHbncxaeiBcbfRROjSOg
 IZJDFUwrAEbEcy9uYYjH8HjYyoDbKIqTuMUYv+Z1kf4U8OGyOoXrHaMICCsL1APCHRjR
 MNiyT7a2AFRlq5Sl0ULbUrhlowvpArHk7Cygi21kdfW1uS82SGjy6lOegIF5atuvrb7D
 DvnM8h/H6PKRG77E6MgTHhOxS6ToEm6X/6f3kM6T0O5uYKYZIIBlQsRHYTa8cKF0tUP8
 p5tw==
X-Gm-Message-State: AOAM532aJPPEoVO6eUrnsNwQV0hvOy/n5Bm7Aa+E2w7jxycNSJ0j0MM5
 FTXhmBif8B9VhhmEDnjRgNuQew==
X-Google-Smtp-Source: ABdhPJzMD1grAq3rQlpuGeMqcTz0AwjjIqo5rMy+rdQh1z6jDAA79a5G2HCymUqOLZViJeGZQJD0KQ==
X-Received: by 2002:a05:600c:2144:: with SMTP id
 v4mr19647966wml.128.1593007961346; 
 Wed, 24 Jun 2020 07:12:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n16sm20955950wrq.39.2020.06.24.07.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 07:12:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B500D1FFAE;
 Wed, 24 Jun 2020 15:04:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v2 24/25] gitlab: add avocado asset caching
Date: Wed, 24 Jun 2020 15:04:45 +0100
Message-Id: <20200624140446.15380-25-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200624140446.15380-1-alex.bennee@linaro.org>
References: <20200624140446.15380-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, Thomas Huth <thuth@redhat.com>, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These can be quite big so lets cache them. I couldn't find any nots on
ccache in the gitlab docs so I've just ignored it for now.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200622143204.12921-19-alex.bennee@linaro.org>
---
 .gitlab-ci.yml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 54da29dd384..683a1d90fe6 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -8,6 +8,12 @@ stages:
   - build
   - test
 
+# We assume GitLab has it's own caching set up for RPM/APT repositories so we
+# just take care of avocado assets here.
+cache:
+  paths:
+    - $HOME/avocado/data/cache
+
 include:
   - local: '/.gitlab-ci.d/edk2.yml'
   - local: '/.gitlab-ci.d/opensbi.yml'
-- 
2.20.1


