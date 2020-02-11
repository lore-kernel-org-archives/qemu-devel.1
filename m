Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD8FC352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACA0A20661
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 17:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Or+uJnxK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA0A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1ZX6-0002lF-RH
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 12:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48586)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTk-0005ld-I5
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j1ZTh-00047k-HT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:44 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j1ZTh-00041w-2X
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 12:37:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id t2so13513085wrr.1
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 09:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qxQxsH3Nx8XV7gIhtppy/YXx/6TNRZKK5/Th8LAFzrk=;
 b=Or+uJnxKkB+GMkRP2hg+4vyPMAOYFHQgggoAJPhT9R4YxuWXTgS2WgwCv+sdziRws1
 cd/vVZvzpO8Ck8IyQ2Hz+Y/7JKqMPcofJNUN5FFW2M5Aeqo4Yo/qwlc/LdLWOZgplh+R
 Vr7SkBSa1A3zgLTCie7P0/UPYKrUDSk8EZoNTBKqOMOsCUtvwiX5W/Hsn93dm2bjqI0d
 mUUcUQpDOKnCnYIQHBeISv79NXTyfzrFcEk+4eB5z6StWh66XQ24dfi4iRKPDrMfuYw5
 Y0m6aHGoROcaY0HPSckQXhiXMIK5kbnNnehEykk2ZlQ6FHFOtw4kU5O8dphR5Z46nrtv
 +IsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qxQxsH3Nx8XV7gIhtppy/YXx/6TNRZKK5/Th8LAFzrk=;
 b=K7+vfqJ74h4C81xWEGtaF3TKMpesgPRwVVTLVaaq9Hy3JZ+2OJajOEgZqPwmSVFWIY
 iLd+U3HHe6e3WcJMjo3GDTiyHDiUwAiSkyn/p0dMeWt6fEH/EDbjjnSGUYdazDGLeXKp
 oxcspQ1y02JcgnjoAZYXa1atoLXRfw8J9eVZspCwmEjFHohOXtT1UsXbt19zw0yo1MxK
 Ue0GmJNWRPlmABp/owVgaVkQhxXUDXiduBbCFuxSnW7hp2iEMEaFQzw0lm6rgV8RLRy3
 CmHYD5GtVUQrTDcl/QT5z7u89aKiSrj2CVElTVZgm40wQ8kkeefx8mmSdYYi4pngf12L
 rxTg==
X-Gm-Message-State: APjAAAWNazYxlQy2V7sdZAVv+B5tZWa+sbiZSigSXRLuoisOnrhYMK0D
 MnXJqgUU5UOMfm9YKJBCH0VUwA==
X-Google-Smtp-Source: APXvYqxL5OzHiKpM25WXZN02bwuTG/dLrHwv/AXG49S6J/zl090mnsU85INwztH9W7Wlo5ibc+cKYw==
X-Received: by 2002:a5d:6082:: with SMTP id w2mr9633556wrt.300.1581442657385; 
 Tue, 11 Feb 2020 09:37:37 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y1sm6109675wrq.16.2020.02.11.09.37.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 09:37:36 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 06/13] target/arm: Use FIELD macros for clearing ID_DFR0
 PERFMON field
Date: Tue, 11 Feb 2020 17:37:19 +0000
Message-Id: <20200211173726.22541-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200211173726.22541-1-peter.maydell@linaro.org>
References: <20200211173726.22541-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Eric Auger <eric.auger@redhat.com>,
 Aaron Lindsay <aaron@os.amperecomputing.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We already define FIELD macros for ID_DFR0, so use them in the
one place where we're doing direct bit value manipulation.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
We have lots of this non-FIELD style in the code, of course;
I change this one purely because it otherwise looks a bit odd
sat next to the ID_AA64DFR0 line that was changed in the previous
patch...
---
 target/arm/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index dc582da8fa4..e7858b073b5 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1603,7 +1603,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
     } else {
         cpu->id_aa64dfr0 = FIELD_DP32(cpu->id_aa64dfr0, ID_AA64DFR0, PMUVER, 0);
-        cpu->id_dfr0 &= ~(0xf << 24);
+        cpu->id_dfr0 = FIELD_DP32(cpu->id_dfr0, ID_DFR0, PERFMON, 0);
         cpu->pmceid0 = 0;
         cpu->pmceid1 = 0;
     }
-- 
2.20.1


