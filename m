Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BBF3C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB897222C9
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 14:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lfl26Umk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB897222C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUu3r-0000Qy-TU
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 09:55:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57534)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUu2h-0007Vf-RZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iUu2g-00047B-VZ
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:54:47 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:39015)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iUu2g-00046x-QK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 09:54:46 -0500
Received: by mail-wr1-x441.google.com with SMTP id l7so2707300wrp.6
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 06:54:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=CXLDRqehEwCRk1nCh1wFoVyHcPkj4v1u9Gw3NGDDRGc=;
 b=Lfl26UmkM1BRESuWC6q19voym1sMmDCo1ZhN6qlfWxLutj3NwH945j8PdlGe+EvGp+
 wqiQ3lO3A4cGnMHslUF8oJsqnfk9iR887H9kB/dRwviUXR4izHILsvwwlWxNv5Bpp3nk
 YleZdMOZp4oNSo55xWy9RVHSa9JPpteIA9tEw5D//c/J6Op2+5JcYsJSfG87n2tB4R6r
 caxEIDuAf1dRS2CTlWj3xxL3YjxkHF3y15VymaE1cltu3jaQ895/DgQrKHOt9pjiFpG9
 cxqJI1t5ChmD2p9ULJ+L2mWqXGBSXWVZMzIuIDxK4OoRYSFNDA/kpt8FJuUwB8A/UwQd
 K7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=CXLDRqehEwCRk1nCh1wFoVyHcPkj4v1u9Gw3NGDDRGc=;
 b=WJWI2L7yiQNYYBblReQSyS5dJB0eFOKW+tTCg8T2EHtedIhUlMMFOXXhwxFEZVFqOg
 NAY4LVJReaoEQmtuJKMWM8mzDM/vKqOxp6YKDFtLBb6IHPmOlPZiyl65RqN3UrWFSD/u
 mKkYiXGardOxJ9u49aCcaLn8QnqGa6ZCWjsew+66QZOcHOhOknUj1qPwsQfgq1IChbg6
 fwLzmW6DwI07v/GQf6bHWKnEG4hg/Tj3Y3RW/D36XtrVxPqrYIZbNN33HI1yHWpZfNxI
 qG9wE3BW1oGfKEDGq/m1x9MEbwGjENpNdiB8P2jsIuFszdtpBoVzBMEdJPTDHLElOCR0
 TYjw==
X-Gm-Message-State: APjAAAVWMvO+eMchStdQ3ohjm3/PW9xfZzSd79GIk5wmZnljF02dTGyg
 zhylPdfe/s1K+MzC6D6pwC3iJFtF
X-Google-Smtp-Source: APXvYqzBloGQHfLRAA7DKwProyLvuO2WnodI8ECCOKcUaSSYeVtMS5B2z+K9z6T26jvdbfU1jNF2pA==
X-Received: by 2002:a5d:4589:: with SMTP id p9mr742356wrq.61.1573656885530;
 Wed, 13 Nov 2019 06:54:45 -0800 (PST)
Received: from donizetti.redhat.com ([2001:b07:6468:f312:64a1:540d:6391:74a9])
 by smtp.gmail.com with ESMTPSA id
 u13sm2360090wmm.45.2019.11.13.06.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 06:54:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] target/i386: add PSCHANGE_NO bit for the ARCH_CAPABILITIES MSR
Date: Wed, 13 Nov 2019 15:54:46 +0100
Message-Id: <20191113145446.16506-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: Jinpu Wang <jinpuwang@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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


