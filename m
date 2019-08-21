Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016C1C3A589
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:12:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C072E2332B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TT6fjxKL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C072E2332B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0H2f-0007Kh-SL
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 23:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1i0H0Z-0006e2-CR
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:10:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1i0H0Y-0003Xd-Ed
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:09:59 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43831)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1i0H0W-0003TI-2W; Tue, 20 Aug 2019 23:09:56 -0400
Received: by mail-pl1-x642.google.com with SMTP id 4so497448pld.10;
 Tue, 20 Aug 2019 20:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=4H0DNln+vkIfh3c16gEfBqSh6PiHJ/PVZ4BRLm+SFLI=;
 b=TT6fjxKLXHGBiNm3kYcqos/P1+uUqIFmRu4wrlu18JrXhGnRoV8lgryOIU3JCIfWjr
 MB7a56PpHkyiku5ARARow/VTelXruvv38sklWPkLS3ulHGjm0WO80SURfsJ6grLlAMMy
 qLvS+C1OdiXemZjpskZGzu3kFkKmXdO6nchF99xMn6C1dG58CPgr/FubEzqc4jmWBmmN
 t49mbcth9vyPQJQadYqGvWD8T+9oJXAWu4Qun4Qv3HVP1L1c/AumnFKXRsHoadI4mXhI
 JHWl70AS2GqkQkDVxsfayogPQBR3Q5cfmY6+Lb+sdxC0k9lnNetOkjQH2sjKdEOKQx/j
 Cutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=4H0DNln+vkIfh3c16gEfBqSh6PiHJ/PVZ4BRLm+SFLI=;
 b=ZPAkTAiUZ8BzI2Y7Scy3ryNhlaX3fAHdVabvdI/6tmNmRpL5OHJfllaH72byDF+hAP
 rryfHbDHNkJEKyDa8DKBx1PuRJdVjLJ6J1xc2uakJX0KmkNwrbPiv5yvCRkDj0jgnJUz
 G5zH9L5T9Hn3ajnfjNwnovhR2KzQMYVv4hncexjKV5ItEMzjYYX5vIiNEpuFI/adZqKF
 HHr3wdL+d1DZkNvMI0R9QI4txZMhhqu5UsaO8/CwDs96WJmgNsq8x/t+3bht05d2Emtl
 X5VqL2mgO4sy9X80233r8adXEIIA7wxENqOQ3OwjV5JEF3foUOZfjmGbXDR9h1CV8aqK
 fLvQ==
X-Gm-Message-State: APjAAAV+j4+Md5ze9xgUW7ZMssBXGzC+mq9wp+TUi0FdKnF9hBxC4kRC
 oGXUy2UdGIYA7+FzHB0m8LA+2Uv0
X-Google-Smtp-Source: APXvYqz+fsexjRX/MjnQEbaR8sNd55NIudhCNs2m5xczzd25mqpRbPTLeqvtprDONJW1MfWDEahdsQ==
X-Received: by 2002:a17:902:b604:: with SMTP id
 b4mr30612298pls.94.1566356993571; 
 Tue, 20 Aug 2019 20:09:53 -0700 (PDT)
Received: from voyager.ibm.com ([36.255.48.244])
 by smtp.gmail.com with ESMTPSA id j10sm21335220pfn.188.2019.08.20.20.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2019 20:09:53 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 21 Aug 2019 12:39:45 +0930
Message-Id: <20190821030945.473-1-joel@jms.id.au>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: [Qemu-devel] [PATCH v2] ppc/pnv: Set default ram size to 1.75GB
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
initrd address (1.5GB) is now within RAM.

This uses less than 2GB of RAM to ensure 32 bit Qemu still works.

Signed-off-by: Joel Stanley <joel@jms.id.au>
--
v2: Use INITRD defines, whcih come out to 1.75, instead of 2GB
---
 hw/ppc/pnv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index d95086fbbd1e..5000db5faab5 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1361,7 +1361,9 @@ static void pnv_machine_class_init(ObjectClass *oc, void *data)
                                       * storage */
     mc->no_parallel = 1;
     mc->default_boot_order = NULL;
-    mc->default_ram_size = 1 * GiB;
+    /* RAM defaults to less than 2048 for 32-bit hosts, and large
+     * enough to fit the maximum initrd size at it's load address */
+    mc->default_ram_size = INITRD_LOAD_ADDR + INITRD_MAX_SIZE;
     xic->icp_get = pnv_icp_get;
     xic->ics_get = pnv_ics_get;
     xic->ics_resend = pnv_ics_resend;
-- 
2.23.0.rc1


