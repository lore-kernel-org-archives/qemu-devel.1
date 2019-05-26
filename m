Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E7C4C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:39:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA28F20815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA28F20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49254 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUi7n-0004KT-3z
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:38:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxF-0003HK-V8
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgI-0006Qa-7j
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:35 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37159)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgI-0006QH-2n
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:34 -0400
Received: by mail-pf1-f196.google.com with SMTP id a23so7511682pff.4
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=ePYfUi0rWjHzSUZxVonvvQDM/bFMIG9WKPecvkNdal0=;
	b=Y92O6T/8HAOXA4P55/ERR0U31X83uTFCXHSRsb4bYiSYMHaxXCBoD0mo4v60M7rwgK
	w4TZaMdkfcg2OPgqtDTsylWegVcB2hjO4QMEoG0jocF2XqJ3yE88wB6+gpJTd+CBkq85
	G+TnbACsOOTCBvOwTzQImIBhe1ieKacN8v2JPXjivt5EcSEeOTpT5V8XNV8p6VfpuZOn
	PRMxqQ8rnUFVGSX8eFreNMYqaiuwkWKXKWQc0Ed6KOgLO3rmjUbIhl13wdLvS/NSyoW8
	EEBt4wgHCLXk3ow/eRpVgPK5zlgcy2widkWCS/JYAABQ2S5/W/5DnwHNi+vK0pPHVsqw
	RDaQ==
X-Gm-Message-State: APjAAAWkNmlDeBUCX+5pAE6EAKYL9ehGjGVSo7n/pNK7FMn0P6p0yPjH
	7FwElVpMyPRAQ4zk52M1krMvEw==
X-Google-Smtp-Source: APXvYqyqbPYdR0ZcoUIlnyxv9Pik8Q6hTB82K++7HBNqvvUPdBQWvVEuYxz96XVCA47ZUCz/qziRzQ==
X-Received: by 2002:a62:304:: with SMTP id 4mr107211110pfd.186.1558833032608; 
	Sat, 25 May 2019 18:10:32 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id 25sm6410198pfp.76.2019.05.25.18.10.31
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:32 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:41 -0700
Message-Id: <20190526010948.3923-23-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.196
Subject: [Qemu-devel] [PULL 22/29] target/riscv: Add the MPV and MTL mstatus
 bits
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
 target/riscv/cpu_bits.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
index 945aa8dbb851..fe7164754b19 100644
--- a/target/riscv/cpu_bits.h
+++ b/target/riscv/cpu_bits.h
@@ -316,14 +316,11 @@
 /* mstatus CSR bits */
 #define MSTATUS_UIE         0x00000001
 #define MSTATUS_SIE         0x00000002
-#define MSTATUS_HIE         0x00000004
 #define MSTATUS_MIE         0x00000008
 #define MSTATUS_UPIE        0x00000010
 #define MSTATUS_SPIE        0x00000020
-#define MSTATUS_HPIE        0x00000040
 #define MSTATUS_MPIE        0x00000080
 #define MSTATUS_SPP         0x00000100
-#define MSTATUS_HPP         0x00000600
 #define MSTATUS_MPP         0x00001800
 #define MSTATUS_FS          0x00006000
 #define MSTATUS_XS          0x00018000
@@ -335,6 +332,8 @@
 #define MSTATUS_TVM         0x00100000 /* since: priv-1.10 */
 #define MSTATUS_TW          0x20000000 /* since: priv-1.10 */
 #define MSTATUS_TSR         0x40000000 /* since: priv-1.10 */
+#define MSTATUS_MTL         0x4000000000ULL
+#define MSTATUS_MPV         0x8000000000ULL
 
 #define MSTATUS64_UXL       0x0000000300000000ULL
 #define MSTATUS64_SXL       0x0000000C00000000ULL
-- 
2.21.0


