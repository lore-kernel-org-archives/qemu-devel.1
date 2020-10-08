Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6B2C04EBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:33:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9AD121924
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 14:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cl4uMKza"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9AD121924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQWyw-0004CY-L1
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 10:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38284)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs5-0004T1-LP
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:17 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQWs1-00060w-RL
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 10:26:17 -0400
Received: by mail-wr1-x42f.google.com with SMTP id z1so6840087wrt.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=zyXdfXYrOKepRXbRJutbH2Bb8nSc3k6lkoxjaH6/PAI=;
 b=Cl4uMKzaGFnrpiYfC/UTyBoZA+6CV7ILmY5Z4qeuZty6rE9WSYvuVJ0sNvYvvMtGYD
 QSCNBynfqChBiTFWksGgo7S9YfV0eaA9UyBhdhG/rjUTA0TsPAgzu2MX20veo3fLCvav
 Jzo2PvVJHMMFL4o7AQInDwGAR2lPIP1/G9oxgRlMSVXT84w0PWsC6WQJVn/Z/3ltxKIr
 BFRG4esipREp1/2A8+I2yg8Q7O7j2Mc++KEpWuol+qCconzImjijvOeMCLwWKmxFhuEe
 8Ig66mdgOnIc7oDEBP9il+vd5s4tJJ59Y2u7iK7yH/qhgqZW5shZu3qiGhwRYfDG6DlY
 RS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zyXdfXYrOKepRXbRJutbH2Bb8nSc3k6lkoxjaH6/PAI=;
 b=cZPt+fIh421fUOUJ+eRpGsN5fa2/Zp3F696A3m7gYW5H0PrYRp8eV64Cnl0aIHZfvi
 1XMLUfl773JRjU5ZcEYWqvelfu40n9rHm3uSvhRVZ4ZfRjxTYZiSdhoei7CWtSebnHES
 qnjQ7iKDwWghwb+EvSijyWa+5BGomR04h6v56zhjuFiLzG/YGJs9Z0sQU7fCFVO3I427
 bZLFPRec0AY0VfSoD04Zq1vA8Uq0isA4BLvrE+gaGeRrB9JLV5nBdF5zGQVCSr67eBBq
 3nZft3IwopNd+Owcc4ol2vTpmOWUrRq+ZsnxcqSrhqPFNL98Mm/f+DUTpyQc7xQwwTbe
 1ZgQ==
X-Gm-Message-State: AOAM533ZRcil4JssqWxGSx6a4J7n9pwXJzf5gxyi4IRZGAHBs/8lFJyZ
 UaodVOoyy7X6FzGxpiEOaoTE1tsN29wy2Eqf
X-Google-Smtp-Source: ABdhPJxrF/cUTlDWgwmMxcoR2c2w+OGbRBDoJ74lTO9S8kNvSjWQeLHOqqYBFSw374/Ut4TBc/s3Pg==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr9561980wru.173.1602167172215; 
 Thu, 08 Oct 2020 07:26:12 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id j1sm7905104wrc.28.2020.10.08.07.26.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2020 07:26:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/12] tests/qtest: Restore aarch64 arm-cpu-features test
Date: Thu,  8 Oct 2020 15:25:55 +0100
Message-Id: <20201008142557.9845-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201008142557.9845-1-peter.maydell@linaro.org>
References: <20201008142557.9845-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

arm-cpu-features got dropped from the AArch64 tests during the meson
conversion shuffle.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-id: 20201001061718.101915-6-drjones@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index ad33ac311d0..0f32ca08950 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -146,7 +146,8 @@ qtests_aarch64 = \
   (cpu != 'arm' ? ['bios-tables-test'] : []) +                                                  \
   (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-test'] : []) +        \
   (config_all_devices.has_key('CONFIG_TPM_TIS_SYSBUS') ? ['tpm-tis-device-swtpm-test'] : []) +  \
-  ['numa-test',
+  ['arm-cpu-features',
+   'numa-test',
    'boot-serial-test',
    'migration-test']
 
-- 
2.20.1


