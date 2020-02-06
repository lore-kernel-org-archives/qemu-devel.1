Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0683BC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:07:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6B42214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctB7hra7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6B42214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgsW-0001Ha-0n
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:07:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60259)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <npes87184@gmail.com>) id 1izggz-0003AB-VS
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:55:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <npes87184@gmail.com>) id 1izggt-0006qh-F3
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:55:37 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e]:37850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <npes87184@gmail.com>)
 id 1izggr-0006jt-KF; Thu, 06 Feb 2020 07:55:30 -0500
Received: by mail-pj1-x102e.google.com with SMTP id m13so2520826pjb.2;
 Thu, 06 Feb 2020 04:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=HBKiWyxPOBeQhjpTMCQRY2PgitDnOF2YSfOVmPlQ+rY=;
 b=ctB7hra7HJBaoU8/+T+Cwmz7JjyT1MbPBewMwTjWd1vpMzmiNSdApSfgLkNZFSP8Ty
 7zmbePH/9QtCvB/1TJWykiMN51cMCioSsT97wD5iTDNbLbwXi7b3V8MI2KWy47BZKqtF
 vZk1Vow5KKU2TUugQEHjuL79I41KY+cBu2T6F9GtlWorj19oqsl6/SxoxUWV7bSPmrVk
 1KLni5At3q/QDFFLIndOskd4DN/ZlIJaVKx75q82mXxWnGfqbB93EfBNL+S18Q3GnXpF
 /B6YLj95PlSPCEQjMUI+my7VUclJ3eBs4jhbxvD/OaXF0EUGHt2I60RZtEo5SCB8PXAa
 KuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=HBKiWyxPOBeQhjpTMCQRY2PgitDnOF2YSfOVmPlQ+rY=;
 b=O2EGTir47ehIlqUaYHFpt+WOYr8AlMOa7gE069jxqwBDy3GeMIHX6EJ6/n2zkjVvzs
 jusJlozr6VauousMDzPOAvqHZb3/kiY/VcSqKVSRsVAiOsn38sXAKT8SqOPVqS9QwyHQ
 kWRR3GNGpRYJ3z+81tFjbCO0+SIo5v90+h9p+tVDz2U6pp59MUDRUEZKJCU51/QimSLO
 tsLhwExwOglYD5i7uGPhOaw3L2xZGLiBb5AaDfYRiOOPwOtmHq7armMVlsKya0zmdvsq
 KrjhG1PRQI6HZv1cWJObbb0wuVWIEf5PXMK5l/Do38Vdofl/RoMYvC5x6+e+Rfal/SuY
 /KDQ==
X-Gm-Message-State: APjAAAUchqaW3jBdk2u5Xmli0zoPd29tEaqjDFLhJy2AzkfssRm7AXJv
 dc4o/oSSWQfL/oWUln86iOATd9e+gw07MQ==
X-Google-Smtp-Source: APXvYqyO+LSl0KsZ/fQUDjgH+u0Y50C2MM0pt1VtpY9Yx1bgyohtWTX0iEmpzs3iGp6fzYD5th5dbA==
X-Received: by 2002:a17:90a:d789:: with SMTP id z9mr4116160pju.5.1580993726567; 
 Thu, 06 Feb 2020 04:55:26 -0800 (PST)
Received: from localhost.localdomain (223-136-131-195.emome-ip.hinet.net.
 [223.136.131.195])
 by smtp.googlemail.com with ESMTPSA id d4sm3342809pjz.12.2020.02.06.04.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 04:55:26 -0800 (PST)
From: Yu-Chen Lin <npes87184@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] mailmap: Add entry for Yu-Chen Lin
Date: Thu,  6 Feb 2020 20:55:04 +0800
Message-Id: <20200206125504.7150-1-npes87184@gmail.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::102e
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
Cc: qemu-trivial@nongnu.org, yuchenlin@synology.com,
 Yu-Chen Lin <npes87184@gmail.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I have two mail address, add entries for
showing author and email correctly.

Signed-off-by: Yu-Chen Lin <npes87184@gmail.com>
---
v1 -> v2:
* Change subject

 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 3816e4effe..3fbf3902a3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -151,7 +151,8 @@ Xiaoqiang Zhao <zxq_yx_007@163.com>
 Xinhua Cao <caoxinhua@huawei.com>
 Xiong Zhang <xiong.y.zhang@intel.com>
 Yin Yin <yin.yin@cs2c.com.cn>
-yuchenlin <npes87184@gmail.com>
+Yu-Chen Lin <npes87184@gmail.com>
+Yu-Chen Lin <npes87184@gmail.com> <yuchenlin@synology.com>
 YunQiang Su <syq@debian.org>
 YunQiang Su <ysu@wavecomp.com>
 Yuri Pudgorodskiy <yur@virtuozzo.com>
-- 
2.17.1


