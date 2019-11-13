Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48C6C43141
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B050E206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 22:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2QvVQrw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B050E206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0xO-0003i2-FQ
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 17:17:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iV0t6-0001l0-Dn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iV0t5-00014z-Dn
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 17:13:20 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36012)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iV0t3-00010S-3O; Wed, 13 Nov 2019 17:13:17 -0500
Received: by mail-pf1-x441.google.com with SMTP id b19so2609593pfd.3;
 Wed, 13 Nov 2019 14:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rndpeHxbj/C4hJGnw+1eeHlSftg7rDiNlHx9DUUhsi4=;
 b=Q2QvVQrwr9Y3i0kbVP9b8obuulJ3ApAcpv9Ah5q8l7T/dGYWdytdIGMw5bmf1BFeTK
 wRS7bWxxual+nURxenc8DRDmfKIoUI/Ne7IvxhXLF3n9mC6EdGUM7qZ+EARwCRRCWL43
 HQje+51Rmrz87LooE+hDqVZbT/NQY3NgpK9XtSXYWyWF9tnr0dqYsF4AkMQh4knGxPEL
 bIkt41rh2m6MCNEiN5MJcWLVBwEPNBA7RMfrLbZlAj1bk7ZHu71XHDANajRhazl0W9Sy
 Jx036vQ8eEYauPjzybjMyUknqb+sPYUe+b7hl0mJidNlfwLJoAKXC6+UIRc2hgCF0ZFA
 wSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=rndpeHxbj/C4hJGnw+1eeHlSftg7rDiNlHx9DUUhsi4=;
 b=m2Gwe4bddRfj1/1PSaFG1eVFa/aGWy3gj77L0v6z7LPTxKDh3/Q1cjTBU0fx6DRqaE
 E1WVCaWF7G612bqr606U9+4mN6v3ZIuQ9YcvHovVnGE4vHa17zoxVZpSc8kFjHlxydCy
 YNWoPTUCOkyvrrVjiOfUOOZpMX2jv4+/CeWkNJExIZual04b2J/FaKfYon6M6KAV8AGr
 jj0cLloaDZDzSInacfiXwS3Ac+aMxmmvc9CBmMBS4QKbAq7wN3DDh29B8w/OxnQuHeft
 gLl6GMs9eoRVP16W4l4F4xRiLaWzqy3rLvrnm3+4Zcma/XZUmfo1qOnMNxboyd6EbjjO
 z83w==
X-Gm-Message-State: APjAAAUtvG4JxT9bDAzyqiisl8oBlIhdQSAPHXgsexEEMmxTCfzEt7x+
 kLHghDVOFLUDOwjEnDUDx14=
X-Google-Smtp-Source: APXvYqzakeii9HBttyGDQRJTQdroyE9HlIG2xOy74QGnsDrejzKqXTyH/Yu3FE2tDAlOvlHnxstEgA==
X-Received: by 2002:a17:90a:b28c:: with SMTP id
 c12mr5739070pjr.22.1573683195848; 
 Wed, 13 Nov 2019 14:13:15 -0800 (PST)
Received: from voyager.lan ([45.124.203.14])
 by smtp.gmail.com with ESMTPSA id w69sm5252005pfc.164.2019.11.13.14.13.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Nov 2019 14:13:15 -0800 (PST)
From: Joel Stanley <joel@jms.id.au>
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v3 1/4] aspeed/sdmc: Make ast2600 default 1G
Date: Thu, 14 Nov 2019 08:42:58 +1030
Message-Id: <20191113221301.8768-2-joel@jms.id.au>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191113221301.8768-1-joel@jms.id.au>
References: <20191113221301.8768-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Most boards have this much.

Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/misc/aspeed_sdmc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/aspeed_sdmc.c b/hw/misc/aspeed_sdmc.c
index f3a63a2e01db..2df3244b53c8 100644
--- a/hw/misc/aspeed_sdmc.c
+++ b/hw/misc/aspeed_sdmc.c
@@ -208,10 +208,10 @@ static int ast2600_rambits(AspeedSDMCState *s)
     }
 
     /* use a common default */
-    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 512M",
+    warn_report("Invalid RAM size 0x%" PRIx64 ". Using default 1024M",
                 s->ram_size);
-    s->ram_size = 512 << 20;
-    return ASPEED_SDMC_AST2600_512MB;
+    s->ram_size = 1024 << 20;
+    return ASPEED_SDMC_AST2600_1024MB;
 }
 
 static void aspeed_sdmc_reset(DeviceState *dev)
-- 
2.24.0


