Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338ADC43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 05:02:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CE22075A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 05:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBokwxko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CE22075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEmp4-0001z6-3b
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 01:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEmnn-00012X-Nb
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 01:01:19 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36608)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEmnl-0002aD-S1
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 01:01:19 -0400
Received: by mail-pf1-x443.google.com with SMTP id d9so559151pfd.3
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2020 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/iCHgyxkq9v43nhcSQtgg4n7M9LvoD8NgErTOXuCnmg=;
 b=lBokwxkoUOBX+KHWO9mQL7EsuhI7rdElWmBPog0pRdUkbWBkR5A88gLl9Z1Fcm2Lor
 UI3FCKNd9VgzxpZsK7a4bsRBdiHlcuMjFBmTV8R++V9lgZKhE7H9MSEFjl8AifDQDclo
 cIp6TsfVr7/hCOJ6+8tFA9pRIDQFIBt1jt4S/MJI/BdtBfb45Z+VmwxbV5EQt1rI3v0M
 X7Nb9+gxGbSLInWz1UXbiqE+Mzah9RC3BHz+YWZN57KgbMOGxh8D8pnbAOZ8/VH5K6li
 dX0ty1kzu10X8yby1gq4NK0t3bn8ptkGLS/5gTwWZl2Oso4AOGCG5HScIzgN1jwvvjNy
 sLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/iCHgyxkq9v43nhcSQtgg4n7M9LvoD8NgErTOXuCnmg=;
 b=YdzerCWw58V0t3M/G3/asJ32ty3jY76DFEHTZZUcN58MBpSEpISqIizabnE3squuOa
 xEt76WAccXl9kTa/fSFEQF7EXAhiHiMfqW/NOvjiQDbZ9uID1EggDuGxwu4xY+i0TIpm
 ubRFnSCeO5r8yijtnK0vCiKGIgsY0mX7dTfpqlgrodvDWpjiA05/PCSMVbcqXc8KCmYv
 Io2AIQVUOBnxps2ZsFTUzt4ZjwTRzVzIFIJ2CyY9Wq02CPHbLhQ2bBlfCwpRRlDR22co
 nwIUScMPU9swuv08YNvyDG98xapwfl//cs5r+FMD5JMc5J7GIZV8cZStPOjnWAKN7Ymi
 jN9w==
X-Gm-Message-State: AOAM533neugTbWP2wyTHDpKCRJYej34DAYr7JRSIUvGz/K+JYHfyVBpE
 DUXUvIipM/+/CKOYbghTZg8Ft2j/wATA6Q==
X-Google-Smtp-Source: ABdhPJzu5rpVYsPTrMj5kUIW3xmKQm3WUdU3JYkUOFK7xB2KOYVybD4KaWZf/xAjFozElB06kv9tcA==
X-Received: by 2002:aa7:9084:0:b029:13c:1611:658c with SMTP id
 i4-20020aa790840000b029013c1611658cmr13844960pfa.9.1599368475720; 
 Sat, 05 Sep 2020 22:01:15 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id p9sm9289361pjm.1.2020.09.05.22.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2020 22:01:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/hyperv: Fix 32-bit build error for vmbus.
Date: Sat,  5 Sep 2020 22:01:13 -0700
Message-Id: <20200906050113.2783642-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: pbonzini@redhat.com, ehabkost@redhat.com, Jon Doron <arilou@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

../qemu/hw/hyperv/vmbus.c: In function ‘gpadl_iter_io’:
../qemu/hw/hyperv/vmbus.c:383:13: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
  383 |         p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
      |             ^
cc1: all warnings being treated as errors

Fixes: 0d71f7082d7 ("vmbus: vmbus implementation")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
Cc: Jon Doron <arilou@gmail.com>
---
 hw/hyperv/vmbus.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 75af6b83dd..3482e9c6cb 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -380,7 +380,8 @@ static ssize_t gpadl_iter_io(GpadlIter *iter, void *buf, uint32_t len)
             }
         }
 
-        p = (void *)(((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
+        p = (void *)(uintptr_t)
+            (((uintptr_t)iter->map & TARGET_PAGE_MASK) | off_in_page);
         if (iter->dir == DMA_DIRECTION_FROM_DEVICE) {
             memcpy(p, buf, cplen);
         } else {
-- 
2.25.1


