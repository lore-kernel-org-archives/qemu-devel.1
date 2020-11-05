Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F598C55179
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE8022203
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 18:11:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ojJ/7JWg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE8022203
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kajiz-0005ZB-D3
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 13:11:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34782)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR5-0004Zo-15
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:35 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46737)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kajR1-0004t2-7S
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:52:34 -0500
Received: by mail-wr1-x443.google.com with SMTP id a3so2628555wrx.13
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6HDnL9lHgiiH9MDMI0qBRqslGyWUb9BrATmyPde4NtI=;
 b=ojJ/7JWg/Rttp9cb91BI9irG0lx9GyYLxNzVECXDlBcd6WL9uYvsVynlaG+vWbVVkq
 oStz5uNAVI+mPOmt1VmkISYUFYg5VNvdooNrczxm49L6weCQUihresOWDEzI+Lg1+qxD
 kuZvPpsOUEDXXJjwWMh+UCORCSekNQ1NEtKXKilTCIU38/8V05j205C/en1wYtcAwBgd
 wLRST6+YZKGI+HTqHemHyHBXFeXFvoIlomyCCfvVOpl6LfGLtoZdCohe5iyOd17wv+5k
 ODvasRzD676TgTouvraQiTpfZ+lkp6cGsjbv4Zt65nMfz6Zi9HVhXjw1V6m8V2kpb/B2
 /lBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6HDnL9lHgiiH9MDMI0qBRqslGyWUb9BrATmyPde4NtI=;
 b=GIuTANg2KeZeogi17D8Z1prbgUhxgmllqFQ+rjULR5kc7eTB40iO2yC+bo/7bDA7hQ
 cqX5H+/tHCtvKA+kqRxtKQRpxf79EO02v0Q2+ZDNxpy6pR2X3+RGkDI6CwC9ODZEMMxN
 zVvWW3mZFxojnlsTjEV3/rFIArp319g0bXx8NmSovDtO0Wvw87fFhdlb9x0W26PKymTd
 EI02ZKlE3R98IpWkQ4F5w/K6URoJITjEoQu+1pyX5OT6IcqpFgGLdT896fFzc29H3CJy
 NWLJOK0W+8JrjFocZAzwH5ceaSI0olHou8Ot4sIzMj4PpNZfunGjvBoOTOe0HMZOHp7A
 21vw==
X-Gm-Message-State: AOAM5317jXuB8rguOLWDDCHI1zC89ehM+QI6qpUE0Kpl6ixZFpWDK9Ab
 uzE+PC1dFSfTrxr3PDGjp3LUTw==
X-Google-Smtp-Source: ABdhPJwFK5j2f9TimoBCcdqXsXQAzgKKoSCuFcFCFKKZzONtrhaUMN5iOfMdIidHjtSIaGcLRH9gbg==
X-Received: by 2002:a5d:4bd1:: with SMTP id l17mr4643449wrt.38.1604598749318; 
 Thu, 05 Nov 2020 09:52:29 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u6sm3257348wmj.40.2020.11.05.09.52.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2020 09:52:15 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EA3E51FF9C;
 Thu,  5 Nov 2020 17:51:54 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH  13/15] accel/stubs: drop unused cpu.h include
Date: Thu,  5 Nov 2020 17:51:51 +0000
Message-Id: <20201105175153.30489-14-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105175153.30489-1-alex.bennee@linaro.org>
References: <20201105175153.30489-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: julien@xen.org, masami.hiramatsu@linaro.org, andre.przywara@arm.com,
 stefano.stabellini@linaro.org, takahiro.akashi@linaro.org,
 Colin Xu <colin.xu@intel.com>, Wenchao Wang <wenchao.wang@intel.com>,
 "open list:X86 HAXM CPUs" <haxm-team@intel.com>, stefano.stabellini@xilinx.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 accel/stubs/hax-stub.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/accel/stubs/hax-stub.c b/accel/stubs/hax-stub.c
index 1a9da83185..49077f88e3 100644
--- a/accel/stubs/hax-stub.c
+++ b/accel/stubs/hax-stub.c
@@ -14,7 +14,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "cpu.h"
 #include "sysemu/hax.h"
 
 int hax_sync_vcpus(void)
-- 
2.20.1


