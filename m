Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15096C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1C8B20644
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1C8B20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49163 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi23-0007Lu-4P
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:33:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxD-0003GC-Dy
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgM-0006To-Fi
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:39 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:46128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgM-0006TB-9U
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:38 -0400
Received: by mail-pg1-f179.google.com with SMTP id v9so690314pgr.13
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=KIAg2gQWYBFXGhiwY1FH7h14Y3/EHJ7QY6t2x+0oGds=;
	b=IeA3cQyx0fUDB9fS3EhnKrRdGiexBKUVoUMqSoIbeLBizX/lumIUF7/T5svqjzWMzS
	ITjAWDaA1Ox3DvNw9mASMcZ5cfgI6MpUD8fcoVUaABdiDkpCzDMx4rj2NLWOXnGGcKLL
	eXINcgA5I1Q9QInKxvCx40OKt60Kd4TKEVx4SoU93qTPARqcmyvkeEu+AWxKZ1bhnMun
	Q/oJfFckejpwqNi6FBuX7A1SC+pfBYckKdWGVmByxux//kAdb7KOygI4sdiBqJF3JNue
	/sO5IzTTLOQNd4XcAnz1jBruxRFcg5eshTLfl6KDH+Zl4Sybal05CxakndFUpqIpccXq
	hIaA==
X-Gm-Message-State: APjAAAWWakVY2hAJScpGv/8J+6nxNIJwOBxu/87VeGMzcBhiAjTlrjVj
	n+Yn18eRtsZGdDeHSeecYWj/862blig=
X-Google-Smtp-Source: APXvYqwF6JP8Us09I64WIsfIvejVotMlJIqNBDgc+/vs2uoDLpkvnii0p/A4OuwgwBNPJEm6mN728g==
X-Received: by 2002:a17:90a:17c7:: with SMTP id
	q65mr19925459pja.92.1558833037044; 
	Sat, 25 May 2019 18:10:37 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id l43sm5675264pjb.7.2019.05.25.18.10.36
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:36 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:45 -0700
Message-Id: <20190526010948.3923-27-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.179
Subject: [Qemu-devel] [PULL 26/29] target/riscv: Add the HGATP register masks
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Alistair Francis <alistair.francis@wdc.com>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Alistair Francis <Alistair.Francis@wdc.com>

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index a179137bc1f2..dc9d53d4becf 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -208,6 +208,17 @@
 #define CSR_HIDELEG         0xa03
 #define CSR_HGATP           0xa80
 
+#if defined(TARGET_RISCV32)
+#define HGATP_MODE           SATP32_MODE
+#define HGATP_ASID           SATP32_ASID
+#define HGATP_PPN            SATP32_PPN
+#endif
+#if defined(TARGET_RISCV64)
+#define HGATP_MODE           SATP64_MODE
+#define HGATP_ASID           SATP64_ASID
+#define HGATP_PPN            SATP64_PPN
+#endif
+
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
-- 
2.21.0


