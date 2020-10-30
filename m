Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC4C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:51:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD0982076E
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 13:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l15Nxchq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD0982076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYUoS-0000PY-Ma
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 09:51:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40382)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYUmU-00082Y-Hn; Fri, 30 Oct 2020 09:49:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:45342)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYUmS-0004KJ-7A; Fri, 30 Oct 2020 09:49:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id a9so6512739wrg.12;
 Fri, 30 Oct 2020 06:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=enUHVE6/PhcWn+p+KJmbDxlEVfrqGZDvXq7Vvykiais=;
 b=l15NxchqxHP32IrV97Oaxdtzr3ovzT8yLhgt2wRUvgCAe+k7EG0A73U8V/OnUV6knl
 mW/82zxGRrjpSgDx7j1UkrKtlzvzYUawaXKtHGo8/LSClAxg8aCDf/RZzVdPCUdkMj3b
 RogjorSz2dAWz6uTvdGdEFSkbua9jx1OVGT36A1S9IfT+SPOxUutc4IhJ7NnO2MYT/2Y
 bZCVhECEs/7oiCr0lwZQKBuVCLrnQYhU88EhWS6eURYfaI0wDq7yGToLcgvTLQ16mbW4
 suzBM5oZg/umkpm0UGQzttAQlQcXDf0whC0PQGST+nYHCJ5oss0T7MkM1smJBYAE27MP
 ztbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=enUHVE6/PhcWn+p+KJmbDxlEVfrqGZDvXq7Vvykiais=;
 b=bDBXQTwoC4233BnPjTJYCoiorzXjHV3S6LBHJ5KOpDmjod/xvlI2heviGfnDoK2bs4
 OAKrlk9hUQB+q/vzMMI2vxZsCVS0vehKz30aOgzlHiOZc4WZH0TDq/oYPBNRL/6U0imZ
 5au73679Wp4gueqPilFKGD+Jdfgc6eYSkbEw4Fm8jsovOIRMBu1N+P9LpK62oSMUHQpK
 skK+qpMEuR9/u5qp1AZcSx37ud4Z6fTD2T6h1dhpfVYAuWt1WvrCA5srOQKBbRANPLzu
 65IYJGkB/yrJzTKRJHluMTWgbzhvFcWJiSdZq3upcVxm45dvadCySsqPPdFQVx708TFE
 Ancg==
X-Gm-Message-State: AOAM533t5Bj+tmFVyDISVdq5ZQc2NWhxBA61c9zabhNKKQ6kuim4dnQo
 Z+g4OOsaNJ9s9WzRQeUYD9ZErWe2xdM=
X-Google-Smtp-Source: ABdhPJw0zNnE0bCthm0WUdrS9gHjSkaetEIKU5DDAWJXPMiZblBQdUYRYj47r5Vlufe4HkxmVOm9NA==
X-Received: by 2002:a5d:4f8c:: with SMTP id d12mr3369673wru.351.1604065762105; 
 Fri, 30 Oct 2020 06:49:22 -0700 (PDT)
Received: from localhost.localdomain (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id 205sm4905578wme.38.2020.10.30.06.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 06:49:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH-for-5.2 v2] hw/rx/rx-gdbsim: Fix memory leak
Date: Fri, 30 Oct 2020 14:49:18 +0100
Message-Id: <20201030134918.1518930-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x42a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As load_device_tree() returns allocated memory,
we need to free it.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Fixes: bda19d7bb56 ("hw/rx: Add RX GDB simulator")
Reported-by: Coverity (CID 1432307: RESOURCE_LEAK)
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
v2: NULL-initialize (Richard)
---
 hw/rx/rx-gdbsim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rx/rx-gdbsim.c b/hw/rx/rx-gdbsim.c
index 417ec0564b3..d70865962e8 100644
--- a/hw/rx/rx-gdbsim.c
+++ b/hw/rx/rx-gdbsim.c
@@ -122,7 +122,7 @@ static void rx_gdbsim_init(MachineState *machine)
         if (dtb_filename) {
             ram_addr_t dtb_offset;
             int dtb_size;
-            void *dtb;
+            g_autofree void *dtb = NULL;
 
             dtb = load_device_tree(dtb_filename, &dtb_size);
             if (dtb == NULL) {
-- 
2.26.2


