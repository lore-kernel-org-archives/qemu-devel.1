Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43401C35247
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:44:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10408217BA
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 18:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P7yUBhQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10408217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iz3Bq-0002Kl-7F
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 13:44:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37r-0002K3-1D
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iz37q-0003E6-10
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:42 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:39829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iz37p-0003B1-QN
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 13:40:41 -0500
Received: by mail-wr1-x434.google.com with SMTP id y11so24407395wrt.6
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 10:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RGSEAwRzGquzo0z9rwho6pYbImwPBYk422V1NiGGQVw=;
 b=P7yUBhQ2fqZqgisIfBQns3BkLmZY+lwyi/+8vhdAEcijIedGnbKE4D5dZtWwFO+MoU
 LiBJjREJu4n7qygwGHIKwkt7gE+qSFozH94+ytJCREl4tlpCUxLU9Z7ijVtCFPlroNpm
 /babPlxv7LbJCIPLEb4gPhoeN9SL6aWyrb0IxFhWzfmeKKwsFn8Sjdr1gay4jHZwRiZo
 +Vg7D0IbS+QwTtPUsa0rYvRk4pWa1Hlt5o4SA+LfeEkNy1GFueVhIpIChzZkr9ArcMWJ
 IdnEe/b0W9vu5+utFGch9GiduuhVXiuxS13exNuxNurcfsQdeAxX1+dDf3ciKjElYe3q
 wRKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RGSEAwRzGquzo0z9rwho6pYbImwPBYk422V1NiGGQVw=;
 b=Ys53WqaMsgNZOB3UqzUUYrIA1DLrGoL81Wuprd/EYQ5he4j7jT0svgGg7xYqQLEARO
 f/uW/mYD0m4SSucNRVax0tOOi2FeLqrs23NY4sfgX9GJUmrn5nSTFs14NAXibgXC0tN/
 isM+vECrxgM2QNkyH6zYDmm1iUHv0myrow+NDdSagdjlEskMnnX90MB0RM1Ey9WmpTCb
 I6dr5P9fSnOyREK0AunCKXBAZlURkvJnb1Bv0ve+DA6IFGwnKUjtUm7sw1Nl8rYPaqtF
 az1562+pYVfJv1wLz7tN5toxe6b2G+i1ZLhdwPfzdEVlGaGi40OwEBKalHXqh0RIvRkX
 LOTA==
X-Gm-Message-State: APjAAAUByYLNXWNKKUjafAEZOIQiVKJAfXNFKG6Pnk/B9fieNUrZqkRt
 V+a+i+qbzFgYCpmgvEhRfpq6qg==
X-Google-Smtp-Source: APXvYqxe7XHFumEicLtHyd4Uyw/5lu5nKTBwFcTrtHM6pGP4kfUb16ZgtP/LQf00bjGElioCHcKwqw==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr23660394wrt.343.1580841640830; 
 Tue, 04 Feb 2020 10:40:40 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g7sm30955462wrq.21.2020.02.04.10.40.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2020 10:40:37 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 495A11FF9A;
 Tue,  4 Feb 2020 18:40:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 10/16] tests/tcg: add a configure compiler check for ARMv8.1
 and SVE
Date: Tue,  4 Feb 2020 18:40:22 +0000
Message-Id: <20200204184028.13708-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200204184028.13708-1-alex.bennee@linaro.org>
References: <20200204184028.13708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::434
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We will need this for some tests later. The docker images already
support it by default.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200203090932.19147-13-alex.bennee@linaro.org>

diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
index 210e68396f2..e0d1fbb182f 100755
--- a/tests/tcg/configure.sh
+++ b/tests/tcg/configure.sh
@@ -216,6 +216,20 @@ for target in $target_list; do
       echo "CROSS_CC_GUEST_STATIC=y" >> $config_target_mak
     fi
     echo "CROSS_CC_GUEST=$target_compiler" >> $config_target_mak
+
+    # Test for compiler features for optional tests. We only do this
+    # for cross compilers because ensuring the docker containers based
+    # compilers is a requirememt for adding a new test that needs a
+    # compiler feature.
+    case $target in
+        aarch64-*)
+            if do_compiler "$target_compiler" $target_compiler_cflags \
+               -march=armv8.1-a+sve -o $TMPE $TMPC; then
+                echo "CROSS_CC_HAS_SVE=y" >> $config_target_mak
+            fi
+        ;;
+    esac
+
     enabled_cross_compilers="$enabled_cross_compilers $target_compiler"
     got_cross_cc=yes
     break
-- 
2.20.1


