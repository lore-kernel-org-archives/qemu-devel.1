Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD63C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:53:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499C2206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OKDNOhyO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499C2206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEes-00010P-Hp
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:53:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58358)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbJ-0003kW-Du
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:45 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:46957)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEbI-0004LO-Df
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:49:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id x6so10204210wrm.13
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RbfN3UAKOxV1a7MN3ugZcRLG3PinsC5XFsde1PoDV3g=;
 b=OKDNOhyObI6MafLc/Ew6BWrO3gWnH1n555mwTa9BmMyx2C9GIIBQmQ9ot/DdbU82Up
 I6zqfMje3jKHE3GTxRGm/DMqRX3Jyfkky0EE8MInWbn9U7I86rCmjAOLYwq3+ePtsZoh
 ER3QKetQscL79R7DtiJzlYnJ2JupyLbawZPdopNkA4XUdM0vaiVwstYkTlsc7++VItbI
 DwkaNBOV8cQjYyaPrj5s1YXJmfIJfXWOTIPxNMc+NsT2jlX0sQo5qdmF3sUSfsUHRtQX
 ZjjEg6Qogz+zg7n+E4M9FIdMPl4IhckI6UriNj9y6ILfhLlQpGWrh3AgadqzWYJ2vmEw
 j/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RbfN3UAKOxV1a7MN3ugZcRLG3PinsC5XFsde1PoDV3g=;
 b=Gsb/zH7bSiyg0mQf4P6D5w2ufUodT/m4X/SWO4wiu1omyp7a5G6FkczhaawDAjXIcZ
 Qozm4GxE25GKQLO1ZvgvqXKtTL2GzZJ4TpJcFlJHHaPwN87/r16/4FeHLkpO9wrzFr1R
 5f6jDO/f0UTa/59Hw6mE3sgw9NahsTv7fcMjNpZxSxz1MbuQYVxPDam3WDAu9AqazSHe
 SwerLDmEb7BDuq1BEaeK3fMkgqu28uy3tjjLChJdS7ScKJCrWsxyn72nG7SU7L73clkc
 ijhCT/w/y7W7x1sh/fPz1UJSsxLUKdah8ofpvZDZyfeIlCE8z9j5W0CeD1BFOgraDn8o
 PsPA==
X-Gm-Message-State: AOAM532Ti5eTe7l0K6uXa/jhXsPzcsH+xGj2OD031qSDq1o3BMPNr7sX
 sezVlUUyBAFup/x22ipEBCK03w==
X-Google-Smtp-Source: ABdhPJz3k8tDQcfQUzbhIZa+UXu+A/k/5nzbIOtPCy9L2uMKyuS138ftq4N0cnava1FOdRTWNcbOdg==
X-Received: by 2002:adf:fd4b:: with SMTP id h11mr9932711wrs.209.1591372183004; 
 Fri, 05 Jun 2020 08:49:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n1sm12446584wrp.10.2020.06.05.08.49.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:49:40 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB0DB1FF96;
 Fri,  5 Jun 2020 16:49:29 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 08/14] tests/docker: fix pre-requisite for
 debian-tricore-cross
Date: Fri,  5 Jun 2020 16:49:23 +0100
Message-Id: <20200605154929.26910-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200605154929.26910-1-alex.bennee@linaro.org>
References: <20200605154929.26910-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
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
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reported-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/docker/Makefile.include | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index ed46bd98eb5..981b7fcf2a5 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -130,7 +130,7 @@ docker-image-debian-sparc64-cross: docker-image-debian10
 docker-image-travis: NOUSER=1
 
 # Specialist build images, sometimes very limited tools
-docker-image-tricore-cross: docker-image-debian9
+docker-image-debian-tricore-cross: docker-image-debian9
 docker-image-debian-arm64-test-cross: docker-image-debian11
 
 # These images may be good enough for building tests but not for test builds
-- 
2.20.1


