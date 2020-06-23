Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F23BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68CEE206A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 12:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L4n6WaKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68CEE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnhcg-00081Y-ID
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 08:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHG-0003VJ-Qf
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:42643)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnhHF-0003Or-5X
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 07:39:46 -0400
Received: by mail-wr1-x442.google.com with SMTP id o11so12449557wrv.9
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 04:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=SI0UuaYn0LhrgnH6JJza5nCoeq6PoqqyPFPSDuwFopc=;
 b=L4n6WaKjnTeSm0Jxq6WbowY1X3LmIW5sUu3GadFqIli6aDuffMh4u7jJpFaMsaoutN
 bZjNx1DiVKiVr+B9nEl7OKMGz4g5RZxEhd8bvQ8llVLvhVWyIFCDRgmWR8BR3WCw696p
 W0u29LQ56sKu0aF9WHBQjLdzmI4/wc+nC2fgYK7z0UGxOdMz81DDkb6tlbK9pkqf8Nm0
 bqYCJ5xa79BUDClvWuBcQ8mZuGlHeBJ3wrJQiUHSl1nS3xy8gD5Lmq4Wb6r9cR6IIYBj
 Lvyt+31RslVDuzrb6HKDLz9pnf3zNcqwDyYzJAcjNAhKkhKQmJy4SoiZVdR4sIZrFD0Z
 wTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SI0UuaYn0LhrgnH6JJza5nCoeq6PoqqyPFPSDuwFopc=;
 b=d8LcqpDNv0FrnxiX5MTdi97jdlolJvTgT0redciLcxg/8XYhuKBX5NzZno7p2JIbvq
 b9cNqIiUSwqMnuHO6smrDNwm+pYv2kxWEikYbxLt90593CLnk1u5u8g4YidAIxHebGuI
 3oKU4w9U8jsKqoh8yXVtel0+TlpF0G+RwJB4MT7Zrnl9Fsc0qfDvbLABZbGYDif0PeSW
 Wvqkmmhcu+N/hTT9OLL921DcVBkZO4He/bx3UrZQdyNZGxpjiyIkJ4hGSvRCkvJSitkH
 +U3AL1bCL2liPs/TBdKNwgjYx+5zc2fsyUpG/QvcTPldFnaui8Fu/+5S8tlzeXTjbVm7
 bm4g==
X-Gm-Message-State: AOAM532GYuKjrvNqFzQ6qhwSGWaCb4r7kKQBN0w0xoGJpKLz1RfXCOxD
 f3l0HkHAO54oai32JcGJd0yWsG/3MhjGTg==
X-Google-Smtp-Source: ABdhPJw+K8zcNWdkInPj0drZXSSwDG4JPuvYaOweHgzPiQTWKabs9nbsx76d+yO1TKWCiEOYwHseAw==
X-Received: by 2002:a5d:5642:: with SMTP id j2mr17589023wrw.19.1592912383658; 
 Tue, 23 Jun 2020 04:39:43 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id m10sm4022177wru.4.2020.06.23.04.39.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 04:39:43 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/42] hw/arm/mps2: Rename CMSDK AHB peripheral region
Date: Tue, 23 Jun 2020 12:38:54 +0100
Message-Id: <20200623113904.28805-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623113904.28805-1-peter.maydell@linaro.org>
References: <20200623113904.28805-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

To differenciate with the CMSDK APB peripheral region,
rename this region 'CMSDK AHB peripheral region'.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20200617072539.32686-8-f4bug@amsat.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index ee555f919de..4fe5cc8622f 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -212,10 +212,11 @@ static void mps2_common_init(MachineState *machine)
      */
     create_unimplemented_device("CMSDK APB peripheral region @0x40000000",
                                 0x40000000, 0x00010000);
-    create_unimplemented_device("CMSDK peripheral region @0x40010000",
+    create_unimplemented_device("CMSDK AHB peripheral region @0x40010000",
                                 0x40010000, 0x00010000);
     create_unimplemented_device("Extra peripheral region @0x40020000",
                                 0x40020000, 0x00010000);
+
     create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
     create_unimplemented_device("VGA", 0x41000000, 0x0200000);
 
-- 
2.20.1


