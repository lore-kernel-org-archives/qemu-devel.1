Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DFEC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2185206D5
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 09:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oXumBaXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2185206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiDhD-0006vk-Rf
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 05:03:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfD-0004mk-S4; Mon, 08 Jun 2020 05:01:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43439)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jiDfD-0004I3-0l; Mon, 08 Jun 2020 05:01:51 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so16471837wrr.10;
 Mon, 08 Jun 2020 02:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DWv5RFKPzeQC/b6mqfO3apmE0DL5hQ60SIP+EzfSOBM=;
 b=oXumBaXInvSsQGZqOhS6RdTIxHOmbpnYLU13QQXf9vgL8EjXzUbUaIecqrM3TyUnyR
 6vQ6WF1hrD0Jq2/mdebfgjchE2yAXZX1eUgcAuQ2oF8nKmM/1PnCTVRQpvsQNT9iAbno
 NR074gUP6+2F+aENl4QaO0kX1hV9t/+MPr4b0qoHhZGOgbsFIfVwJ3gvUgMQnthPQstB
 PSj7KScppT9TGSVhP8/yq8LoeSAplpMXXLJPpdUR5ru2CJgxgoE24BAzdMXK1oDdum7I
 aUwgT7pfGuqKqWkytOukDosEwbZUDUP4tOpV4o5y0/v0phh6hG+t/pLnH4cbQPPP+Sxx
 6SeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=DWv5RFKPzeQC/b6mqfO3apmE0DL5hQ60SIP+EzfSOBM=;
 b=MFFg+CDmExX/LMEzyzwJH3/FEoq9pNvkaGYqQdRe1Ep0XyqgN4nQ738TNIO8aF8qlc
 4dJgNYRhGwiw1VYywQTCUFHkQrCMt3Vczq5RzIXs1pIOuxHMWmtphNEyGknMg/0Obrx9
 WXATOATRY4HmWXpoRIYXjYJAxLhGcdMZbyVLhbOUUV70IRTGJxMMkcgrxdF2ed9GvN7W
 IqVZS2qKYk7+DKXNCn4op+0Wlu/Z3Dq3wdqV5mGRQn7sC4hmtZZTwtmf/juRy1pyF4v5
 3Vk2ptsfGg39FPz+YNZ8clF0ZpaVdYrZMVG7fjlHuNXlEZDS7ycoO9hrXAdJSd0KmRGU
 3t2w==
X-Gm-Message-State: AOAM532P5fLV09UF8Tgch4b2JH2NA6n1sJnGWJHw32QprwbmnKEr8Fw0
 uml9lA1Mia164YLTWaPr29RDyWpU
X-Google-Smtp-Source: ABdhPJxpGUivaiQnY6rtUvVaINKD7UCsyBkqd7jpeoFKZNjcjR24dcY39i70zqCXYt+5vQLYumKU/Q==
X-Received: by 2002:a5d:4dc9:: with SMTP id f9mr22047593wru.407.1591606909040; 
 Mon, 08 Jun 2020 02:01:49 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id t8sm22192989wro.56.2020.06.08.02.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 02:01:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/8] MAINTAINERS: Mark SH4 based R2D & Shix machines orphan
Date: Mon,  8 Jun 2020 11:01:36 +0200
Message-Id: <20200608090142.6793-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608090142.6793-1-f4bug@amsat.org>
References: <20200608090142.6793-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Last commit from Magnus Damm is fc8e320ef583, which date is
Fri Nov 13 2009.  As nobody else seems to care about the patches
posted [*] related to the R2D and Shix machines, mark them orphan.

Many thanks to Magnus for his substantial contributions to QEMU,
and for introducing these SH4 based machine!

[*] https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg08519.html

Cc: Magnus Damm <magnus.damm@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 MAINTAINERS | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49d90c70de..a012d9b74e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1250,14 +1250,15 @@ SH4 Machines
 ------------
 R2D
 M: Magnus Damm <magnus.damm@gmail.com>
-S: Maintained
+S: Orphan
 F: hw/sh4/r2d.c
 F: hw/intc/sh_intc.c
 F: hw/timer/sh_timer.c
+F: include/hw/sh4/sh_intc.h
 
 Shix
 M: Magnus Damm <magnus.damm@gmail.com>
-S: Odd Fixes
+S: Orphan
 F: hw/sh4/shix.c
 
 SPARC Machines
-- 
2.21.3


