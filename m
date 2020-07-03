Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 149CEC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D072C20782
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 20:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5deevcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D072C20782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrSDu-0008FI-2y
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 16:23:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9c-00080f-4S; Fri, 03 Jul 2020 16:19:24 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37180)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jrS9a-0001V0-O8; Fri, 03 Jul 2020 16:19:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id a6so33946289wrm.4;
 Fri, 03 Jul 2020 13:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=hDAjsWCo4muYV2UGuHt56RhWysQG9sjw6uJx4BVOBUQ=;
 b=T5deevcTXhgqKXgllHmkBGEkLA9yEGSlNTkrTEWmGqAibvBGJXinmQw7EaBFlyTNcX
 N0sRPe0rSHqTYpHtPhOf39NM378uLokFNzcYPeOuMcHDGluWC6EUmzK3bMaJLaqkgw3T
 MUbCA+wfdNOV+ZOP0ifhVZ5eIO/KBWY38sKtMGjZzyt0iT08x5XxyYp6woFtAFKZrzHx
 UcSyT4BvtjLQm70bi/4V8MeVmqsp3bPeEGbVoD1GltkmklBrJL21wcqb4TaHVhg1+gFt
 2pXauzM2Z6kZRn9d0fuDY5WLfJJQ3g/0H0qO/B7u2y5oUmcBSN9Z4OGGDvOZsUmFE7Ac
 mERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=hDAjsWCo4muYV2UGuHt56RhWysQG9sjw6uJx4BVOBUQ=;
 b=mnMDt4FO5AU2sfuFPbiepoF1CQhxWK+4wZXeg/+PhN+dE/o/BRyjHig4TGajz+VJA0
 ng+ff2RuvDDyA4iQLRBVq03m+OpTsJACtWqsas4+7Bh2d+ut8pKGAsg7Txrsly6WjIsN
 h/Rv3scdgLvlN/s4ieSAontiIPoUxg2jIFpKzC5kj6DZRZshavup1lILjOgVNIzz1xMP
 6Z5dL/BWW7R5B23GMdQNeEQpSW+wDnTyswXyLdBbQcYqe2yNpHgWWVWqkJPqq+DmWZzG
 ne65Mb1nTTlGo53ruG0SsHBe+JrsAWOGkLSFn6vQk1sQ6+9ZxQpsDG/F7D0SWRamb7oh
 MAjQ==
X-Gm-Message-State: AOAM531ky9GF+ixjyZKF7FyxpO4hn+eNC7g8m+3up7q2NNtVllpOyY+a
 +SUPLPPfvxWtLIjCg4EnF1h+OlLgwGA=
X-Google-Smtp-Source: ABdhPJzRNrtwZQ56e6eQM6fJRfBWPZw8hDCvTQd2nhysuIrrXXxKO1yOwGigr8QXfyscSFSlmafmFg==
X-Received: by 2002:a5d:474f:: with SMTP id o15mr35354909wrs.306.1593807560975; 
 Fri, 03 Jul 2020 13:19:20 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id u65sm14229625wmg.5.2020.07.03.13.19.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 13:19:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH 05/18] hw/arm/aspeed_soc: Mark the device with no migratable
 fields
Date: Fri,  3 Jul 2020 22:18:58 +0200
Message-Id: <20200703201911.26573-6-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200703201911.26573-1-f4bug@amsat.org>
References: <20200703201911.26573-1-f4bug@amsat.org>
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
Cc: Laurent Vivier <laurent@vivier.eu>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This device doesn't have fields to migrate. Be explicit
by using vmstate_qdev_no_state_to_migrate.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/aspeed_soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 311458aa76..b15984e4d3 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -442,6 +442,7 @@ static void aspeed_soc_class_init(ObjectClass *oc, void *data)
     dc->realize = aspeed_soc_realize;
     /* Reason: Uses serial_hds and nd_table in realize() directly */
     dc->user_creatable = false;
+    dc->vmsd = vmstate_qdev_no_state_to_migrate;
     device_class_set_props(dc, aspeed_soc_properties);
 }
 
-- 
2.21.3


