Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929A4C43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:37:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5362D20665
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 21:37:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZhuZkyV7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5362D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDwvU-00007T-Bf
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 17:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLy-0004zF-Nr; Thu, 03 Sep 2020 17:01:06 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43302)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1kDwLw-0007qv-LG; Thu, 03 Sep 2020 17:01:05 -0400
Received: by mail-oi1-x243.google.com with SMTP id i17so4498667oig.10;
 Thu, 03 Sep 2020 14:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=RAtZibjRPRUwDnQzP5UjXu8eSd4RDr/MjWSFq1fE5u4=;
 b=ZhuZkyV74JC45mz5cwb0f3GH13dtUNdxELR+kqHiYgq5A/6yeSRps6GRPyCBkvkma+
 r380bNZKG1zInRmRtcpJ9pvDyJD4Rfrrl2lXO7n2/HMLmMHpjWQkQL1YL0dSsVR7zsj7
 1uxBJ2NPRZpjl/7fDGur57ukWIn0HXjmIzVk0OMZay9mxyXW3N1cPYem9mzGYelMxqXw
 Ccv1c0mU+aVcSlR2arIRl/FFYqupsS0uivsI0w0Mg+KEOeJZAHrC4pq/YsupI5JBGVWZ
 dNfekOwt8crLqPOoG9keNJ/R1gxee/JuFJdFF9dNYO+iOXEvKpxVbBRg30epetpAgQ13
 OKqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=RAtZibjRPRUwDnQzP5UjXu8eSd4RDr/MjWSFq1fE5u4=;
 b=cIxVcsvxNREeWOSwJNp1znUlmA0N+hx1i2yC3ceXxvPYonnugCDzd9v30cBN1SDkcl
 O9BOX7IfQ9Musgdj3bzpeRhbaLuqKnmwGcP9BKV4Bd08rV7dgd2/EXN8hsnnSOIz2CjU
 InRX56NttT/w30jNOtCfrFr4p7bLdYtsjs0lTxUVqmEncGibVEYaH5K3WRniBSDRVQgv
 jZKlaWJtQn+G/1776b1hKF33utfb44gtq/Q+v7/VsuaW94uKcYI+sIcAHbnKlHO8K9kb
 54HrzCxVd5f8AbBqgIqgYXXmqQsUL85Yof1pAmZqKTy9b6pgJ2vI63wrEYtZU35BLhpd
 T3ow==
X-Gm-Message-State: AOAM532vY6qDbOgV5ZobycEN8iXwQHqLwNjVoMlqApZFCef+BHFSX35i
 0Rf/LQ6AdPcbt3ffH5b8O0KtTkUAcfsNHA==
X-Google-Smtp-Source: ABdhPJwyMrA+NINQEC9TZehHF1vSHz8eEPFNC1egNQv+Tcf2Q/vkdfb9Av7VcGnlkppxB7vqN+vFpg==
X-Received: by 2002:aca:4901:: with SMTP id w1mr3171952oia.160.1599166862698; 
 Thu, 03 Sep 2020 14:01:02 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id x4sm724977oic.11.2020.09.03.14.01.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 03 Sep 2020 14:01:01 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/77] net: Do not include a newline in the id of -nic devices
Date: Thu,  3 Sep 2020 15:58:23 -0500
Message-Id: <20200903205935.27832-6-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
References: <20200903205935.27832-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::243;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-stable@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Thomas Huth <thuth@redhat.com>

The '\n' sneaked in by accident here, an "id" string should really
not contain a newline character at the end.

Fixes: 78cd6f7bf6b ('net: Add a new convenience option "--nic" ...')
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200518074352.23125-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
(cherry picked from commit 0561dfac082becdd9e89110249a27b309b62aa9f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/net.c b/net/net.c
index 38778e831d..cbeeeadff8 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1506,7 +1506,7 @@ static int net_param_nic(void *dummy, QemuOpts *opts, Error **errp)
     /* Create an ID if the user did not specify one */
     nd_id = g_strdup(qemu_opts_id(opts));
     if (!nd_id) {
-        nd_id = g_strdup_printf("__org.qemu.nic%i\n", idx);
+        nd_id = g_strdup_printf("__org.qemu.nic%i", idx);
         qemu_opts_set_id(opts, nd_id);
     }
 
-- 
2.17.1


