Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC3DC07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28CBA20644
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CBA20644
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49220 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi4w-0001dr-B3
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:36:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxD-0003HK-Uu
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgL-0006So-Cj
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:38 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgL-0006SK-7R
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:37 -0400
Received: by mail-pl1-f177.google.com with SMTP id g21so5660535plq.0
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=J7lhhgtf0sOTXH1yJE/Uqjkv+hDa7WrYfOdgGU5K6D4=;
	b=Tac60sdLGy+l3lYMhA9dbXMcWT+prMolc/h2Pw3RZ8QPR49VJK9moTHO+w5DclVNdQ
	qGvyyRbfMYxmcYacfNHzB81WygZ2U3wbg0arGNhIzJbuXBfD0Y1b5g+FslKutEgLl6ux
	6+ZQqAXdcz1m+5HVPsnnczK1fpIVyZ1N5rKUNLHwXO5oMAXSU0gz4RpTZbWHZThyKcZq
	aTWgc0mYedYJO3CzH60Slg6bfFq4SQ0okamrV7CIYhTHklW7d7e3j7UBb26GV0cu43re
	PM00YLOrBa6GCzzQTvTHiVHP7rvS6ASUh2z2foTVSSekVXCoGufV2TBovjISFSfjKZzP
	aGRA==
X-Gm-Message-State: APjAAAUdgRsLu4Svx7/SEGYRrMwCGsATcaazl+YSGMbN9uD6YdxE8C0K
	jnEp0d90zs4x3OGPAzpgcudK6Q==
X-Google-Smtp-Source: APXvYqx3aSfewtpSAEOx4sclNnBttL3hHIQSuLNFe9dadntDNBnK9LAGKDhPeKWUHYLb5vtuO1WPaQ==
X-Received: by 2002:a17:902:2d:: with SMTP id
	42mr118552335pla.34.1558833035950; 
	Sat, 25 May 2019 18:10:35 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	g22sm6826305pfo.28.2019.05.25.18.10.35
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:35 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:44 -0700
Message-Id: <20190526010948.3923-26-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.177
Subject: [Qemu-devel] [PULL 25/29] target/riscv: Add the HSTATUS register
 masks
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
Reviwed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/cpu_bits.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 52c21699774f..a179137bc1f2 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -382,6 +382,24 @@
 #define SSTATUS_SD SSTATUS64_SD
 #endif
 
+/* hstatus CSR bits */
+#define HSTATUS_SPRV         0x00000001
+#define HSTATUS_STL          0x00000040
+#define HSTATUS_SPV          0x00000080
+#define HSTATUS_SP2P         0x00000100
+#define HSTATUS_SP2V         0x00000200
+#define HSTATUS_VTVM         0x00100000
+#define HSTATUS_VTSR         0x00400000
+
+#define HSTATUS32_WPRI       0xFF8FF87E
+#define HSTATUS64_WPRI       0xFFFFFFFFFF8FF87EULL
+
+#if defined(TARGET_RISCV32)
+#define HSTATUS_WPRI HSTATUS32_WPRI
+#elif defined(TARGET_RISCV64)
+#define HSTATUS_WPRI HSTATUS64_WPRI
+#endif
+
 /* Privilege modes */
 #define PRV_U 0
 #define PRV_S 1
-- 
2.21.0


