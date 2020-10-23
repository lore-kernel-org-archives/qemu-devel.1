Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CC4C56202
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:22:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B07921527
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 12:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdY+F/bd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B07921527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVw5c-0005Fh-Bm
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 08:22:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37482)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw3u-00043U-Km; Fri, 23 Oct 2020 08:20:50 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:43824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chetan4windows@gmail.com>)
 id 1kVw3s-0001IU-SJ; Fri, 23 Oct 2020 08:20:50 -0400
Received: by mail-pf1-x42f.google.com with SMTP id a200so1077306pfa.10;
 Fri, 23 Oct 2020 05:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dGYC16kRLr+K+bWkoObF8naoY/6hygFVxJewUXsQEC8=;
 b=FdY+F/bd7Zeu6QzA690ElOVWs0had1Z12pFpsVrVrvsOgb2zUOSDF6X7+2SjCfr+Vv
 HAyDv7dc/lJzCAYyR4o0bqCD8dtcYHwr3Hfz5ojCAtmCY7Hr5/ltq6d6/dezwATmkHYS
 59XF9KFZPOg5/6GOUZyXL9Htx5sbbDDlsi4jaM2md9fjeszq09H1qNoF4wfV6a60i21p
 zdn0YenmswBIai8Wdj4VrlAuGZbByWNBnZS+xHZWFEaGyFhBQtU8uz9AAiUW93SdZLmf
 LNctPMVDA+Qtc6sdS6CB/iuId0q1UlgtusUaMyEXuLrAb1o5qkPreehRGpXVzS8VjV/c
 zgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dGYC16kRLr+K+bWkoObF8naoY/6hygFVxJewUXsQEC8=;
 b=krJuMiT3dErwbzNMo6pBVLHMBnm6d+P7SxXJZTh5X1XfGEAalLiWWn4WJFUV3d0APh
 H3mG/Aj4mQCJ59K5TrstcvSgbdpVubjCsf+hSPowt0UgtZKH42pZ8aTbH9P59PrVRZTh
 hhDw9fXwbBVdImTYmW+CPX3zdT8p3LiSsmaRqtyagz2/cA5rQ5EYHH3ZmQvfmHemh7FI
 S2k8ltTS1xUpFRZ2B+D7fh+jYWFpVOPylX0xUpQSiiGGI5m/l6RklYWDV0fvB2anAaCw
 oaNtYIEq7TOXk2qmMS4pm7ueu6UizUDyrQMkSju6es0/vMWwUTnyVZ2esCljn4TFe+IF
 nmsw==
X-Gm-Message-State: AOAM530415hehlA/0hAnv9H8m4G279QH5zH0hhZgBywR0ToEEiPWm7PZ
 OpDx49+MONtFVIctQViVlMDNUE86NR08N7zW
X-Google-Smtp-Source: ABdhPJw9gMkCbh10UX4/akvV825cqpo1Ed7IZ0JXxMjAqJyP/If/B9Rdv/VIg+8zGrg2Lm8Jo2TSiw==
X-Received: by 2002:a17:90a:e998:: with SMTP id
 v24mr2151099pjy.5.1603455646919; 
 Fri, 23 Oct 2020 05:20:46 -0700 (PDT)
Received: from pulp100.localdomain ([103.199.158.131])
 by smtp.gmail.com with ESMTPSA id x12sm1957555pfr.156.2020.10.23.05.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 05:20:46 -0700 (PDT)
From: Chetan Pant <chetan4windows@gmail.com>
To: qemu-trivial@nongnu.org
Subject: [PATCH 11/30] prep: Fix Lesser GPL version number
Date: Fri, 23 Oct 2020 12:19:33 +0000
Message-Id: <20201023121933.19227-1-chetan4windows@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201014134248.14146-1-chetan4windows@gmail.com>
References: <20201014134248.14146-1-chetan4windows@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=chetan4windows@gmail.com; helo=mail-pf1-x42f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: hpoussin@reactos.org, qemu-devel@nongnu.org,
 Chetan Pant <chetan4windows@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is no "version 2" of the "Lesser" General Public License.
It is either "GPL version 2.0" or "Lesser GPL version 2.1".
This patch replaces all occurrences of "Lesser GPL version 2" with
"Lesser GPL version 2.1" in comment section.

Signed-off-by: Chetan Pant <chetan4windows@gmail.com>
---
 hw/isa/i82378.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 8285b06..2a2ff05 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -6,7 +6,7 @@
  * This library is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public
  * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
+ * version 2.1 of the License, or (at your option) any later version.
  *
  * This library is distributed in the hope that it will be useful,
  * but WITHOUT ANY WARRANTY; without even the implied warranty of
-- 
2.17.1


