Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78223C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:10:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F000A2074A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 21:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dly5QzSQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F000A2074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRicL-0004lz-2v
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 17:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiX9-0007pp-Dk; Sun, 11 Oct 2020 17:05:35 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39435)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRiX7-00006h-Q8; Sun, 11 Oct 2020 17:05:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id d3so15561026wma.4;
 Sun, 11 Oct 2020 14:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3/Yc3WohY6Xtn0FpFPx5SHsA/mZ/UF7uI6UU+43HITI=;
 b=Dly5QzSQXGzZGxUrz169OqjcKPpZxZr/+xZmt7vrY1jIUeDpMcLfRiLP0Z0Ql5oKn5
 zcmhIt1yAdsw8E3Kowe6IKNMk6bhEFw83SPqmWRnhr4GWCG2eGZRe2u9yaYeBnsk8Hxs
 gIYqfG57Vj+H0TGQxLD2OIdsppzZ+VkFyf6SB6FJq86iAvH/yzP/BOCuFeYwb+fqd4gl
 +uQYDvDNbTDRfx86Drlfk56FuhZJzAtBaJ1YrnXsdcocvV0cPDrEvjrFYpc7j9Q6xjaO
 QSTizlMt9UC3jauBM+/E+FEPhmja0d95MVffNAyhsz+tlUdfTkkTzcb9u9NveA1LBSNq
 Nmyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=3/Yc3WohY6Xtn0FpFPx5SHsA/mZ/UF7uI6UU+43HITI=;
 b=OS3CmRCxtN+hSzkxxVK6Ed2fx9GTw2tUAllWSWPBY6lzVtqsEpFKjVHuVrKNgwDb/+
 krUiWQGOqQ3oTJX+LzD5cc+n90XS5x5V779LrXU8kDYHByFxPAde+OHTYCzgr80BFH5g
 LP7WwHKJL32Ftq1TaBknHi5N8Vx8SpNVAjD0fiO2LE/PygD/PohYJZuSIIVKykBjp3iR
 QpZmvgI9+zuiox2w5ewKg4pb2TqkW+HuaALAHowptyffUQu8ubHLWJ1gawTcHmIBV6+b
 Sf4zil3Q2SRDfMtUOPsdcOx4J57c/yYeZte8nfrNU4LQj2Y9RzVnZMxvCgtSxXjyJdqH
 e07g==
X-Gm-Message-State: AOAM532PLKQHEHGZlrnuTXTOWiFlGD17okotLavKpdoGXWWgdwGU4XpH
 U8Id8yJ9KK9tiu44Rau5E7QBet/z9UE=
X-Google-Smtp-Source: ABdhPJx1MwX7HmiJENbDZ5fLmsGQhBU2g7hLyLYVsIhEAdW60y/PqJvn4gJ6FK6aopgmwCFtfSw8yw==
X-Received: by 2002:a05:600c:2297:: with SMTP id
 23mr8292685wmf.104.1602450331111; 
 Sun, 11 Oct 2020 14:05:31 -0700 (PDT)
Received: from localhost.localdomain
 (106.red-83-59-162.dynamicip.rima-tde.net. [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id n2sm21987838wrt.82.2020.10.11.14.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2020 14:05:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 2/3] hw/ssi/ssi: Update coding style to make checkpatch.pl
 happy
Date: Sun, 11 Oct 2020 23:05:12 +0200
Message-Id: <20201011210513.3253905-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201011210513.3253905-1-f4bug@amsat.org>
References: <20201011210513.3253905-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make the next commit easier to review, clean this code first.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/ssi/ssi.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/hw/ssi/ssi.h b/include/hw/ssi/ssi.h
index fe3028c39dc..c15548425a3 100644
--- a/include/hw/ssi/ssi.h
+++ b/include/hw/ssi/ssi.h
@@ -1,12 +1,14 @@
 /* QEMU Synchronous Serial Interface support.  */
 
-/* In principle SSI is a point-point interface.  As such the qemu
-   implementation has a single slave device on a "bus".
-   However it is fairly common for boards to have multiple slaves
-   connected to a single master, and select devices with an external
-   chip select.  This is implemented in qemu by having an explicit mux device.
-   It is assumed that master and slave are both using the same transfer width.
-   */
+/*
+ * In principle SSI is a point-point interface.  As such the qemu
+ * implementation has a single slave device on a "bus".
+ * However it is fairly common for boards to have multiple slaves
+ * connected to a single master, and select devices with an external
+ * chip select.  This is implemented in qemu by having an explicit mux device.
+ * It is assumed that master and slave are both using the same transfer
+ * width.
+ */
 
 #ifndef QEMU_SSI_H
 #define QEMU_SSI_H
-- 
2.26.2


