Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7B8C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:23:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5F7D2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 23:23:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Br9LTCmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5F7D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv8I0-0000DY-48
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 18:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58645)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8FS-0004AZ-BO
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iv8FR-0005ck-8F
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:22 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32816)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iv8FR-0005bZ-2B
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 18:20:21 -0500
Received: by mail-pf1-x442.google.com with SMTP id n7so1811146pfn.0
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ByWTVem8tb3au/b4x5fdyhlm60dqCY2c6IfxCbm59X0=;
 b=Br9LTCmb3fHHoMJ2MWzIPXAkX+oT9fIPBUN4JkUqmr6mG0rdlgG51lo2u9oxbMomou
 ffTMej6qVXVDZSDcMyoM82RUkqWWFR31hIF3L6g+z/xb8lp5zaLd5X/Rr5nwnMkkVU0F
 zaY3csbaNz9J/wRpFXtVi2l8HhOS843J8kmc58zJr1xKil776RJ6OdnuN3tfKyF9Q3YW
 sOAPJYBMZo7itF7F0s/wc72uc/MC22/o2PEBmLky04/NmX7wkourPBhf5oCU9v0RQWDV
 MH9XUDVTPN7mCAmGNlgZT2eWHO6ZYFGsSOlRmHBDqzHDcGCGJv7qaqLAFh+oY9SiNgSC
 4oCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ByWTVem8tb3au/b4x5fdyhlm60dqCY2c6IfxCbm59X0=;
 b=Tl0JBtZiQaIKlJ/rbBq3YGu2daJFSQn788zx5bAQLemAvhSnWa8/Fpg2GJ7N9FEY1U
 CsKYuUL0qUp1KprbHGnf91AvCMOHmKPnnugt93jH9VMcTsReVDh8xdp5PyL2i3GFX/9Y
 igwvKsgFJHUBBu50xt4E8X1JKSuXDi7kvYwOsEshWwt7p528VvsiywZvsKd9Mr69lghY
 T2zLC8FiBlHAf1HJl7g8cLLa8CvB3rnxJQ8BaIHdib9FdpdG3my2MaK1cOJh1fnrgYr9
 JBCl4goRjDTC4gAuNZPVIj8L7pkKsp3mg4vUd1k4T4Lgu7jwhL7MzJHp7c5GFnSAYzaU
 LhGw==
X-Gm-Message-State: APjAAAVtLyGJQqXGZkFepAOYcjja3j0ZieqMMhQrSBv9eH/6tcCV031u
 u5ZeX6XGxQ8qMzs0P33G8BhagLjNuK0=
X-Google-Smtp-Source: APXvYqyZa76WxCEGXd3jfRbB28Pv+pyanPvYmGnJrdWZ1QKCvUyyLGk0b8CFUv9tWr5HyxeYMoL5lQ==
X-Received: by 2002:aa7:94a4:: with SMTP id a4mr5436833pfl.178.1579908019143; 
 Fri, 24 Jan 2020 15:20:19 -0800 (PST)
Received: from localhost.localdomain (rrcs-173-198-77-92.west.biz.rr.com.
 [173.198.77.92])
 by smtp.gmail.com with ESMTPSA id v4sm8377880pgo.63.2020.01.24.15.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 15:20:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/11] ps2: accept 'Set Key Make and Break' commands
Date: Fri, 24 Jan 2020 13:20:01 -1000
Message-Id: <20200124232009.12928-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124232009.12928-1-richard.henderson@linaro.org>
References: <20200124232009.12928-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: peter.maydell@linaro.org, deller@gmx.de, svens@stackframe.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

HP-UX sends both the 'Set key make and break (0xfc) and
'Set all key typematic make and break' (0xfa). QEMU response
with 'Resend' as it doesn't handle these commands. HP-UX than
reports an PS/2 max retransmission exceeded error. Add these
commands and just reply with ACK.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Message-Id: <20191220211512.3289-4-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/input/ps2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 67f92f6112..0b671b6339 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -49,6 +49,8 @@
 #define KBD_CMD_RESET_DISABLE	0xF5	/* reset and disable scanning */
 #define KBD_CMD_RESET_ENABLE   	0xF6    /* reset and enable scanning */
 #define KBD_CMD_RESET		0xFF	/* Reset */
+#define KBD_CMD_SET_MAKE_BREAK  0xFC    /* Set Make and Break mode */
+#define KBD_CMD_SET_TYPEMATIC   0xFA    /* Set Typematic Make and Break mode */
 
 /* Keyboard Replies */
 #define KBD_REPLY_POR		0xAA	/* Power on reset */
@@ -573,6 +575,7 @@ void ps2_write_keyboard(void *opaque, int val)
         case KBD_CMD_SCANCODE:
         case KBD_CMD_SET_LEDS:
         case KBD_CMD_SET_RATE:
+        case KBD_CMD_SET_MAKE_BREAK:
             s->common.write_cmd = val;
             ps2_queue(&s->common, KBD_REPLY_ACK);
             break;
@@ -592,11 +595,18 @@ void ps2_write_keyboard(void *opaque, int val)
                 KBD_REPLY_ACK,
                 KBD_REPLY_POR);
             break;
+        case KBD_CMD_SET_TYPEMATIC:
+            ps2_queue(&s->common, KBD_REPLY_ACK);
+            break;
         default:
             ps2_queue(&s->common, KBD_REPLY_RESEND);
             break;
         }
         break;
+    case KBD_CMD_SET_MAKE_BREAK:
+        ps2_queue(&s->common, KBD_REPLY_ACK);
+        s->common.write_cmd = -1;
+        break;
     case KBD_CMD_SCANCODE:
         if (val == 0) {
             if (s->common.queue.count <= PS2_QUEUE_SIZE - 2) {
-- 
2.20.1


