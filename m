Return-Path: <SRS0=Kewn=DL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 770C0C4363C
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 207A0206B6
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2020 18:09:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lgcexNKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 207A0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kP8RS-0007EY-7Q
	for qemu-devel@archiver.kernel.org; Sun, 04 Oct 2020 14:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NR-00022t-DR
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:53 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:35108)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kP8NP-0008IG-Mr
 for qemu-devel@nongnu.org; Sun, 04 Oct 2020 14:04:53 -0400
Received: by mail-wm1-x343.google.com with SMTP id y15so6565702wmi.0
 for <qemu-devel@nongnu.org>; Sun, 04 Oct 2020 11:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RP77/yFw9g0T9T5eJ4E89nVHf4u9YwODjY6xg3HiL/4=;
 b=lgcexNKzsAaWTyTtFz9OXwAn+/lmBO543D4ZlhzdOMDKFGl3yduuErO/QqdeI+laaF
 bewjyORNFCsJkGJhi3db142gfyBYQu1VK2G9sZDO3LWehR3goC+MN4oyMbDp4hVoS/gv
 NgE1vQbh2Wz1xX17wXFDJqcQwefT1qSUzja0l7nMN1ulWrfLu7r5fpN9G22BuHX5Gtyv
 rMIYruSdIC5QRDMFUMEtFl6qZOqkl+8J7oznUTeuGX1WUxtLCnJuMEZWFoi4+kLlWAyK
 dKBlY9cQ1yGewoEXLMOmoNWpqpK1f00dQvW39GSYz7geJ7n1pRHU7vWmviwGUv/Alg/+
 GuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RP77/yFw9g0T9T5eJ4E89nVHf4u9YwODjY6xg3HiL/4=;
 b=QP4xIpyjW9FEvPdXxvoxYSW5imwpHNe9QjT2OuFqJt1dqQF2G9oK1wuqFUE4IkborJ
 tZddw9JsjJqWBj89mpg+34xYQ/dg120bFspWYgK0MNYFt+y35QPfo5VFNUpNp0BNQwJo
 h9bGOn0vCLVeL9psVi9mMa3FfTn1NHqTzeRUkUTgvsNcIZofynkI1Ijx5ub3ZlsBNdwN
 hiiq8EzHUUQByS/LpUC61sCkN/2N8vaBfUpVa35QjPg7GcJZX3EfKN5dodMq7DW/XjVX
 sWWBAP7wExDx6/2Cj9/0PpJbh40iwbsLfq3X80B//XotbRxnnpvhKlD8hVxQTbCdj6lx
 Wnbg==
X-Gm-Message-State: AOAM53233IaSG4io4GckCxSogwhhz8vy9wH3b1xqw2knFKtAdTmnEdpV
 vLYVd7XUElq0mdlfrZueeHvDPmp9CsM=
X-Google-Smtp-Source: ABdhPJzx9lQzFARtSYE9gBh3K0G3Y/OyvxYhVCpK25RY6y/06N8QsU3FpHJ93MbkYmBo9Mouju5S+w==
X-Received: by 2002:a1c:ddc2:: with SMTP id u185mr2255584wmg.21.1601834690120; 
 Sun, 04 Oct 2020 11:04:50 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id j10sm9593202wrn.2.2020.10.04.11.04.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2020 11:04:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 03/21] contrib/gitdm: Add Baidu to the domain map
Date: Sun,  4 Oct 2020 20:04:25 +0200
Message-Id: <20201004180443.2035359-4-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004180443.2035359-1-f4bug@amsat.org>
References: <20201004180443.2035359-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
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
Cc: Li Hangjing <lihangjing@baidu.com>, Ni Xun <nixun@baidu.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Zhang Yu <zhangyu31@baidu.com>, Jia Lina <jialina01@baidu.com>,
 Chai Wen <chaiwen@baidu.com>, Xie Yongji <xieyongji@baidu.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a number of contributors from this domain,
add its own entry to the gitdm domain map.

Cc: Jia Lina <jialina01@baidu.com>
Cc: Li Hangjing <lihangjing@baidu.com>
Cc: Xie Yongji <xieyongji@baidu.com>
Cc: Chai Wen <chaiwen@baidu.com>
Cc: Ni Xun <nixun@baidu.com>
Cc: Zhang Yu <zhangyu31@baidu.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
One Reviewed-by/Ack-by from someone from this domain
should be sufficient to get this patch merged.
---
 contrib/gitdm/domain-map | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/gitdm/domain-map b/contrib/gitdm/domain-map
index 2956f9e4de..0eaa4ec051 100644
--- a/contrib/gitdm/domain-map
+++ b/contrib/gitdm/domain-map
@@ -8,6 +8,7 @@ linux.alibaba.com Alibaba
 amazon.com      Amazon
 amazon.de       Amazon
 amd.com         AMD
+baidu.com       Baidu
 cmss.chinamobile.com China Mobile
 citrix.com      Citrix
 greensocs.com   GreenSocs
-- 
2.26.2


