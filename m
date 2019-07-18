Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB5C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5613E21019
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:33:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n56y341f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5613E21019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnz2J-00071k-7d
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 01:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34380)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hnz29-0006XC-6S
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:32:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hnz28-00007K-50
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:32:49 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46472)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hnz25-0008Vx-VY; Thu, 18 Jul 2019 01:32:46 -0400
Received: by mail-pg1-x542.google.com with SMTP id i8so12295738pgm.13;
 Wed, 17 Jul 2019 22:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oCGxQMRGIQLS91TMlbVn6ao3mfUogIA+oIr1UHhs44U=;
 b=n56y341fnmqrYkZFpG+9gP5WKp077pVo6Bet2fBEtTZziYA/UKffIA4WhxUIMkhZZ8
 m5u+MwE6eVitbzACX6FRn0UWmIGWIA9kyeE1MMo7wJXqp4U1Kz0YqQWDxlphCfoKA/n7
 52f4j9EBvQjYHTz0r0Qy6jGzaYGo04YBJbl3KZKxBfet/ciirY8pbLkk4t1NiAwFnDPD
 AT7sqV7glsJm9R3SXkNhDaFH4RRDGC9nI4yYGoUmWrfwPXJsphoDuNIXbUiSloeCrHh1
 QH8Sk9JgXoDWfErlHTybHV2mkdlIUzjGXX3n0VySEPWfTGviMFQ9PFus09hKqly3jSYG
 N3gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=oCGxQMRGIQLS91TMlbVn6ao3mfUogIA+oIr1UHhs44U=;
 b=NQlhKw3dsubNAzDxJHM5RvowWIUfSAYGs6aopOhA3SI+agCJLpt3iafAX5GDt9sEFt
 /+VeVILOygBf6XHZ8i9wnO51KnkXun2P60b2RF8NvWbgt2nKSjnJDDlxzQSDHuUvXv0Q
 hgVzngbjpI/HK3KGnEmj2OLN7T5m6xtB/q1I7bGbVS0TeI8ddnC09zPuXyL/yd9nUz0E
 sGTINn9ZcpfXfQRHUZMlPGQKutdr67a6Pw2YwDnZd7l7tqq3rtAdbN//u1iKE4YCHgDZ
 sJaHC+nK4QS5U8gy1161sc0lMFUW8EZr8OGpEagsizNjCbCPQ8xQmgX76ML7uicho8Kz
 JkKA==
X-Gm-Message-State: APjAAAWv7gWgPgWVhjYCxEyFd5pdr9h9+sdJl/dw2fdpbKXs2YLxfFx3
 ZkdC1BqGxHOmYbnOsx+zi4c=
X-Google-Smtp-Source: APXvYqx8Me/ycAtVQKGqWZ02a/TZqsOtOUqIB+in+uZ6MCeW8WoVWJl7klQ4p/8Y6Um1KiMmYPiHhQ==
X-Received: by 2002:a63:5f95:: with SMTP id
 t143mr44520720pgb.304.1563427963952; 
 Wed, 17 Jul 2019 22:32:43 -0700 (PDT)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id g11sm8512367pgu.11.2019.07.17.22.32.41
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 17 Jul 2019 22:32:43 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 18 Jul 2019 15:02:36 +0930
Message-Id: <20190718053236.6721-1-joel@jms.id.au>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: [Qemu-devel] [PATCH] ppc/pnv: Set default ram size to 2GB
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes the powernv machine easier for end users as the default
initrd address is now within RAM.

Signed-off-by: Joel Stanley <joel@jms.id.au>
--
This replaces https://patchwork.ozlabs.org/patch/1132438/

 hw/ppc/pnv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index bd4531c82260..8cef6d17f111 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1358,7 +1358,7 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
                                       * storage */
     mc->no_parallel = 1;
     mc->default_boot_order = NULL;
-    mc->default_ram_size = 1 * GiB;
+    mc->default_ram_size = 2 * GiB;
     xic->icp_get = pnv_icp_get;
     xic->ics_get = pnv_ics_get;
     xic->ics_resend = pnv_ics_resend;
-- 
2.20.1


