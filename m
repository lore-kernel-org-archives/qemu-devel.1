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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C18DC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:48:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF80207FF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 18:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pf3PzziF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF80207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioXQY-0005zS-9A
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 13:48:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46022)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4g-0002um-7U
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioX4f-0004j2-85
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 13:25:58 -0500
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:40610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioX4f-0004iY-4U; Mon, 06 Jan 2020 13:25:57 -0500
Received: by mail-qt1-x841.google.com with SMTP id e6so43208924qtq.7;
 Mon, 06 Jan 2020 10:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NDENpcOxrSQW9UZ3pijocQSdBIy4XBNwZQRjnmUpikY=;
 b=pf3PzziFI1qtO+PwJCFaC/uGCn0ZkFfWCqnvHr8XUQKHLuUbBUY+k0TmFTQDjaLsaD
 bAfAmG0r+sgHc5ZKvCFwaUwydNot+GVd+ExrvhHIADRcskMkCuX65hH6ldKGJDgw6shw
 C8ysLc440K7NftNq9Je3z04ZNeCMNH2AjMsxW9PsnYK7oTgoUTt/OUBqteW5MAgufL7e
 qzmWy9wbPyUWNQyIPVBB1xwjuMclwyIoqO55g38AdRQqdeRwg7BITwqfN2I+i8jXJ62N
 OrdltzzkTqef8/slUOpbaFbI3VkiIQeW0J6szpYqQnu1UX2mMlXZMstk4scORiuwCBN3
 C/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NDENpcOxrSQW9UZ3pijocQSdBIy4XBNwZQRjnmUpikY=;
 b=PHxHneGN7pQTIVwJFXyXf2O/Tp2UCtchSYN3siUC8Yv5WtsrysEhHA6mfbU+A3iYEo
 prk41ahJaS0MPvdPeK5j7pRXhSBw/gT06DPWpK8TORJhMpsHlMHdXD4/3vVeuhC73299
 x5cMBWG85E0yF6d/G7npCUZ2Yz3hRoboMu1yc6lSX3JPlFKSZ75nfgCU2Qr3yMggw4IC
 0uEnU84LjYhwDoBtpi1MWK3ED2JzaIZk67cTI97XLEsC+FxjKqih4KeMSCdm8ZMJ+bSr
 fEg5q8H7SyMYz1EB0VWmKhNqczOvQA2TuqEt2pQ7JQLCHgAR56hoZCh34Lw24HM3rwfr
 OQSg==
X-Gm-Message-State: APjAAAU3UiZG6Ld+7MpyOn6Iej5L2CGETf9f9ckbrf2O7HLv/YIUi5c2
 MGJHcJKl5nckl1vW/PsxbhKm4iCa
X-Google-Smtp-Source: APXvYqwAqKKyyYmsXaeW4lCIhlIXBQ1eaRlFkQWReyJRbzWNsfs1TcHrnZG4zlrzFHLre5CY765g6w==
X-Received: by 2002:ac8:490f:: with SMTP id e15mr72869796qtq.32.1578335156613; 
 Mon, 06 Jan 2020 10:25:56 -0800 (PST)
Received: from rekt.ibmuc.com ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id b81sm21026522qkc.135.2020.01.06.10.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 10:25:56 -0800 (PST)
From: Daniel Henrique Barboza <danielhb413@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 36/59] ipmi/ipmi_kcs.c: remove unneeded label in
 ipmi_kcs_handle_event
Date: Mon,  6 Jan 2020 15:24:02 -0300
Message-Id: <20200106182425.20312-37-danielhb413@gmail.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200106182425.20312-1-danielhb413@gmail.com>
References: <20200106182425.20312-1-danielhb413@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
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

'out_noibf' can be replaced by 'return'.

CC: Corey Minyard <minyard@acm.org>
Signed-off-by: Daniel Henrique Barboza <danielhb413@gmail.com>
---
 hw/ipmi/ipmi_kcs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index a77612946a..83009baddb 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -168,7 +168,7 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
             ik->outpos = 0;
             bk->handle_command(ik->bmc, ik->inmsg, ik->inlen, sizeof(ik->inmsg),
                                ik->waiting_rsp);
-            goto out_noibf;
+            return;
         } else if (ik->cmd_reg == IPMI_KCS_WRITE_END_CMD) {
             ik->cmd_reg = -1;
             ik->write_end = 1;
@@ -197,8 +197,6 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
     ik->cmd_reg = -1;
     ik->data_in_reg = -1;
     IPMI_KCS_SET_IBF(ik->status_reg, 0);
- out_noibf:
-    return;
 }
 
 static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
-- 
2.24.1


