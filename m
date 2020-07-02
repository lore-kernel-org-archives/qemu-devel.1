Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74A7C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9918F2084C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 17:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3u1U/+G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9918F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3CB-0005lF-OL
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 13:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AK-0003qg-QI; Thu, 02 Jul 2020 13:38:29 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:35675)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jr3AI-0007AV-Un; Thu, 02 Jul 2020 13:38:28 -0400
Received: by mail-ej1-x641.google.com with SMTP id rk21so30749892ejb.2;
 Thu, 02 Jul 2020 10:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uWQtmlnUnO1TU3kRM0oAvddbkP0WvBi3XDQ6Wp9rAws=;
 b=d3u1U/+Gjl0EarJuK9Th5Pd8m2Xp+FGbzzjlbfT6JunGPLtkjsrditKrA2Gw4SOOtt
 lp/7Zyq14K47PNGtv5mqgA82jKC0RXjH2Lvj1oLdK8TbWFjQiM6IiqKY7x7KFYC9hC5w
 RXhuE6052AwPl0wlYFEOWgc8lAl2nufV9HMjuPrDQth5bGfBJllm6co60+yqxWaD+3cw
 jVKCqksK/V0GRXahG5gRsd0BkS9VVg4URxmH4QCpHOAWo7XyaYWxnCJMgCHs50a/vRFR
 a6s1Rm1GeNa2X8WIRwm5GCPQluWkDwaHATmE0t/wEaigYjFs8fro3lbU3DgmiWi4V6dV
 1iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=uWQtmlnUnO1TU3kRM0oAvddbkP0WvBi3XDQ6Wp9rAws=;
 b=f1faa6u0OOnUInDdcPUWQp0U6MtYKB7vg97nBUhnQ0XtvQhbAdp1hV0xIaK9iIwgXq
 bTkes4GikxVfU1tv928caplZZflscn+bObnsZzUykyg6QcpmhS7UK7vl+wvaU4uggLdR
 Mg36zOcH5wcz80yJuOdzrLcnS6kvvsuMxkvw9ioPcPHlLk7EdB4LukA9HpyVQH7olInm
 I/LwUdos+tgiUA0Cb20ynaqIHgqSFyY1k0rFywEDsqaKP3WTmVN7k0ujJtTTwWvdwo7u
 CJWxTWwlsJbzx1FRU5I79UuOEr6qEhey81qhTMdNlgHXQexFIamJWhf4YbE5EbXqt3Hx
 +wWw==
X-Gm-Message-State: AOAM53123G7PX3catULQUU7ieWcTtgM1H4Zed8xtwMMh+DFcV6kiswnV
 dycu9auz7og+3n1vuTD0IeuDArF3JwE=
X-Google-Smtp-Source: ABdhPJxwFXdySPBUv4435aePn4Ghj+9JoD1QvdFMXq1ax0VmVAHYzpFuji4zlef2EvVdFHLKav5f5w==
X-Received: by 2002:a17:907:2170:: with SMTP id
 rl16mr29984514ejb.422.1593711504962; 
 Thu, 02 Jul 2020 10:38:24 -0700 (PDT)
Received: from x1w.redhat.com (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id w20sm5710344eds.21.2020.07.02.10.38.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 10:38:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 04/19] .mailmap: Display correct email address for Arei
 Gonglei
Date: Thu,  2 Jul 2020 19:38:03 +0200
Message-Id: <20200702173818.14651-5-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200702173818.14651-1-f4bug@amsat.org>
References: <20200702173818.14651-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Arei Gonglei <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix Arei Gonglei email address in the following commits:

  $ git log --committer='<root@ceth6.(none)>' --oneline
  ddcd55316f bootdevice: add Error **errp argument for QEMUBootSetHandler
  3b08098b40 bootdevice: add validate check for qemu_boot_set()
  f1839938b0 bootdevice: add Error **errp argument for qemu_boot_set()
  703008e81a bootdevice: add Error **errp argument for validate_bootdevices()
  9816833d3b bootdevice: move code about bootorder from vl.c to bootdevice.c

Cc: Arei Gonglei <arei.gonglei@huawei.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 .mailmap | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index a539ae8222..dbf674066f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -65,6 +65,8 @@ Alexey Gerasimenko <x1917x@gmail.com>
 Alex Ivanov <void@aleksoft.net>
 Andreas Färber <afaerber@suse.de>
 Andreas Färber <andreas.faerber@web.de>
+Arei Gonglei <arei.gonglei@huawei.com>
+Arei Gonglei <arei.gonglei@huawei.com> <root@ceth6.(none)>
 Bandan Das <bsd@redhat.com>
 Benjamin MARSILI <mlspirat42@gmail.com>
 Benoît Canet <benoit.canet@gmail.com>
@@ -90,7 +92,6 @@ Fernando Luis Vázquez Cao <fernando_b1@lab.ntt.co.jp>
 Fernando Luis Vázquez Cao <fernando@oss.ntt.co.jp>
 Gautham R. Shenoy <ego@in.ibm.com>
 Gautham R. Shenoy <ego@linux.vnet.ibm.com>
-Gonglei (Arei) <arei.gonglei@huawei.com>
 Guang Wang <wang.guang55@zte.com.cn>
 Hailiang Zhang <zhang.zhanghailiang@huawei.com>
 Hervé Poussineau <hpoussin@reactos.org>
-- 
2.21.3


