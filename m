Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32FCCC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:13:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED87F206DD
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 12:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hcm9XnLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED87F206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWIvD-0003V8-41
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 08:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56458)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo1-00068T-Ij
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:41 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jWIo0-0000Lh-Qb
 for qemu-devel@nongnu.org; Wed, 06 May 2020 08:05:41 -0400
Received: by mail-wm1-x336.google.com with SMTP id k12so2294600wmj.3
 for <qemu-devel@nongnu.org>; Wed, 06 May 2020 05:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=peaM6igo+AhDvK0qqAnxFsdR5nx5YlJ8GTR7GVhQ6qE=;
 b=Hcm9XnLGvGSEqB9XHdouwA9/fVpoXuwHP70rQijEiQs80jghsXrlSHQRgTLjj0eDKJ
 6a3JQk+bm/LWIidhuilsh0PspmO+KPM/mhK6c0s7t2mfhuWaq94NshHFis25QMesKVWE
 jG3tMuNLFQqMKm/2GHO0Z+qp0+FXH/iiL2gBX0ad8gbMgb3Omg9lYVF+T/myDnhrMxS+
 me+lrnOnXLfkidr9oYUnlWzLhGNi/1TGlr6meM4wxpiUvVonFA4sM77ucfkTBvHXR6le
 qj+EZFAwBAJEdwuQ0AsFA4GECFE0SVDp8DhlS9w1XASspikBROUIJGZF5Anr32pNawTI
 Oyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=peaM6igo+AhDvK0qqAnxFsdR5nx5YlJ8GTR7GVhQ6qE=;
 b=HvnKm7WVFHQEvsCL/eDgwBWWkm+3tJyMB/mYg/s3M5CZnNKsi6jF5J7PhOeGqbSgcl
 4GQn6CFTHNi48gT4g67npuQjhqGe9TP4cqkRM/NyDzFmhtOGjCdkVt0/fjZLvyzc3geK
 hUWdbB9HE3s+ovLTgcPlVXCL5Tt/vSV5M8m4WNi861GmGiklWObGdmYt+qYY7z9e8ICb
 GyWlVSWA2nT2OXx3S17S46ZZsdtyISAN38veBLflpbGolsGsAdoRYRScw8zIz9fEChD7
 q7CVPqh8q67qhXMpaniyqkYhfKx2ziQkqlx7CkcwBDlcyNEB6eYhyCyEeRRmWp/grt+F
 nlWg==
X-Gm-Message-State: AGi0PuYtsBfcaFd2webQi2t7cxdM9d8Udu/ma9NHE8W0gxzuLtOh74+C
 HPtTxWD03JbdJxvufut761hcLt38egc=
X-Google-Smtp-Source: APiQypJVvskfWWSvBhlmk7dJFVzsZkgu15NMv7HFkpeatpHPKVzJJmJIILb2izlwUtTTAa3jCtEm7w==
X-Received: by 2002:a05:600c:1:: with SMTP id g1mr4116927wmc.142.1588766739533; 
 Wed, 06 May 2020 05:05:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v131sm2877237wmb.19.2020.05.06.05.05.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2020 05:05:37 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 218661FF91;
 Wed,  6 May 2020 13:05:30 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 05/14] .travis.yml: reduce the load on [ppc64] GCC check-tcg
Date: Wed,  6 May 2020 13:05:20 +0100
Message-Id: <20200506120529.18974-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200506120529.18974-1-alex.bennee@linaro.org>
References: <20200506120529.18974-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This seems to be timing out quite often and occasionally running out
of disk space. Relegate it to light duties.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200501111505.4225-5-alex.bennee@linaro.org>

diff --git a/.travis.yml b/.travis.yml
index 49267b73b36..fe708792ca2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -458,7 +458,7 @@ jobs:
           - genisoimage
       env:
         - TEST_CMD="make check check-tcg V=1"
-        - CONFIG="--disable-containers --target-list=${MAIN_SOFTMMU_TARGETS},ppc64le-linux-user"
+        - CONFIG="--disable-containers --target-list=ppc64-softmmu,ppc64le-linux-user"
 
     - name: "[s390x] GCC check-tcg"
       arch: s390x
-- 
2.20.1


