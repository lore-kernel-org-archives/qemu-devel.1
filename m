Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7581FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:19:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387F420738
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 19:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sMJNYReZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 387F420738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbqin-0008Ip-Cr
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 15:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfy-0001xY-AB
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:34834)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbqfx-0000Oi-He
 for qemu-devel@nongnu.org; Thu, 21 May 2020 15:16:18 -0400
Received: by mail-wm1-x32b.google.com with SMTP id n5so7564593wmd.0
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 12:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Ua66Po+S3fTZ1GQQHmrF+D0YxmGxJFJ7sLOjFuo6+sc=;
 b=sMJNYReZlzbKibgOo2Z8Lph/UOTxHaVxxJ2/lACoK8SBd+HSqYqp+fAXXoZ6TqU1AI
 9NxDcS8CGkYfYJ/OvWPCV5buutAwYGVJyYYzwnTHlkRJO5N/KN18+v55rPQIeWDPlPTS
 K4L44uzuoxoKNYHm7Bc9bwAyMfUsv0N/OVU3kgb/nClgc5TlpvtrgKxFusCZQBKvdwfV
 QoOGRR0RRK9vq8Jp9DAtVHKgN/tPd6PmOi/OCEVj971gWHCMsDK/1vOxtNy4PR3k19hU
 FLDyssr5Fyb9cy59wIDXI96JNwwObG5+e/PsL5EZYs1yXnmbv9RZc684gnZBl6ddkSEw
 G8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Ua66Po+S3fTZ1GQQHmrF+D0YxmGxJFJ7sLOjFuo6+sc=;
 b=NjyDNEJIYOjXVYZsaGvZbLvjA/Hb9lokaKEc9oP5H+1Tz5xPXCLHhvBfDsEtEd51pk
 4en6VDSqrk3s9aayfK4TYIi3BksnRSXs9t9n1+f9gh9q5G8e1WS3FoSo8tu+SfMTweNg
 b5GIKZo71OtkaRd40P5599z6Kw0zW1nnDEtFVodP6kcYRbNpJ6BzPKEZ5U4BF8eSNuce
 eagzrNzhWN3keWjG1wU72WvhLkqP49e1TBkvDa2v7b4IOZsUEjocYhSaVXmcgF2ZMC+m
 3EYlKb1jOdjiWaHac4oQegqw9N/lFukPWlcuRF5Qy1Blm+g+ZZrPxL41sFmBlvJxCVfT
 93Kw==
X-Gm-Message-State: AOAM533o48egFe+kvYQn72V2yZCu+zO2QTvlctOnKQqZ3l/vQFDAZKhk
 dV2Wycv9MpDYT45AxOQ6q0lafSUCQuV48Q==
X-Google-Smtp-Source: ABdhPJyJyFI61x2npqm85JPSCyQELmgJsFseoLdtXx7T0Je1SB7mxE/WWzfPB8hIPSkkiUKvUEhR4g==
X-Received: by 2002:a1c:5502:: with SMTP id j2mr10776930wmb.56.1590088575861; 
 Thu, 21 May 2020 12:16:15 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z124sm7335100wmg.20.2020.05.21.12.16.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 12:16:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/29] docs/system: Add 'Arm' to the Integrator/CP document
 title
Date: Thu, 21 May 2020 20:15:43 +0100
Message-Id: <20200521191610.10941-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200521191610.10941-1-peter.maydell@linaro.org>
References: <20200521191610.10941-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add 'Arm' to the Integrator/CP document title, for consistency with
the titling of the other documentation of Arm devboard models
(versatile, realview).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200507151819.28444-2-peter.maydell@linaro.org
---
 docs/system/arm/integratorcp.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/integratorcp.rst b/docs/system/arm/integratorcp.rst
index e6f050f602b..594438008e4 100644
--- a/docs/system/arm/integratorcp.rst
+++ b/docs/system/arm/integratorcp.rst
@@ -1,5 +1,5 @@
-Integrator/CP (``integratorcp``)
-================================
+Arm Integrator/CP (``integratorcp``)
+====================================
 
 The Arm Integrator/CP board is emulated with the following devices:
 
-- 
2.20.1


