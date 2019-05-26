Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB2C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:30:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C8472075E
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C8472075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49096 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUhzA-0004wn-K4
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:30:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxC-0003Hg-Hv
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhgN-0006UX-Un
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:40 -0400
Received: from mail-pf1-f173.google.com ([209.85.210.173]:44180)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhgN-0006U6-OK
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:39 -0400
Received: by mail-pf1-f173.google.com with SMTP id g9so7487399pfo.11
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=niN4BQwRj/iTWl309DyTteKW5yqNgmgqemJXUQlVM6Q=;
	b=tfB02dBStjAMSB1j+6UK3wyLDCfe9xWewMIHl5uElucL5MQk5d3LyP2/em1ehjIHCz
	SKxkHgD9Q8956fpKmiUgg/AbngXsu0zo0+YabFg9VzCEWQSmKpAVKh9mZpJebsKzZAPG
	DOG8n4M+KVtp+ydPhPQZURngDCcKnb6aRM5btjLKDOkAjze8HIUgb2tD9okgJGAQQioA
	8PgjtOXVL4Azgv0arRS1KxTwgoO5feFfnlqZ2uQR8xVTNiG8pExqNyXaVLnquHRqL8kG
	x1Ijmp+kJue/Lh/0DD8Rwe7LMxeGgwadkq5bBBGoIIp6CuRvoDdTnqeVJDF0HcU8ZBQZ
	gL7Q==
X-Gm-Message-State: APjAAAWMT0i09lT5vonYnUhS97j21YgfialrumGMcRQpWlZK7phqpOss
	wNEM7ecCTe0uIY5odjU19S3BIA==
X-Google-Smtp-Source: APXvYqxFrBxvVTpxjJFShiK4u0T6spM17yF8HNMDiZvO6E4GU6DAqlnoeguQd7cKu7fk3NdQCW8QjA==
X-Received: by 2002:a63:1224:: with SMTP id h36mr24384550pgl.9.1558833038226; 
	Sat, 25 May 2019 18:10:38 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	a11sm6828548pff.128.2019.05.25.18.10.37
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:37 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:46 -0700
Message-Id: <20190526010948.3923-28-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.173
Subject: [Qemu-devel] [PULL 27/29] target/riscv: Add checks for several RVC
 reserved operands
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Palmer Dabbelt <palmer@sifive.com>, qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

C.ADDI16SP, C.LWSP, C.JR, C.ADDIW, C.LDSP all have reserved
operands that were not diagnosed.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 target/riscv/insn16-64.decode | 10 ++++++++--
 target/riscv/insn16.decode    |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/target/riscv/insn16-64.decode b/target/riscv/insn16-64.decode
index 055859d29f61..672e1e916f6b 100644
--- a/target/riscv/insn16-64.decode
+++ b/target/riscv/insn16-64.decode
@@ -21,10 +21,16 @@ ld                011  ... ... .. ... 00 @cl_d
 sd                111  ... ... .. ... 00 @cs_d
 
 # *** RV64C Standard Extension (Quadrant 1) ***
-addiw             001 .  .....  ..... 01 @ci
+{
+  illegal         001 -  00000  ----- 01 # c.addiw, RES rd=0
+  addiw           001 .  .....  ..... 01 @ci
+}
 subw              100 1 11 ... 00 ... 01 @cs_2
 addw              100 1 11 ... 01 ... 01 @cs_2
 
 # *** RV64C Standard Extension (Quadrant 2) ***
-ld                011 .  .....  ..... 10 @c_ldsp
+{
+  illegal         011 -  00000  ----- 10 # c.ldsp, RES rd=0
+  ld              011 .  .....  ..... 10 @c_ldsp
+}
 sd                111 .  .....  ..... 10 @c_sdsp
diff --git a/target/riscv/insn16.decode b/target/riscv/insn16.decode
index 433c0e8c6861..1cb93876fe0f 100644
--- a/target/riscv/insn16.decode
+++ b/target/riscv/insn16.decode
@@ -96,6 +96,7 @@ sw                110  ... ... .. ... 00 @cs_w
 addi              000 .  .....  ..... 01 @ci
 addi              010 .  .....  ..... 01 @c_li
 {
+  illegal         011 0  -----  00000 01 # c.addi16sp and c.lui, RES nzimm=0
   addi            011 .  00010  ..... 01 @c_addi16sp
   lui             011 .  .....  ..... 01 @c_lui
 }
@@ -113,8 +114,12 @@ bne               111  ... ...  ..... 01 @cb_z
 # *** RV32/64C Standard Extension (Quadrant 2) ***
 slli              000 .  .....  ..... 10 @c_shift2
 fld               001 .  .....  ..... 10 @c_ldsp
-lw                010 .  .....  ..... 10 @c_lwsp
 {
+  illegal         010 -  00000  ----- 10 # c.lwsp, RES rd=0
+  lw              010 .  .....  ..... 10 @c_lwsp
+}
+{
+  illegal         100 0  00000  00000 10 # c.jr, RES rs1=0
   jalr            100 0  .....  00000 10 @c_jalr rd=0  # C.JR
   addi            100 0  .....  ..... 10 @c_mv
 }
-- 
2.21.0


