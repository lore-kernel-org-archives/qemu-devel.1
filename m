Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74A7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:34:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4EF12080D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 14:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kycbMPE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4EF12080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlCfC-00043s-VW
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 10:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPh-00023E-Cx; Tue, 16 Jun 2020 10:18:09 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jlCPf-0006eO-Sn; Tue, 16 Jun 2020 10:18:09 -0400
Received: by mail-ot1-x342.google.com with SMTP id v13so16028366otp.4;
 Tue, 16 Jun 2020 07:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8ZFVEmVYSWBDs8wC8TE3sSuzczpmCQe4KbuCRBmtqzI=;
 b=kycbMPE1ue+qVRKGS+ClDnHRvZPxLhY1FtmjGQmrBo/4oN6af+kGcE+srdZYvzyVpM
 q8zAlGls0vGi61aBZfhq5qmcjL6hCJ6O1Z6aWX0hEENVldQzVOqIzcNbGh1ARl0Yi8iz
 1hI9QPEPV6XHXmZK4IUXusUU1m1LBujxfGJJbQEFcAu1EJxhRns0LgRmA0dfkIJktrEf
 /xGPaN8dyhLXq9jVnOnyG05GK0C39XH7WrpYeBOn2WnxCOVFeC1sWPYlLn/TFsE15U97
 hkll7ov8rwVe7f8jLlhXG5q5pRIBVVL6fRlaKYdKgGDjgfY2yErxRsk+X8vXnlqOSiQB
 KFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=8ZFVEmVYSWBDs8wC8TE3sSuzczpmCQe4KbuCRBmtqzI=;
 b=f6buWVo4XjvC7Xm8ak8JVa7oLV43E2ZJWbd/5HgH8kwY0R0Bbgz8kFnKZPs2XFnFUu
 p13vtOiUc2zBJkXM26OGZFdDOEavIA5+qgavFhF9w0T9A/n+EaigPrNd9v48+JTiEc+p
 eHcPWJ8sWG6W1G4+BTULQzvBZfQX7AyQ05nv5Ify7/yjsL3KGKMYcwQLUDrGyZHWMMrS
 V3MVqhdusGANZ9GjEDg4I1/HVRp0Zy2w1CT4J+7p0aroGbz6AhEgzzWsBgZLww6WeoOg
 VOvMN9AAjFAo/nGBfJrZOgqJK42u7teALk9buWBHagRB22oECl003+BqVSVaLoCg+Qff
 LpxQ==
X-Gm-Message-State: AOAM533tvi9PiRdvNjXO8rafflEvYmW7XDzbpT+k7Q0DqCX8B1SAhk4x
 6t9TkDPbiEu5Yihjxt9p1Vu691zz
X-Google-Smtp-Source: ABdhPJweTg1fM1X+ePN3WI4LGW+YjxGrI7lSPOB0Ux1yCk366Z8h54xYQoOKul0W4fhebjIbyBknug==
X-Received: by 2002:a9d:6103:: with SMTP id i3mr2494415otj.354.1592317085563; 
 Tue, 16 Jun 2020 07:18:05 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id c196sm4149776oib.34.2020.06.16.07.18.04
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 16 Jun 2020 07:18:04 -0700 (PDT)
From: Michael Roth <mdroth@linux.vnet.ibm.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 29/78] dp8393x: Clean up endianness hacks
Date: Tue, 16 Jun 2020 09:14:58 -0500
Message-Id: <20200616141547.24664-30-mdroth@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
References: <20200616141547.24664-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=flukshun@gmail.com; helo=mail-ot1-x342.google.com
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-stable@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

According to the datasheet, section 3.4.4, "in 32-bit mode ... the SONIC
always writes long words".

Therefore, use the same technique for the 'in_use' field that is used
everywhere else, and write the full long word.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 46ffee9ad43185cbee4182c208bbd534814086ca)
 Conflicts:
	hw/net/dp8393x.c
*roll in local dependencies on b7cbebf2b9d
*drop functional dep. on 19f70347731
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/net/dp8393x.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 49c304ee20..f89f4c7ba3 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -776,8 +776,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         return -1;
     }
 
-    /* XXX: Check byte ordering */
-
     /* Check for EOL */
     if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* Are we still in resource exhaustion? */
@@ -847,15 +845,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        /* Clear in_use, but it is always 16bit wide */
-        int offset = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
-        if (s->big_endian && width == 2) {
-            /* we need to adjust the offset of the 16bit field */
-            offset += sizeof(uint16_t);
-        }
-        s->data[0] = 0;
-        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)s->data, sizeof(uint16_t), 1);
+        /* Clear in_use */
+        size = sizeof(uint16_t) * width;
+        address = dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        dp8393x_put(s, width, 0, 0);
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, size, true);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.17.1


