Return-Path: <SRS0=WNoQ=AJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45360C433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 19:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1554C206C3
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jun 2020 19:55:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dDftPtHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1554C206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpdOe-0005oJ-D0
	for qemu-devel@archiver.kernel.org; Sun, 28 Jun 2020 15:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpdNz-0005NR-LD
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 15:54:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50471)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpdNx-0000fx-Vb
 for qemu-devel@nongnu.org; Sun, 28 Jun 2020 15:54:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id l17so13488283wmj.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2020 12:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dd6UT/sJQhVQoU/A5etTLisFLDqNewMQfmLXJ1m4wic=;
 b=dDftPtHL3EHzIGBd6Ggh8DtUVevwB8J7NDSbey/OM/MCSGCGNqC4UTTj6/bDle4yvt
 7hAvz6iLo6EVpHY5U8OWLF3t4cXBm6pQS9uFMycPsVx/VKn6dBxBULqXPD3D2kPnjo2x
 dSvl05dKFMn6zxiSi/py+ckqO0Yektw+6f+ZSxB2SzreIBgB9hx95zgBa7f8/q1+fOF7
 a1u7LotW8GZ3/vKa/dfj8ca/jPelwEi9zYVNVIdGbzRkiIaDRtz4eCWfpiks/Cj5ITJJ
 +r7rqupQyH1HCyoHA65LwCfv3K2I12w0kj56U00DdjSWy7scD4O7CgqC+oCT4I3S0wbo
 THmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=dd6UT/sJQhVQoU/A5etTLisFLDqNewMQfmLXJ1m4wic=;
 b=Abr6JBKYgOJ+MKL/BNV+VQZk6pEgsp6nJAticKMSg639F3ppVxGkI5vL/TCvi2Wf9R
 OjDI5mnR7Nvc+TVMjnELtyK0MGdeh4bZKZoLdcpaY7m++zGk31obuuziibxmfFr/o24K
 MmNwnkyM9Ur8OlY9tczK0IZnv76xlA8KY+L2M4rPulYMGz6AMuNQY+IcwbaKdiUhz4iE
 SdEv/qWogmxSXqUuKUrjtkd0xK7UlEgDZGL9GrJLp7rYvdYWAf8QZ3roWkES1pq2K08u
 VFKv2AEhZU+/HCxSUeJQC9t74xgGgDGQEOkarOjYw8geeF/N/ma361/dA8/UbNn0L06e
 xAfg==
X-Gm-Message-State: AOAM531l19z1aqNYXW+XDC8VkwrVPKALtvX3QR81Q5WLrr/OKKS49hqb
 lfb68pt8O+IiPIBX4/OErxVMSw==
X-Google-Smtp-Source: ABdhPJwgsVcgEwOyaI+MJaBwDKm3YhqCh55Ou7MN4Q3udKfSEtFBTETsR8PwtZb9RhKpYxf/7RLNqQ==
X-Received: by 2002:a1c:de07:: with SMTP id v7mr13871715wmg.56.1593374078893; 
 Sun, 28 Jun 2020 12:54:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t4sm20609177wmf.4.2020.06.28.12.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2020 12:54:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/display/bcm2835_fb.c: Initialize all fields of struct
Date: Sun, 28 Jun 2020 20:54:36 +0100
Message-Id: <20200628195436.27582-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In bcm2835_fb_mbox_push(), Coverity complains (CID 1429989) that we
pass a pointer to a local struct to another function without
initializing all its fields.  This is a real bug:
bcm2835_fb_reconfigure() copies the whole of our new BCM2385FBConfig
struct into s->config, so any fields we don't initialize will corrupt
the state of the device.

Copy the two fields which we don't want to update (pixo and alpha)
from the existing config so we don't accidentally change them.

Fixes: cfb7ba983857e40e88
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Not sure why this wasn't a visible bug -- alpha isn't used,
but if pixo changes from zero to non-zero we flip from
RGB to BGR...
---
 hw/display/bcm2835_fb.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/display/bcm2835_fb.c b/hw/display/bcm2835_fb.c
index c6263808a27..7c0e5eef2d5 100644
--- a/hw/display/bcm2835_fb.c
+++ b/hw/display/bcm2835_fb.c
@@ -282,6 +282,10 @@ static void bcm2835_fb_mbox_push(BCM2835FBState *s, uint32_t value)
     newconf.base = s->vcram_base | (value & 0xc0000000);
     newconf.base += BCM2835_FB_OFFSET;
 
+    /* Copy fields which we don't want to change from the existing config */
+    newconf.pixo = s->config.pixo;
+    newconf.alpha = s->config.alpha;
+
     bcm2835_fb_validate_config(&newconf);
 
     pitch = bcm2835_fb_get_pitch(&newconf);
-- 
2.20.1


