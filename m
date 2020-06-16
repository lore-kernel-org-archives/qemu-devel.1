Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA22FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 937C6207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 23:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPs992Hu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937C6207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlKmB-0003q0-NA
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 19:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKlH-0002WS-Rv
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:12:59 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jlKlG-0006uF-Df
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 19:12:59 -0400
Received: by mail-wm1-x344.google.com with SMTP id t194so88682wmt.4
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 16:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=J6ZyVPWxE4rUpNMsUOcvfAQU0YaltDpuLYEOTXm+nBw=;
 b=NPs992HuvCRmWPp97bKClU5zyJ9dYklHXZlnoRjeRVrTX/jtFPUsdpBCDsxwHaFx6y
 GE/B2+KcPHHtymgxFh3WDUUE3xlXvlu+HBaah1AWuKvMZaXk0FZSMaIm8qToZYPdZjj2
 Rvh8bhsHg0o92uRczKsc54Au2Um8WCoZElnnO3j4lLyyG3vlZ4kSsjds9JftfMmSqTVJ
 DzuoOjO/UmMhl51Fg/w3sgU3L1dYzgCWp3JSlC07OnZQz/i8m3ShhrCibS3GraxRU73d
 yPDipNC8LD4RtPJWPeM9yM3aYpRKF1Kg2Ouux+G5afroDYfgKqnzMHWNLLILpC1TCh9+
 ZWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=J6ZyVPWxE4rUpNMsUOcvfAQU0YaltDpuLYEOTXm+nBw=;
 b=pkYZykdaNS14yE2EMSihLpZiN31bLXEEUhmMwwD1jw6dhRopOFM9SWalwOxrNayl/F
 3ZgPIt/+sddBn9ncsI1JDTokfNq0J2Eyt4Pdfw62jpYHUf9qsxgQzWARLWrwa3r74WUC
 XQ5WXrKxgA9WVYURzw9edsgBxd5B/I3xqQUJZLnW7TYrsPpivMdqiyLZtLuH46P4l2z1
 7nbYM8XniMiMVipudoRckJjbFgKwSat6SwOlAPDOlCJqGO0XrUx/t9yIaXNQYnMyhAr+
 /gInBLIwe2KsDdPv2ac/8T84fifCGe6gyHwhixE3gr20EfLy94muPxcqw0tssxnWSOXO
 pQsA==
X-Gm-Message-State: AOAM533VYt+b1OUYFRax378OEZ675EE+tOq7vAo0u8GTcVgfpvI2kax8
 48vUq2sEkQ8ZPyvuFsHq/9/f2h5qwIU=
X-Google-Smtp-Source: ABdhPJx2IBnHr1A13sYggnwPRN+i3kFokqrVuY1lshd9gLGGju3In+2/UfmQxbV3o09nx6xwe8I/Sg==
X-Received: by 2002:a7b:cc08:: with SMTP id f8mr5772413wmh.106.1592349176891; 
 Tue, 16 Jun 2020 16:12:56 -0700 (PDT)
Received: from AK-L.domain.name ([197.58.89.86])
 by smtp.gmail.com with ESMTPSA id o9sm2384226wrs.1.2020.06.16.16.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 16:12:56 -0700 (PDT)
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
To: qemu-devel@nongnu.org, rth@twiddle.net, aleksandar.qemu.devel@gmail.com,
 alex.bennee@linaro.org, eblake@redhat.com, ldoktor@redhat.com,
 ehabkost@redhat.com, crosa@redhat.com
Subject: [PATCH 1/3] MAINTAINERS: Add 'Miscellaneous' section
Date: Wed, 17 Jun 2020 01:12:02 +0200
Message-Id: <20200616231204.8850-2-ahmedkhaledkaraman@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
References: <20200616231204.8850-1-ahmedkhaledkaraman@gmail.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This new section includes the 'Performance Tools and Tests' subsection
which will contain the the performance scripts and benchmarks written
as a part of the 'TCG Continuous Benchmarking' project.

Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 955cc8dd5c..68f668ae2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2974,3 +2974,10 @@ M: Peter Maydell <peter.maydell@linaro.org>
 S: Maintained
 F: docs/conf.py
 F: docs/*/conf.py
+
+Miscellaneous
+-------------
+Performance Tools and Tests
+M: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
+S: Maintained
+F: scripts/performance/
\ No newline at end of file
-- 
2.17.1


