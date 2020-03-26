Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B3C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:47:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB82B206E6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 19:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gsC8RzGU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB82B206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHYTW-0006Rw-Oe
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 15:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58554)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKB-0006WK-MZ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <robert.foley@linaro.org>) id 1jHYKA-0001Uu-L8
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:55 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:34949)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <robert.foley@linaro.org>)
 id 1jHYKA-0001Uc-H6
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 15:37:54 -0400
Received: by mail-qt1-x843.google.com with SMTP id e14so6560270qts.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5p5QVMZ54qL4PKza/xfxsC7DswUaUr8tRQACxDFIq5U=;
 b=gsC8RzGUTyXSQR4RxqGvgtbU+GedsxhCgLCACtiD7u+2ik/z2ZUdPv7m+wfFDsrDMb
 gFfXJqQsAHKqahTFGfWFD0UdUduk+7nJPkxieLc9PuAHE/GVJsKQPdOCxd51grTzCqx5
 SqHl8StTHeiibqfC2FBM45o6BmdJRj/cim3KeH3bNXveAzhKi2S95X8DggOyzOfctdmQ
 H3L0Xm0N3ZsmDcRcThcdOBgW/gmSy2DF2pq7sIICZKVGSuQELEk6YnCipkrXffuyHvgC
 t3V27a6pQOOheVTC6EQSx+9jNGXXRT1NWHTTdxcFzdRfe32wWoYKpAphBIVs732nJwx9
 kVug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5p5QVMZ54qL4PKza/xfxsC7DswUaUr8tRQACxDFIq5U=;
 b=sUzHkF+s9w1zRKGgXK09tX4dCci85HQuFmudkEyu0wCjxuR3DvoxSBkSz7vdW8JOLP
 FlYZamdFFPFS3wkD8PbA4XIIskq9vbmjyICrlqLwtVErrmTFvtOUdSddO15tn6EoyLso
 zXwl4sarbvxH4usIvoftbt5TXgLn3zRXz4WAFHEP9ig7b2LaMqpVPqCey0kmG9lfSnqU
 OKyT89YwNumJOD0tWVRZEVPET9cymnraIRDkocTEOKlGJyUePMjsR01vuiEVCtX7u8Mc
 ZVrD2iygs3PjJwsqn8g/s+lOMpFbn4L7M68d+fa5xwtA3BiHDUVwV2VA3bmi/tZ4rnrD
 s7tg==
X-Gm-Message-State: ANhLgQ2DmkCAQ2GR7xb20CJZjwOeMCxzLkBEJspD82xy4HaHTQqtyENs
 mQvDTcTrgUvx0SdaFRKtcfaBeC364J6ECQ==
X-Google-Smtp-Source: ADFU+vvG3oaWmnxq+sJzzkdx3egsQZdL/OxwixhzbwPleOkapoexTbO8fDjfIxV+u2cPpuYvAoHepw==
X-Received: by 2002:ac8:68c:: with SMTP id f12mr1873056qth.100.1585251473638; 
 Thu, 26 Mar 2020 12:37:53 -0700 (PDT)
Received: from Rfoley-MA01.hsd1.ma.comcast.net
 ([2601:199:4480:60c0:fd55:4e67:1038:8302])
 by smtp.gmail.com with ESMTPSA id u51sm2161916qth.46.2020.03.26.12.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2020 12:37:53 -0700 (PDT)
From: Robert Foley <robert.foley@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 16/74] tcg-runtime: convert to cpu_halted_set
Date: Thu, 26 Mar 2020 15:30:58 -0400
Message-Id: <20200326193156.4322-17-robert.foley@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200326193156.4322-1-robert.foley@linaro.org>
References: <20200326193156.4322-1-robert.foley@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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
Cc: richard.henderson@linaro.org, "Emilio G. Cota" <cota@braap.org>,
 alex.bennee@linaro.org, robert.foley@linaro.org, peter.puhov@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Robert Foley <robert.foley@linaro.org>
---
 accel/tcg/tcg-runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-runtime.c b/accel/tcg/tcg-runtime.c
index 32ec18fe40..ca0774d3bf 100644
--- a/accel/tcg/tcg-runtime.c
+++ b/accel/tcg/tcg-runtime.c
@@ -173,5 +173,5 @@ void HELPER(cpu_halted_set)(CPUArchState *env, uint32_t val)
 {
     CPUState *cpu = env_cpu(env);
 
-    cpu->halted = val;
+    cpu_halted_set(cpu, val);
 }
-- 
2.17.1


