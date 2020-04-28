Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 123E3C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:28:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0A112082E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 17:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kzkdl6Zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0A112082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41256 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTU2G-0004jm-UV
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 13:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41410)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTU0y-00036E-8T
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTU0F-0006ve-Fv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 13:27:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41365)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jTU0F-0006vK-3Q; Tue, 28 Apr 2020 13:26:39 -0400
Received: by mail-wr1-x443.google.com with SMTP id g13so25618199wrb.8;
 Tue, 28 Apr 2020 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xj9mbELBxmDJv8s9rOOYS9YWnqmysEZNeFuMvyIIlyA=;
 b=Kzkdl6ZotuJuQRi9dX0Gl+v1Qt0Rrwc/vwPNM7kYUWRImgpXPnYJW7Jrw87F+YYr1J
 c68jfMCbFNtTJ/1hsZv0drxDIyjrxQ014XUg7ipvyaKgWB7Vuxo3cJyKdpAguzRZP9E+
 9wRKj24gb2AyvHGkBlj0vdbZvthc41UhN1gIst9GnUrQagUNqZkHNcZtiRAJX3j5WEj3
 Pr0b2x3HT1TFmAKTFqqEBFwQNLaNHyxau23MTPaU9WvEx+88E6sNdvqoZceAjh5vMZ7b
 Fq3PX6q1jJabTzHHWM+Jo1gcY4avryYTOQRTg9gC4qNAhkZkaAUMPSrK4U0nJCYb1BCo
 4ygQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=xj9mbELBxmDJv8s9rOOYS9YWnqmysEZNeFuMvyIIlyA=;
 b=ITPzEspDVtPcuaOcNhcMd0f3nAWDDUNj+9muNz8PlZwzL81iFLqWLWWhYa/qi0jFwD
 TrF8jMrm3kJcGg92MeFPd1McZ2G8xwQ8sEtjBiGhcplXpAJUyxqoZeGimh2i6xFgo2Kh
 Swli3BvPtwsDXpD5IN6uTahSF+A39iSNKpstboweuSEZ0t+H817wxYUcFXcxRsKc3XU9
 ymygH+3HQU1k9Ar7QJhikXaSUAIWmLv+9fhVcIfWwqYC2r785ue0jHODHGRPL6HU/rB/
 MeiFh2a6BiQL/WqyEy3FdXDvBMmY6cJp3rUT0+5yQU6sFci2B/ERzRiOFsI3O3fyyr8i
 zFGw==
X-Gm-Message-State: AGi0PubY8uUAv3hynISh5Edg9xzIq10xHf8rTORd3W/zYwW1y6f+JhOY
 BmwwEmCA5B3Gx0Ms4gm9wx9GDFO9WFw=
X-Google-Smtp-Source: APiQypL47sLmxJRilvt7J9SQ036wwpQ0Wh7mkdbsCW45ZpWGBbrNTFllZpiG1bY0BIjdP+QeNzOvRg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr27383600wro.361.1588094796438; 
 Tue, 28 Apr 2020 10:26:36 -0700 (PDT)
Received: from x1w.redhat.com (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id w6sm27132286wrm.86.2020.04.28.10.26.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 10:26:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3] target/arm: Use correct variable for setting 'max' cpu's
 MIDR_EL1
Date: Tue, 28 Apr 2020 19:26:34 +0200
Message-Id: <20200428172634.29707-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::443
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.

This fixes when compiling with -Werror=conversion:

  target/arm/cpu64.c: In function ‘aarch64_max_initfn’:
  target/arm/cpu64.c:628:21: error: conversion from ‘uint64_t’ {aka ‘long unsigned int’} to ‘uint32_t’ {aka ‘unsigned int’} may change value [-Werror=conversion]
    628 |         cpu->midr = t;
        |                     ^

Suggested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Since v2: Do not use RESERVED bits.
Since v1: Follow Laurent and Peter suggestion.
---
 target/arm/cpu.h | 2 +-
 target/arm/cpu.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8b9f2961ba..592fb217d6 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -894,7 +894,7 @@ struct ARMCPU {
         uint64_t id_aa64dfr0;
         uint64_t id_aa64dfr1;
     } isar;
-    uint32_t midr;
+    uint64_t midr;
     uint32_t revidr;
     uint32_t reset_fpsid;
     uint32_t ctr;
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index a79f233b17..7ff80894b6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2757,7 +2757,7 @@ static const ARMCPUInfo arm_cpus[] = {
 static Property arm_cpu_properties[] = {
     DEFINE_PROP_BOOL("start-powered-off", ARMCPU, start_powered_off, false),
     DEFINE_PROP_UINT32("psci-conduit", ARMCPU, psci_conduit, 0),
-    DEFINE_PROP_UINT32("midr", ARMCPU, midr, 0),
+    DEFINE_PROP_UINT64("midr", ARMCPU, midr, 0),
     DEFINE_PROP_UINT64("mp-affinity", ARMCPU,
                         mp_affinity, ARM64_AFFINITY_INVALID),
     DEFINE_PROP_INT32("node-id", ARMCPU, node_id, CPU_UNSET_NUMA_NODE_ID),
-- 
2.21.1


