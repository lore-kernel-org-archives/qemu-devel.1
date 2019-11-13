Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F05EC43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:55:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FD9222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRskTjeA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FD9222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu3N-0008B7-5z
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57451)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUu2O-00073U-9n
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:54:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUu2M-0003yt-8I
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:54:28 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:45624)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUu2L-0003wm-Vu
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:54:26 -0500
Received: by mail-wr1-x444.google.com with SMTP id z10so2675694wrs.12
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0e/IEGD2nU1wq5jgs4stb3eSCZi/H8yvoxbn7PksIPc=;
 b=BRskTjeA/qi+QHtLw6VTZTPOrvD1KV7aJrhj4jiW8JyUO05y+DUM4NUuSorSzyUreA
 KaxT9tYQHAq+YJ4e96KpTX/aiMVIGgaHUUqyrGXIMaUQEGX+Lg1AdZED40zDuNLkwZfl
 uzEmK6luwueBT7F4UA2Eln8CZi9AMPbbaWTpMm5YG1VBM48+3uBXU45qBybEDCMEPrkv
 dCPL/wLRQbEq2gDkmRp8Pya7pR4reuOKpKwBAGYfzHzCxRC19nS1OuPpNYShp3cMeOf/
 ziwoBw4+Z7QEWDJC/IPEWc+2XWFH44G9W1Rzm7Jq5L8Ek+QtPi/+gBaGOuDZRkPxlEG0
 2u+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=0e/IEGD2nU1wq5jgs4stb3eSCZi/H8yvoxbn7PksIPc=;
 b=llVzg+8LDPO0nMAMsKo0Uf7bI+P3epId5QXD7kMBWsrNwp8ghUadkYC2qGUGi+Btou
 UUhlx0dMR7kIBk+OpguAlhbwLb+GoR2uNrwoUmOWvhLR+wzmnab6AmAG3U3SH08Lwrkb
 tFUTUfscEs03kodvRS0Z/hdiL/zM3/9tU645iY7x3C549CGiljoIaZyH82sA3XmXOYQM
 /vyJcISwwIAiYM4qgemBKXBnCoU5iOTtgfLTx9s7sxXWmcobhxvdMa1DzRQ8YgEbhNnV
 /5H5g+0VghsyFlnf12s1q262oElTSmCNh6sOL//qc5macrsRextvzKrt25dm7Uxcn/PZ
 fwOQ==
X-Gm-Message-State: APjAAAUcb2naWrEzrrsI6oHucLX1yHFs55zpVJi62z82PySI4zmCUlAT
 a5Sm521LmIkcLyZP8canhRuEf0s5
X-Google-Smtp-Source: APXvYqxlptbj9biPJUjhpihDbElL2clyq/Y6gnQ/KGiQby/deNsKcn96H8vUQx7XQM5kRjrSTkb9kw==
X-Received: by 2002:adf:dd0a:: with SMTP id a10mr2865008wrm.299.1573656864248; 
 Wed, 13 Nov 2019 06:54:24 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:64a1:540d:6391:74a9])
 by smtp.gmail.com with ESMTPSA id
 n1sm3171579wrr.24.2019.11.13.06.54.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 06:54:23 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: add PSCHANGE_NO bit for the ARCH_CAPABILITIES MSR
Date: Wed, 13 Nov 2019 15:54:25 +0100
Message-Id: <20191113145425.16326-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
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
Cc: speck for Paolo Bonzini <speck@linutronix.de>,
 Jinpu Wang <jinpuwang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: speck for Paolo Bonzini <speck@linutronix.de>

This is required to disable ITLB multihit mitigations in nested
hypervisors.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a624163ac2..2f60df37c4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1204,7 +1204,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
         .type = MSR_FEATURE_WORD,
         .feat_names = {
             "rdctl-no", "ibrs-all", "rsba", "skip-l1dfl-vmentry",
-            "ssb-no", "mds-no", NULL, NULL,
+            "ssb-no", "mds-no", "pschange-mc-no", NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.21.0


