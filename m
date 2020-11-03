Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F49C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:17:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E995022243
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H4qiG/dW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E995022243
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZx7S-0006EP-0E
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZx63-0005F9-I9
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:15:39 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44661)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kZx61-0007bg-OY
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:15:39 -0500
Received: by mail-wr1-x442.google.com with SMTP id b3so12821370wrx.11
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GCaaj1QfbjtfUrsNgOKvPWlqrBINzAGn9vemG05ove4=;
 b=H4qiG/dWHBBu1Q+Bay0Fr6owZeDY5zX5bJC+jUCy5AdBWRIT7txkREbV0K39YAuL7s
 BhR14SiP2giUTgwjNd2vMKN/MeHlfr31JR0eLV17JHSAUaa181UU8h6JUGc+nu0vsclt
 07fbfM2sPHF2w77x8HrUDSk/VvWUsN2DDP4T9UXyH+Gw4LZ+ltymr9tDfnL0uBeuLYoY
 NYmBdA8LeXiXs5SdDh+A1M7UOKtUPVLru2WNghDzMMCLts0aygBd2Mq5vC0faicjut+y
 f9oM8l4jaD2eyyLEX74H51koYT4h0za7X4n4E+hzxKLCPCZ3onknwGXpsr1byvWWa7H/
 H92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=GCaaj1QfbjtfUrsNgOKvPWlqrBINzAGn9vemG05ove4=;
 b=RBVlD8Xb26elk8a7+W1BnrF09qNARew08VG1HTJ++IDgq5g2v/FY3QXAISDziC5IxQ
 WdudqxAQDwkyr8PvbgPtpOIyvxg7A7T4IJFIWhvErA6WhB9cM16lQk8dMJsEydgBhRBL
 bX4dQ9yZ8nKkdMFfK+zLhOGKqkD0nu7/+odSSUAd8gI6uTPiLHCDCABoCpm839kCta09
 rxK3z4m1csuVXki/ZxK5AU3M7ChbzJNBtiLghLKKQXVAskbJtq66YaeFGNfa8H6ibzvR
 sbXjg4pcpWymLv2DXvSL9oEGjH7nTBQO9Bzk2HkPrdXKu3juzkQPi/VSJ5Ps+/RaqDKc
 dI5A==
X-Gm-Message-State: AOAM531YK4+c/O10bJVh4X2y9kyIqbNN7DvWEsKHIGaDPN0bsf0cVFkF
 CY30ubY2ZNulQHilGuDsfxDwofyQmRqKqA==
X-Google-Smtp-Source: ABdhPJzDyDJq1+ADPj6sgnF6ASerkiOp7Ivl9ECwt7BY/d8B87NRVubmb/y8LFe4vD817Vtuoys4Tw==
X-Received: by 2002:a5d:5548:: with SMTP id g8mr26363343wrw.364.1604412935856; 
 Tue, 03 Nov 2020 06:15:35 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e6sm19225027wrs.7.2020.11.03.06.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:15:34 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] linux-user: Check copy_from_user() return value in
 vma_dump_size()
Date: Tue,  3 Nov 2020 14:15:32 +0000
Message-Id: <20201103141532.19912-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Coverity points out that we don't check the return value from
copy_from_user() in vma_dump_size(). This is to some extent
a "can't happen" error since we've already checked the page
with an access_ok() call earlier, but it's simple enough to
handle the error anyway.

Fixes: Coverity CID 1432362
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index bf8c1bd2533..e19d0b5cb05 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -3484,7 +3484,9 @@ static abi_ulong vma_dump_size(const struct vm_area_struct *vma)
     if (vma->vma_flags & PROT_EXEC) {
         char page[TARGET_PAGE_SIZE];
 
-        copy_from_user(page, vma->vma_start, sizeof (page));
+        if (copy_from_user(page, vma->vma_start, sizeof (page))) {
+            return 0;
+        }
         if ((page[EI_MAG0] == ELFMAG0) &&
             (page[EI_MAG1] == ELFMAG1) &&
             (page[EI_MAG2] == ELFMAG2) &&
-- 
2.20.1


