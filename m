Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515F6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:32:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22DCF207E8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9PAo1GG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22DCF207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot8u-0001eG-Bl
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:32:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0E-0003mv-W1
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:07 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jot0D-00057v-AT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:23:06 -0400
Received: by mail-wm1-x343.google.com with SMTP id j18so9660869wmi.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AGl2Uc8EGJJxA1tr+9fN1UmCX9zweogDk66dtMF1ioY=;
 b=M9PAo1GGD/3IdoVQbke8syP8CW0gW8XptiHLbRxVTvJMO1Za+Uhg/sLumcGRRacG46
 LuLVVAriBCUozEZZmbgE0EGy6wG/r8ZhhVIcZBYdiodX5a8nCJ+2l6Z/6vNO7yGGb8ZA
 cwws9nDgt2Xxel5GSQPBy7udJpiH3Vk4b1wJNV1g3/y6y6IEJXZcEjisN9WZeo4KWM6U
 IBvh5WeI129WfnuheRzXlUdWySG5RYfnTyFzxYEQDKe1ie1dQiIe/bl05zShL1nNLtqS
 WuUS1P5b0TMKHRXxY2uqvXWuEd55GEvZdZgmNKIiplFPgaJKD5aGnxKOuh2kFy33W5pE
 OyGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AGl2Uc8EGJJxA1tr+9fN1UmCX9zweogDk66dtMF1ioY=;
 b=q5ndwkf+g5XTX5CMkgqkd2R69odql2AP6vVq3uzZwFoClkIySa78rA0pWs/F7F9umN
 v4W7G/b30ns+VD5HFPn5/feBGdhV7hozxT4XQ3gmuymME3C3i6n/Lesamltx79KG/VMf
 GEno+hUC29ZlMYDltKwA2ifoJrflnzKXAHwS2Vhb63xc+bPVZ8VJGPCmLA703TzmW3kj
 nHACTiFXGqb21bJ4SMeMSXNCJFHIyDLYh8kmxgEBK6TyS1NMMtJsx7mQ4YOmKayedGH7
 E6dLNJQ1Qeroa1UEgnO2KwFYmNW7yDRXAwDILY5wLbnXPzv8sF2ru/RCdDE85DSw/OYC
 Cj/Q==
X-Gm-Message-State: AOAM530XYpuprKpHeANPVdhOy+Rk88Z8WkN6JpG+1JOfAbGz7BlCsO9O
 1C6NJfOzBvvU7FuwiCNxMp8a5A==
X-Google-Smtp-Source: ABdhPJxeoMHPxTRYeLNWzBwOTp24A/CWsn9Y6KR0VDO2Cb2mV+/71sVQCreF8Swyczl4g7NuvS5R1Q==
X-Received: by 2002:a1c:f608:: with SMTP id w8mr4632677wmc.78.1593195783948;
 Fri, 26 Jun 2020 11:23:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c2sm38315159wrv.47.2020.06.26.11.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 11:22:57 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E04EA1FFB3;
 Fri, 26 Jun 2020 19:14:03 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v3 29/30] gitlab: limit re-builds of the containers
Date: Fri, 26 Jun 2020 19:13:56 +0100
Message-Id: <20200626181357.26211-30-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200626181357.26211-1-alex.bennee@linaro.org>
References: <20200626181357.26211-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most of the time we are just rebuilding the same things. We can skip
this although currently there is no mechanism for picking up new
distro releases.

Rather than try to be too fine grained allow any change to trigger all
the images being rebuilt.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/containers.yml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index 20b2fb1de5d..f56aa44f711 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -19,6 +19,10 @@
     - docker push "$TAG"
   after_script:
     - docker logout
+  only:
+    changes:
+      - .gitlab-ci.d/containers.yml
+      - tests/docker/*
 
 amd64-centos7-container:
   <<: *container_job_definition
-- 
2.20.1


