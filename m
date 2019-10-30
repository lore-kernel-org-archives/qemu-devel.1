Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D181BCA9EAE
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 00:58:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C15320862
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 00:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBBwHmJm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C15320862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPcK2-00008d-OF
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 20:58:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46564)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hiroyuki.obinata@gmail.com>) id 1iPblh-00050K-WA
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 20:23:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hiroyuki.obinata@gmail.com>) id 1iPblg-0003CV-Vb
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 20:23:21 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34755)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hiroyuki.obinata@gmail.com>)
 id 1iPblg-0003AZ-Pr; Tue, 29 Oct 2019 20:23:20 -0400
Received: by mail-pf1-x443.google.com with SMTP id b128so289218pfa.1;
 Tue, 29 Oct 2019 17:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=cKiv4G9Jdvqdv8VdDDKTa4KgoftRUOjopQK0c1wrgb8=;
 b=mBBwHmJmM7HJ7mxErdvgocQSLnHk8jiU0Khud+rKUrv7JUllLgc3heWiVYGRwXcfbW
 vHTsl4gqfIxFQJ7jjVtbILGwG9ifZ2ZA2Bf2ngzeeLyKDkofEFaFaZilecqWoz9+TT1Z
 MxFH/zJsfIajw3R4RCC0aY0m61/l7sauEU/MBN9Ft7ibMULFXG9GUZ+PzJ+U/zihN1g5
 XenSZKlqzjJqy7YW21ZhAgzpG6V+DZuLXv/GvzxB7mU/XaHrUdcAkEF30AR00dcPBcN5
 a4fejLesEmnYII65AnVidDzTvGklkqegFTY7qP3/Mg1aPN+lQh5vwwSi6/ojgcuRDffJ
 bIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=cKiv4G9Jdvqdv8VdDDKTa4KgoftRUOjopQK0c1wrgb8=;
 b=bHrW+6SaxARx/+fSh7gUPwjtzSebSWSPbMdyE4vJTibKjhHSb1qvvHe5X+CmZNLq2D
 ZEqmbpsoAZSduw98SSD3XrV/GtP8LUkF0FvOvomgbJ1TgdgqNJN2W4CthQ+9qKCs+/+H
 2Dt3CEepUc1B5j4IlE5TC7jPJZHpZZ9lEi6DChW/a9UCDbrqHl99kADn/hfZ+4f1jRo0
 bScX82RRWx6XS+0K3RP4yBxn3RJ2jo4+jZpmL2KeEzOC4YG0O8o7FGhBTIhR3xFA9xjf
 RISQSUUbghGkClkkTLnC0gauCE+kWmDkcLeGVQLPsbYlJUwo8tJ5jEIxDILxXIn8NIDL
 FRAg==
X-Gm-Message-State: APjAAAXmVHS7iCfV4DaIYEy1FXaKRuDr3PlxijEI0ZKtYU4V2yWhoCMJ
 mTG+Q7+9iwc+IkbusvcoGJ+SVjnR5QE=
X-Google-Smtp-Source: APXvYqyltxkxnVGIfAw2q1dKZGLmN0mJf8wkrtShT3BuiOSnfg2exJIU7jIGZz0gv6EI0EiTWAORKg==
X-Received: by 2002:a65:4189:: with SMTP id a9mr30028495pgq.380.1572394998433; 
 Tue, 29 Oct 2019 17:23:18 -0700 (PDT)
Received: from DESKTOP-GC166TB.localdomain (softbank126163109097.bbtec.net.
 [126.163.109.97])
 by smtp.gmail.com with ESMTPSA id l11sm351821pgr.77.2019.10.29.17.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2019 17:23:17 -0700 (PDT)
From: hiroyuki.obinata@gmail.com
To: qemu-devel@nongnu.org
Subject: [PATCH] remove unnecessary ifdef TARGET_RISCV64
Date: Wed, 30 Oct 2019 09:23:18 +0900
Message-Id: <20191030002318.399-1-hiroyuki.obinata@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
X-Mailman-Approved-At: Tue, 29 Oct 2019 20:57:58 -0400
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
Cc: "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "hiroyuki.obinata" <hiroyuki.obinata@gmail.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "hiroyuki.obinata" <hiroyuki.obinata@gmail.com>

Signed-off-by: Hiroyuki Obinata <hiroyuki.obinata@gmail.com>
---
 target/riscv/translate.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index adeddb85f6..5c4dd21a98 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -64,12 +64,10 @@ static const int tcg_memop_lookup[8] = {
     [0] = MO_SB,
     [1] = MO_TESW,
     [2] = MO_TESL,
+    [3] = MO_TEQ,
     [4] = MO_UB,
     [5] = MO_TEUW,
-#ifdef TARGET_RISCV64
-    [3] = MO_TEQ,
     [6] = MO_TEUL,
-#endif
 };
 #endif
 
-- 
2.17.1


