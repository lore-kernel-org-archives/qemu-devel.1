Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E39CAC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:10:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7FCC207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 19:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFAHkREE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FCC207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXlk-0003NI-4j
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 14:10:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4e-0002rA-KL
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4d-0004h2-Ih
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:56 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:37947)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4d-0004gh-Eo; Mon, 06 Jan 2020 13:25:55 -0500
Received: by mail-qv1-xf44.google.com with SMTP id t6so19447132qvs.5;
 Mon, 06 Jan 2020 10:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8+CZdFpf3tevgOcUS4uRCI6axpXi/NG+wpiA6ZaBcfg=;
 b=lFAHkREEA9zOA84tmBdmJe0yyz5tibWdRaWk9V6hg2bIxqanpTLo90uhWnOiaI69TM
 SOXlcYKJ7rTQqloejIT2KBN6yV39/NZlV5ydKPl62oAAfzroRV9n6s+TwbRN4xmfQfrw
 VqF0ouw19/mmCnflhYrIeyYKutMBWOE9bT3hDcSXOb+LgyciM492n3r28O74PjyKZJaZ
 75G5eUcGCw40DXFPQyrJLaKgMCzxdctqUhFNswowuqlKUdat8nOyQU4ZFW9CONVqRR9i
 6SZk7eYonUgYnRlGoEfN3U91pspmgPdbOS43q3eLhUjZD0zDOxzM4iSi31YZ+Dq2T3pF
 ThzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8+CZdFpf3tevgOcUS4uRCI6axpXi/NG+wpiA6ZaBcfg=;
 b=KKiVXFctn8Cd5Xk3vRvIJuyxPryJKkZ5hOEd3JNOvJt7lyYhgnTu6oh6d6UGwxBFWI
 oFcyJ5VSNS2eep6yP4D6uPxY5zbCneEc6BJDktZR2y/FXr4Wo4X0ipz9tGL5YgG4zFVF
 vojmb8tbilrJ+w0roJ3OCH8BhvD27yloiUbQqDuFhx9YYcvr7DCz/dOBlCrQaclMwrIy
 0x7krY4OunKJWZo+2ffVSYNFMedb+ElQPonENGgiAZuN8PY9f6Vc5UXuNRapELTD1tKU
 lcM4ygRhehRIyGydi1vE7+37DD9kokjTyIXriOAMkrxcht4kch47ucmAZRhs6SVkwp9C
 UBtg==
X-Gm-Message-State: APjAAAXTAosNFLUcaXrM7z8ExvX2jef7ia//TFu6+A5CyhnxJJh6UUXX
 iHnSBb+pdjZt0EaUa9actSH18NMI
X-Google-Smtp-Source: APXvYqwbOyXc8qrqk5iQUvc0gUPDpjsvnNs1tH3O5eaBsXLxEHrMGNRybDgKdBqAFkhAL8KMWl1dGA==
X-Received: by 2002:a0c:8bd2:: with SMTP id a18mr53139947qvc.38.1578335154886; 
 Mon, 06 Jan 2020 10:25:54 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:54 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 35/59] ipmi_bmc_extern.c: remove unneeded label in
 ipmi_bmc_extern_handle_command
Date: Mon,  6 Jan 2020 15:24:01 -0300
Message-Id: <20200106182425.20312-36-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f44
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
Cc: qemu-trivial@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Corey Minyard <minyard@acm.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'out' label can be replaced by 'return'.

CC: Corey Minyard <minyard@acm.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ipmi/ipmi_bmc_extern.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 87da9ff99c..16d9114725 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -217,7 +217,7 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
         rsp[2] = err;
         ibe->waiting_rsp = false;
         k->handle_rsp(s, msg_id, rsp, 3);
-        goto out;
+        return;
     }
 
     addchar(ibe, msg_id);
@@ -232,9 +232,6 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
 
     /* Start the transmit */
     continue_send(ibe);
-
- out:
-    return;
 }
 
 static void handle_hw_op(IPMIBmcExtern *ibe, unsigned char hw_op)
-- 
2.24.1


