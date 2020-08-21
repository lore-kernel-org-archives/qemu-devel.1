Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F678C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E431720702
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 17:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lejooW60"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E431720702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9B8O-0005r0-TV
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 13:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9B7H-0004LK-G2
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:46:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:34035)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9B7E-0003Xv-5V
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 13:46:15 -0400
Received: by mail-wr1-x443.google.com with SMTP id f7so2726278wrw.1
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 10:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JJh19wKWhpGRMYR48TCz0u7CP2SwdWq6MznAfKm/N0Q=;
 b=lejooW60ejQ7m6N6DRC4BdE/9CbLe4x90ppZf5biz8Cv7OuAoBPZimneFYkpKsg8v2
 yHCWTsfRXcmGLv8F9yDAB94aJYRcDifaygFqpTdwkddey5k/7R7IEXJoNNchWUlBrp2O
 Yijhsu14OO1IgDG5eBpgVgi2wtCBZf6PDlSJ6Qb/keW+X2z8zYP0k5QYVYVCrX6Dofaq
 4UQ8Z6125RKy4KxuqZHCReF7nbf2oXqSEdDxxV/P7anogqCwjh7A60jPIZHzos+/W2Zw
 mo6NwXmoHknLtyoSBNyFRAitH/IQWFV/vVP8b2jiT2T17om7zGkhtqqxC4G694dB/jrP
 3Tmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=JJh19wKWhpGRMYR48TCz0u7CP2SwdWq6MznAfKm/N0Q=;
 b=mylWkYJtCw3ATdOrvPUocItc/winFAxW1Y0gFaimSf8v+rOYtHtqNZGR1G8JsEyC0a
 1/N11sVpGc8CSjek2k06bWCOxtkHlGdcJlhvqUUieVPyG+M4yur/onNK3T2RN8nZHQy1
 P2kdoQtHqB2bgxirenrHDoOSwG5ICSVOdmjiorzOuK53h0iZrfFR4kC+SCreWQU81Reu
 XaVjw3lkvT8E5/OaHyLcx5YkE5bABbeYQacAGlDb/OLBHeKhnP8SLavyr0IvbKtPe8/F
 yTmjeJawtlMzZG7jYFtEqvE/TdnTlcso9Krv4mwSmJDiLlMEq0xm73rx3G7riFxda5Pd
 Y/qA==
X-Gm-Message-State: AOAM533nKfbXJOt/a7suNwHjrqsj/9U9W5nSHaAMz2o3RDtGqDidGU/X
 S9w60W9gfe8QhR9XuOq0Cy4YV0FrJrE=
X-Google-Smtp-Source: ABdhPJzHM3cn67cqpPdK0KF/+dEtMz+P/Opk42YLgHubu+eE038Ai67pUhR3jretKFq16ebyGKyrGw==
X-Received: by 2002:adf:f149:: with SMTP id y9mr3570753wro.93.1598031967835;
 Fri, 21 Aug 2020 10:46:07 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n124sm7017713wmn.29.2020.08.21.10.46.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 10:46:06 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/ssi/ssi: Set abstract TYPE_SSI_SLAVE instance size
Date: Fri, 21 Aug 2020 19:46:04 +0200
Message-Id: <20200821174604.1264321-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Set the abstract TYPE_SSI_SLAVE instance size in case an
implementation forgot to set it.

Reported-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
See:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg731954.html
---
 hw/ssi/ssi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/ssi/ssi.c b/hw/ssi/ssi.c
index a35d7ebb266..b3e82470381 100644
--- a/hw/ssi/ssi.c
+++ b/hw/ssi/ssi.c
@@ -85,6 +85,7 @@ static void ssi_slave_class_init(ObjectClass *klass, void *data)
 static const TypeInfo ssi_slave_info = {
     .name = TYPE_SSI_SLAVE,
     .parent = TYPE_DEVICE,
+    .instance_size = sizeof(SSISlave),
     .class_init = ssi_slave_class_init,
     .class_size = sizeof(SSISlaveClass),
     .abstract = true,
-- 
2.26.2


