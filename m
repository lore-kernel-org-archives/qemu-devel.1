Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF4AC4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C0E1206DD
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 20:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agh9kOQS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C0E1206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPArn-000370-FH
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 16:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37464)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAno-0000pR-Mm
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:40:16 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46878)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kPAnn-0008LQ-A4
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 16:40:16 -0400
Received: by mail-wr1-x443.google.com with SMTP id o5so7311981wrn.13
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 13:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bUQVva2+x0gxkjCNaWZB7LXKpo81OHKP88TdTCRYgb4=;
 b=agh9kOQS75WXxYR54dTZWs1uK77XCe3wosn3eJ8y5gl/4AX6E9+KJr1cAlsZSPjqXy
 q7Ue+mwC1zx0r/0tCMPok3YVXntpyswpboJrLEwNwwlvgr6+t4JBq+QH1MaGLl/l402g
 Hq/BkDUd8eGFowsl3Dz3tJg403u6o/QMC3SB4AtK7LQwEY4scAuGcJGXvrnFGRAkHBJD
 8PhemPZlTpUmVwDlgX8U5NXRHUmOTzyVbNvYsiB/Crc6zOEboZDJLHejmW51jMVm5qnN
 KyA3T8mx78UpXO3YCHKHYphzF13uCm9a97JDA0YhsEchhLK4IXfxZmX+i4CvvBLUz2X5
 0vpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=bUQVva2+x0gxkjCNaWZB7LXKpo81OHKP88TdTCRYgb4=;
 b=EddS7/3uAdx5hM9LIxDyQvUCD5DoScldpekznLr6fVBZjlP+5mlsxYaGnmdLLDOKZ8
 /iDTShbwG8P4tzLT5LZgqKm7iBTjius6jEOGmV3cG3xm4EmI4I5yTZkgvrxBMfF2ftnx
 qWmMWl9MNnDr9ytAM5h/zHRvRq6HTj2/E6YSYV9G5+2lThbpGdRXvli38w4jqhgKrIUj
 wA8L0MxV8c6pFHSqb63sbZuK+2SuAPY4VPm0+k+Fq2rgOzspFOSqV1bMZ0YK/cSMbkmT
 Up5QtzJOLB7m9fgHJ9kTExp1cR6OPCp0FVGjs23/kS4y8/VlL/FakUBePll6mmJ6nAks
 J6Gg==
X-Gm-Message-State: AOAM530UCxfjhfb5dt4cCyK4Fu0eplu6XIDBkgzSWNzqgqS3aZZbBBY8
 XGg5t9eH4bVjmPIqvobAPsl53djcwCsWFA==
X-Google-Smtp-Source: ABdhPJxbsBka/Auzz55vBi0Fz2mANUhizEzg3L7tSRR+n/kf9hcfIf36RO8a+3ZpQhhxGnKEK7n9Jw==
X-Received: by 2002:adf:ec0a:: with SMTP id x10mr13254105wrn.47.1601844013625; 
 Sun, 04 Oct 2020 13:40:13 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id y1sm10245424wma.36.2020.10.04.13.40.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 13:40:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 1/2] contrib/gitdm: Add more academic contributors
Date: Sun,  4 Oct 2020 22:40:09 +0200
Message-Id: <20201004204010.2048608-2-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004204010.2048608-1-f4bug@amsat.org>
References: <20201004204010.2048608-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.248,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>,
 Pavel Dovgaluk <pavel.dovgaluk@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

These academic contributors have a number of contributions,
add them to the 'academic' group map.

Cc: Pavel Dovgaluk <pavel.dovgaluk@gmail.com>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
To the developers Cc'ed: If you agree with your entry, please
reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
care, please either reply with Nack-by or ignore this patch.
I'll repost in 2 weeks as formal patch (not RFC) with only the
entries acked by their author.
---
 contrib/gitdm/group-map-academics | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/contrib/gitdm/group-map-academics b/contrib/gitdm/group-map-academics
index 08f9d81d13..c7b0dd46a3 100644
--- a/contrib/gitdm/group-map-academics
+++ b/contrib/gitdm/group-map-academics
@@ -8,7 +8,12 @@
 
 # Institute for System Programming of Russian Academy of Science
 ispras.ru
+pavel.dovgaluk@gmail.com
 
 # Columbia University
 cs.columbia.edu
 cota@braap.org
+
+jiaxun.yang@flygoat.com
+
+artem.k.pisarenko@gmail.com
-- 
2.26.2


