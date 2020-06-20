Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E4FC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:02:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52B8A2474B
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 23:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVjMF968"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B8A2474B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmmVS-0006YZ-KG
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 19:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmRy-0000dc-HF; Sat, 20 Jun 2020 18:59:02 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jmmRx-0000xb-4B; Sat, 20 Jun 2020 18:59:02 -0400
Received: by mail-wm1-x344.google.com with SMTP id r15so12410879wmh.5;
 Sat, 20 Jun 2020 15:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PMxJwJBI3i/pj9/ZmzkEHm5G2TKnOFdjlimCFEXNzcQ=;
 b=mVjMF968rBtCgu5Q3KOuOALUM4aXGyvylX53nc5C4wDkvqOmtFzDzvjtkeKtkFibKV
 SR9QqE2gmQZ6kqm3mng7VGR1acJUGhVnofAT43SEf6S6BBOOw6kkaZ5nVpx2cutOBzOc
 jdYVN4CIW+LT7JN0eGsAcENWUdIo/2FQgqu4+B/KiJqJtHIfG6G6Yk76OYn/V0O158F3
 rLHplFyUmsia5MEjBCN4vqLR/CRCZkZkYGbuI1OQFsYPW0l/+/Oq0wMka845cEwhR3yk
 IrqfqTTn2wnMF3Okn2ThDCBrNJye8MHWZAsyVhFhGtMKj5WQL9Bmp452mPqe7E7lsZb3
 GxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=PMxJwJBI3i/pj9/ZmzkEHm5G2TKnOFdjlimCFEXNzcQ=;
 b=EU4D/1pNtYTj07n8Wjri1cH5Zxzy8n3cA7QwGD9MZUvM0Z8L+jE42+Pg5sc/3Kn3Dd
 sO5lbUw7l6X5NxkhUTyuK3NVPZv+a8c4AI2nrylcRgKUsXddQAdtSlviJ32OXoTLVSDI
 VPSCMAXboyCacceakxPnYkpRCcJ513V7KQlMVPmSj0R7U1fRDSjfrBaatCOrU/SspE81
 u5f+sFO8dYf3M2oK2uCIAQn93vQwiY2xaynxQ1/I0+ybjrFG0HK6WKC6w7l1NH9x9/uZ
 prA1rKUPnycJlcqLXrNdpKZ3y3/sxi6/AZ+3W9Lzr/ot2YlHOJhcII8rZGK8J+sutJCV
 xvBQ==
X-Gm-Message-State: AOAM533u76JsNbKkzi2KD78cvxmcM8D2/5PTPkHilWimpwgSKHJAE5DG
 HbzRSGVxccJNa0j6qJqdddlCxgb/
X-Google-Smtp-Source: ABdhPJxVeyz4GUnxrUsbhyTLjNL9HR6WSnBkumxISLK2JE4pEitFMLgI5jfKEUxX3Xrgca6Ksoq3aQ==
X-Received: by 2002:a1c:7fd7:: with SMTP id a206mr3228068wmd.104.1592693939373; 
 Sat, 20 Jun 2020 15:58:59 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id x18sm11147127wmi.35.2020.06.20.15.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jun 2020 15:58:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 2/8] hw/misc/pca9552: Replace magic value by
 PCA9552_PIN_COUNT definition
Date: Sun, 21 Jun 2020 00:58:48 +0200
Message-Id: <20200620225854.31160-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200620225854.31160-1-f4bug@amsat.org>
References: <20200620225854.31160-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: Corey Minyard <cminyard@mvista.com>,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the '16' magic value by the PCA9552_PIN_COUNT definition.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/misc/pca9552.h | 1 +
 hw/misc/pca9552.c         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/misc/pca9552.h b/include/hw/misc/pca9552.h
index ebb43c63fe..ef6da4988f 100644
--- a/include/hw/misc/pca9552.h
+++ b/include/hw/misc/pca9552.h
@@ -15,6 +15,7 @@
 #define PCA9552(obj) OBJECT_CHECK(PCA9552State, (obj), TYPE_PCA9552)
 
 #define PCA9552_NR_REGS 10
+#define PCA9552_PIN_COUNT 16
 
 typedef struct PCA9552State {
     /*< private >*/
diff --git a/hw/misc/pca9552.c b/hw/misc/pca9552.c
index cac729e35a..cfefb8fce8 100644
--- a/hw/misc/pca9552.c
+++ b/hw/misc/pca9552.c
@@ -291,7 +291,7 @@ static void pca9552_initfn(Object *obj)
      * PCA955X device
      */
     s->max_reg = PCA9552_LS3;
-    s->nr_leds = 16;
+    s->nr_leds = PCA9552_PIN_COUNT;
 
     for (led = 0; led < s->nr_leds; led++) {
         char *name;
-- 
2.21.3


