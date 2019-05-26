Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FAC4C07542
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:46:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E0020815
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 01:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E0020815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49407 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUiFA-0002YI-FP
	for qemu-devel@archiver.kernel.org; Sat, 25 May 2019 21:46:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhxL-0003GC-FE
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:28:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hUhg9-0006Bj-PI
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hUhg6-0005x2-I0
	for qemu-devel@nongnu.org; Sat, 25 May 2019 21:10:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so7080933pgm.7
	for <qemu-devel@nongnu.org>; Sat, 25 May 2019 18:10:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:cc:from:to;
	bh=4bBhQ9kganCVq1dJ403sszl/Wog9yBvWM1+fvLLlsdk=;
	b=VVmDpKiVKKwfuy09tLbOI5laTytraoii3HV+LA0rUikKPJSDhM5kWRooPBmV0OvTeb
	IET4JFpVE9tA7v3JV35Z1VtfG35XhxQb6Wb6aHan9pTYuI2W5cvWkdqwbl/U4ONQ5JNb
	zFlMlJ24jxsALLKysoo0AANhl9sMqrcOUAtbtC63Yri1+6imFr+RBZ7//n3qIORW6sZC
	DSi0+RFzlt7x30Pm998nPe4XoEAI+OLW8cWfNBGzacXVThdzoBkGztUaT6ZCILsxslsQ
	zuifgP8BnRfByA9/oYATwnceNlsxFk1boGsFJgSpd12IGiynvIQg+YJ/1dbJK2vxozzR
	2V0w==
X-Gm-Message-State: APjAAAUwk8Snymr0wV340hd0hmI0do+YUWN5+VNI/1kkVZNz1y7bIVQ6
	cuVt0z4kO22ZzwH6SwypRKP8mhDiy0Q=
X-Google-Smtp-Source: APXvYqw3hrIqaAxl/xFRvZtZK5blDbpQajvTtKP42Ce8xxtOnknCcqzuOZ2CPvAg04Nt7X0cH836mw==
X-Received: by 2002:a65:6255:: with SMTP id
	q21mr105163733pgv.211.1558833019583; 
	Sat, 25 May 2019 18:10:19 -0700 (PDT)
Received: from localhost ([12.206.222.5])
	by smtp.gmail.com with ESMTPSA id t10sm7999147pfe.2.2019.05.25.18.10.18
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Sat, 25 May 2019 18:10:18 -0700 (PDT)
Date: Sat, 25 May 2019 18:09:32 -0700
Message-Id: <20190526010948.3923-14-palmer@sifive.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190526010948.3923-1-palmer@sifive.com>
References: <20190526010948.3923-1-palmer@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
From: Palmer Dabbelt <palmer@sifive.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.215.194
Subject: [Qemu-devel] [PULL 13/29] linux-user/riscv: Add the CPU type as a
 comment
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
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 linux-user/riscv/target_elf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/riscv/target_elf.h b/linux-user/riscv/target_elf.h
index a6716a6aac23..9dd65652ee45 100644
--- a/linux-user/riscv/target_elf.h
+++ b/linux-user/riscv/target_elf.h
@@ -9,6 +9,7 @@
 #define RISCV_TARGET_ELF_H
 static inline const char *cpu_get_model(uint32_t eflags)
 {
+    /* TYPE_RISCV_CPU_ANY */
     return "any";
 }
 #endif
-- 
2.21.0


