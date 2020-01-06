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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF4FC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:45:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A7D9208C4
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcQxEVDf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A7D9208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXNF-0002wC-PS
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45958)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4c-0002o4-Sy
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4b-0004fP-T0
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:54 -0500
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:45620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4b-0004ey-PZ; Mon, 06 Jan 2020 13:25:53 -0500
Received: by mail-qv1-xf44.google.com with SMTP id l14so19416062qvu.12;
 Mon, 06 Jan 2020 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+Ybn8SHkq8jjr5laYfWKQovRFgmNlWcpAqoISVHGuSA=;
 b=PcQxEVDfKIoEBYkWAYPs+4/6kfD+8h3oxGya2O1PCDxbqG286Exuqa4QtABEnAtgkM
 SeS5QttmNwC/kDzG2gAcdHnKpFoY911IygzOXoJErqeBsUM07zFhzFGVx1O7FMQOcbnP
 FDfE1/vf6FSBZygWQa4e7x69/YP/95CUAeTt8YHKeZvl7cVAqw90ePDPLjdSXDrZqmxN
 QGMsil8CfuNj4atB3UViORrwsA2vBjDL2bQJGflC7s1f4Jqspl1sRlVHQSMpOoETZck+
 1uwAsjUlNE57W55EiWzMmasyWuWYH4CDrUE+NTWVrKpWgKRzHrOx87tNfk+knkqKdMJe
 uMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+Ybn8SHkq8jjr5laYfWKQovRFgmNlWcpAqoISVHGuSA=;
 b=H/maD4rrebleTLlOQVRe3TgxT/c5qDRPQsUGc7igG+aVtSD04U+Qj2apTllnUfi10T
 UpUiIKhYG5ruQhzbx0GLvDqWMHPTlf+hJFqefCuf8mXslWMmtP/2bKecZFQmOQ/XnD9O
 V4yt/JlgGXyct2LdDgIhZrqi/umt7U60tFFTWhdHrAGk/gYAtTM6VM91tNjaXFcHFRxp
 CPJdviYBJCso7NFV2iEDmoNYzjelUyStjnQH6HH26gcXs/VrhD5bAA4h0a0366RYnKaT
 +mKSsv0SLphPoJ/HL1DGdJriAWJsGPsTaNz2GEKxl+sXqHawS2jm85GU7O4znngETIUe
 ix2g==
X-Gm-Message-State: APjAAAXKMdAXePSUd5PVjmgM6gHm6A2Y7AcdSgxbYrnEK2eQjRtsMP7U
 fl3wo61ISfSaP478SmaygLkgWkUB
X-Google-Smtp-Source: APXvYqyLtTjVd0dbqEcDUlg26wRB/H7xY1Azv6a1zMD1apI7oJI2kccqTIASGHOz5KK8Bz4W0meLhQ==
X-Received: by 2002:a0c:c250:: with SMTP id w16mr76989332qvh.24.1578335153245; 
 Mon, 06 Jan 2020 10:25:53 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:52 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 34/59] ipmi/ipmi_bt.c: remove unneeded label in
 ipmi_bt_handle_event
Date: Mon,  6 Jan 2020 15:24:00 -0300
Message-Id: <20200106182425.20312-35-danielhb413@gmail.com>
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

'out' can be replaced by 'return'.

CC: Corey Minyard <minyard@acm.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ipmi/ipmi_bt.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 22f94fb98d..8173551d7d 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -98,14 +98,14 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
     IPMIBT *ib = iic->get_backend_data(ii);
 
     if (ib->inlen < 4) {
-        goto out;
+        return;
     }
     /* Note that overruns are handled by handle_command */
     if (ib->inmsg[0] != (ib->inlen - 1)) {
         /* Length mismatch, just ignore. */
         IPMI_BT_SET_BBUSY(ib->control_reg, 1);
         ib->inlen = 0;
-        goto out;
+        return;
     }
     if ((ib->inmsg[1] == (IPMI_NETFN_APP << 2)) &&
                         (ib->inmsg[3] == IPMI_CMD_GET_BT_INTF_CAP)) {
@@ -136,7 +136,7 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
             IPMI_BT_SET_B2H_IRQ(ib->mask_reg, 1);
             ipmi_bt_raise_irq(ib);
         }
-        goto out;
+        return;
     }
     ib->waiting_seq = ib->inmsg[2];
     ib->inmsg[2] = ib->inmsg[1];
@@ -145,8 +145,6 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
         bk->handle_command(ib->bmc, ib->inmsg + 2, ib->inlen - 2,
                            sizeof(ib->inmsg), ib->waiting_rsp);
     }
- out:
-    return;
 }
 
 static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
-- 
2.24.1


