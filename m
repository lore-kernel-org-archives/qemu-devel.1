Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C55FAC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 943C520643
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/P45Hhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 943C520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiM3-00047b-Ow
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiI8-0006pd-0N
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:29 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51046)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiI5-0002Zo-Od
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:18:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id m12so2072859wmc.0
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=TGcmfNlDWPZF6zKifFKModO2QCDgF7kjS3M9oH6wUnM=;
 b=t/P45HhfXSOxnzevGByJpsItNSTteT0+FvltoX/hvsGi2Gt5qrpcA5tCi2ImJ20sks
 SjJmu7pWh5VyXeXUQDukMRJiy3znFPJehUFE5yYs9cxRPiRaqy1XT1HZMzoZRiiljPVV
 qYFhsL/KjSfz62iHQvrnRI+e5B5G4wqtiDDjdLcX4x57rXvPNuhAUSJpl5pEKzB/zzhj
 D06xc3GpGeLqAmdHlUl3TcZV8k9CryzQGgdRUdxu825z+k4vpchW0uOdNpxf4BVJ358D
 qzdawIJgwKrJWUbypZlQPR6SWCKhtxWfNZ8Z4f5Ji4KN7F1DYLEMAWgyFMWCMLcb9o5T
 Xv8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=TGcmfNlDWPZF6zKifFKModO2QCDgF7kjS3M9oH6wUnM=;
 b=lqV4kTn1e54V28aNYAHnsK1nDOo+9qy1T+rZ9nw7RmxAvP3dHcFkpmtV/IJArw2cxL
 iWKyH5oATHuTjRoHzqgkJa2XX/4eoO4gowUs+zaetU9sw3CqpfJh5P3f24CWjysl3F32
 1E8heJj9nKa8aiBfUt7IL0GOzXCXzbSdPhbzGcyB6JTo96oE0bjkT4xJ2LUH6t7ThmDk
 VWJLVl6XkS5OUouZH/JqY465Gz/4gAY+h7+VqF645nOWKlheDoTiSCs/J3e5Cld3B4mj
 gio0RVvh7GZmIsp1oG6CQPqahpyXu+x6xDxLy6dODv1b/h49WTM780ayv/IFT3xkME/x
 fdOw==
X-Gm-Message-State: AGi0PubTdqXkdI6QjGUFRn6Sa0vXvjEP/GM9blEf9T7K7iffPq3W5co/
 ZIABf8ipa7XQ2XJtNotI3KAgvw==
X-Google-Smtp-Source: APiQypIk1l3dAIwZzQXczf5nsuvc8qoVIPHvore/ektV3epakATUHPxxDGvB1rFyjnYyku6TZ7s5OQ==
X-Received: by 2002:a1c:dc8b:: with SMTP id
 t133mr11000234wmg.117.1588864704035; 
 Thu, 07 May 2020 08:18:24 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q74sm961246wme.14.2020.05.07.08.18.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 08:18:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 1/5] docs/system: Add 'Arm' to the Integrator/CP document title
Date: Thu,  7 May 2020 16:18:15 +0100
Message-Id: <20200507151819.28444-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200507151819.28444-1-peter.maydell@linaro.org>
References: <20200507151819.28444-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x343.google.com
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


