Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE32C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:32:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAE720644
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAE720644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49161 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi1y-0007HI-T6
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:32:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxE-0003Hg-Qu
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgK-0006Rt-4a
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:36 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgJ-0006Ra-VY
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id u17so7496855pfn.7
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=VQ8fcwwFdIxm5HTObYVrKZCT6rKtwie9e2FUMwfKUS4=;
	b=amcd11AFOfx5nM4SIeRL18RN3piQfxMQheqcnSqfnacFE5VW+yhb3N59WPQHX6Jnhc
	WXbPFDckgfUpPg6ZfvMEBYRSKJp0VQO1ajZZRGn7xSLWnnrDfs6teTnoMK971+MlabvI
	SWl0fxYv8OhG59OwcfwI40C3xrjrh5XgJ4scBQ1uH7dVywMFWiRyhZJGAb08fEvPTR4w
	n7zX4Fn7CX1oYSdqkiXtNq+SgtBSW4Dck9SIHstSBkvbtdpXKhEmzGNFhTki6VKAbuoA
	LBCggnoMx59ctwxyhloU6YW5b3UTfp+/x9HKn5bK7Pi8iDnMrU3NK3ncdRSNRwnSmCKO
	NweA==
X-Gm-Message-State: APjAAAUqt5HM7NVEoXZeOcRS6y4HIWLic2YMByLnBrd+mlE56lGIS8R1
	AkouppzKziKHsa0W5HOmHVCzrQ==
X-Google-Smtp-Source: APXvYqys2KYuKN4U7KzKmfBzhu9d270erB562S7aRzp/Nrwa0C63vk4UDPQTvdwksXis2on/X3cJTw==
X-Received: by 2002:a63:1150:: with SMTP id 16mr116821920pgr.40.1558833034802; 
	Sat, 25 May 2019 18:10:34 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	b4sm6805720pfd.120.2019.05.25.18.10.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:34 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:43 -0700
Message-Id: <20190526010948.3923-25-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.194
Subject: [Qemu-devel] [PULL 24/29] target/riscv: Add Hypervisor CSR macros
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

Add the 1.10.1 Hypervisor CSRs and remove the 1.9.1 spec versions.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index fe7164754b19..52c21699774f 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -202,6 +202,12 @@
 #define CSR_DPC             0x7b1
 #define CSR_DSCRATCH        0x7b2
 
+/* Hpervisor CSRs */
+#define CSR_HSTATUS         0xa00
+#define CSR_HEDELEG         0xa02
+#define CSR_HIDELEG         0xa03
+#define CSR_HGATP           0xa80
+
 /* Performance Counters */
 #define CSR_MHPMCOUNTER3    0xb03
 #define CSR_MHPMCOUNTER4    0xb04
@@ -292,9 +298,6 @@
 #define CSR_MHPMCOUNTER31H  0xb9f
 
 /* Legacy Hypervisor Trap Setup (priv v1.9.1) */
-#define CSR_HSTATUS         0x200
-#define CSR_HEDELEG         0x202
-#define CSR_HIDELEG         0x203
 #define CSR_HIE             0x204
 #define CSR_HTVEC           0x205
 
-- 
2.21.0


